From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 22 May 2015 11:06:35 +0000
Subject: [PATCH] usb: renesas_usbhs: avoid uninitialized variable use
Message-Id: <16028110.26u0uMKA2O@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

After the renesas_usbhs driver is enabled in ARM multi_v7_defconfig,
we now get a new warning:

renesas_usbhs/mod.c: In function 'usbhs_interrupt':
renesas_usbhs/mod.c:246:7: warning: 'intenb1' may be used uninitialized in this function [-Wmaybe-uninitialized]

gcc correctly points to a problem here, for the case that the
device is in host mode, we use the intenb1 variable without
having assigned it first. The state->intsts1 has a similar
problem, but gcc cannot know that.

This avoids the problem by initializing both sides of the
comparison to zero when we don't read them from the respective
registers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 88a25e02f3 ("usb: renesas_usbhs: Add access control for INTSTS1 and INTENB1 register")

diff --git a/drivers/usb/renesas_usbhs/mod.c b/drivers/usb/renesas_usbhs/mod.c
index e5ce6e6d4f51..d4be5d594896 100644
--- a/drivers/usb/renesas_usbhs/mod.c
+++ b/drivers/usb/renesas_usbhs/mod.c
@@ -223,6 +223,8 @@ static int usbhs_status_get_each_irq(struct usbhs_priv *priv,
 	if (usbhs_mod_is_host(priv)) {
 		state->intsts1 = usbhs_read(priv, INTSTS1);
 		intenb1 = usbhs_read(priv, INTENB1);
+	} else {
+		state->intsts1 = intenb1 = 0;
 	}
 
 	/* mask */

