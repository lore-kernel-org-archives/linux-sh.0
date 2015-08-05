From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 05 Aug 2015 13:18:26 +0000
Subject: [RFT 2/2] i2c: sh_mobile: add support for r8a7795 (R-Car H3)
Message-Id: <1438780706-20945-3-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1438780706-20945-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1438780706-20945-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Enable the I2C core for this SoC. It is compitable to Gen2 SoCs, so
reuse the settings.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt | 1 +
 drivers/i2c/busses/i2c-sh_mobile.c                      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt b/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
index 2bfc6e7ed09473..214f94c25d370b 100644
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
index 47659a925e09cd..7d2bd3ec2d2d25 100644
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
2.1.4

