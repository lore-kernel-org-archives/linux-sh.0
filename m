From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 17 Jun 2011 04:33:13 +0000
Subject: [PATCH] ARM: mach-shmobile: mackerel: change usbhs devices order
Message-Id: <w3pips5oz5i.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

USB1 can use IRQ interrupt and notify function for usbhs driver,
but USB0 is using polling for it.
The priority of usbhs devices order USB1 > USB0 is good idea

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-mackerel.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 7e1d375..3802f2a 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1287,9 +1287,9 @@ static struct platform_device *mackerel_devices[] __initdata = {
 	&nor_flash_device,
 	&smc911x_device,
 	&lcdc_device,
-	&usbhs0_device,
 	&usb1_host_device,
 	&usbhs1_device,
+	&usbhs0_device,
 	&leds_device,
 	&fsi_device,
 	&fsi_ak4643_device,
-- 
1.7.4.1

