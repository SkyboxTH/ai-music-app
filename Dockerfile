# 1. ใช้เวอร์ชันใหม่ล่าสุดที่เสถียร (Bookworm)
FROM python:3.9-bookworm

# 2. ติดตั้งเครื่องมือจัดการไฟล์เสียง (คลังของ bookworm จะไม่มีปัญหา 404)
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

# 3. อัปเกรดเครื่องมือ
RUN pip install --no-cache-dir --upgrade pip setuptools wheel

# 4. ติดตั้ง av เวอร์ชันที่เสถียร
RUN pip install --no-cache-dir av==10.0.0

COPY . .

# 5. ติดตั้งตัวที่เหลือจาก requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8501

CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
