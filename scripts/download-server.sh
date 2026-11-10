#!/usr/bin/env bash

# Настройки
PROJECT="paper"
MINECRAFT_VERSION="26.3"
USER_AGENT="org.konnovki.mc/dev"
OUTPUT_FILE="server/server.jar"

# Проверка: если файл уже существует — выходим
if [ -f "${OUTPUT_FILE}" ]; then
    echo "Файл ${OUTPUT_FILE} уже существует. Пропускаем скачивание."
    exit 0
fi

mkdir -p server

# Проверка наличия jq
if ! command -v jq &> /dev/null; then
    echo "Ошибка: утилита 'jq' не найдена. Установите её (например: sudo apt install jq)."
    exit 1
fi

echo "Поиск последней стабильной сборки Paper для версии ${MINECRAFT_VERSION}..."

# Получаем URL для скачивания через API Fill
# Скрипт ищет первую сборку с каналом "STABLE" в списке
DOWNLOAD_URL=$(curl -s -H "User-Agent: ${USER_AGENT}" \
  "https://fill.papermc.io/v3/projects/${PROJECT}/versions/${MINECRAFT_VERSION}/builds" | \
  jq -r 'first(.[] | select(.channel == "STABLE") | .downloads."server:default".url) // "null"')

# Проверка, удалось ли найти сборку
if [ "$DOWNLOAD_URL" == "null" ] || [ -z "$DOWNLOAD_URL" ]; then
    echo "Ошибка: Не удалось найти стабильную сборку для версии ${MINECRAFT_VERSION}."
    echo "Возможно, для этой версии ещё нет стабильного релиза, или версия указана неверно."
    exit 1
fi

echo "Скачивание: ${OUTPUT_FILE}"
# Скачиваем файл
curl -L -H "User-Agent: ${USER_AGENT}" -o "${OUTPUT_FILE}" "${DOWNLOAD_URL}"

echo "Готово! Сервер сохранён в ${OUTPUT_FILE}"
