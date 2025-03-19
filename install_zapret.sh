REPO="https://api.github.com/repos/remittor/zapret-openwrt/releases/latest"
DOWNLOAD_DIR="/tmp"
ARCHIVE_NAME="aarch64_cortex-a53.zip"

# Получаем ссылку на архив
URL=$(wget -qO- "$REPO" | grep -oP 'https://[^"]*'"$ARCHIVE_NAME"')

if [ -z "$URL" ]; then
    echo "Не удалось найти архив $ARCHIVE_NAME"
    exit 1
fi

# Скачиваем архив
FILENAME="$DOWNLOAD_DIR/$ARCHIVE_NAME"
echo "Скачивание $ARCHIVE_NAME..."
wget -q -O "$FILENAME" "$URL"

# Распаковываем архив
unzip -o "$FILENAME" -d "$DOWNLOAD_DIR"

# Устанавливаем пакеты
opkg install $DOWNLOAD_DIR/zapret_*.ipk
opkg install $DOWNLOAD_DIR/luci-app-zapret*.ipk

# Удаляем загруженные файлы
rm -rf "$DOWNLOAD_DIR/$ARCHIVE_NAME"
