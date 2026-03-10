FROM python:3.9-slim
RUN apt-get update && apt-get install -y git ffmpeg && apt-get clean
WORKDIR /app
COPY . .
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 8501
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
