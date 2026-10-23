FROM python:3.12-slim

WORKDIR /app

# Cài dependencies trước (cache layer hiệu quả)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
