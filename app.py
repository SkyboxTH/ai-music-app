import streamlit as st
import torch
from audiocraft.models import MusicGen
import scipy.io.wavfile as wav
import os

# ตั้งค่าหน้าเว็บ
st.set_page_config(page_title="AI Music Studio", page_icon="🎵")
st.title("🎵 AI Music Generator (Topic Selection)")
st.write("เลือกหัวข้อดนตรีที่ต้องการ แล้วให้ AI แต่งเพลงให้คุณ")

# ส่วนเลือกหัวข้อ/สไตล์ดนตรี
topic = st.selectbox("เลือกแนวเพลงที่ต้องการ:", 
    ["Happy Acoustic Guitar", "Dark Techno Beat", "Lo-fi Hip Hop for Studying", "Epic Cinematic Orchestra", "Relaxing Piano Solo"])

duration = st.slider("ความยาวเพลง (วินาที):", 5, 15, 10)

if st.button("Generate Music"):
    with st.spinner(f"กำลังสร้างเพลงแนว {topic}... (อาจใช้เวลา 1-2 นาที)"):
        try:
            # โหลด Model ขนาดเล็ก (MusicGen Small)
            model = MusicGen.get_pretrained('facebook/musicgen-small')
            model.set_generation_params(duration=duration)
            
            # สั่ง AI สร้างดนตรีตามหัวข้อที่เลือก
            wav_output = model.generate([topic])
            
            # บันทึกไฟล์ชั่วคราว
            output_path = "output.wav"
            wav.write(output_path, rate=32000, data=wav_output[0, 0].cpu().numpy())
            
            st.success(f"สร้างเพลงแนว {topic} เสร็จแล้ว!")
            st.audio(output_path)
            
        except Exception as e:
            st.error(f"เกิดข้อผิดพลาด: {e}")

st.info("หมายเหตุ: การรันครั้งแรกจะช้าเพราะต้องโหลด Model AI มาไว้ใน VM ครับ")
