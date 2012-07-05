From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 05 Jul 2012 08:28:54 +0000
Subject: [PATCH 10/12 v2] ARM: shmobile: mackerel: switch to using pm-rmobile API
Message-Id: <87r4sqpq64.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch switches mackerel platform to use pm-rmobile base common API.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - based on pm-rmobile

 arch/arm/mach-shmobile/board-mackerel.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 9def7c3..7ea2b31 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1623,20 +1623,20 @@ static void __init mackerel_init(void)
 
 	platform_add_devices(mackerel_devices, ARRAY_SIZE(mackerel_devices));
 
-	sh7372_add_device_to_domain(&sh7372_a4lc, &lcdc_device);
-	sh7372_add_device_to_domain(&sh7372_a4lc, &hdmi_lcdc_device);
-	sh7372_add_device_to_domain(&sh7372_a4lc, &meram_device);
-	sh7372_add_device_to_domain(&sh7372_a4mp, &fsi_device);
-	sh7372_add_device_to_domain(&sh7372_a3sp, &usbhs0_device);
-	sh7372_add_device_to_domain(&sh7372_a3sp, &usbhs1_device);
-	sh7372_add_device_to_domain(&sh7372_a3sp, &nand_flash_device);
-	sh7372_add_device_to_domain(&sh7372_a3sp, &sh_mmcif_device);
-	sh7372_add_device_to_domain(&sh7372_a3sp, &sdhi0_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a4lc, &lcdc_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a4lc, &hdmi_lcdc_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a4lc, &meram_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a4mp, &fsi_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a3sp, &usbhs0_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a3sp, &usbhs1_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a3sp, &nand_flash_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a3sp, &sh_mmcif_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a3sp, &sdhi0_device);
 #if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
-	sh7372_add_device_to_domain(&sh7372_a3sp, &sdhi1_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a3sp, &sdhi1_device);
 #endif
-	sh7372_add_device_to_domain(&sh7372_a3sp, &sdhi2_device);
-	sh7372_add_device_to_domain(&sh7372_a4r, &ceu_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a3sp, &sdhi2_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a4r, &ceu_device);
 
 	hdmi_init_pm_clock();
 	sh7372_pm_init();
-- 
1.7.5.4

