From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 20 Aug 2015 09:29:01 +0000
Subject: [PATCH 13/17 v6][RFC] Local: Hack: enable CONFIG_ARCH_SHMOBILE_MULTI temporary
Message-Id: <874mjub9c3.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Gaku Inami <gaku.inami.xw@bp.renesas.com>

Since legacy code is not required in arm64, it is not necessary to use
"CONFIG_ARCH_SHMOBILE_MULTI". But some drivers files have referred to
this config. Until drivers files are fixed, it will use this config in
H3 board.

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v5 -> v6

 - no change

 arch/arm64/Kconfig.platforms | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 8e45879..1e9b0c8 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -54,6 +54,7 @@ config ARCH_QCOM
 config ARCH_RCAR_GEN3
 	bool "Renesas R-Car Gen3 SoC Platform"
 	select ARCH_SHMOBILE
+	select ARCH_SHMOBILE_MULTI
 	help
 	  This enables support for Renesas SoC.
 
@@ -75,6 +76,9 @@ config ARCH_SEATTLE
 config ARCH_SHMOBILE
 	bool
 
+config ARCH_SHMOBILE_MULTI
+	bool
+
 config ARCH_TEGRA
 	bool "NVIDIA Tegra SoC Family"
 	select ARCH_HAS_RESET_CONTROLLER
-- 
1.9.1

