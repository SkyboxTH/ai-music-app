# 1. ใช้ Python 3.9 แบบตัวเต็ม (ไม่ใช่ slim) เพื่อให้มีเครื่องมือครบ
FROM python:3.9-bookworm

# 2. ติดตั้ง Library พื้นฐาน (ผมแยกบรรทัดให้มันอ่านง่ายและชัวร์ที่สุด)
RUN apt-get update && apt-get install -y \
    ffmpeg \
    pkg-config \
    git \
    build-essential \
    libavformat-dev \
    libavcodec-dev \
    libavdevice-dev \
    libavutil-dev \
    libswscale-dev \
    libswresample-dev \
    libavfilter-dev

WORKDIR /app

# 3. สั่งติดตั้ง av และ scipy แบบ Binary เท่านั้น (ห้ามให้มัน Build เองเด็ดขาด)
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir --only-binary=:all: av==10.0.0 scipy

COPY . .

# 4. ติดตั้งตัวที่เหลือ (streamlit, audiocraft, torch)
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8501

CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
