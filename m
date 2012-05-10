From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 10 May 2012 07:10:29 +0000
Subject: [PATCH 2/2] ARM: mach-shmobile: kzm9g: enable SMP boot
Message-Id: <87bolwpl3y.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/configs/kzm9g_defconfig |    4 +++-
 arch/arm/mach-shmobile/platsmp.c |    2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/kzm9g_defconfig b/arch/arm/configs/kzm9g_defconfig
index 4bbea36..e3ebc20 100644
--- a/arch/arm/configs/kzm9g_defconfig
+++ b/arch/arm/configs/kzm9g_defconfig
@@ -31,13 +31,15 @@ CONFIG_ARM_ERRATA_743622=y
 CONFIG_ARM_ERRATA_754322=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_SMP=y
+CONFIG_SCHED_MC=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 # CONFIG_OABI_COMPAT is not set
 CONFIG_HIGHMEM=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="console=tty0 console=ttySC4,115200 root=/dev/nfs ip=dhcp ignore_loglevel earlyprintk=serial"
+CONFIG_CMDLINE="console=tty0 console=ttySC4,115200 root=/dev/nfs ip=dhcp ignore_loglevel earlyprintk=sh-sci.4,115200"
 CONFIG_KEXEC=y
 CONFIG_VFP=y
 CONFIG_NEON=y
diff --git a/arch/arm/mach-shmobile/platsmp.c b/arch/arm/mach-shmobile/platsmp.c
index 45fa392..d959f07 100644
--- a/arch/arm/mach-shmobile/platsmp.c
+++ b/arch/arm/mach-shmobile/platsmp.c
@@ -20,7 +20,7 @@
 #include <asm/mach-types.h>
 #include <mach/common.h>
 
-#define is_sh73a0() (machine_is_ag5evm() || machine_is_kota2())
+#define is_sh73a0() (machine_is_ag5evm() || machine_is_kota2() || machine_is_kzm9g())
 #define is_r8a7779() machine_is_marzen()
 
 static unsigned int __init shmobile_smp_get_core_count(void)
-- 
1.7.5.4

