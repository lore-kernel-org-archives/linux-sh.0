From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sat, 15 Dec 2012 22:50:38 +0000
Subject: [PATCH v3 04/81] sh: sh7757: Fix GPIO_FN_ET0_MDIO and GPIO_FN_ET1_MDIO GPIO entries
Message-Id: <1355611915-25060-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The GPIO_FN_ET0_MDIO and GPIO_FN_ET1_MDIO GPIO entries incorrectly
reference the ET0_MDC_MARK and ET1_MDC_MARK marks instead of the
ET0_MDIO_MARK and ET1_MDIO_MARK marks. Fix them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/sh/kernel/cpu/sh4a/pinmux-sh7757.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/pinmux-sh7757.c b/arch/sh/kernel/cpu/sh4a/pinmux-sh7757.c
index 4c74bd0..4a2736d 100644
--- a/arch/sh/kernel/cpu/sh4a/pinmux-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/pinmux-sh7757.c
@@ -1376,9 +1376,9 @@ static struct pinmux_gpio pinmux_gpios[] = {
 	PINMUX_GPIO(GPIO_FN_WE1, WE1_MARK),
 	PINMUX_GPIO(GPIO_FN_RDY, RDY_MARK),
 	PINMUX_GPIO(GPIO_FN_ET0_MDC, ET0_MDC_MARK),
-	PINMUX_GPIO(GPIO_FN_ET0_MDIO, ET0_MDC_MARK),
+	PINMUX_GPIO(GPIO_FN_ET0_MDIO, ET0_MDIO_MARK),
 	PINMUX_GPIO(GPIO_FN_ET1_MDC, ET1_MDC_MARK),
-	PINMUX_GPIO(GPIO_FN_ET1_MDIO, ET1_MDC_MARK),
+	PINMUX_GPIO(GPIO_FN_ET1_MDIO, ET1_MDIO_MARK),
 
 	/* PTB (mobule: INTC, ONFI, TMU) */
 	PINMUX_GPIO(GPIO_FN_IRQ15, IRQ15_MARK),
-- 
1.7.8.6

