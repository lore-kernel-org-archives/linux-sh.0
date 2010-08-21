From: Matt Fleming <matt@console-pimps.org>
Date: Sat, 21 Aug 2010 14:49:38 +0000
Subject: [PATCH] sh: Set CONFIG_SYSFS_DEPRECATED_V2=n
Message-Id: <20100821144938.GD6510@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
References: <2bf9c3bb585d142503d6b7f3669e2138ba9ed112.1282398356.git.matt@console-pimps.org>
In-Reply-To: <2bf9c3bb585d142503d6b7f3669e2138ba9ed112.1282398356.git.matt@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

As the help for the config option suggests, this option really shouldn't
be set by default for any recent distribution as it changes the layout
of sysfs. I spotted this while running debian when udev got very
confused by the sysfs layout and failed to create some device nodes.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/configs/ap325rxa_defconfig          |    1 -
 arch/sh/configs/cayman_defconfig            |    1 -
 arch/sh/configs/dreamcast_defconfig         |    1 -
 arch/sh/configs/ecovec24-romimage_defconfig |    1 -
 arch/sh/configs/edosk7760_defconfig         |    1 -
 arch/sh/configs/espt_defconfig              |    1 -
 arch/sh/configs/hp6xx_defconfig             |    1 -
 arch/sh/configs/kfr2r09-romimage_defconfig  |    1 -
 arch/sh/configs/kfr2r09_defconfig           |    1 -
 arch/sh/configs/landisk_defconfig           |    1 -
 arch/sh/configs/lboxre2_defconfig           |    1 -
 arch/sh/configs/magicpanelr2_defconfig      |    1 -
 arch/sh/configs/microdev_defconfig          |    1 -
 arch/sh/configs/migor_defconfig             |    1 -
 arch/sh/configs/polaris_defconfig           |    1 -
 arch/sh/configs/r7780mp_defconfig           |    1 -
 arch/sh/configs/r7785rp_defconfig           |    1 -
 arch/sh/configs/rts7751r2d1_defconfig       |    1 -
 arch/sh/configs/rts7751r2dplus_defconfig    |    1 -
 arch/sh/configs/sdk7780_defconfig           |    1 -
 arch/sh/configs/se7343_defconfig            |    1 -
 arch/sh/configs/se7712_defconfig            |    1 -
 arch/sh/configs/se7721_defconfig            |    1 -
 arch/sh/configs/se7722_defconfig            |    1 -
 arch/sh/configs/se7724_defconfig            |    1 -
 arch/sh/configs/se7750_defconfig            |    1 -
 arch/sh/configs/se7751_defconfig            |    1 -
 arch/sh/configs/se7780_defconfig            |    1 -
 arch/sh/configs/sh03_defconfig              |    1 -
 arch/sh/configs/sh2007_defconfig            |    1 -
 arch/sh/configs/sh7710voipgw_defconfig      |    1 -
 arch/sh/configs/sh7763rdp_defconfig         |    1 -
 arch/sh/configs/sh7785lcr_defconfig         |    1 -
 arch/sh/configs/shx3_defconfig              |    1 -
 arch/sh/configs/snapgear_defconfig          |    1 -
 arch/sh/configs/systemh_defconfig           |    1 -
 arch/sh/configs/titan_defconfig             |    1 -
 arch/sh/configs/ul2_defconfig               |    1 -
 38 files changed, 0 insertions(+), 38 deletions(-)

diff --git a/arch/sh/configs/ap325rxa_defconfig b/arch/sh/configs/ap325rxa_defconfig
index 238d683..e533512 100644
--- a/arch/sh/configs/ap325rxa_defconfig
+++ b/arch/sh/configs/ap325rxa_defconfig
@@ -3,7 +3,6 @@ CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_LOG_BUF_SHIFT
-CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_KALLSYMS is not set
 CONFIG_SLAB=y
 CONFIG_MODULES=y
diff --git a/arch/sh/configs/cayman_defconfig b/arch/sh/configs/cayman_defconfig
index b3bf11b..67e1506 100644
--- a/arch/sh/configs/cayman_defconfig
+++ b/arch/sh/configs/cayman_defconfig
@@ -1,7 +1,6 @@
 CONFIG_EXPERIMENTAL=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_LOG_BUF_SHIFT
-CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SLAB=y
 CONFIG_MODULES=y
diff --git a/arch/sh/configs/dreamcast_defconfig b/arch/sh/configs/dreamcast_defconfig
index 3cdee4f..ec243ca 100644
--- a/arch/sh/configs/dreamcast_defconfig
+++ b/arch/sh/configs/dreamcast_defconfig
@@ -2,7 +2,6 @@ CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_LOG_BUF_SHIFT
-CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_SYSCTL_SYSCALL is not set
 CONFIG_SLAB=y
 CONFIG_PROFILING=y
diff --git a/arch/sh/configs/ecovec24-romimage_defconfig b/arch/sh/configs/ecovec24-romimage_defconfig
index 021633b..5fcb17b 100644
--- a/arch/sh/configs/ecovec24-romimage_defconfig
+++ b/arch/sh/configs/ecovec24-romimage_defconfig
@@ -5,7 +5,6 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_KALLSYMS is not set
 CONFIG_SLAB=y
diff --git a/arch/sh/configs/edosk7760_defconfig b/arch/sh/configs/edosk7760_defconfig
index 365f231..e1077a0 100644
--- a/arch/sh/configs/edosk7760_defconfig
+++ b/arch/sh/configs/edosk7760_defconfig
@@ -5,7 +5,6 @@ CONFIG_POSIX_MQUEUE=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_MODULES=y
diff --git a/arch/sh/configs/espt_defconfig b/arch/sh/configs/espt_defconfig
index ca7fc1b..67cb109 100644
--- a/arch/sh/configs/espt_defconfig
+++ b/arch/sh/configs/espt_defconfig
@@ -3,7 +3,6 @@ CONFIG_SYSVIPC=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_NAMESPACES=y
 CONFIG_UTS_NS=y
 CONFIG_IPC_NS=y
diff --git a/arch/sh/configs/hp6xx_defconfig b/arch/sh/configs/hp6xx_defconfig
index 45c18a3..496edcd 100644
--- a/arch/sh/configs/hp6xx_defconfig
+++ b/arch/sh/configs/hp6xx_defconfig
@@ -3,7 +3,6 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT
-CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 # CONFIG_SYSCTL_SYSCALL is not set
 CONFIG_SLAB=y
diff --git a/arch/sh/configs/kfr2r09-romimage_defconfig b/arch/sh/configs/kfr2r09-romimage_defconfig
index d4268b1..029a506 100644
--- a/arch/sh/configs/kfr2r09-romimage_defconfig
+++ b/arch/sh/configs/kfr2r09-romimage_defconfig
@@ -5,7 +5,6 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_KALLSYMS is not set
 CONFIG_SLAB=y
diff --git a/arch/sh/configs/kfr2r09_defconfig b/arch/sh/configs/kfr2r09_defconfig
index ad5d296..fac13de 100644
--- a/arch/sh/configs/kfr2r09_defconfig
+++ b/arch/sh/configs/kfr2r09_defconfig
@@ -5,7 +5,6 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_KALLSYMS is not set
 CONFIG_SLAB=y
diff --git a/arch/sh/configs/landisk_defconfig b/arch/sh/configs/landisk_defconfig
index 14e658e..3670e93 100644
--- a/arch/sh/configs/landisk_defconfig
+++ b/arch/sh/configs/landisk_defconfig
@@ -1,7 +1,6 @@
 CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT
-CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_SYSCTL_SYSCALL is not set
 CONFIG_KALLSYMS_EXTRA_PASS=y
 CONFIG_SLAB=y
diff --git a/arch/sh/configs/lboxre2_defconfig b/arch/sh/configs/lboxre2_defconfig
index 6be7eaa..e3c0894 100644
--- a/arch/sh/configs/lboxre2_defconfig
+++ b/arch/sh/configs/lboxre2_defconfig
@@ -1,7 +1,6 @@
 CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT
-CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_SYSCTL_SYSCALL is not set
 CONFIG_KALLSYMS_EXTRA_PASS=y
 CONFIG_SLAB=y
diff --git a/arch/sh/configs/magicpanelr2_defconfig b/arch/sh/configs/magicpanelr2_defconfig
index 4d61b77..9479872 100644
--- a/arch/sh/configs/magicpanelr2_defconfig
+++ b/arch/sh/configs/magicpanelr2_defconfig
@@ -5,7 +5,6 @@ CONFIG_POSIX_MQUEUE=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_AUDIT=y
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_RELAY=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
diff --git a/arch/sh/configs/microdev_defconfig b/arch/sh/configs/microdev_defconfig
index 0e32a24..f1d2e1b 100644
--- a/arch/sh/configs/microdev_defconfig
+++ b/arch/sh/configs/microdev_defconfig
@@ -1,7 +1,6 @@
 CONFIG_EXPERIMENTAL=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_LOG_BUF_SHIFT
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 # CONFIG_SYSCTL_SYSCALL is not set
diff --git a/arch/sh/configs/migor_defconfig b/arch/sh/configs/migor_defconfig
index c19fcdf..9ad904a 100644
--- a/arch/sh/configs/migor_defconfig
+++ b/arch/sh/configs/migor_defconfig
@@ -3,7 +3,6 @@ CONFIG_SYSVIPC=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 # CONFIG_SYSCTL_SYSCALL is not set
diff --git a/arch/sh/configs/polaris_defconfig b/arch/sh/configs/polaris_defconfig
index 984e3fe..f3d5d9f 100644
--- a/arch/sh/configs/polaris_defconfig
+++ b/arch/sh/configs/polaris_defconfig
@@ -7,7 +7,6 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_AUDIT=y
 CONFIG_LOG_BUF_SHIFT
-CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SLAB=y
 CONFIG_MODULES=y
diff --git a/arch/sh/configs/r7780mp_defconfig b/arch/sh/configs/r7780mp_defconfig
index e8b5472..920b847 100644
--- a/arch/sh/configs/r7780mp_defconfig
+++ b/arch/sh/configs/r7780mp_defconfig
@@ -4,7 +4,6 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT
-CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_SYSCTL_SYSCALL is not set
 # CONFIG_FUTEX is not set
 # CONFIG_EPOLL is not set
diff --git a/arch/sh/configs/r7785rp_defconfig b/arch/sh/configs/r7785rp_defconfig
index fd88480..c77da6b 100644
--- a/arch/sh/configs/r7785rp_defconfig
+++ b/arch/sh/configs/r7785rp_defconfig
@@ -8,7 +8,6 @@ CONFIG_RCU_TRACE=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT
-CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_SYSCTL_SYSCALL is not set
 CONFIG_SLAB=y
 CONFIG_PROFILING=y
diff --git a/arch/sh/configs/rts7751r2d1_defconfig b/arch/sh/configs/rts7751r2d1_defconfig
index a42f7c2..a3d0810 100644
--- a/arch/sh/configs/rts7751r2d1_defconfig
+++ b/arch/sh/configs/rts7751r2d1_defconfig
@@ -1,7 +1,6 @@
 CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT
-CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 # CONFIG_SYSCTL_SYSCALL is not set
 CONFIG_SLAB=y
diff --git a/arch/sh/configs/rts7751r2dplus_defconfig b/arch/sh/configs/rts7751r2dplus_defconfig
index 742aa61..b1a04f3 100644
--- a/arch/sh/configs/rts7751r2dplus_defconfig
+++ b/arch/sh/configs/rts7751r2dplus_defconfig
@@ -1,7 +1,6 @@
 CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT
-CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 # CONFIG_SYSCTL_SYSCALL is not set
 CONFIG_SLAB=y
diff --git a/arch/sh/configs/sdk7780_defconfig b/arch/sh/configs/sdk7780_defconfig
index aed394d..ae11158 100644
--- a/arch/sh/configs/sdk7780_defconfig
+++ b/arch/sh/configs/sdk7780_defconfig
@@ -6,7 +6,6 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_RELAY=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_MODULES=y
diff --git a/arch/sh/configs/se7343_defconfig b/arch/sh/configs/se7343_defconfig
index 7a7e138..be9c474 100644
--- a/arch/sh/configs/se7343_defconfig
+++ b/arch/sh/configs/se7343_defconfig
@@ -3,7 +3,6 @@ CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_LOG_BUF_SHIFT
-CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_SYSCTL_SYSCALL is not set
 # CONFIG_FUTEX is not set
 # CONFIG_EPOLL is not set
diff --git a/arch/sh/configs/se7712_defconfig b/arch/sh/configs/se7712_defconfig
index 3620a7f..1248635 100644
--- a/arch/sh/configs/se7712_defconfig
+++ b/arch/sh/configs/se7712_defconfig
@@ -5,7 +5,6 @@ CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_LOG_BUF_SHIFT
-CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_KALLSYMS_ALL=y
 # CONFIG_BUG is not set
diff --git a/arch/sh/configs/se7721_defconfig b/arch/sh/configs/se7721_defconfig
index fe22f59..c3ba6e8 100644
--- a/arch/sh/configs/se7721_defconfig
+++ b/arch/sh/configs/se7721_defconfig
@@ -5,7 +5,6 @@ CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_LOG_BUF_SHIFT
-CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_KALLSYMS_ALL=y
 # CONFIG_BUG is not set
diff --git a/arch/sh/configs/se7722_defconfig b/arch/sh/configs/se7722_defconfig
index b9b64c3..ae998c7 100644
--- a/arch/sh/configs/se7722_defconfig
+++ b/arch/sh/configs/se7722_defconfig
@@ -4,7 +4,6 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_PROFILING=y
 CONFIG_MODULES=y
diff --git a/arch/sh/configs/se7724_defconfig b/arch/sh/configs/se7724_defconfig
index 03e7367..ed35093 100644
--- a/arch/sh/configs/se7724_defconfig
+++ b/arch/sh/configs/se7724_defconfig
@@ -3,7 +3,6 @@ CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_LOG_BUF_SHIFT
-CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_KALLSYMS is not set
 CONFIG_SLAB=y
 CONFIG_MODULES=y
diff --git a/arch/sh/configs/se7750_defconfig b/arch/sh/configs/se7750_defconfig
index 1a686b6..912c985 100644
--- a/arch/sh/configs/se7750_defconfig
+++ b/arch/sh/configs/se7750_defconfig
@@ -5,7 +5,6 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT
-CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 # CONFIG_SYSCTL_SYSCALL is not set
 # CONFIG_HOTPLUG is not set
diff --git a/arch/sh/configs/se7751_defconfig b/arch/sh/configs/se7751_defconfig
index 7e03451..75c92fc 100644
--- a/arch/sh/configs/se7751_defconfig
+++ b/arch/sh/configs/se7751_defconfig
@@ -2,7 +2,6 @@ CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_LOG_BUF_SHIFT
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 # CONFIG_SYSCTL_SYSCALL is not set
diff --git a/arch/sh/configs/se7780_defconfig b/arch/sh/configs/se7780_defconfig
index 4cfc4de..c8c5e7f 100644
--- a/arch/sh/configs/se7780_defconfig
+++ b/arch/sh/configs/se7780_defconfig
@@ -3,7 +3,6 @@ CONFIG_SYSVIPC=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT
-CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_KALLSYMS is not set
 # CONFIG_HOTPLUG is not set
 # CONFIG_EPOLL is not set
diff --git a/arch/sh/configs/sh03_defconfig b/arch/sh/configs/sh03_defconfig
index b95dc76..2051821 100644
--- a/arch/sh/configs/sh03_defconfig
+++ b/arch/sh/configs/sh03_defconfig
@@ -3,7 +3,6 @@ CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_LOG_BUF_SHIFT
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_SYSCTL_SYSCALL is not set
 CONFIG_SLAB=y
diff --git a/arch/sh/configs/sh2007_defconfig b/arch/sh/configs/sh2007_defconfig
index c492796..0d2f414 100644
--- a/arch/sh/configs/sh2007_defconfig
+++ b/arch/sh/configs/sh2007_defconfig
@@ -7,7 +7,6 @@ CONFIG_AUDIT=y
 CONFIG_AUDITSYSCALL=y
 CONFIG_IKCONFIG=y
 CONFIG_LOG_BUF_SHIFT
-CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_KALLSYMS_ALL=y
 CONFIG_SLAB=y
diff --git a/arch/sh/configs/sh7710voipgw_defconfig b/arch/sh/configs/sh7710voipgw_defconfig
index b804641..f92ad17 100644
--- a/arch/sh/configs/sh7710voipgw_defconfig
+++ b/arch/sh/configs/sh7710voipgw_defconfig
@@ -3,7 +3,6 @@ CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_LOG_BUF_SHIFT
-CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_SYSCTL_SYSCALL is not set
 # CONFIG_FUTEX is not set
 # CONFIG_EPOLL is not set
diff --git a/arch/sh/configs/sh7763rdp_defconfig b/arch/sh/configs/sh7763rdp_defconfig
index 3618767..4795364 100644
--- a/arch/sh/configs/sh7763rdp_defconfig
+++ b/arch/sh/configs/sh7763rdp_defconfig
@@ -3,7 +3,6 @@ CONFIG_SYSVIPC=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_NAMESPACES=y
 CONFIG_UTS_NS=y
 CONFIG_IPC_NS=y
diff --git a/arch/sh/configs/sh7785lcr_defconfig b/arch/sh/configs/sh7785lcr_defconfig
index ee6b81f..51561f5 100644
--- a/arch/sh/configs/sh7785lcr_defconfig
+++ b/arch/sh/configs/sh7785lcr_defconfig
@@ -4,7 +4,6 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_SLAB=y
 CONFIG_PROFILING=y
 CONFIG_MODULES=y
diff --git a/arch/sh/configs/shx3_defconfig b/arch/sh/configs/shx3_defconfig
index bb4f60c..3f92d37 100644
--- a/arch/sh/configs/shx3_defconfig
+++ b/arch/sh/configs/shx3_defconfig
@@ -15,7 +15,6 @@ CONFIG_CGROUP_DEVICE=y
 CONFIG_CGROUP_CPUACCT=y
 CONFIG_RESOURCE_COUNTERS=y
 CONFIG_CGROUP_MEM_RES_CTLR=y
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_RELAY=y
 CONFIG_NAMESPACES=y
 CONFIG_UTS_NS=y
diff --git a/arch/sh/configs/snapgear_defconfig b/arch/sh/configs/snapgear_defconfig
index f38c983..7eae4e5 100644
--- a/arch/sh/configs/snapgear_defconfig
+++ b/arch/sh/configs/snapgear_defconfig
@@ -1,7 +1,6 @@
 CONFIG_EXPERIMENTAL=y
 # CONFIG_SWAP is not set
 CONFIG_LOG_BUF_SHIFT
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_SYSCTL_SYSCALL is not set
 # CONFIG_HOTPLUG is not set
diff --git a/arch/sh/configs/systemh_defconfig b/arch/sh/configs/systemh_defconfig
index 7007d00..b58dfc5 100644
--- a/arch/sh/configs/systemh_defconfig
+++ b/arch/sh/configs/systemh_defconfig
@@ -1,6 +1,5 @@
 CONFIG_EXPERIMENTAL=y
 CONFIG_LOG_BUF_SHIFT
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 # CONFIG_SYSCTL_SYSCALL is not set
diff --git a/arch/sh/configs/titan_defconfig b/arch/sh/configs/titan_defconfig
index 45c309f..0f55891 100644
--- a/arch/sh/configs/titan_defconfig
+++ b/arch/sh/configs/titan_defconfig
@@ -5,7 +5,6 @@ CONFIG_POSIX_MQUEUE=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 # CONFIG_SYSCTL_SYSCALL is not set
diff --git a/arch/sh/configs/ul2_defconfig b/arch/sh/configs/ul2_defconfig
index e107d42..2d288b8 100644
--- a/arch/sh/configs/ul2_defconfig
+++ b/arch/sh/configs/ul2_defconfig
@@ -4,7 +4,6 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_PROFILING=y
 CONFIG_MODULES=y
-- 
1.7.1

