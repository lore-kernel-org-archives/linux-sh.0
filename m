From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 05 Jun 2014 05:15:28 +0000
Subject: [PATCH 03/08] ARM: shmobile: Move r8a7790 reset code to pm-r8a7790.c
Message-Id: <20140605051528.18075.47881.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Move r8a7790 specific reset vector setup code from the
SMP glue code to PM code. This makes the code one step
closer to allow PM operations such as Suspend-to-RAM
in the case when SMP is disabled in the kernel config.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/pm-r8a7790.c  |   40 ++++++++++++++++++++++++++++++++--
 arch/arm/mach-shmobile/smp-r8a7790.c |   30 -------------------------
 2 files changed, 38 insertions(+), 32 deletions(-)

--- 0001/arch/arm/mach-shmobile/pm-r8a7790.c
+++ work/arch/arm/mach-shmobile/pm-r8a7790.c	2014-06-05 11:25:46.000000000 +0900
@@ -11,10 +11,22 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/smp.h>
 #include <asm/io.h>
+#include <mach/common.h>
 #include <mach/pm-rcar.h>
 #include <mach/r8a7790.h>
 
+/* RST */
+#define RST		0xe6160000
+#define CA15BAR		0x0020
+#define CA7BAR		0x0030
+#define CA15RESCNT	0x0040
+#define CA7RESCNT	0x0044
+
+/* On-chip RAM */
+#define MERAM		0xe8080000
+
 /* SYSC */
 #define SYSCIER 0x0c
 #define SYSCIMR 0x10
@@ -38,8 +50,32 @@ static inline void r8a7790_sysc_init(voi
 
 void __init r8a7790_pm_init(void)
 {
+	void __iomem *p;
+	u32 bar;
 	static int once;
 
-	if (!once++)
-		r8a7790_sysc_init();
+	if (once++)
+		return;
+
+	/* MERAM for jump stub, because BAR requires 256KB aligned address */
+	p = ioremap_nocache(MERAM, shmobile_boot_size);
+	memcpy_toio(p, shmobile_boot_vector, shmobile_boot_size);
+	iounmap(p);
+
+	/* setup reset vectors */
+	p = ioremap_nocache(RST, 0x63);
+	bar = (MERAM >> 8) & 0xfffffc00;
+	writel_relaxed(bar, p + CA15BAR);
+	writel_relaxed(bar, p + CA7BAR);
+	writel_relaxed(bar | 0x10, p + CA15BAR);
+	writel_relaxed(bar | 0x10, p + CA7BAR);
+
+	/* de-assert reset for all CPUs */
+	writel_relaxed((readl_relaxed(p + CA15RESCNT) & ~0x0f) | 0xa5a50000,
+		       p + CA15RESCNT);
+	writel_relaxed((readl_relaxed(p + CA7RESCNT) & ~0x0f) | 0x5a5a0000,
+		       p + CA7RESCNT);
+	iounmap(p);
+
+	r8a7790_sysc_init();
 }
--- 0001/arch/arm/mach-shmobile/smp-r8a7790.c
+++ work/arch/arm/mach-shmobile/smp-r8a7790.c	2014-06-05 11:25:46.000000000 +0900
@@ -22,13 +22,6 @@
 #include <mach/pm-rcar.h>
 #include <mach/r8a7790.h>
 
-#define RST		0xe6160000
-#define CA15BAR		0x0020
-#define CA7BAR		0x0030
-#define CA15RESCNT	0x0040
-#define CA7RESCNT	0x0044
-#define MERAM		0xe8080000
-
 static struct rcar_sysc_ch r8a7790_ca15_scu = {
 	.chan_offs = 0x180, /* PWRSR5 .. PWRER5 */
 	.isr_bit = 12, /* CA15-SCU */
@@ -41,32 +34,9 @@ static struct rcar_sysc_ch r8a7790_ca7_s
 
 static void __init r8a7790_smp_prepare_cpus(unsigned int max_cpus)
 {
-	void __iomem *p;
-	u32 bar;
-
 	/* let APMU code install data related to shmobile_boot_vector */
 	shmobile_smp_apmu_prepare_cpus(max_cpus);
 
-	/* MERAM for jump stub, because BAR requires 256KB aligned address */
-	p = ioremap_nocache(MERAM, shmobile_boot_size);
-	memcpy_toio(p, shmobile_boot_vector, shmobile_boot_size);
-	iounmap(p);
-
-	/* setup reset vectors */
-	p = ioremap_nocache(RST, 0x63);
-	bar = (MERAM >> 8) & 0xfffffc00;
-	writel_relaxed(bar, p + CA15BAR);
-	writel_relaxed(bar, p + CA7BAR);
-	writel_relaxed(bar | 0x10, p + CA15BAR);
-	writel_relaxed(bar | 0x10, p + CA7BAR);
-
-	/* enable clocks to all CPUs */
-	writel_relaxed((readl_relaxed(p + CA15RESCNT) & ~0x0f) | 0xa5a50000,
-		       p + CA15RESCNT);
-	writel_relaxed((readl_relaxed(p + CA7RESCNT) & ~0x0f) | 0x5a5a0000,
-		       p + CA7RESCNT);
-	iounmap(p);
-
 	/* turn on power to SCU */
 	r8a7790_pm_init();
 	shmobile_smp_apmu_suspend_init();
