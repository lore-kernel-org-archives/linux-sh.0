From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 20 Aug 2012 09:39:23 +0000
Subject: [PATCH] usb: renesas_usbhs: modify the irq handler for sharing irq
Message-Id: <503205CB.5010109@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

When IORESOURCE_IRQ_SHAREABLE is set, the irq handler may be called
even if the interupt of the USB module doesn't happen. So, it may
clear the interrupt flags by mistake. This patch fixes it.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/renesas_usbhs/mod.c |   25 ++++++++++++++++++++++---
 1 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/mod.c b/drivers/usb/renesas_usbhs/mod.c
index 82a628f..35c5208 100644
--- a/drivers/usb/renesas_usbhs/mod.c
+++ b/drivers/usb/renesas_usbhs/mod.c
@@ -209,14 +209,18 @@ int usbhs_status_get_ctrl_stage(struct usbhs_irq_state *irq_state)
 	return (int)irq_state->intsts0 & CTSQ_MASK;
 }

-static void usbhs_status_get_each_irq(struct usbhs_priv *priv,
-				      struct usbhs_irq_state *state)
+static int usbhs_status_get_each_irq(struct usbhs_priv *priv,
+				     struct usbhs_irq_state *state)
 {
 	struct usbhs_mod *mod = usbhs_mod_get_current(priv);
+	u16 intenb0, intenb1;

 	state->intsts0 = usbhs_read(priv, INTSTS0);
 	state->intsts1 = usbhs_read(priv, INTSTS1);

+	intenb0 = usbhs_read(priv, INTENB0);
+	intenb1 = usbhs_read(priv, INTENB1);
+
 	/* mask */
 	if (mod) {
 		state->brdysts = usbhs_read(priv, BRDYSTS);
@@ -226,6 +230,20 @@ static void usbhs_status_get_each_irq(struct usbhs_priv *priv,
 		state->bempsts &= mod->irq_bempsts;
 		state->brdysts &= mod->irq_brdysts;
 	}
+
+	/*
+	 * Check whether the irq enable registers and the irq status are set
+	 * when IRQF_SHARED is set.
+	 */
+	if (priv->irqflags & IRQF_SHARED) {
+		if (!(intenb0 & state->intsts0) &&
+		    !(intenb1 & state->intsts1) &&
+		    !(state->bempsts) &&
+		    !(state->brdysts))
+			return -EIO;
+	}
+
+	return 0;
 }

 /*
@@ -238,7 +256,8 @@ static irqreturn_t usbhs_interrupt(int irq, void *data)
 	struct usbhs_priv *priv = data;
 	struct usbhs_irq_state irq_state;

-	usbhs_status_get_each_irq(priv, &irq_state);
+	if (usbhs_status_get_each_irq(priv, &irq_state) < 0)
+		return IRQ_NONE;

 	/*
 	 * clear interrupt
-- 
1.7.1
