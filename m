From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 05 Jul 2012 08:29:17 +0000
Subject: [PATCH 11/12 v2] ARM: shmobile: ap4evb: switch to using pm-rmobile API
Message-Id: <87pq8apq5h.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch switches ap4evb platform to use pm-rmobile base common API.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - based on pm-rmobile

 arch/arm/mach-shmobile/board-ap4evb.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 3a8548a..f172ca8 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -1461,14 +1461,14 @@ static void __init ap4evb_init(void)
 
 	platform_add_devices(ap4evb_devices, ARRAY_SIZE(ap4evb_devices));
 
-	sh7372_add_device_to_domain(&sh7372_a4lc, &lcdc1_device);
-	sh7372_add_device_to_domain(&sh7372_a4lc, &lcdc_device);
-	sh7372_add_device_to_domain(&sh7372_a4mp, &fsi_device);
-
-	sh7372_add_device_to_domain(&sh7372_a3sp, &sh_mmcif_device);
-	sh7372_add_device_to_domain(&sh7372_a3sp, &sdhi0_device);
-	sh7372_add_device_to_domain(&sh7372_a3sp, &sdhi1_device);
-	sh7372_add_device_to_domain(&sh7372_a4r, &ceu_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a4lc, &lcdc1_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a4lc, &lcdc_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a4mp, &fsi_device);
+
+	rmobile_add_device_to_domain(&sh7372_pd_a3sp, &sh_mmcif_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a3sp, &sdhi0_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a3sp, &sdhi1_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a4r, &ceu_device);
 
 	hdmi_init_pm_clock();
 	fsi_init_pm_clock();
-- 
1.7.5.4

