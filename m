From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 19 Jan 2010 08:09:10 +0000
Subject: [PATCH 4/4] sh: audio support for the sh7722 Migo-R board
Message-Id: <Pine.LNX.4.64.1001190906030.4607@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1001190839110.4607@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1001190839110.4607@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org
Cc: linux-sh@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Magnus Damm <damm@opensource.se>

Configure SIU port B pins and register the WM8978 audio codec.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/boards/mach-migor/setup.c       |   16 ++++++++++++++++
 arch/sh/include/mach-migor/mach/migor.h |    1 +
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index e1972a8..8f2bd4e 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -419,6 +419,9 @@ static struct i2c_board_info migor_i2c_devices[] = {
 		I2C_BOARD_INFO("migor_ts", 0x51),
 		.irq = 38, /* IRQ6 */
 	},
+	{
+		I2C_BOARD_INFO("wm8978", 0x1a),
+	},
 };
 
 static struct i2c_board_info migor_i2c_camera[] = {
@@ -631,6 +634,19 @@ static int __init migor_devices_setup(void)
 
 	platform_resource_setup_memory(&migor_ceu_device, "ceu", 4 << 20);
 
+	/* SIU: Port B */
+	gpio_request(GPIO_FN_SIUBOLR, NULL);
+	gpio_request(GPIO_FN_SIUBOBT, NULL);
+	gpio_request(GPIO_FN_SIUBISLD, NULL);
+	gpio_request(GPIO_FN_SIUBOSLD, NULL);
+	gpio_request(GPIO_FN_SIUMCKB, NULL);
+
+	/*
+	 * The original driver sets SIUB OLR/OBT, ILR/IBT, and SIUA OLR/OBT to
+	 * output. Need only SIUB, set to output for master mode (table 34.2)
+	 */
+	ctrl_outw(ctrl_inw(PORT_MSELCRA) | 1, PORT_MSELCRA);
+
 	i2c_register_board_info(0, migor_i2c_devices,
 				ARRAY_SIZE(migor_i2c_devices));
 
diff --git a/arch/sh/include/mach-migor/mach/migor.h b/arch/sh/include/mach-migor/mach/migor.h
index cee6cb8..42fccf9 100644
--- a/arch/sh/include/mach-migor/mach/migor.h
+++ b/arch/sh/include/mach-migor/mach/migor.h
@@ -1,6 +1,7 @@
 #ifndef __ASM_SH_MIGOR_H
 #define __ASM_SH_MIGOR_H
 
+#define PORT_MSELCRA 0xa4050180
 #define PORT_MSELCRB 0xa4050182
 #define BSC_CS4BCR 0xfec10010
 #define BSC_CS6ABCR 0xfec1001c
-- 
1.6.2.4

