From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 28 Nov 2013 01:03:47 +0000
Subject: [PATCH v3 10/15] ARM: shmobile: Remove non-multiplatform Koelsch reference support
Message-Id: <1385600632-5181-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Now that r8a7791 has CCF support remove the legacy Koelsch reference
Kconfig bits CONFIG_MACH_KOELSCH_REFERENCE for the non-multiplatform
case.

Starting from this commit Koelsch board support is always enabled via
CONFIG_MACH_KOELSCH, and CONFIG_ARCH_MULTIPLATFORM is used to select
between board-koelsch.c and board-koelsch-reference.c

The file board-koelsch-reference.c can no longer be used together with
the legacy sh-clk clock framework, instead CCF is used.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/Makefile           |  1 -
 arch/arm/mach-shmobile/Kconfig       | 11 -----------
 arch/arm/mach-shmobile/Makefile      |  1 -
 arch/arm/mach-shmobile/Makefile.boot |  1 -
 4 files changed, 14 deletions(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0457edb..37aefa2 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -226,7 +226,6 @@ dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += emev2-kzm9d.dtb \
 	r8a7779-marzen.dtb \
 	r8a7779-marzen-reference.dtb \
 	r8a7791-koelsch.dtb \
-	r8a7791-koelsch-reference.dtb \
 	r8a7790-lager.dtb \
 	sh73a0-kzm9g.dtb \
 	sh73a0-kzm9g-reference.dtb \
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 82b75f5..38e9514 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -262,17 +262,6 @@ config MACH_KOELSCH
 	depends on ARCH_R8A7791
 	select USE_OF
 
-config MACH_KOELSCH_REFERENCE
-	bool "Koelsch board - Reference Device Tree Implementation"
-	depends on ARCH_R8A7791
-	select USE_OF
-	---help---
-	   Use reference implementation of Koelsch board support
-	   which makes use of device tree at the expense
-	   of not supporting a number of devices.
-
-	   This is intended to aid developers
-
 config MACH_KZM9G
 	bool "KZM-A9-GT board"
 	depends on ARCH_SH73A0
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index fad94ee..fe7d4ff 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -74,7 +74,6 @@ obj-$(CONFIG_MACH_LAGER)	+= board-lager.o
 obj-$(CONFIG_MACH_ARMADILLO800EVA)	+= board-armadillo800eva.o
 obj-$(CONFIG_MACH_ARMADILLO800EVA_REFERENCE)	+= board-armadillo800eva-reference.o
 obj-$(CONFIG_MACH_KOELSCH)	+= board-koelsch.o
-obj-$(CONFIG_MACH_KOELSCH_REFERENCE)	+= board-koelsch-reference.o
 obj-$(CONFIG_MACH_KZM9G)	+= board-kzm9g.o
 obj-$(CONFIG_MACH_KZM9G_REFERENCE)	+= board-kzm9g-reference.o
 endif
diff --git a/arch/arm/mach-shmobile/Makefile.boot b/arch/arm/mach-shmobile/Makefile.boot
index f6d5119..99455ec 100644
--- a/arch/arm/mach-shmobile/Makefile.boot
+++ b/arch/arm/mach-shmobile/Makefile.boot
@@ -9,7 +9,6 @@ loadaddr-$(CONFIG_MACH_BOCKW_REFERENCE) += 0x60008000
 loadaddr-$(CONFIG_MACH_GENMAI) += 0x08008000
 loadaddr-$(CONFIG_MACH_GENMAI_REFERENCE) += 0x08008000
 loadaddr-$(CONFIG_MACH_KOELSCH) += 0x40008000
-loadaddr-$(CONFIG_MACH_KOELSCH_REFERENCE) += 0x40008000
 loadaddr-$(CONFIG_MACH_KZM9G) += 0x41008000
 loadaddr-$(CONFIG_MACH_KZM9G_REFERENCE) += 0x41008000
 loadaddr-$(CONFIG_MACH_LAGER) += 0x40008000
-- 
1.8.3.2

