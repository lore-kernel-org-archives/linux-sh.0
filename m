From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 15 Oct 2015 06:59:34 +0000
Subject: [PATCH/RFC 3/6] arm: shmobile: rcar-gen2: Obtain MD pin value using boot-mode-reg
Message-Id: <1444892377-10170-4-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Use new boot mode reg infrastructure to obtain the mode pin
value for initialising arch timer for R-Car Gen2 SoCs.

Subsequent patches will remove other calls to rcar_gen2_read_mode_pins()
and in turn that function.

rcar_gen2_init_boot_mode() is called to implicitly initialise
the R-Car Gen2 boot mod register driver as rcar_gen2_timer_init()
is run before initcalls.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig           |  1 +
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 24 +++++++++++++++++++++---
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 88734a5e10ca..79b7db5f6417 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -22,6 +22,7 @@ config ARCH_RCAR_GEN2
 	select RENESAS_IRQC
 	select SYS_SUPPORTS_SH_CMT
 	select PCI_DOMAINS if PCI
+	select BOOT_MODE_REG_RCAR_GEN2
 
 config ARCH_RMOBILE
 	bool
diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index aa3339258d9c..3a2bffd4c1cf 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -24,6 +24,7 @@
 #include <linux/memblock.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
+#include <misc/boot-mode-reg.h>
 #include <asm/mach/arch.h>
 #include "common.h"
 #include "rcar-gen2.h"
@@ -49,13 +50,19 @@ u32 rcar_gen2_read_mode_pins(void)
 #define CNTCR 0
 #define CNTFID0 0x20
 
-void __init rcar_gen2_timer_init(void)
+void __init rcar_gen2_timer_init_for_arch_timer(void)
 {
-	u32 mode = rcar_gen2_read_mode_pins();
 #ifdef CONFIG_ARM_ARCH_TIMER
 	void __iomem *base;
 	int extal_mhz = 0;
-	u32 freq;
+	u32 freq, mode;
+	int err;
+
+	err = boot_mode_reg_get(&mode);
+	if (err) {
+		pr_err("%s: failed obtain boot mode\n", __func__);
+		return;
+	}
 
 	if (of_machine_is_compatible("renesas,r8a7794")) {
 		freq = 260000000 / 8;	/* ZS / 8 */
@@ -126,7 +133,18 @@ void __init rcar_gen2_timer_init(void)
 
 	iounmap(base);
 #endif /* CONFIG_ARM_ARCH_TIMER */
+}
+
+void __init rcar_gen2_timer_init(void)
+{
+	int err;
+	u32 mode = rcar_gen2_read_mode_pins();
+
+	err = rcar_gen2_init_boot_mode();
+	if (err)
+		pr_err("Could not initialise boot mode register driver\n");
 
+	rcar_gen2_timer_init_for_arch_timer();
 	rcar_gen2_clocks_init(mode);
 	clocksource_of_init();
 }
-- 
2.1.4

