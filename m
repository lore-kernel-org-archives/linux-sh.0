From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 10 Jul 2015 06:37:02 +0000
Subject: [PATCH 15/16] ARM: shmobile: R-Car Gen2: CONFIG_ARCH_SHMOBILE_MULTI is always set
Message-Id: <d62ba10c31ac16aaa16f5b49308658ea2f1e71a9.1436509680.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1436509680.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1436509680.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Since commit e042681894b62d60 ("ARM: shmobile: r8a7790: Remove legacy
code"), all R-Car Gen2 SoCs are supported by multiplatform kernels only.
As CONFIG_ARCH_SHMOBILE_MULTI is always set for shmobile multiplatform
kernels, we can remove related #ifdefs in code specific to R-Car Gen2
SoCs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 5d13595aa027..aa3339258d9c 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -128,9 +128,7 @@ void __init rcar_gen2_timer_init(void)
 #endif /* CONFIG_ARM_ARCH_TIMER */
 
 	rcar_gen2_clocks_init(mode);
-#ifdef CONFIG_ARCH_SHMOBILE_MULTI
 	clocksource_of_init();
-#endif
 }
 
 struct memory_reserve_config {
-- 
2.1.4

