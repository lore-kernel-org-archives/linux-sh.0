From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Mon, 01 Jun 2015 14:22:57 +0000
Subject: [PATCH v5 4/4] ARM: shmobile: gose: enable R-Car Gen2 regulator quirk
Message-Id: <1433168577-7678-5-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Regulator setup seems identical to Koelsch.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/mach-shmobile/Kconfig                     | 1 +
 arch/arm/mach-shmobile/Makefile                    | 1 +
 arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c | 3 ++-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index c59d75e..429157d 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -83,6 +83,7 @@ config ARCH_R8A7791
 config ARCH_R8A7793
 	bool "R-Car M2-N (R8A7793)"
 	select ARCH_RCAR_GEN2
+	select I2C
 
 config ARCH_R8A7794
 	bool "R-Car E2 (R8A77940)"
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index e4b8fdb..def7a09 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_ARCH_RCAR_GEN2)	+= setup-rcar-gen2.o platsmp-apmu.o $(cpu-y)
 CFLAGS_setup-rcar-gen2.o	+= -march=armv7-a
 obj-$(CONFIG_ARCH_R8A7790)	+= regulator-quirk-rcar-gen2.o
 obj-$(CONFIG_ARCH_R8A7791)	+= regulator-quirk-rcar-gen2.o
+obj-$(CONFIG_ARCH_R8A7793)	+= regulator-quirk-rcar-gen2.o
 
 # SMP objects
 smp-y				:= $(cpu-y)
diff --git a/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c b/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
index 384e6e9..62437b5 100644
--- a/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
@@ -123,7 +123,8 @@ static int __init rcar_gen2_regulator_quirk(void)
 	u32 mon;
 
 	if (!of_machine_is_compatible("renesas,koelsch") &&
-	    !of_machine_is_compatible("renesas,lager"))
+	    !of_machine_is_compatible("renesas,lager") &&
+	    !of_machine_is_compatible("renesas,gose"))
 		return -ENODEV;
 
 	irqc = ioremap(IRQC_BASE, PAGE_SIZE);
-- 
2.4.2

