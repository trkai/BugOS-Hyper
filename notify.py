import os
import sys
import json
import requests
from datetime import datetime, timezone, timedelta

if hasattr(sys.stdout, 'reconfigure'):
    try:
        sys.stdout.reconfigure(encoding='utf-8')
    except Exception:
        pass
if hasattr(sys.stderr, 'reconfigure'):
    try:
        sys.stderr.reconfigure(encoding='utf-8')
    except Exception:
        pass

def read_file_if_exists(path, default=""):
    if os.path.exists(path):
        try:
            with open(path, "r", encoding="utf-8") as f:
                val = f.read().strip()
                return val if val else default
        except Exception:
            return default
    return default

def is_available(value):
    if not value:
        return False
    val_lower = str(value).strip().lower()
    if val_lower in ["", "chưa rõ", "unknown", "đang xác định...", "⏳ đang quét..."]:
        return False
    return True

def get_prop_value(prop_path, key, default=""):
    if not os.path.exists(prop_path):
        return default
    try:
        with open(prop_path, "r", encoding="utf-8", errors="ignore") as f:
            for line in f:
                line = line.strip()
                if line.startswith(f"{key}="):
                    val = line.split("=", 1)[1].strip()
                    return val if val else default
    except Exception:
        pass
    return default

def html_esc(text):
    if text is None:
        return ""
    return (str(text)
            .replace("&", "&amp;")
            .replace("<", "&lt;")
            .replace(">", "&gt;")
            .replace('"', "&quot;"))

def get_time_vn():
    vn_tz = timezone(timedelta(hours=7))
    return datetime.now(vn_tz).strftime("%H:%M · %d/%m/%Y")

STATUS_MAP = {
    "start":    ("⏳", "Khởi động pipeline",  "Dọn môi trường, cài toolchain…"),
    "download": ("⬇️", "Đang tải ROM gốc",     "Downloading base ROM…"),
    "unpack":   ("📂", "Đang giải nén ROM",    "Unpacking partitions…"),
    "build":    ("🔨", "Đang biên dịch ROM",   "Đang chạy build.sh"),
    "pack":     ("📦", "Đang đóng gói",        "Đang chạy packROM.sh"),
    "upload":   ("☁️", "Đang tải lên Gofile",  "Upload file ROM…"),
    "success":  ("✅", "Hoàn tất",             "ROM đã sẵn sàng để tải về."),
    "fail":     ("❌", "Build thất bại",       "Pipeline dừng. Mở log để xem lỗi."),
}

def get_rom_size():
    zip_name = read_file_if_exists("bin/ddevice/output_zip.txt")
    path = os.path.join("out", zip_name) if zip_name else ""
    if not path or not os.path.isfile(path):
        return ""
    try:
        size = os.path.getsize(path)
    except OSError:
        return ""
    if size >= 1024 ** 3:
        return f"{size / 1024 ** 3:.1f} GB"
    return f"{size / 1024 ** 2:.0f} MB"

def get_device_model():
    for path in ("bin/ddevice/device_name.txt", "bin/ddevice/name_devices.txt"):
        val = read_file_if_exists(path)
        if val and val not in ("Không tìm thấy key", "Xiaomi Device"):
            return val
    for path in ("build/baserom/images/product/etc/build.prop", "build/baserom/images/system/system/build.prop"):
        val = get_prop_value(path, "ro.product.marketname", "") or get_prop_value(path, "ro.product.model", "")
        if val:
            return val
    return ""

def build_message(status, rom_link):
    status_l = status.lower()
    icon, title, hint = STATUS_MAP.get(status_l, ("ℹ️", status, ""))

    system_prop = "build/baserom/images/system/system/build.prop"

    # ----- 1. Codename -----
    codename = read_file_if_exists("bin/ddevice/device_code.txt").upper()
    if not codename or codename == "YOURDEVICE":
        codename = read_file_if_exists("bin/ddevice/device_f.txt").upper()
    if not codename or codename == "YOURDEVICE":
        codename = read_file_if_exists("bin/ddevice/device_model.txt").upper()
    if not codename or codename == "YOURDEVICE":
        codename = get_prop_value(system_prop, "ro.product.device", "").upper()
    if not codename or codename == "YOURDEVICE":
        codename = get_prop_value("build/baserom/images/product/etc/build.prop", "ro.product.product.device", "").upper()

    if not codename:
        device_dir = "bin/device"
        if os.path.exists(device_dir):
            for file in os.listdir(device_dir):
                if file.endswith(".txt"):
                    lines_ = [l.strip() for l in read_file_if_exists(os.path.join(device_dir, file)).split("\n") if l.strip()]
                    if len(lines_) >= 2:
                        codename = lines_[1].upper()
                    break

    # ----- 2. Phiên bản hệ điều hành (OS Version) -----
    rom_os = read_file_if_exists("bin/ddevice/rom_os.txt", "")
    base_rom_code = read_file_if_exists("bin/ddevice/base_rom_code.txt", "")

    if rom_os and base_rom_code:
        xiaomi_version = base_rom_code if rom_os in base_rom_code else f"{rom_os} ({base_rom_code})"
    elif base_rom_code:
        xiaomi_version = base_rom_code
    elif rom_os:
        xiaomi_version = rom_os
    else:
        display_id = get_prop_value(system_prop, "ro.build.display.id", "")
        os_name = get_prop_value(system_prop, "ro.mi.os.version.name", "")
        ver_inc = get_prop_value(system_prop, "ro.mi.os.version.incremental", "")
        xiaomi_version = display_id or (f"{os_name} ({ver_inc})" if os_name and ver_inc else os_name or ver_inc)

    if not xiaomi_version:
        device_dir = "bin/device"
        if os.path.exists(device_dir):
            for file in os.listdir(device_dir):
                if file.endswith(".txt"):
                    lines_ = [l.strip() for l in read_file_if_exists(os.path.join(device_dir, file)).split("\n") if l.strip()]
                    if len(lines_) >= 3:
                        xiaomi_version = lines_[2]
                    break

    lines = []
    if status_l != "success":
        lines += [f"{icon} <b>{html_esc(title)}</b>", ""]

    model = get_device_model()
    codename = codename or "UNKNOWN"
    title_line = f"{model} - {codename}" if model else codename
    lines.append(f"<b>{html_esc(title_line)}</b>")
    lines.append(f"<b>{html_esc(xiaomi_version or 'Đang đọc bản dựng…')}</b>")

    rom_size = get_rom_size() if status_l == "success" else ""
    if rom_size:
        lines.append(f"📦 Dung lượng: {rom_size}")

    lines.append(f"🕐 {get_time_vn()}")

    if is_available(rom_link):
        lines.append(f"🔗 <a href='{html_esc(rom_link)}'>Nguồn ROM</a>")

    if status_l != "success":
        lines += ["", f"<i>{html_esc(hint)}</i>"]

    return "\n".join(lines)

def send_notification(status, rom_link, channel_id, bot_token, builder_id="", download_link=""):
    is_success = status.lower() == 'success'

    run_url = ""
    if os.environ.get("GITHUB_SERVER_URL") and os.environ.get("GITHUB_REPOSITORY") and os.environ.get("GITHUB_RUN_ID"):
        run_url = f"{os.environ['GITHUB_SERVER_URL']}/{os.environ['GITHUB_REPOSITORY']}/actions/runs/{os.environ['GITHUB_RUN_ID']}"

    message = build_message(status, rom_link)
    if is_success and not is_available(download_link):
        message += "\n\n⚠️ <i>Upload lên Drive/Gofile thất bại — chưa có link tải.</i>"

    payload = {
        "text": message,
        "parse_mode": "HTML",
        "disable_web_page_preview": True
    }

    buttons = []
    if is_success:
        if is_available(download_link):
            buttons.append([{"text": "⬇️ Tải ROM", "url": download_link}])
    elif is_available(run_url):
        buttons.append([{"text": "Mở log GitHub Actions", "url": run_url}])

    if buttons:
        payload["reply_markup"] = json.dumps({"inline_keyboard": buttons})

    target_chat_id = builder_id if is_available(builder_id) else channel_id
    if not is_available(target_chat_id):
        print("Lỗi: Không tìm thấy ID chat để gửi báo cáo.")
        return

    payload["chat_id"] = target_chat_id
    print(f"[notify] status={status} link={download_link!r} chat={target_chat_id}")

    try:
        response = requests.post(f"https://api.telegram.org/bot{bot_token}/sendMessage", json=payload)
        if not response.ok:
            print(f"Telegram trả lỗi: {response.status_code} {response.text}")
        response.raise_for_status()
    except Exception as e:
        print(f"Lỗi khi gửi thông báo: {e}")


if __name__ == "__main__":
    if len(sys.argv) < 4:
        sys.exit(1)

    status = sys.argv[1]
    rom_link = sys.argv[3]
    builder_id = sys.argv[6] if len(sys.argv) > 6 else ""
    download_link = sys.argv[7] if len(sys.argv) > 7 and sys.argv[7] else os.environ.get("DOWNLOAD_LINK", "")

    bot_token = os.environ.get("TELEGRAM_BOT_TOKEN")
    channel_id = os.environ.get("TELEGRAM_CHANNEL_ID")

    if not bot_token:
        sys.exit(1)

    send_notification(status, rom_link, channel_id, bot_token, builder_id, download_link)
