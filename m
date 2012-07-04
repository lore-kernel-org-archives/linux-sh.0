From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 04 Jul 2012 03:56:18 +0000
Subject: [PATCH 7/7] ARM: shmobile: armadillo800eva: A3SP domain includes USB
Message-Id: <87fw98tc0w.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Because USB Func is controlled by external IRQ mode,
it is possible to control USB under A3SP domain to reduce power.
This patch enables it.

Armadillo800eva board switchs USB Host/Func by SW1.6,
So, the device to adds into domain is selected on this patch.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 437a84c..2c7d50f 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -953,6 +953,8 @@ clock_error:
 #define GPIO_PORT8CR	0xe6050008
 static void __init eva_init(void)
 {
+	struct platform_device *usb = NULL;
+
 	regulator_register_always_on(0, "fixed-3.3V", fixed3v3_power_consumers,
 				     ARRAY_SIZE(fixed3v3_power_consumers), 3300000);
 
@@ -1050,6 +1052,7 @@ static void __init eva_init(void)
 		gpio_direction_input(GPIO_PORT209);
 
 		platform_device_register(&usbhsf_device);
+		usb = &usbhsf_device;
 	}
 
 	/* SDHI0 */
@@ -1180,6 +1183,8 @@ static void __init eva_init(void)
 
 	r8a7740_add_device_to_domain(&r8a7740_a4lc, &lcdc0_device);
 	r8a7740_add_device_to_domain(&r8a7740_a4lc, &hdmi_lcdc_device);
+	if (usb)
+		r8a7740_add_device_to_domain(&r8a7740_a3sp, usb);
 }
 
 static void __init eva_earlytimer_init(void)
-- 
1.7.5.4

