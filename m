From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 18 Sep 2015 01:56:55 +0000
Subject: [PATCH 2/2 v3] i2c: sh_mobile: add support for r8a7795 (R-Car H3)
Message-Id: <87k2ro1ok8.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Enable the I2C core for this SoC. It is compitable to Gen2 SoCs, so
reuse the settings.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2 -> v3

 - add Geert's Acked-by

 Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt | 1 +
 drivers/i2c/busses/i2c-sh_mobile.c                      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt b/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
index 2bfc6e7..214f94c 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
@@ -10,6 +10,7 @@ Required properties:
 			- "renesas,iic-r8a7792" (R-Car V2H)
 			- "renesas,iic-r8a7793" (R-Car M2-N)
 			- "renesas,iic-r8a7794" (R-Car E2)
+			- "renesas,iic-r8a7795" (R-Car H3)
 			- "renesas,iic-sh73a0" (SH-Mobile AG5)
 - reg             : address start and address range size of device
 - interrupts      : interrupt of device
diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 47659a9..7d2bd3e 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -836,6 +836,7 @@ static const struct of_device_id sh_mobile_i2c_dt_ids[] = {
 	{ .compatible = "renesas,iic-r8a7792", .data = &fast_clock_dt_config },
 	{ .compatible = "renesas,iic-r8a7793", .data = &fast_clock_dt_config },
 	{ .compatible = "renesas,iic-r8a7794", .data = &fast_clock_dt_config },
+	{ .compatible = "renesas,iic-r8a7795", .data = &fast_clock_dt_config },
 	{ .compatible = "renesas,iic-sh73a0", .data = &fast_clock_dt_config },
 	{},
 };
-- 
1.9.1

