From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 11 Dec 2013 03:26:23 +0000
Subject: [PATCH 03/10] sh-pfc: sh73a0: Add missing IRQ15
Message-Id: <1386732390-31724-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1386732390-31724-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1386732390-31724-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The external IRQ15 input multiplexed on GPIO 0 is missing. Add it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index 7e278a9..f47df12 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -3661,6 +3661,7 @@ static const struct pinmux_data_reg pinmux_data_regs[] = {
 };
 
 static const struct pinmux_irq pinmux_irqs[] = {
+	PINMUX_IRQ(irq_pin(15), 0),
 	PINMUX_IRQ(irq_pin(19), 9),
 	PINMUX_IRQ(irq_pin(1), 10),
 	PINMUX_IRQ(irq_pin(0), 11),
-- 
1.8.3.2

