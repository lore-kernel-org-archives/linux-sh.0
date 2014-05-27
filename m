From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 27 May 2014 13:45:10 +0000
Subject: [PATCH RFC 2/3] spi: sh-msiof: Add support for new R-Car Gen2 SoCs
Message-Id: <1401198311-21268-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add support for MSIOF in:
  - r8a7792 (R-Car V2H)
  - r8a7793 (R-Car M2-N)
  - r8a7794 (R-Car E2)

r8a7791 is now called "R-Car M2-W".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/spi/sh-msiof.txt | 5 ++++-
 drivers/spi/spi-sh-msiof.c                         | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt b/Documentation/devicetree/bindings/spi/sh-msiof.txt
index f24baf3b6cc1..fea7c0e5498d 100644
--- a/Documentation/devicetree/bindings/spi/sh-msiof.txt
+++ b/Documentation/devicetree/bindings/spi/sh-msiof.txt
@@ -6,7 +6,10 @@ Required properties:
 			 "renesas,sh-mobile-msiof" for SH Mobile series.
 			 Examples with soctypes are:
 			 "renesas,msiof-r8a7790" (R-Car H2)
-			 "renesas,msiof-r8a7791" (R-Car M2)
+			 "renesas,msiof-r8a7791" (R-Car M2-W)
+			 "renesas,msiof-r8a7792" (R-Car V2H)
+			 "renesas,msiof-r8a7793" (R-Car M2-N)
+			 "renesas,msiof-r8a7794" (R-Car E2)
 - reg                  : Offset and length of the register set for the device
 - interrupt-parent     : The phandle for the interrupt controller that
 			 services interrupts for this device
diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 6300e2ac1bcf..300173236d93 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1060,6 +1060,9 @@ static const struct of_device_id sh_msiof_match[] = {
 	{ .compatible = "renesas,sh-mobile-msiof", .data = &sh_data },
 	{ .compatible = "renesas,msiof-r8a7790",   .data = &r8a779x_data },
 	{ .compatible = "renesas,msiof-r8a7791",   .data = &r8a779x_data },
+	{ .compatible = "renesas,msiof-r8a7792",   .data = &r8a779x_data },
+	{ .compatible = "renesas,msiof-r8a7793",   .data = &r8a779x_data },
+	{ .compatible = "renesas,msiof-r8a7794",   .data = &r8a779x_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sh_msiof_match);
@@ -1209,6 +1212,9 @@ static struct platform_device_id spi_driver_ids[] = {
 	{ "spi_sh_msiof",	(kernel_ulong_t)&sh_data },
 	{ "spi_r8a7790_msiof",	(kernel_ulong_t)&r8a779x_data },
 	{ "spi_r8a7791_msiof",	(kernel_ulong_t)&r8a779x_data },
+	{ "spi_r8a7792_msiof",	(kernel_ulong_t)&r8a779x_data },
+	{ "spi_r8a7793_msiof",	(kernel_ulong_t)&r8a779x_data },
+	{ "spi_r8a7794_msiof",	(kernel_ulong_t)&r8a779x_data },
 	{},
 };
 MODULE_DEVICE_TABLE(platform, spi_driver_ids);
-- 
1.9.1

