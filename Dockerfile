FROM selenium/standalone-chrome:latest

USER root

# Instalacja Pythona i pip
RUN apt-get update && \
    apt-get install -y python3 python3-pip

# Ustawienia katalogu roboczego
WORKDIR /app

# Kopiujemy pliki
COPY . .

# Instalacja zależności Pythona
RUN pip3 install --no-cache-dir -r requirements.txt

CMD ["python3", "bypass_bot.py"]
