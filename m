From: Bastian Hecht <hechtb@googlemail.com>
Date: Thu, 26 Apr 2012 14:01:01 +0000
Subject: [RFC DT style 3/4] Out-of-tree: sh_flctl: Add dirty hardware init code
Message-Id: <1335448862-5201-4-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Configure the gpios and make sure the flctl is clocked.
---
 drivers/mtd/nand/sh_flctl.c |   52 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 221a4d4..2d88e8b 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -40,6 +40,8 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/sh_flctl.h>
 
+#include "../../../arch/arm/mach-shmobile/include/mach/sh7372.h"
+
 static struct nand_ecclayout flctl_4secc_oob_16 = {
 	.eccbytes = 10,
 	.eccpos = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
@@ -708,11 +710,19 @@ runtime_exit:
 	return;
 }
 
+#if defined(CONFIG_OF)
+static void activate_flctl(void);
+#endif
+
 static void flctl_select_chip(struct mtd_info *mtd, int chipnr)
 {
 	struct sh_flctl *flctl = mtd_to_flctl(mtd);
 	int ret;
 
+#if defined(CONFIG_OF)
+	activate_flctl();
+#endif
+
 	switch (chipnr) {
 	case -1:
 		flctl->flcmncr_base &= ~CE0_ENABLE;
@@ -861,6 +871,46 @@ static int flctl_chip_init_tail(struct mtd_info *mtd)
 	return 0;
 }
 
+#if defined(CONFIG_OF)
+static void activate_flctl()
+{
+	int ret;
+	/* FLCTL */
+	gpio_request(GPIO_FN_D0_NAF0, NULL);
+	gpio_request(GPIO_FN_D1_NAF1, NULL);
+	gpio_request(GPIO_FN_D2_NAF2, NULL);
+	gpio_request(GPIO_FN_D3_NAF3, NULL);
+	gpio_request(GPIO_FN_D4_NAF4, NULL);
+	gpio_request(GPIO_FN_D5_NAF5, NULL);
+	gpio_request(GPIO_FN_D6_NAF6, NULL);
+	gpio_request(GPIO_FN_D7_NAF7, NULL);
+	gpio_request(GPIO_FN_D8_NAF8, NULL);
+	gpio_request(GPIO_FN_D9_NAF9, NULL);
+	gpio_request(GPIO_FN_D10_NAF10, NULL);
+	gpio_request(GPIO_FN_D11_NAF11, NULL);
+	gpio_request(GPIO_FN_D12_NAF12, NULL);
+	gpio_request(GPIO_FN_D13_NAF13, NULL);
+	gpio_request(GPIO_FN_D14_NAF14, NULL);
+	gpio_request(GPIO_FN_D15_NAF15, NULL);
+	gpio_request(GPIO_FN_FCE0, NULL);
+	gpio_request(GPIO_FN_WE0_FWE, NULL);
+	gpio_request(GPIO_FN_FRB, NULL);
+	gpio_request(GPIO_FN_A4_FOE, NULL);
+	gpio_request(GPIO_FN_A5_FCDE, NULL);
+	gpio_request(GPIO_FN_RD_FSC, NULL);
+
+	ret = readl(0xe6150048);
+
+	//printk("flctl device tree probe 2: %x\n", ret);
+
+	ret = readl(0xE615013C);
+	writel(ret & 0xffff7fff, 0xE615013C);
+	ret = readl(0xe6150048);
+	udelay(1);
+
+}
+#endif
+
 static irqreturn_t flctl_handle_flste(int irq, void *dev_id)
 {
 	struct sh_flctl *flctl = dev_id;
@@ -888,6 +938,8 @@ static int __devinit flctl_probe(struct platform_device *ofdev)
 	struct mtd_part_parser_data ppdata;
 	int ret = -ENXIO;
 
+	activate_flctl();
+
 	flctl = kzalloc(sizeof(struct sh_flctl), GFP_KERNEL);
 	if (!flctl) {
 		dev_err(&ofdev->dev, "failed to allocate driver data\n");
-- 
1.7.5.4

