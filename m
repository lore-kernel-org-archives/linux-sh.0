From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 04 Mar 2013 07:30:19 +0000
Subject: [PATCH] ARM: shmobile: tidyup chip series definition order for r8a7740/r8a7779
Message-Id: <87obezpqpk.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

move r8a7740_meram_workaround() to r8a7740 area
from r8a7779 area

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---

This is based on simon/next branch

 arch/arm/mach-shmobile/include/mach/common.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 2cf3ef3..727e9bc 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -50,6 +50,7 @@ extern struct clk sh73a0_extal2_clk;
 extern struct clk sh73a0_extcki_clk;
 extern struct clk sh73a0_extalr_clk;
 
+extern void r8a7740_meram_workaround(void);
 extern void r8a7740_init_irq(void);
 extern void r8a7740_map_io(void);
 extern void r8a7740_add_early_devices(void);
@@ -80,8 +81,6 @@ extern void r8a7779_add_standard_devices_dt(void);
 extern void r8a7779_clock_init(void);
 extern void r8a7779_pinmux_init(void);
 extern void r8a7779_pm_init(void);
-extern void r8a7740_meram_workaround(void);
-
 extern void r8a7779_register_twd(void);
 
 #ifdef CONFIG_SUSPEND
-- 
1.7.9.5

