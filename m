From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 06 Nov 2014 11:52:07 +0000
Subject: [PATCH 2/5] i2c: sh_mobile: Add support for r8a73a4 and sh73a0
Message-Id: <1415274730-310-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1415274730-310-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1415274730-310-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

Add support for r8a73a4 (R-Mobile APE6) and sh73a0 (SH-Mobile AG5).
On these SoCs, the operating clock runs faster that on previous SoCs,
and the internal SCL clock counter gets incremented every 2 clocks of
the operating clock, just like on R-Car Gen2.

Cfr. the "/2" in the calculation of ICCL/ICCH in section "I2C Bus
Interface (IIC)", subsection "Transfer Rate" of the datasheets.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 8b5e79cb4468a87f..8ac36e4ff40a09bb 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -626,17 +626,19 @@ static const struct sh_mobile_dt_config default_dt_config = {
 	.clks_per_count = 1,
 };
 
-static const struct sh_mobile_dt_config rcar_gen2_dt_config = {
+static const struct sh_mobile_dt_config fast_clock_dt_config = {
 	.clks_per_count = 2,
 };
 
 static const struct of_device_id sh_mobile_i2c_dt_ids[] = {
 	{ .compatible = "renesas,rmobile-iic", .data = &default_dt_config },
-	{ .compatible = "renesas,iic-r8a7790", .data = &rcar_gen2_dt_config },
-	{ .compatible = "renesas,iic-r8a7791", .data = &rcar_gen2_dt_config },
-	{ .compatible = "renesas,iic-r8a7792", .data = &rcar_gen2_dt_config },
-	{ .compatible = "renesas,iic-r8a7793", .data = &rcar_gen2_dt_config },
-	{ .compatible = "renesas,iic-r8a7794", .data = &rcar_gen2_dt_config },
+	{ .compatible = "renesas,iic-r8a73a4", .data = &fast_clock_dt_config },
+	{ .compatible = "renesas,iic-r8a7790", .data = &fast_clock_dt_config },
+	{ .compatible = "renesas,iic-r8a7791", .data = &fast_clock_dt_config },
+	{ .compatible = "renesas,iic-r8a7792", .data = &fast_clock_dt_config },
+	{ .compatible = "renesas,iic-r8a7793", .data = &fast_clock_dt_config },
+	{ .compatible = "renesas,iic-r8a7794", .data = &fast_clock_dt_config },
+	{ .compatible = "renesas,iic-sh73a0", .data = &fast_clock_dt_config },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sh_mobile_i2c_dt_ids);
-- 
1.9.1

