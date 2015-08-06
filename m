From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 06 Aug 2015 08:04:48 +0000
Subject: [PATCH 02/13 v4][RFC] arm64: renesas: Add new Renesas R-Car Gen3 SoC Kconfig
Message-Id: <87twscyhev.wl%kuninori.morimoto.gx@renesas.com>
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
v3 -> v4

 - no change

 arch/arm64/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 318175f..bd1257e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -202,11 +202,20 @@ config ARCH_QCOM
 	help
 	  This enables support for the ARMv8 based Qualcomm chipsets.
 
+config ARCH_RCAR_GEN3
+	bool "Renesas R-Car Gen3 SoC Platform"
+	select ARCH_SHMOBILE
+	help
+	  This enables support for Renesas SoC.
+
 config ARCH_SEATTLE
 	bool "AMD Seattle SoC Family"
 	help
 	  This enables support for AMD Seattle SOC Family
 
+config ARCH_SHMOBILE
+	bool
+
 config ARCH_TEGRA
 	bool "NVIDIA Tegra SoC Family"
 	select ARCH_HAS_RESET_CONTROLLER
-- 
1.9.1

