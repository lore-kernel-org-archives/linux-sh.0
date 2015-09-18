From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 18 Sep 2015 01:56:29 +0000
Subject: [PATCH 1/2 v3] i2c: rcar: add support for r8a7795 (R-Car H3)
Message-Id: <87lhc41okx.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Enable the I2C core for this SoC. I add a new type because this version
has new features (e.g. DMA) which will be added somewhen later.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2 -> v3

 - add Geert's Acked-by

 Documentation/devicetree/bindings/i2c/i2c-rcar.txt | 1 +
 drivers/i2c/busses/i2c-rcar.c                      | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
index 16b3e07..ea406eb2 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
@@ -10,6 +10,7 @@ Required properties:
 	"renesas,i2c-r8a7792"
 	"renesas,i2c-r8a7793"
 	"renesas,i2c-r8a7794"
+	"renesas,i2c-r8a7795"
 - reg: physical base address of the controller and length of memory mapped
   region.
 - interrupts: interrupt specifier.
diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index d8361da..3e12565 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -103,6 +103,7 @@
 enum rcar_i2c_type {
 	I2C_RCAR_GEN1,
 	I2C_RCAR_GEN2,
+	I2C_RCAR_GEN3,
 };
 
 struct rcar_i2c_priv {
@@ -178,6 +179,7 @@ static int rcar_i2c_clock_calculate(struct rcar_i2c_priv *priv,
 		cdf_width = 2;
 		break;
 	case I2C_RCAR_GEN2:
+	case I2C_RCAR_GEN3:
 		cdf_width = 3;
 		break;
 	default:
@@ -625,6 +627,7 @@ static const struct of_device_id rcar_i2c_dt_ids[] = {
 	{ .compatible = "renesas,i2c-r8a7792", .data = (void *)I2C_RCAR_GEN2 },
 	{ .compatible = "renesas,i2c-r8a7793", .data = (void *)I2C_RCAR_GEN2 },
 	{ .compatible = "renesas,i2c-r8a7794", .data = (void *)I2C_RCAR_GEN2 },
+	{ .compatible = "renesas,i2c-r8a7795", .data = (void *)I2C_RCAR_GEN3 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, rcar_i2c_dt_ids);
-- 
1.9.1

