FROM python:3.9-slim

# 1. ติดตั้ง System Dependencies ทั้งหมด
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
    python3-dev \
    && apt-get clean

WORKDIR /app

# 2. อัปเกรด pip และลง Cython ก่อนเป็นอันดับแรก (สำคัญมากสำหรับ av)
RUN pip install --no-cache-dir --upgrade pip setuptools wheel
RUN pip install --no-cache-dir Cython==0.29.36 

COPY . .

# 3. ติดตั้ง requirements
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8501

CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
