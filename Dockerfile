FROM python:3.9-slim

# 1. ลงเครื่องมือพื้นฐาน
RUN apt-get update && apt-get install -y \
    git \
    ffmpeg \
    pkg-config \
    build-essential \
    && apt-get clean

WORKDIR /app

# 2. อัปเกรดเครื่องมือติดตั้ง
RUN pip install --no-cache-dir --upgrade pip setuptools wheel

# 3. ติดตั้ง av และ scipy แบบสำเร็จรูป (Binary) ตัดหน้าไว้ก่อนเลย!
# สองตัวนี้คือตัวปัญหา ถ้าลงแบบนี้จะเร็วและไม่ Error ครับ
RUN pip install --no-cache-dir av scipy --only-binary=:all:

COPY . .

# 4. ติดตั้งตัวที่เหลือ (streamlit, audiocraft, torch, torchaudio)
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8501

CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
