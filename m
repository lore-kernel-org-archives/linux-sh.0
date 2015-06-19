From: Simon Horman <horms@verge.net.au>
Date: Fri, 19 Jun 2015 08:14:17 +0000
Subject: possible regression caused by "ARM: shmobile: r8a7778: Instantiate
Message-Id: <20150619081416.GA434@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

GIC from C board code in legacy builds"
Reply-To: 

cpu_possible_mask to fix SMP broadcast
Reply-To: 
Organisation: Horms Solutions Ltd.

Hi Magnus, Hi All,

I have observed what appears to be a regression caused by
1fbbc3f0c544 ("ARM: shmobile: r8a7778: Instantiate GIC from C board code in
legacy builds"), which was included in v3.19.

As its subject states,
patch in question is initiates the GIC from C board code in legacy builds.
And this appears to work when booting using non-DT-reference. However,
it causes the boot to fail - I see no console output - for DT-reference.

The patch below is a work-around I used while investigating the problem.

I can think of two solutions:
* A run-time check to see if DT-reference is in use or not:
  possibly by checking for a GIC node in DT.
* Scheduling bockw-reference for removal.

Given our recent discussion of a regression in marzen legacy
I suspect the latter will be preferred.

-- >8 --
From: Simon Horman <horms@verge.net.au>

Subject: [RFC/PATCH] ARM: shmobile: r8a7778: Do not instantiate GIC from C board
 code in DT-reference builds

This is just a work around as it will break booting (non-reference) using
legacy C code if CONFIG_MACH_BOCKW_REFERENCE is enabled.

*** For informational purposes only
*** Not for mainline merge

Fixes: 1fbbc3f0c5440 ("ARM: shmobile: r8a7778: Instantiate GIC from C board
code in legacy builds")
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7778.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index c49aa094fe17..94d5489b4b07 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -592,14 +592,14 @@ void __init r8a7778_init_irq_extpin(int irlm)
 void __init r8a7778_init_irq_dt(void)
 {
 	void __iomem *base = ioremap_nocache(0xfe700000, 0x00100000);
-#ifdef CONFIG_ARCH_SHMOBILE_LEGACY
+#if defined(CONFIG_ARCH_SHMOBILE_LEGACY) && !defined(CONFIG_MACH_BOCKW_REFERENCE)
 	void __iomem *gic_dist_base = ioremap_nocache(0xfe438000, 0x1000);
 	void __iomem *gic_cpu_base = ioremap_nocache(0xfe430000, 0x1000);
 #endif
 
 	BUG_ON(!base);
 
-#ifdef CONFIG_ARCH_SHMOBILE_LEGACY
+#if defined(CONFIG_ARCH_SHMOBILE_LEGACY) && !defined(CONFIG_MACH_BOCKW_REFERENCE)
 	gic_init(0, 29, gic_dist_base, gic_cpu_base);
 #else
 	irqchip_init();
-- 
2.1.4

