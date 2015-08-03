From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 03 Aug 2015 01:53:04 +0000
Subject: [PATCH 2/4 v3][RFC] arm64: Add new Renesas R-Car Gen3 SoC Kconfig
Message-Id: <874mkhw37r.wl%kuninori.morimoto.gx@renesas.com>
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
v2 -> v3

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

