#!/bin/bash

# URL страницы для проверки
url="https://it.is.mysite.ru"

# Ожидаемый текст на странице
expected_text="Про важное"

# Отправляем GET-запрос на страницу и сохраняем код состояния
response=$(curl -s -o /dev/null -w "%{http_code}" "$url")

# Проверяем код состояния
if [ "$response" -eq 200 ]; then
  echo "Страница доступна. Проверка текста..."

  # Загружаем содержимое страницы
  page_content=$(curl -s "$url")

  # Проверяем наличие ожидаемого текста на странице
  if [[ "$page_content" == *"$expected_text"* ]]; then
    echo "Текст '$expected_text' найден на странице."
  else
    echo "Ошибка: Текст '$expected_text' не найден на странице."
    exit 1
  fi
else
  echo "Ошибка: Не удалось получить доступ к странице. Код состояния: $response"
  exit 1
fi

