FROM python:3.9-slim

# ติดตั้งเครื่องมือพื้นฐานสำหรับจัดการไฟล์เสียงและระบบ compile
RUN apt-get update && apt-get install -y \
    git \
    ffmpeg \
    pkg-config \
    libavformat-dev \
    libavcodec-dev \
    libavdevice-dev \
    libavutil-dev \
    libswscale-dev \
    libswresample-dev \
    libavfilter-dev \
    build-essential \
    && apt-get clean

WORKDIR /app
COPY . .

# ติดตั้ง Library
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8501

CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
