From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 23 Jan 2015 07:55:16 +0000
Subject: [PATCH] ARM: shmobile: salvage lost CONFIG_REGULATOR
Message-Id: <87fvb2exr7.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

eb4513482d1c4882e3633528ccc48d77581b7bb1
(ARM: shmobile: Enable kzm9g board in multiplatform defconfig)
dropped CONFIG_REGULATOR from shmobile_defconfig.
So, we lost CONFIG_REGULATOR_GPIO or others REGULATORs
Let's salvage these

This patch is using "make savedefconfig"

Reported-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
Geert, Magnus

Can you check this patch ?

 arch/arm/configs/shmobile_defconfig |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 6512c41..46c6623 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -18,7 +18,6 @@ CONFIG_ARCH_R8A7779=y
 CONFIG_ARCH_R8A7790=y
 CONFIG_ARCH_R8A7791=y
 CONFIG_ARCH_R8A7794=y
-CONFIG_ARCH_SH73A0=y
 CONFIG_MACH_MARZEN=y
 CONFIG_CPU_BPREDICT_DISABLE=y
 CONFIG_PL310_ERRATA_588369=y
@@ -55,7 +54,6 @@ CONFIG_IP_PNP_DHCP=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
-CONFIG_SIMPLE_PM_BUS=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_M25P80=y
@@ -118,6 +116,7 @@ CONFIG_WATCHDOG=y
 CONFIG_DA9063_WATCHDOG=y
 CONFIG_MFD_AS3711=y
 CONFIG_MFD_DA9063=y
+CONFIG_REGULATOR=y
 CONFIG_REGULATOR_AS3711=y
 CONFIG_REGULATOR_DA9210=y
 CONFIG_REGULATOR_GPIO=y
@@ -170,7 +169,6 @@ CONFIG_RTC_DRV_RS5C372=y
 CONFIG_RTC_DRV_S35390A=y
 CONFIG_DMADEVICES=y
 CONFIG_SH_DMAE=y
-CONFIG_RCAR_DMAC=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_IIO=y
 CONFIG_AK8975=y
-- 
1.7.9.5

