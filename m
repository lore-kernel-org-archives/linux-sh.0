From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 22 Feb 2013 04:46:19 +0000
Subject: [PATCH 2/3] ARM: shmobile: armadillo800eva: enable branch prediction on defconfig
Message-Id: <87ppztdkh4.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1351731731-8435-3-git-send-email-horms@verge.net.au>
In-Reply-To: <1351731731-8435-3-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Because defconfig disabled ARM branch prediction
by CONFIG_CPU_BPREDICT_DISABLE,
Armadillo800eva's Bogomips and Loop were not good performance.
This patch enabled Arm branch prediction.
Special thanks to Ishiyama-san

Reported-by: Kiyoshi Ishiyama <kiyoshi.ishiyama.wg@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/configs/armadillo800eva_defconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/armadillo800eva_defconfig b/arch/arm/configs/armadillo800eva_defconfig
index 891318e..dd1592b 100644
--- a/arch/arm/configs/armadillo800eva_defconfig
+++ b/arch/arm/configs/armadillo800eva_defconfig
@@ -20,7 +20,6 @@ CONFIG_ARCH_R8A7740=y
 CONFIG_MACH_ARMADILLO800EVA=y
 # CONFIG_SH_TIMER_TMU is not set
 CONFIG_ARM_THUMB=y
-CONFIG_CPU_BPREDICT_DISABLE=y
 CONFIG_CACHE_L2X0=y
 CONFIG_ARM_ERRATA_430973=y
 CONFIG_ARM_ERRATA_458693=y
-- 
1.7.9.5

