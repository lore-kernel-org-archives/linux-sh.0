From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 22 Aug 2014 11:14:00 +0000
Subject: [PATCH 2/4] usb: renesas_usbhs: protect mod->irq_{bemp,brdy}sts by spin lock
Message-Id: <53F725F8.1040601@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch protects the mod->irq_bempsts and mod->irq_brdysts by
spin lock in the usbhs_status_get_each_irq() because other functions
will write them during spin lock. Otherwise, the driver will clears
the BRDYSTS and/or BEMPSTS wrongly, and then, the transaction will not
finish.
Also since the driver should use the INTSTS0 and BRDYSTS and BEMPSTS
as the same timing, the patch protects them.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/renesas_usbhs/mod.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/renesas_usbhs/mod.c b/drivers/usb/renesas_usbhs/mod.c
index 6a030b9..9a705b1 100644
--- a/drivers/usb/renesas_usbhs/mod.c
+++ b/drivers/usb/renesas_usbhs/mod.c
@@ -213,7 +213,10 @@ static int usbhs_status_get_each_irq(struct usbhs_priv *priv,
 {
 	struct usbhs_mod *mod = usbhs_mod_get_current(priv);
 	u16 intenb0, intenb1;
+	unsigned long flags;

+	/********************  spin lock ********************/
+	usbhs_lock(priv, flags);
 	state->intsts0 = usbhs_read(priv, INTSTS0);
 	state->intsts1 = usbhs_read(priv, INTSTS1);

@@ -229,6 +232,8 @@ static int usbhs_status_get_each_irq(struct usbhs_priv *priv,
 		state->bempsts &= mod->irq_bempsts;
 		state->brdysts &= mod->irq_brdysts;
 	}
+	usbhs_unlock(priv, flags);
+	/********************  spin unlock ******************/

 	/*
 	 * Check whether the irq enable registers and the irq status are set
-- 
1.7.9.5

