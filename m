From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 04 Jul 2012 03:56:08 +0000
Subject: [PATCH 6/7] ARM: shmobile: armadillo800eva: A4LC domain includes LCDC
Message-Id: <87hatotc16.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

It is possible to control LCDC under A4LC domain to reduce power.
This patch enable it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 5002f64..437a84c 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1177,6 +1177,9 @@ static void __init eva_init(void)
 			     ARRAY_SIZE(eva_devices));
 
 	eva_clock_init();
+
+	r8a7740_add_device_to_domain(&r8a7740_a4lc, &lcdc0_device);
+	r8a7740_add_device_to_domain(&r8a7740_a4lc, &hdmi_lcdc_device);
 }
 
 static void __init eva_earlytimer_init(void)
-- 
1.7.5.4

