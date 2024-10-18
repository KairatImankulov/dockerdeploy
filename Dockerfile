# Используем официальный образ Python
FROM python:3.9-slim

# Устанавливаем рабочую директорию
WORKDIR /my_project_barbershop

# Копируем зависимости
COPY requirements.txt /my_project_barbershop/requirements.txt

# Устанавливаем зависимости
RUN pip install --no-cache-dir -r /my_project_barbershop/requirements.txt

# Копируем все файлы проекта в контейнер
COPY my_project_barbershop /my_project_barbershop

# Сбор статических файлов
RUN python manage.py collectstatic --noinput

# Открываем порт для приложения
EXPOSE 8000

CMD ["python3", "manage.py", "makemigrations"]
CMD ["python3", "manage.py", "migrate"]
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "barbershop.wsgi:application"]
