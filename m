From: Magnus Damm <magnus.damm@gmail.com>
Date: Sun, 16 Mar 2014 21:35:48 +0000
Subject: [PATCH 03/06] ARM: shmobile: Setup reset vector for non-SMP r8a7790
Message-Id: <20140316213548.15598.27573.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Move reset vector setup code for r8a7790 from the SMP support
file to the PM code that gets built both for SMP and non-SMP.

Not-Yet-Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/pm-r8a7790.c    |   40 ++++++++++++++++++++++++++++++--
 arch/arm/mach-shmobile/setup-r8a7790.c |    1 
 arch/arm/mach-shmobile/smp-r8a7790.c   |   30 ------------------------
 3 files changed, 39 insertions(+), 32 deletions(-)

--- 0001/arch/arm/mach-shmobile/pm-r8a7790.c
+++ work/arch/arm/mach-shmobile/pm-r8a7790.c
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
--- 0001/arch/arm/mach-shmobile/setup-r8a7790.c
+++ work/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -284,6 +284,7 @@ static const struct resource cmt00_resou
 
 void __init r8a7790_add_dt_devices(void)
 {
+ 	r8a7790_pm_init();
 	r8a7790_register_scif(0);
 	r8a7790_register_scif(1);
 	r8a7790_register_scif(2);
--- 0001/arch/arm/mach-shmobile/smp-r8a7790.c
+++ work/arch/arm/mach-shmobile/smp-r8a7790.c
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
 	rcar_sysc_power_up(&r8a7790_ca15_scu);
