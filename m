From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 09 Apr 2013 09:37:27 +0000
Subject: [PATCH 2/2] ARM: shmobile: bockw: enable boot from shmobile_defconfig
Message-Id: <87sj309h9o.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1365131070-13142-3-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1365131070-13142-3-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

To enable boot from shmobile_defconfig on Bock-W,
it needs
 - memory started from 0x40000000
 - enable R8A7778
 - enable Bock-W board
 - enable TMU

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7778-bockw.dts |    2 +-
 arch/arm/configs/shmobile_defconfig |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
index 0076b1e..1242940 100644
--- a/arch/arm/boot/dts/r8a7778-bockw.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw.dts
@@ -27,6 +27,6 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0x60000000 0x10000000>;
+		reg = <0x40000000 0x10000000>;
 	};
 };
diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 7dba53f..c1fdff9 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -14,13 +14,14 @@ CONFIG_SLAB=y
 CONFIG_ARCH_SHMOBILE=y
 CONFIG_ARCH_SH7372=y
 CONFIG_ARCH_R8A7740=y
+CONFIG_ARCH_R8A7778=y
 CONFIG_ARCH_R8A7790=y
 CONFIG_ARCH_EMEV2=y
 CONFIG_MACH_MACKEREL=y
 CONFIG_MACH_ARMADILLO800EVA=y
+CONFIG_MACH_BOCKW=y
 CONFIG_MACH_LAGER=y
 CONFIG_MACH_KZM9D=y
-# CONFIG_SH_TIMER_TMU is not set
 # CONFIG_SWP_EMULATE is not set
 CONFIG_ARM_ERRATA_430973=y
 CONFIG_ARM_ERRATA_458693=y
-- 
1.7.9.5

