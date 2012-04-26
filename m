From: Bastian Hecht <hechtb@googlemail.com>
Date: Thu, 26 Apr 2012 14:01:00 +0000
Subject: [RFC DT style 2/4] mtd: sh_flctl: Add device tree support
Message-Id: <1335448862-5201-3-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The flctl can now be probed via device tree setup in addition to the existing
platform data way.
---
 drivers/mtd/nand/sh_flctl.c |  155 ++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 154 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index c6e072d..221a4d4 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -28,6 +28,11 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
+#include <linux/of_mtd.h>
 #include <linux/slab.h>
 
 #include <linux/mtd/mtd.h>
@@ -866,8 +871,147 @@ static irqreturn_t flctl_handle_flste(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __devinit flctl_probe(struct platform_device *pdev)
+#if defined(CONFIG_OF)
+static const char const *of_part_type[] = {
+	"ofpart",
+	NULL
+};
+
+static int __devinit flctl_probe(struct platform_device *ofdev)
 {
+	struct resource io_res;
+	struct sh_flctl *flctl;
+	struct mtd_info *flctl_mtd;
+	struct nand_chip *nand;
+	const __be32 *prop;
+	struct device_node *nand_ic;
+	struct mtd_part_parser_data ppdata;
+	int ret = -ENXIO;
+
+	flctl = kzalloc(sizeof(struct sh_flctl), GFP_KERNEL);
+	if (!flctl) {
+		dev_err(&ofdev->dev, "failed to allocate driver data\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(ofdev, flctl);
+	flctl_mtd = &flctl->mtd;
+	nand = &flctl->chip;
+	flctl_mtd->priv = nand;
+	flctl->pdev = ofdev;
+
+	ret = of_address_to_resource(ofdev->dev.of_node, 0, &io_res);
+	if (ret) {
+		dev_err(&ofdev->dev, "failed to get I/O memory\n");
+		goto err_iomap;
+	}
+
+	flctl->reg = ioremap(io_res.start, resource_size(&io_res));
+	if (flctl->reg = NULL) {
+		dev_err(&ofdev->dev, "failed to remap I/O memory\n");
+		goto err_iomap;
+	}
+
+	flctl->flcmncr_base = TYPESEL_SET;
+
+	/* Parse the flctl host controller properties */
+	prop = of_get_property(ofdev->dev.of_node, "clk-scheme", NULL);
+	if (!prop) {
+		dev_err(&ofdev->dev, "no clocking scheme supplied\n");
+		goto err_clk;
+	} else
+		flctl->flcmncr_base |= be32_to_cpup(prop);
+
+	prop = of_get_property(ofdev->dev.of_node, "ext-bus-con", NULL);
+	if (prop)
+		flctl->flcmncr_base |= SHBUSSEL;
+
+	prop = of_get_property(ofdev->dev.of_node, "use-holden", NULL);
+	if (prop)
+		flctl->holden = true;
+
+	/*
+	 *  Parse the nand IC specific properties.
+	 *  Until now we support only 1 chip
+	 */
+	nand_ic = of_get_next_child(ofdev->dev.of_node, NULL);
+	if (!nand_ic) {
+		dev_err(&ofdev->dev, "no nand chip data supplied\n");
+		goto err_clk;
+	}
+
+	ret = of_get_nand_ecc_mode(nand_ic);
+	if (ret < 0 || (ret != NAND_ECC_HW && ret != NAND_ECC_SOFT)) {
+		dev_err(&ofdev->dev, "no supported ECC mode selected\n");
+		if (ret >= 0)
+			ret = -EINVAL;
+		goto err_subnode;
+	}
+	flctl->hwecc = ret = NAND_ECC_HW ? 1 : 0;
+
+	ret = of_get_nand_bus_width(nand_ic);
+	if (ret = 16) {
+		flctl->flcmncr_base |= SEL_16BIT;
+		nand->options = NAND_BUSWIDTH_16;
+		nand->read_word = flctl_read_word;
+	} else if (ret != 8) {
+		dev_err(&ofdev->dev, "invalid bus width\n");
+		goto err_subnode;
+	} /* else we stick with the default 8 bit settings */
+
+	prop = of_get_property(nand_ic, "flctl-snand", NULL);
+	if (prop)
+		flctl->flcmncr_base |= SNAND_E;
+
+	/* Set address of hardware control function */
+	/* 20 us command delay time */
+	nand->chip_delay = 20;
+	nand->options |= NAND_NO_AUTOINCR;
+
+	nand->read_byte = flctl_read_byte;
+	nand->write_buf = flctl_write_buf;
+	nand->read_buf = flctl_read_buf;
+	nand->verify_buf = flctl_verify_buf;
+	nand->select_chip = flctl_select_chip;
+	nand->cmdfunc = flctl_cmdfunc;
+
+	pm_runtime_enable(&ofdev->dev);
+	pm_runtime_resume(&ofdev->dev);
+
+	ret = nand_scan_ident(flctl_mtd, 1, NULL);
+	if (ret)
+		goto err_chip;
+
+	ret = flctl_chip_init_tail(flctl_mtd);
+	if (ret)
+		goto err_chip;
+
+	ret = nand_scan_tail(flctl_mtd);
+	if (ret)
+		goto err_chip;
+
+	ppdata.of_node = nand_ic;
+	ret = mtd_device_parse_register
+		(flctl_mtd, of_part_type, &ppdata, NULL, 0);
+
+	of_node_put(nand_ic);
+
+	return ret;
+
+err_chip:
+	pm_runtime_disable(&ofdev->dev);
+err_subnode:
+	of_node_put(nand_ic);
+err_clk:
+	iounmap(flctl->reg);
+err_iomap:
+	kfree(flctl);
+
+	return ret;
+}
+
+#else /* CONFIG_OF */
+static int __devinit flctl_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct sh_flctl *flctl;
 	struct mtd_info *flctl_mtd;
@@ -968,6 +1112,7 @@ err_iomap:
 	kfree(flctl);
 	return ret;
 }
+#endif /* CONFIG_OF */
 
 static int __devexit flctl_remove(struct platform_device *pdev)
 {
@@ -982,11 +1127,19 @@ static int __devexit flctl_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id of_flctl_match[] = {
+		{ .compatible = "renesas,rmobile-flctl" },
+		{ .compatible = "renesas,shmobile-flctl" },
+		{},
+};
+MODULE_DEVICE_TABLE(of, of_flctl_match);
+
 static struct platform_driver flctl_driver = {
 	.remove		= flctl_remove,
 	.driver = {
 		.name	= "sh_flctl",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_flctl_match,
 	},
 };
 
-- 
1.7.5.4

