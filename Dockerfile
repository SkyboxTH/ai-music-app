# 1. ใช้ Image ที่มีปูพื้นฐานเรื่อง AI และ Library เสียงมาให้ครบแล้ว
FROM python:3.9-buster

# 2. ติดตั้งเครื่องมือจัดการไฟล์เสียงให้ครบในระบบ
RUN apt-get update && apt-get install -y \
    ffmpeg \
    libavcodec-dev \
    libavformat-dev \
    libavutil-dev \
    libswresample-dev \
    pkg-config \
    git \
    && apt-get clean

WORKDIR /app

# 3. ติดตั้ง av เวอร์ชันที่เสถียร "ก่อน" ตัวอื่น เพื่อไม่ให้ audiocraft ไปสั่ง build เอง
RUN pip install --no-cache-dir av==10.0.0

COPY . .

# 4. ติดตั้งตัวที่เหลือ (torch, audiocraft, streamlit)
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8501

CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
