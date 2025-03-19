#!/bin/sh

# Создаем временную папку
TMP_DIR="/tmp/zaprettmp"
mkdir -p "$TMP_DIR"

# Получаем ссылку на последний релиз
LATEST_URL="https://github.com/remittor/zapret-openwrt/releases/latest"
ARCHIVE_URL=$(curl -s -L "$LATEST_URL" | grep -oE 'https://github.com/remittor/zapret-openwrt/releases/download/v70.20250213/zapret_v70.20250213_aarch64_cortex-a53.zip' | head -n 1)

# Проверяем, что нашли нужный архив
if [ -z "$ARCHIVE_URL" ]; then
    echo "Не найден архив для aarch64_cortex-a53"
    exit 1
fi

# Определяем имя архива
ARCHIVE_NAME=$(basename "$ARCHIVE_URL")

# Качаем архив
wget -O "$TMP_DIR/$ARCHIVE_NAME" "$ARCHIVE_URL"

# Распаковываем
unzip "$TMP_DIR/$ARCHIVE_NAME" -d "$TMP_DIR"

# Опционально: удаляем архив после распаковки
rm "$TMP_DIR/$ARCHIVE_NAME"

echo "Файлы извлечены в $TMP_DIR"
