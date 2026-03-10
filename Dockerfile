FROM python:3.9-slim

# 1. ติดตั้ง System Dependencies ที่จำเป็น
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

# 2. อัปเกรดเครื่องมือพื้นฐาน
RUN pip install --no-cache-dir --upgrade pip setuptools wheel

# 3. ติดตั้ง av แบบ Binary (ท่าไม้ตาย: ข้ามขั้นตอน Build ที่มีปัญหา)
RUN pip install --no-cache-dir av --only-binary=:all:

COPY . .

# 4. ติดตั้งตัวอื่นๆ ที่เหลือ
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8501

CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
