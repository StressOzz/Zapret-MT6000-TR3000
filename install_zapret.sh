#!/bin/sh

# Временная папка
TEMP_DIR="/tmp/zaprettmp"

# Создаем временную папку
mkdir -p "$TEMP_DIR"

# Переходим в временную папку
cd "$TEMP_DIR"

# Получаем URL последнего релиза
RELEASE_URL=$(curl -s https://api.github.com/repos/remittor/zapret-openwrt/releases/latest | grep -o 'https://.*aarch64_cortex-a53.*\.tar\.gz')

# Проверяем, что URL был найден
if [ -z "$RELEASE_URL" ]; then
    echo "Не удалось найти архив с aarch64_cortex-a53 в названии."
    exit 1
fi

# Скачиваем архив
echo "Скачиваем архив: $RELEASE_URL"
curl -L -o zapret.tar.gz "$RELEASE_URL"

# Распаковываем архив
echo "Распаковываем архив..."
tar -xzf zapret.tar.gz

# Очищаем временные файлы
rm zapret.tar.gz

echo "Архив успешно скачан и распакован в $TEMP_DIR"
