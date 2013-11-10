From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 10 Nov 2013 03:15:52 +0000
Subject: [PATCH v2 5/8] ARM: shmobile: Remove non-multiplatform Lager reference support
Message-Id: <1384053355-30703-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Now that r8a7790 has CCF support remove the legacy Lager reference
Kconfig bits CONFIG_MACH_LAGER_REFERENCE for the non-multiplatform
case.

Starting from this commit Lager board support is always enabled via
CONFIG_MACH_LAGER, and CONFIG_ARCH_MULTIPLATFORM is used to select
between board-lager.c and board-lager-reference.c

The file board-lager-reference.c can no longer be used together with
the legacy sh-clk clock framework, instead CCF is used.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/Makefile           |  1 -
 arch/arm/mach-shmobile/Kconfig       | 11 -----------
 arch/arm/mach-shmobile/Makefile      |  1 -
 arch/arm/mach-shmobile/Makefile.boot |  1 -
 4 files changed, 14 deletions(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index eea1304..27414c9 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -208,7 +208,6 @@ dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += emev2-kzm9d.dtb \
 	r8a7791-koelsch.dtb \
 	r8a7791-koelsch-reference.dtb \
 	r8a7790-lager.dtb \
-	r8a7790-lager-reference.dtb \
 	sh73a0-kzm9g.dtb \
 	sh73a0-kzm9g-reference.dtb \
 	r8a73a4-ape6evm.dtb \
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 3887f0e..2e4cb61 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -229,17 +229,6 @@ config MACH_LAGER
 	depends on ARCH_R8A7790
 	select USE_OF
 
-config MACH_LAGER_REFERENCE
-	bool "Lager board - Reference Device Tree Implementation"
-	depends on ARCH_R8A7790
-	select USE_OF
-	---help---
-	   Use reference implementation of Lager board support
-	   which makes use of device tree at the expense
-	   of not supporting a number of devices.
-
-	   This is intended to aid developers
-
 config MACH_KOELSCH
 	bool "Koelsch board"
 	depends on ARCH_R8A7791
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 32f3975..d94fc5e 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -68,7 +68,6 @@ obj-$(CONFIG_MACH_GENMAI)	+= board-genmai.o
 obj-$(CONFIG_MACH_MARZEN)	+= board-marzen.o
 obj-$(CONFIG_MACH_MARZEN_REFERENCE)	+= board-marzen-reference.o
 obj-$(CONFIG_MACH_LAGER)	+= board-lager.o
-obj-$(CONFIG_MACH_LAGER_REFERENCE)	+= board-lager-reference.o
 obj-$(CONFIG_MACH_ARMADILLO800EVA)	+= board-armadillo800eva.o
 obj-$(CONFIG_MACH_ARMADILLO800EVA_REFERENCE)	+= board-armadillo800eva-reference.o
 obj-$(CONFIG_MACH_KOELSCH)	+= board-koelsch.o
diff --git a/arch/arm/mach-shmobile/Makefile.boot b/arch/arm/mach-shmobile/Makefile.boot
index ae6f9b7..b60d90d 100644
--- a/arch/arm/mach-shmobile/Makefile.boot
+++ b/arch/arm/mach-shmobile/Makefile.boot
@@ -13,7 +13,6 @@ loadaddr-$(CONFIG_MACH_KZM9D) += 0x40008000
 loadaddr-$(CONFIG_MACH_KZM9G) += 0x41008000
 loadaddr-$(CONFIG_MACH_KZM9G_REFERENCE) += 0x41008000
 loadaddr-$(CONFIG_MACH_LAGER) += 0x40008000
-loadaddr-$(CONFIG_MACH_LAGER_REFERENCE) += 0x40008000
 loadaddr-$(CONFIG_MACH_MACKEREL) += 0x40008000
 loadaddr-$(CONFIG_MACH_MARZEN) += 0x60008000
 loadaddr-$(CONFIG_MACH_MARZEN_REFERENCE) += 0x60008000
-- 
1.8.1.5

