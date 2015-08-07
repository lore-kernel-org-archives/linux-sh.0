From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 07 Aug 2015 03:15:31 +0000
Subject: [PATCH 02/16 v5][RFC] arm64: renesas: Add new Renesas R-Car Gen3 SoC Kconfig
Message-Id: <87614reqrb.wl%kuninori.morimoto.gx@renesas.com>
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
v4 -> v5

 - based on latest ARM branch (Kconfig.platforms)

 arch/arm64/Kconfig.platforms | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index e2deb18..ee99121 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -55,11 +55,20 @@ config ARCH_ROCKCHIP
 	  This enables support for the ARMv8 based Rockchip chipsets,
 	  like the RK3368.
 
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

