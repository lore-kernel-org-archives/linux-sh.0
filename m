From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 06 Jun 2014 07:21:11 +0000
Subject: [PATCH v2 06/07] ARM: shmobile: Move r8a7791 reset code to pm-r8a7791.c
Message-Id: <20140606072111.14868.23305.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Move r8a7791 specific reset vector setup code from the
SMP glue code to PM code. This makes the code one step
closer to allow PM operations such as Suspend-to-RAM
in the case when SMP is disabled in the kernel config.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/pm-r8a7791.c  |   28 ++++++++++++++++++++++++++--
 arch/arm/mach-shmobile/smp-r8a7791.c |   24 ------------------------
 2 files changed, 26 insertions(+), 26 deletions(-)

--- 0001/arch/arm/mach-shmobile/pm-r8a7791.c
+++ work/arch/arm/mach-shmobile/pm-r8a7791.c	2014-06-06 14:58:04.000000000 +0900
@@ -9,12 +9,18 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  */
-
-#include <asm/io.h>
 #include <linux/kernel.h>
+#include <linux/smp.h>
+#include <asm/io.h>
+#include <mach/common.h>
 #include <mach/pm-rcar.h>
 #include <mach/r8a7791.h>
 
+#define RST		0xe6160000
+#define CA15BAR		0x0020
+#define CA15RESCNT	0x0040
+#define RAM		0xe6300000
+
 /* SYSC */
 #define SYSCIER 0x0c
 #define SYSCIMR 0x10
@@ -38,10 +44,28 @@ static inline void r8a7791_sysc_init(voi
 
 void __init r8a7791_pm_init(void)
 {
+	void __iomem *p;
+	u32 bar;
 	static int once;
 
 	if (once++)
 		return;
 
+	/* RAM for jump stub, because BAR requires 256KB aligned address */
+	p = ioremap_nocache(RAM, shmobile_boot_size);
+	memcpy_toio(p, shmobile_boot_vector, shmobile_boot_size);
+	iounmap(p);
+
+	/* setup reset vectors */
+	p = ioremap_nocache(RST, 0x63);
+	bar = (RAM >> 8) & 0xfffffc00;
+	writel_relaxed(bar, p + CA15BAR);
+	writel_relaxed(bar | 0x10, p + CA15BAR);
+
+	/* enable clocks to all CPUs */
+	writel_relaxed((readl_relaxed(p + CA15RESCNT) & ~0x0f) | 0xa5a50000,
+		       p + CA15RESCNT);
+	iounmap(p);
+
 	r8a7791_sysc_init();
 }
--- 0001/arch/arm/mach-shmobile/smp-r8a7791.c
+++ work/arch/arm/mach-shmobile/smp-r8a7791.c	2014-06-06 14:58:20.000000000 +0900
@@ -22,35 +22,11 @@
 #include <mach/r8a7791.h>
 #include <mach/rcar-gen2.h>
 
-#define RST		0xe6160000
-#define CA15BAR		0x0020
-#define CA15RESCNT	0x0040
-#define RAM		0xe6300000
-
 static void __init r8a7791_smp_prepare_cpus(unsigned int max_cpus)
 {
-	void __iomem *p;
-	u32 bar;
-
 	/* let APMU code install data related to shmobile_boot_vector */
 	shmobile_smp_apmu_prepare_cpus(max_cpus);
 
-	/* RAM for jump stub, because BAR requires 256KB aligned address */
-	p = ioremap_nocache(RAM, shmobile_boot_size);
-	memcpy_toio(p, shmobile_boot_vector, shmobile_boot_size);
-	iounmap(p);
-
-	/* setup reset vectors */
-	p = ioremap_nocache(RST, 0x63);
-	bar = (RAM >> 8) & 0xfffffc00;
-	writel_relaxed(bar, p + CA15BAR);
-	writel_relaxed(bar | 0x10, p + CA15BAR);
-
-	/* enable clocks to all CPUs */
-	writel_relaxed((readl_relaxed(p + CA15RESCNT) & ~0x0f) | 0xa5a50000,
-		       p + CA15RESCNT);
-	iounmap(p);
-
 	r8a7791_pm_init();
 	shmobile_smp_apmu_suspend_init();
 }
