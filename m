From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 15 Jun 2015 04:54:13 +0000
Subject: [PATCH 4/6][RFC] arm64: Add new Renesas R-Car Gen3 SoC Kconfig
Message-Id: <87zj41vaja.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Gaku Inami <gaku.inami.xw@bp.renesas.com>

Initial version of device tree for Renesas R-Car Gen3 SoC Kconfig

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm64/Kconfig           | 13 +++++++++++++
 arch/arm64/boot/dts/Makefile |  1 +
 2 files changed, 14 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 99930cf..3c93c03 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -154,6 +154,12 @@ config PGTABLE_LEVELS
 	default 3 if ARM64_4K_PAGES && ARM64_VA_BITS_39
 	default 4 if ARM64_4K_PAGES && ARM64_VA_BITS_48
 
+config ARCH_SHMOBILE
+	bool
+
+config ARCH_SHMOBILE_MULTI
+	bool
+
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
@@ -195,6 +201,13 @@ config ARCH_QCOM
 	help
 	  This enables support for the ARMv8 based Qualcomm chipsets.
 
+config ARCH_RCAR_GEN3
+	bool "Renesas R-Car Gen3 SoC Platform"
+	select ARCH_SHMOBILE
+	select ARCH_SHMOBILE_MULTI
+	help
+	  This enables support for Renesas SoC.
+
 config ARCH_SEATTLE
 	bool "AMD Seattle SoC Family"
 	help
diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index ad26a75..d10f8ff 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -6,6 +6,7 @@ dts-dirs += exynos
 dts-dirs += freescale
 dts-dirs += mediatek
 dts-dirs += qcom
+dts-dirs += renesas
 dts-dirs += sprd
 dts-dirs += xilinx
 
-- 
1.9.1

