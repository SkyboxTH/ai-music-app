FROM python:3.9-slim

# 1. ติดตั้งทุกอย่างที่ต้องใช้ Compile ในคำสั่งเดียว (รวม pkg-config และพวก libav ทั้งหมด)
RUN apt-get update && apt-get install -y \
    git \
    ffmpeg \
    pkg-config \
    build-essential \
    libavformat-dev \
    libavcodec-dev \
    libavdevice-dev \
    libavutil-dev \
    libswscale-dev \
    libswresample-dev \
    libavfilter-dev \
    python3-dev \
    && apt-get clean

WORKDIR /app

# 2. บังคับลง av และ scipy แบบสำเร็จรูป (Binary) เพื่อข้ามปัญหาเดิมที่คุณเจอในรูป
RUN pip install --no-cache-dir --upgrade pip setuptools wheel
RUN pip install --no-cache-dir av scipy --only-binary=:all:

COPY . .

# 3. ติดตั้งตัวที่เหลือ
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8501

CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
