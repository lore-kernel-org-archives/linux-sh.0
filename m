From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 13 May 2014 11:37:46 +0000
Subject: [PATCH v2 1/4] pinctrl: sh-pfc: Don't set the pinmux_irq irq field for multiplatform
Message-Id: <1399981069-29366-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

In the multiplatform kernel case the IRQs associated with the PFC GPIOs
are specified through DT. The pinmux_irq irq field is thus ignored by
the code, and doesn't need to be set.

This will allow removing the mach/irq.h include from pfc-*.c files that
was required for the irq_pin() macro used to initialize the irq field.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/sh_pfc.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index de19d9e..1eac070 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -98,8 +98,13 @@ struct pinmux_irq {
 	const short *gpios;
 };
 
+#ifdef CONFIG_ARCH_MULTIPLATFORM
+#define PINMUX_IRQ(irq_nr, ids...)			   \
+	{ .gpios = (const short []) { ids, -1 } }
+#else
 #define PINMUX_IRQ(irq_nr, ids...)			   \
 	{ .irq = irq_nr, .gpios = (const short []) { ids, -1 } }
+#endif
 
 struct pinmux_range {
 	u16 begin;
-- 
1.8.5.5

