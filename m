From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Thu, 10 Sep 2009 01:39:37 +0000
Subject: [PATCH] sh: Add I2C device support for EcoVec24
Message-Id: <uvdjry3vq.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 428d118..6721b25 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -324,6 +324,13 @@ static struct platform_device ceu1_device = {
 	},
 };
 
+/* I2C device */
+static struct i2c_board_info i2c1_devices[] = {
+	{
+		I2C_BOARD_INFO("r2025sd", 0x32),
+	},
+};
+
 static struct platform_device *ecovec_devices[] __initdata = {
 	&heartbeat_device,
 	&nor_flash_device,
@@ -506,10 +513,14 @@ static int __init devices_setup(void)
 	gpio_request(GPIO_FN_VIO1_CLK, NULL);
 	platform_resource_setup_memory(&ceu1_device, "ceu1", 4 << 20);
 
+	/* enable I2C device */
+	i2c_register_board_info(1, i2c1_devices,
+				ARRAY_SIZE(i2c1_devices));
+
 	return platform_add_devices(ecovec_devices,
 				    ARRAY_SIZE(ecovec_devices));
 }
-device_initcall(devices_setup);
+arch_initcall(devices_setup);
 
 static struct sh_machine_vector mv_ecovec __initmv = {
 	.mv_name	= "R0P7724 (EcoVec)",
-- 
1.6.0.4

