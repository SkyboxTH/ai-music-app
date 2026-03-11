# 1. ใช้ Python 3.9 Bookworm เหมือนเดิม
FROM python:3.9-bookworm

# 2. ลง Library พื้นฐาน (ผมเน้นตัวที่ av ต้องใช้)
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
    libavfilter-dev \
    && apt-get clean

WORKDIR /app

# 3. ติดตั้ง av และ scipy แบบ Binary โดยไม่ต้องระบุเลขเวอร์ชัน
# ระบบจะเลือกเวอร์ชันที่ "ลงได้เลย" มาให้เราเอง
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir --only-binary=:all: av scipy

COPY . .

# 4. ติดตั้งตัวที่เหลือ (streamlit, audiocraft, torch)
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8501

CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
