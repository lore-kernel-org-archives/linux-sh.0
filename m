From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 05 Apr 2011 01:22:33 +0000
Subject: [PATCH/RFC] ARM: arch-shmobile: only run FSI init on respective boards
Message-Id: <w3pk4f9h4q3.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1104041636280.4668@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1104041636280.4668@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

If several boards are enabled in the kernel configuration,
fsi_init_pm_clock() functions from board-ap4evb.c
will run on any of them. Prevent this by calling these functions from the
.init_machine() callback instead of using device_initcall().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Magnus Damm <damm@opensource.se>
---
This patch is depend on Guennadi's
[PATCH/RFC] ARM: arch-shmobile: only run HDMI init on respective boards

 arch/arm/mach-shmobile/board-ap4evb.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 53c15e1..1e35fa9 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -996,7 +996,7 @@ out:
 		clk_put(hdmi_ick);
 }
 
-static int __init fsi_init_pm_clock(void)
+static void __init fsi_init_pm_clock(void)
 {
 	struct clk *fsia_ick;
 	int ret;
@@ -1005,7 +1005,7 @@ static int __init fsi_init_pm_clock(void)
 	if (IS_ERR(fsia_ick)) {
 		ret = PTR_ERR(fsia_ick);
 		pr_err("Cannot get FSI ICK: %d\n", ret);
-		return ret;
+		return;
 	}
 
 	ret = clk_set_parent(fsia_ick, &sh7372_fsiack_clk);
@@ -1013,10 +1013,7 @@ static int __init fsi_init_pm_clock(void)
 		pr_err("Cannot set FSI-A parent: %d\n", ret);
 
 	clk_put(fsia_ick);
-
-	return ret;
 }
-device_initcall(fsi_init_pm_clock);
 
 /*
  * FIXME !!
@@ -1345,6 +1342,7 @@ static void __init ap4evb_init(void)
 	platform_add_devices(ap4evb_devices, ARRAY_SIZE(ap4evb_devices));
 
 	hdmi_init_pm_clock();
+	fsi_init_pm_clock();
 }
 
 static void __init ap4evb_timer_init(void)
-- 
1.7.1

