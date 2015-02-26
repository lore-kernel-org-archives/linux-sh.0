From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, 26 Feb 2015 16:42:13 +0000
Subject: [PATCH v4 8/9] ARM: shmobile: r8a7778: enable multiplatform target
Message-Id: <1424968934-30577-9-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Adds config option and enables DTB building.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/Makefile     | 1 +
 arch/arm/mach-shmobile/Kconfig | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 65c13eb..7f098c9 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -474,6 +474,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
 	r7s72100-genmai.dtb \
 	r8a73a4-ape6evm.dtb \
 	r8a7740-armadillo800eva.dtb \
+	r8a7778-bockw.dtb \
 	r8a7779-marzen.dtb \
 	r8a7790-lager.dtb \
 	r8a7791-henninger.dtb \
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 0cbe84a..a3e7412 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -63,6 +63,10 @@ config ARCH_R8A7740
 	select ARCH_RMOBILE
 	select RENESAS_INTC_IRQPIN
 
+config ARCH_R8A7778
+	bool "R-Car M1A (R8A77781)"
+	select ARCH_RCAR_GEN1
+
 config ARCH_R8A7779
 	bool "R-Car H1 (R8A77790)"
 	select ARCH_RCAR_GEN1
-- 
2.2.2

