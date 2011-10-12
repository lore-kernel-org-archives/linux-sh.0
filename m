From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 12 Oct 2011 07:21:50 +0000
Subject: [PATCH 07/07] ARM: mach-shmobile: SDHI0 GPIO hotplug for AG5EVM
Message-Id: <20111012072150.25511.94811.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Implement GPIO hotplugging via TMIO_MMC_HAS_COLD_CD for
AG5EVM SDHI0. This is possible now when INTCA is used for
IRQ triggering on sh73a0. Without INTCA IRQ support we are
left with the GIC hardware block that does not support
dealing with active low interrupt sources.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-ag5evm.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- 0003/arch/arm/mach-shmobile/board-ag5evm.c
+++ work/arch/arm/mach-shmobile/board-ag5evm.c	2011-10-12 15:14:41.000000000 +0900
@@ -338,6 +338,18 @@ static struct platform_device mipidsi0_d
 	},
 };
 
+/* SDHI0 */
+static irqreturn_t ag5evm_sdhi0_gpio_cd(int irq, void *arg)
+{
+	struct device *dev = arg;
+	struct sh_mobile_sdhi_info *info = dev->platform_data;
+	struct tmio_mmc_data *pdata = info->pdata;
+
+	tmio_mmc_cd_wakeup(pdata);
+
+	return IRQ_HANDLED;
+}
+
 static struct sh_mobile_sdhi_info sdhi0_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
@@ -561,6 +573,13 @@ static void __init ag5evm_init(void)
 	gpio_request(GPIO_FN_SDHID0_1_PU, NULL);
 	gpio_request(GPIO_FN_SDHID0_0_PU, NULL);
 
+	if (!request_irq(intcs_evt2irq(0x3c0), ag5evm_sdhi0_gpio_cd,
+			 IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
+			 "sdhi0 cd", &sdhi0_device.dev))
+		sdhi0_info.tmio_flags |= TMIO_MMC_HAS_COLD_CD;
+	else
+		pr_warn("Unable to setup SDHI0 GPIO IRQ\n");
+
 	/* enable SDHI1 on CN4 [WLAN I/F] */
 	gpio_request(GPIO_FN_SDHICLK1, NULL);
 	gpio_request(GPIO_FN_SDHICMD1_PU, NULL);
