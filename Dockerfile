FROM python:3.10-slim

# Zależności systemowe do uruchomienia Chrome i ChromeDrivera
RUN apt-get update && apt-get install -y \
    wget unzip curl gnupg ca-certificates \
    fonts-liberation libappindicator3-1 libasound2 \
    libatk-bridge2.0-0 libatk1.0-0 libcups2 libdbus-1-3 \
    libgdk-pixbuf2.0-0 libnspr4 libnss3 libxcomposite1 \
    libxdamage1 libxrandr2 xdg-utils libu2f-udev libvulkan1 \
    libxss1 lsb-release

# Instalacja Google Chrome
RUN curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && apt-get install -y google-chrome-stable

# Instalacja ChromeDrivera
RUN CHROME_VERSION=$(google-chrome --version | grep -oP '\d+\.\d+\.\d+') && \
    wget -q "https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/${CHROME_VERSION}/linux64/chromedriver-linux64.zip" -O /tmp/chromedriver.zip && \
    unzip /tmp/chromedriver.zip -d /usr/bin/ && \
    mv /usr/bin/chromedriver-linux64/chromedriver /usr/bin/chromedriver && \
    chmod +x /usr/bin/chromedriver

# Kopiujemy pliki
WORKDIR /app
COPY . .

# Instalujemy zależności Pythona
RUN pip install --no-cache-dir -r requirements.txt

CMD ["python", "bypass_bot.py"]
