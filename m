From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 06 Aug 2014 04:40:12 +0000
Subject: [PATCH 1/5] i2c: rcar: add renesas,i2c-rcar-gen1/gen2 in DT compatible
Message-Id: <87r40uw7rp.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87silaw7t2.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87silaw7t2.wl%kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Cc: Linux-SH <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch adds DT compatible for Renesas R-Car Gen1/Gen2.
Current driver has SoC level .compatible
(r8a7778/r8a7779/r8a7790/r8a7791/r8a7792/r8a7793/r8a7794),
but these can be match as generation level.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 Documentation/devicetree/bindings/i2c/i2c-rcar.txt |    4 +++-
 drivers/i2c/busses/i2c-rcar.c                      |    2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
index 16b3e07..0f9e812 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
@@ -3,6 +3,8 @@ I2C for R-Car platforms
 Required properties:
 - compatible: Must be one of
 	"renesas,i2c-rcar"
+	"renesas,i2c-rcar-gen1"
+	"renesas,i2c-rcar-gen2"
 	"renesas,i2c-r8a7778"
 	"renesas,i2c-r8a7779"
 	"renesas,i2c-r8a7790"
@@ -24,7 +26,7 @@ Examples :
 i2c0: i2c@e6508000 {
 	#address-cells = <1>;
 	#size-cells = <0>;
-	compatible = "renesas,i2c-r8a7791";
+	compatible = "renesas,i2c-r8a7791", "renesas,i2c-rcar-gen2";
 	reg = <0 0xe6508000 0 0x40>;
 	interrupts = <0 287 IRQ_TYPE_LEVEL_HIGH>;
 	clocks = <&mstp9_clks R8A7791_CLK_I2C0>;
diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index f3c7139..6f805f8 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -487,6 +487,8 @@ static const struct i2c_algorithm rcar_i2c_algo = {
 
 static const struct of_device_id rcar_i2c_dt_ids[] = {
 	{ .compatible = "renesas,i2c-rcar", .data = (void *)I2C_RCAR_GEN1 },
+	{ .compatible = "renesas,i2c-rcar-gen1", .data = (void *)I2C_RCAR_GEN1 },
+	{ .compatible = "renesas,i2c-rcar-gen2", .data = (void *)I2C_RCAR_GEN2 },
 	{ .compatible = "renesas,i2c-r8a7778", .data = (void *)I2C_RCAR_GEN1 },
 	{ .compatible = "renesas,i2c-r8a7779", .data = (void *)I2C_RCAR_GEN1 },
 	{ .compatible = "renesas,i2c-r8a7790", .data = (void *)I2C_RCAR_GEN2 },
-- 
1.7.9.5

