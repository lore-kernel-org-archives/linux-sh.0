From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 02 Jul 2015 05:14:02 +0000
Subject: [PATCH 4/4 v2][RFC] arm64: defconfig: Enable Renesas R-Car Gen3 SoC in defconfig
Message-Id: <873817m9dx.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch enables Renesas R-Car Gen3 SoCs in the arm64 defconfig.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
---
v1 -> v2

 - no change

 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2ed7449..eb7c59f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -34,6 +34,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_ARCH_EXYNOS7=y
 CONFIG_ARCH_FSL_LS2085A=y
 CONFIG_ARCH_MEDIATEK=y
+CONFIG_ARCH_RCAR_GEN3=y
 CONFIG_ARCH_SEATTLE=y
 CONFIG_ARCH_TEGRA=y
 CONFIG_ARCH_TEGRA_132_SOC=y
@@ -102,6 +103,9 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_MT6577=y
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
+CONFIG_SERIAL_SH_SCI=y
+CONFIG_SERIAL_SH_SCI_NR_UARTS=6
+CONFIG_SERIAL_SH_SCI_CONSOLE=y
 CONFIG_SERIAL_MSM=y
 CONFIG_SERIAL_MSM_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
-- 
1.9.1

