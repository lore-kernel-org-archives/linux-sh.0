From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 18 Nov 2011 07:32:34 +0000
Subject: [PATCH] sh: fix build warning in board-sh7757lcr
Message-Id: <4EC60A12.9000504@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

This patch fixed the following build warnings:

  CC      arch/sh/boards/board-sh7757lcr.o
arch/sh/boards/board-sh7757lcr.c:77: warning: initialization from incompatible pointer type
arch/sh/boards/board-sh7757lcr.c:106: warning: initialization from incompatible pointer type
arch/sh/boards/board-sh7757lcr.c:151: warning: initialization from incompatible pointer type
arch/sh/boards/board-sh7757lcr.c:181: warning: initialization from incompatible pointer type
arch/sh/boards/board-sh7757lcr.c:213: warning: missing braces around initializer
arch/sh/boards/board-sh7757lcr.c:213: warning: (near initialization for ‘sh7757lcr_mmcif_dma.chan_priv_tx’)

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/sh/boards/board-sh7757lcr.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/sh/boards/board-sh7757lcr.c b/arch/sh/boards/board-sh7757lcr.c
index ec8c84c..895e337 100644
--- a/arch/sh/boards/board-sh7757lcr.c
+++ b/arch/sh/boards/board-sh7757lcr.c
@@ -50,9 +50,9 @@ static struct platform_device heartbeat_device = {
 #define GBECONT		0xffc10100
 #define GBECONT_RMII1	BIT(17)
 #define GBECONT_RMII0	BIT(16)
-static void sh7757_eth_set_mdio_gate(unsigned long addr)
+static void sh7757_eth_set_mdio_gate(void *addr)
 {
-	if ((addr & 0x00000fff) < 0x0800)
+	if (((unsigned long)addr & 0x00000fff) < 0x0800)
 		writel(readl(GBECONT) | GBECONT_RMII0, GBECONT);
 	else
 		writel(readl(GBECONT) | GBECONT_RMII1, GBECONT);
@@ -116,9 +116,9 @@ static struct platform_device sh7757_eth1_device = {
 	},
 };

-static void sh7757_eth_giga_set_mdio_gate(unsigned long addr)
+static void sh7757_eth_giga_set_mdio_gate(void *addr)
 {
-	if ((addr & 0x00000fff) < 0x0800) {
+	if (((unsigned long)addr & 0x00000fff) < 0x0800) {
 		gpio_set_value(GPIO_PTT4, 1);
 		writel(readl(GBECONT) & ~GBECONT_RMII0, GBECONT);
 	} else {
@@ -210,8 +210,12 @@ static struct resource sh_mmcif_resources[] = {
 };

 static struct sh_mmcif_dma sh7757lcr_mmcif_dma = {
-	.chan_priv_tx	= SHDMA_SLAVE_MMCIF_TX,
-	.chan_priv_rx	= SHDMA_SLAVE_MMCIF_RX,
+	.chan_priv_tx	= {
+		.slave_id = SHDMA_SLAVE_MMCIF_TX,
+	},
+	.chan_priv_rx	= {
+		.slave_id = SHDMA_SLAVE_MMCIF_RX,
+	}
 };

 static struct sh_mmcif_plat_data sh_mmcif_plat = {
-- 
1.7.1
