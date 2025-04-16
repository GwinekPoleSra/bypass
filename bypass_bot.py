import discord
from discord.ext import commands
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
import os
import time

intents = discord.Intents.default()
intents.message_content = True

bot = commands.Bot(command_prefix="!", intents=intents)

@bot.event
async def on_ready():
    print(f"Zalogowano jako {bot.user}")

def bypass_linkvertise(link):
    options = Options()
    options.add_argument("--headless")
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")
    options.add_argument("--disable-blink-features=AutomationControlled")

    options.binary_location = "/usr/bin/google-chrome"
    driver = webdriver.Chrome(options=options)

    try:
        driver.get(link)
        time.sleep(5)

        try:
            button = driver.find_element(By.XPATH, "//a[contains(text(),'Continue') or contains(text(),'Free Access')]")
            button.click()
            time.sleep(10)
        except:
            pass

        return driver.current_url

    except Exception as e:
        return f"❌ Błąd: {str(e)}"
    finally:
        driver.quit()

@bot.command()
async def bypass(ctx, link: str):
    await ctx.send("🔄 Przetwarzam link...")
    result = bypass_linkvertise(link)
    await ctx.send(f"🎯 Wynik: {result}")

bot.run(os.getenv("DISCORD_BOT_TOKEN"))
