From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 12 Oct 2012 05:01:11 +0000
Subject: [PATCH 2/2 v2] ARM: shmobile: armadillo800eva: enable L2X0 cache on defconfig
Message-Id: <87k3uwb7xo.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
>> Simon

very enough for v3.8 ?

 arch/arm/configs/armadillo800eva_defconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/armadillo800eva_defconfig b/arch/arm/configs/armadillo800eva_defconfig
index f78d259..a18593d 100644
--- a/arch/arm/configs/armadillo800eva_defconfig
+++ b/arch/arm/configs/armadillo800eva_defconfig
@@ -20,7 +20,7 @@ CONFIG_MACH_ARMADILLO800EVA=y
 # CONFIG_SH_TIMER_TMU is not set
 CONFIG_ARM_THUMB=y
 CONFIG_CPU_BPREDICT_DISABLE=y
-# CONFIG_CACHE_L2X0 is not set
+CONFIG_CACHE_L2X0=y
 CONFIG_ARM_ERRATA_430973=y
 CONFIG_ARM_ERRATA_458693=y
 CONFIG_ARM_ERRATA_460075=y
-- 
1.7.9.5

