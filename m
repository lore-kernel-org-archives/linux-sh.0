From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 06 Aug 2012 05:47:00 +0000
Subject: [PATCH] ARM: shmobile: mackerel: fixup usb module order
Message-Id: <87obmoefn2.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

renesas_usbhs driver can play role as both Host and Gadget.
In case of Gadget, it requires not only renesas_usbhs
but also usb gadget module (like g_ether).
So, renesas_usbhs driver calls usb_add_gadget_udc() on probe time.

Because of this behavior,
Host port plays also Gadget role if kernel has both Host/Gadget support.

In mackerel case, from 0ada2da51800a4914887a9bcf22d563be80e50be
(ARM: mach-shmobile: mackerel: use renesas_usbhs instead of r8a66597_hcd)
usb0 plays Gadget role, and usb1 plays Host role,
and current mackerel board probes as usb1 -> usb0.
Thus, 1st installed usb gadget module (like g_ether) will be
assigned to usb1 (= usb Host port), and 2nd module to usb0 (= usb Gadget port).
It is very confusable for user.
This patch fixup usb modes probing order as usb0 -> usb1.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-mackerel.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 7b53cda..725bff5 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -679,6 +679,7 @@ static struct platform_device usbhs0_device = {
  *  - J30 "open"
  *  - modify usbhs1_get_id() USBHS_HOST -> USBHS_GADGET
  *  - add .get_vbus = usbhs_get_vbus in usbhs1_private
+ *  - check usbhs0_device(pio)/usbhs1_device(irq) order in mackerel_devices.
  */
 #define IRQ8 evt2irq(0x0300)
 #define USB_PHY_MODE		(1 << 4)
@@ -1262,8 +1263,8 @@ static struct platform_device *mackerel_devices[] __initdata = {
 	&nor_flash_device,
 	&smc911x_device,
 	&lcdc_device,
-	&usbhs1_device,
 	&usbhs0_device,
+	&usbhs1_device,
 	&leds_device,
 	&fsi_device,
 	&fsi_ak4643_device,
-- 
1.7.5.4

