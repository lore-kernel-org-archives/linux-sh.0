From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 25 Nov 2016 07:33:01 +0000
Subject: [PATCH/RFC linux-mtd] mtd: sh_flctl: Remove sh7372 and device tree support
Message-Id: <1480059181-29355-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Boris Brezillon <boris.brezillon@free-electrons.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@atmel.com>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms+renesas@verge.net.au>

Commit edf4100906044225 ("ARM: shmobile: sh7372 dtsi: Remove Legacy file")
removed the sh7272 SoC from the kernel in v4.1.

This patch removes support for the sh7272 SoC from the sh_flctl driver.
As that SoC was the only user of device tree support also remove that
from the driver.

In essence it reverts commit 7c8f680e96ed ("mtd: sh_flctl: Add device tree
support"). This commit may be used as a reference for re-adding device
tree support to this driver if a need for it is found in future.

This commit has been build-testesd against the ap325rxa_defconfig.
I do not have access to the hardware to perform run-time testing
on that board which appears to be the only remaining user of this driver.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 .../devicetree/bindings/mtd/flctl-nand.txt         | 49 ---------------
 drivers/mtd/nand/sh_flctl.c                        | 70 +++-------------------
 2 files changed, 8 insertions(+), 111 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/flctl-nand.txt

diff --git a/Documentation/devicetree/bindings/mtd/flctl-nand.txt b/Documentation/devicetree/bindings/mtd/flctl-nand.txt
deleted file mode 100644
index 427f46dc60ad..000000000000
--- a/Documentation/devicetree/bindings/mtd/flctl-nand.txt
+++ /dev/null
@@ -1,49 +0,0 @@
-FLCTL NAND controller
-
-Required properties:
-- compatible : "renesas,shmobile-flctl-sh7372"
-- reg : Address range of the FLCTL
-- interrupts : flste IRQ number
-- nand-bus-width : bus width to NAND chip
-
-Optional properties:
-- dmas: DMA specifier(s)
-- dma-names: name for each DMA specifier. Valid names are
-	     "data_tx", "data_rx", "ecc_tx", "ecc_rx"
-
-The DMA fields are not used yet in the driver but are listed here for
-completing the bindings.
-
-The device tree may optionally contain sub-nodes describing partitions of the
-address space. See partition.txt for more detail.
-
-Example:
-
-	flctl@e6a30000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "renesas,shmobile-flctl-sh7372";
-		reg = <0xe6a30000 0x100>;
-		interrupts = <0x0d80>;
-
-		nand-bus-width = <16>;
-
-		dmas = <&dmac 1 /* data_tx */
-			&dmac 2;> /* data_rx */
-		dma-names = "data_tx", "data_rx";
-
-		system@0 {
-			label = "system";
-			reg = <0x0 0x8000000>;
-		};
-
-		userdata@8000000 {
-			label = "userdata";
-			reg = <0x8000000 0x10000000>;
-		};
-
-		cache@18000000 {
-			label = "cache";
-			reg = <0x18000000 0x8000000>;
-		};
-	};
diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 442ce619b3b6..7568d77bed88 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -29,8 +29,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/sh_dma.h>
@@ -1073,62 +1071,22 @@ static irqreturn_t flctl_handle_flste(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-struct flctl_soc_config {
-	unsigned long flcmncr_val;
-	unsigned has_hwecc:1;
-	unsigned use_holden:1;
-};
-
-static struct flctl_soc_config flctl_sh7372_config = {
-	.flcmncr_val = CLK_16B_12L_4H | TYPESEL_SET | SHBUSSEL,
-	.has_hwecc = 1,
-	.use_holden = 1,
-};
-
-static const struct of_device_id of_flctl_match[] = {
-	{ .compatible = "renesas,shmobile-flctl-sh7372",
-				.data = &flctl_sh7372_config },
-	{},
-};
-MODULE_DEVICE_TABLE(of, of_flctl_match);
-
-static struct sh_flctl_platform_data *flctl_parse_dt(struct device *dev)
-{
-	const struct of_device_id *match;
-	struct flctl_soc_config *config;
-	struct sh_flctl_platform_data *pdata;
-
-	match = of_match_device(of_flctl_match, dev);
-	if (match)
-		config = (struct flctl_soc_config *)match->data;
-	else {
-		dev_err(dev, "%s: no OF configuration attached\n", __func__);
-		return NULL;
-	}
-
-	pdata = devm_kzalloc(dev, sizeof(struct sh_flctl_platform_data),
-								GFP_KERNEL);
-	if (!pdata)
-		return NULL;
-
-	/* set SoC specific options */
-	pdata->flcmncr_val = config->flcmncr_val;
-	pdata->has_hwecc = config->has_hwecc;
-	pdata->use_holden = config->use_holden;
-
-	return pdata;
-}
-
 static int flctl_probe(struct platform_device *pdev)
 {
+	struct sh_flctl_platform_data *pdata;
 	struct resource *res;
 	struct sh_flctl *flctl;
 	struct mtd_info *flctl_mtd;
 	struct nand_chip *nand;
-	struct sh_flctl_platform_data *pdata;
 	int ret;
 	int irq;
 
+	pdata = pdev->dev.platform_data;
+	if (pdata = NULL) {
+		dev_err(&pdev->dev, "no platform data defined\n");
+		return -EINVAL;
+	}
+
 	flctl = devm_kzalloc(&pdev->dev, sizeof(struct sh_flctl), GFP_KERNEL);
 	if (!flctl)
 		return -ENOMEM;
@@ -1152,20 +1110,9 @@ static int flctl_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (pdev->dev.of_node)
-		pdata = flctl_parse_dt(&pdev->dev);
-	else
-		pdata = dev_get_platdata(&pdev->dev);
-
-	if (!pdata) {
-		dev_err(&pdev->dev, "no setup data defined\n");
-		return -EINVAL;
-	}
-
 	platform_set_drvdata(pdev, flctl);
 	nand = &flctl->chip;
 	flctl_mtd = nand_to_mtd(nand);
-	nand_set_flash_node(nand, pdev->dev.of_node);
 	flctl_mtd->dev.parent = &pdev->dev;
 	flctl->pdev = pdev;
 	flctl->hwecc = pdata->has_hwecc;
@@ -1214,7 +1161,7 @@ static int flctl_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_chip;
 
-	ret = mtd_device_register(flctl_mtd, pdata->parts, pdata->nr_parts);
+	mtd_device_register(flctl_mtd, pdata->parts, pdata->nr_parts);
 
 	return 0;
 
@@ -1239,7 +1186,6 @@ static struct platform_driver flctl_driver = {
 	.remove		= flctl_remove,
 	.driver = {
 		.name	= "sh_flctl",
-		.of_match_table = of_match_ptr(of_flctl_match),
 	},
 };
 
-- 
2.7.0.rc3.207.g0ac5344

