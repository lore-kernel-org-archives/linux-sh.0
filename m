From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 07 Jul 2015 14:05:27 +0000
Subject: [PATCH] ARM: shmobile: rcar-gen2: CONFIG_ARM_ARCH_TIMER is always set
Message-Id: <1436277927-20159-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Since commit 731bde02f622d694 ("ARM: shmobile: Select
HAVE_ARM_ARCH_TIMER from Kconfig"), CONFIG_ARM_ARCH_TIMER is always set
when building for R-Car Gen2 SoCs, as it is selected by
CONFIG_HAVE_ARM_ARCH_TIMER.  Remove the obsolete #ifdef testing for it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index aa3339258d9c0232..570d6bd3784f7464 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -52,7 +52,6 @@ u32 rcar_gen2_read_mode_pins(void)
 void __init rcar_gen2_timer_init(void)
 {
 	u32 mode = rcar_gen2_read_mode_pins();
-#ifdef CONFIG_ARM_ARCH_TIMER
 	void __iomem *base;
 	int extal_mhz = 0;
 	u32 freq;
@@ -125,7 +124,6 @@ void __init rcar_gen2_timer_init(void)
 	}
 
 	iounmap(base);
-#endif /* CONFIG_ARM_ARCH_TIMER */
 
 	rcar_gen2_clocks_init(mode);
 	clocksource_of_init();
-- 
1.9.1

