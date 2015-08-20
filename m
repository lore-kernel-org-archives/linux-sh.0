From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 20 Aug 2015 09:28:21 +0000
Subject: [PATCH 11/17 v6][RFC] arm64: defconfig: renesas: Enable Renesas R-Car Gen3 SoC
Message-Id: <877foqb9d4.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch enables Renesas R-Car Gen3 SoCs in the arm64 defconfig.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v5 -> v6

 - no change

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 34d71dd..8f35763 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -38,6 +38,7 @@ CONFIG_ARCH_FSL_LS2085A=y
 CONFIG_ARCH_HISI=y
 CONFIG_ARCH_MEDIATEK=y
 CONFIG_ARCH_ROCKCHIP=y
+CONFIG_ARCH_RCAR_GEN3=y
 CONFIG_ARCH_SEATTLE=y
 CONFIG_ARCH_TEGRA=y
 CONFIG_ARCH_TEGRA_132_SOC=y
-- 
1.9.1

