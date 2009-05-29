From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Fri, 29 May 2009 07:41:26 +0000
Subject: [PATCH] sh: fix CONFIG_SH_PCLK_FREQ bug for sh7724
Message-Id: <umy8wwe3d.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

CONFIG_SH_PCLK_FREQ3333333 is correct for sh7724.
sh7724 master clock is 33333333, but peripheral is 41666666.
This bug came to light because sh-sci driver had changed clk
from "module_clk" to "peripheral_clk"

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/Kconfig                  |    3 +--
 arch/sh/configs/se7724_defconfig |    2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index c815975..c506099 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -503,8 +503,7 @@ config SH_PCLK_FREQ
 			      CPU_SUBTYPE_SH7760 || CPU_SUBTYPE_SH7705 || \
 			      CPU_SUBTYPE_SH7203 || CPU_SUBTYPE_SH7206 || \
 			      CPU_SUBTYPE_SH7263 || CPU_SUBTYPE_MXG    || \
-			      CPU_SUBTYPE_SH7786
-	default "41666666" if CPU_SUBTYPE_SH7724
+			      CPU_SUBTYPE_SH7786 || CPU_SUBTYPE_SH7724
 	default "60000000" if CPU_SUBTYPE_SH7751 || CPU_SUBTYPE_SH7751R
 	default "66000000" if CPU_SUBTYPE_SH4_202
 	default "50000000"
diff --git a/arch/sh/configs/se7724_defconfig b/arch/sh/configs/se7724_defconfig
index a029d0f..96d2587 100644
--- a/arch/sh/configs/se7724_defconfig
+++ b/arch/sh/configs/se7724_defconfig
@@ -243,7 +243,7 @@ CONFIG_SH_7724_SOLUTION_ENGINE=y
 #
 CONFIG_SH_TIMER_TMU=y
 # CONFIG_SH_TIMER_CMT is not set
-CONFIG_SH_PCLK_FREQA666666
+CONFIG_SH_PCLK_FREQ3333333
 # CONFIG_NO_HZ is not set
 # CONFIG_HIGH_RES_TIMERS is not set
 CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
-- 
1.6.0.4

