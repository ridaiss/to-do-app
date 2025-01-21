FROM python:3.12.8-alpine3.21
COPY . /application
WORKDIR /application
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 5000
CMD ["python", "app.py"]
