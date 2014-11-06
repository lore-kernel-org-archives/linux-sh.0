From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 06 Nov 2014 11:52:06 +0000
Subject: [PATCH 1/5] ARM: shmobile: kzm9g legacy: Set i2c clks_per_count to 2
Message-Id: <1415274730-310-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1415274730-310-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1415274730-310-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

On sh73a0/kzm9g-legacy, probing of the i2c masters fails with:

    i2c-sh_mobile i2c-sh_mobile.0: timing values out of range: L/H=0x208/0x1bf
    sh_mobile: probe of i2c-sh_mobile.0 failed with error -22

According to the datasheet, the transfer rate is derived from the HP
clock (which runs at 104 MHz) divided by two. Hence
i2c_sh_mobile_platform_data.clks_per_count should be set to two.

Now probing succeeds, and i2c works:

    i2c-sh_mobile i2c-sh_mobile.0: I2C adapter 0 with bus speed 100000 Hz (L/H=0x104/0xe0)

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Note that the L/H values still differ from the Transfer Rate Settings
example in Table 19.3 of the datasheet, which suggests 0x121/0xe7.

 arch/arm/mach-shmobile/setup-sh73a0.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 2955a08a655d8889..179c2b65be9f6829 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -22,6 +22,7 @@
 #include <linux/of_platform.h>
 #include <linux/delay.h>
 #include <linux/input.h>
+#include <linux/i2c/i2c-sh_mobile.h>
 #include <linux/io.h>
 #include <linux/serial_sci.h>
 #include <linux/sh_dma.h>
@@ -188,11 +189,18 @@ static struct resource i2c4_resources[] = {
 	},
 };
 
+static struct i2c_sh_mobile_platform_data i2c_platform_data = {
+	.clks_per_count	= 2,
+};
+
 static struct platform_device i2c0_device = {
 	.name		= "i2c-sh_mobile",
 	.id		= 0,
 	.resource	= i2c0_resources,
 	.num_resources	= ARRAY_SIZE(i2c0_resources),
+	.dev		= {
+		.platform_data	= &i2c_platform_data,
+	},
 };
 
 static struct platform_device i2c1_device = {
@@ -200,6 +208,9 @@ static struct platform_device i2c1_device = {
 	.id		= 1,
 	.resource	= i2c1_resources,
 	.num_resources	= ARRAY_SIZE(i2c1_resources),
+	.dev		= {
+		.platform_data	= &i2c_platform_data,
+	},
 };
 
 static struct platform_device i2c2_device = {
@@ -207,6 +218,9 @@ static struct platform_device i2c2_device = {
 	.id		= 2,
 	.resource	= i2c2_resources,
 	.num_resources	= ARRAY_SIZE(i2c2_resources),
+	.dev		= {
+		.platform_data	= &i2c_platform_data,
+	},
 };
 
 static struct platform_device i2c3_device = {
@@ -214,6 +228,9 @@ static struct platform_device i2c3_device = {
 	.id		= 3,
 	.resource	= i2c3_resources,
 	.num_resources	= ARRAY_SIZE(i2c3_resources),
+	.dev		= {
+		.platform_data	= &i2c_platform_data,
+	},
 };
 
 static struct platform_device i2c4_device = {
@@ -221,6 +238,9 @@ static struct platform_device i2c4_device = {
 	.id		= 4,
 	.resource	= i2c4_resources,
 	.num_resources	= ARRAY_SIZE(i2c4_resources),
+	.dev		= {
+		.platform_data	= &i2c_platform_data,
+	},
 };
 
 static const struct sh_dmae_slave_config sh73a0_dmae_slaves[] = {
-- 
1.9.1

