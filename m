From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 16 Jan 2015 01:49:19 +0000
Subject: ARM: shmobile: r8a7779: Instantiate GIC from C board code in legacy builds
Message-Id: <20150116014919.30817.13079.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

As of commit 9a1091ef0017c40a ("irqchip: gic: Support hierarchy irq
domain."), Marzen legacy hangs during boot with:

   Image Name:   'Linux-3.19.0-rc4'
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3445880 Bytes = 3.3 MiB
   Load Address: 60008000
   Entry Point:  60008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Enabling DEBUG_LL does not seem to change the situation, however this
patch by itself fixes this issue and re-enables normal boot.

This issue happens because the IRQ numbers of the GIC are now virtual,
and no longer match the hardcoded hardware IRQ numbers in the platform
board code.

To fix this, instantiate the GIC from platform board code when compiling
a legacy kernel, like is done for the sh73a0, r8a7740 and r8a7778 legacy code.

Follows same style as the r8a7740 legacy GIC fix by Geert Uytterhoeven,
thanks to him for the initial work.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written on top of renesas-devel-20150114v2-v3.19-rc4

 arch/arm/mach-shmobile/setup-r8a7779.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/setup-r8a7779.c
+++ work/arch/arm/mach-shmobile/setup-r8a7779.c	2015-01-15 18:48:00.969339495 +0900
@@ -720,10 +720,17 @@ static int r8a7779_set_wake(struct irq_d
 
 void __init r8a7779_init_irq_dt(void)
 {
+#ifdef CONFIG_ARCH_SHMOBILE_LEGACY
+	void __iomem *gic_dist_base = ioremap_nocache(0xf0001000, 0x1000);
+	void __iomem *gic_cpu_base = ioremap_nocache(0xf0000100, 0x1000);
+#endif
 	gic_arch_extn.irq_set_wake = r8a7779_set_wake;
 
+#ifdef CONFIG_ARCH_SHMOBILE_LEGACY
+	gic_init(0, 29, gic_dist_base, gic_cpu_base);
+#else
 	irqchip_init();
-
+#endif
 	/* route all interrupts to ARM */
 	__raw_writel(0xffffffff, INT2NTSR0);
 	__raw_writel(0x3fffffff, INT2NTSR1);
