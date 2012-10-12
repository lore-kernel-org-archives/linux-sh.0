From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 12 Oct 2012 01:24:46 +0000
Subject: [PATCH] ARM: shmobile: armadillo800eva: __io abuse cleanup
Message-Id: <87sj9kbhye.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fw7w38mf.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fw7w38mf.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

a2a47ca36642e3995e982957bc42678cf11ca6ac
(ARM: __io abuse cleanup) cleanuped __io() -> IOMEM(),
but armadillo800eva was a outside of a target,
since "merge window" timing issue.
This patch cleanup it, and enabled CONFIG_CACHE_L2X0

Cc: Masahiro Nakai <nakai@atmark-techno.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/configs/armadillo800eva_defconfig     |    2 +-
 arch/arm/mach-shmobile/board-armadillo800eva.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 2912eab..3cc8b1c 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1196,7 +1196,7 @@ static void __init eva_init(void)
 
 #ifdef CONFIG_CACHE_L2X0
 	/* Early BRESP enable, Shared attribute override enable, 32K*8way */
-	l2x0_init(__io(0xf0002000), 0x40440000, 0x82000fff);
+	l2x0_init(IOMEM(0xf0002000), 0x40440000, 0x82000fff);
 #endif
 
 	i2c_register_board_info(0, i2c0_devices, ARRAY_SIZE(i2c0_devices));
-- 
1.7.9.5

