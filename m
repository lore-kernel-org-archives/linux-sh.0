From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Tue, 15 Dec 2009 00:27:57 +0000
Subject: [PATCH] sh: ms7724se: Add ak4642 support
Message-Id: <uk4wp9j3m.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Linux-SH <linux-sh@vger.kernel.org>

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
This patch is based on ALSA ak4642 patch.

 arch/sh/boards/mach-se/7724/setup.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index 4b0f0c0..5d0f70b 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -514,6 +514,13 @@ static struct platform_device *ms7724se_devices[] __initdata = {
 	&sdhi1_cn8_device,
 };
 
+/* I2C device */
+static struct i2c_board_info i2c0_devices[] = {
+	{
+		I2C_BOARD_INFO("ak4642", 0x12),
+	},
+};
+
 #define EEPROM_OP   0xBA206000
 #define EEPROM_ADR  0xBA206004
 #define EEPROM_DATA 0xBA20600C
@@ -575,6 +582,16 @@ extern char ms7724se_sdram_enter_end;
 extern char ms7724se_sdram_leave_start;
 extern char ms7724se_sdram_leave_end;
 
+
+static int __init arch_setup(void)
+{
+	/* enable I2C device */
+	i2c_register_board_info(0, i2c0_devices,
+				ARRAY_SIZE(i2c0_devices));
+	return 0;
+}
+arch_initcall(arch_setup);
+
 static int __init devices_setup(void)
 {
 	u16 sw = ctrl_inw(SW4140); /* select camera, monitor */
-- 
1.6.3.3

