From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
Date: Tue, 19 Jun 2012 05:30:38 +0000
Subject: [PATCH] ARM: shmobile: kzm9g: Support Real Time Clock
Message-Id: <4FE00E7E.8030406@kmckk.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello, this is my first patch to this ML.

This depends on Morimoto-san's 
[PATCH 0/27] ARM: shmobile: resend patch set




KZM-A9-GT board has RTC device r2025d at I2C channel 0
with slave address 0x64.

This patch enables reading and writing hardware real time clock on
KZM-A9-GT board. Interrupt is not yet supported.

How to test this patch using user space command.

Read RTC
 # hwclock -r

Copy system clock to RTC
 # hwclock -w

Shutdown and power off the board, and wait a while, then power on again.
Check RTC still keeps correct date.

Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
---
 arch/arm/configs/kzm9g_defconfig     |    1 +
 arch/arm/mach-shmobile/board-kzm9g.c |    3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/configs/kzm9g_defconfig b/arch/arm/configs/kzm9g_defconfig
index eeeb29f..7b2eecd 100644
--- a/arch/arm/configs/kzm9g_defconfig
+++ b/arch/arm/configs/kzm9g_defconfig
@@ -113,6 +113,7 @@ CONFIG_MMC_SH_MMCIF=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_RS5C372=y
 CONFIG_DMADEVICES=y
 CONFIG_SH_DMAE=y
 CONFIG_ASYNC_TX_DMA=y
diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index 3687f3b..ab6207b 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -531,6 +531,9 @@ static struct pcf857x_platform_data pcf8575_pdata = {
 static struct i2c_board_info i2c0_devices[] = {
 	{
 		I2C_BOARD_INFO("ak4648", 0x12),
+	},
+	{
+		I2C_BOARD_INFO("r2025sd", 0x32),
 	}
 };
 
-- 
1.7.9.5

