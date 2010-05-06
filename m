From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 06 May 2010 07:17:31 +0000
Subject: [PATCH] sh: as long as CPU_IDLE is broken on SuperH, remove it from
Message-Id: <Pine.LNX.4.64.1005060917070.4557@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/configs/kfr2r09_defconfig         |    4 +---
 arch/sh/configs/rsk7201_defconfig         |    3 +--
 arch/sh/configs/rsk7203_defconfig         |    3 +--
 arch/sh/configs/sdk7786_defconfig         |    4 +---
 arch/sh/configs/sh7724_generic_defconfig  |    4 +---
 arch/sh/configs/sh7770_generic_defconfig  |    4 +---
 arch/sh/configs/sh7785lcr_32bit_defconfig |    4 +---
 arch/sh/configs/urquell_defconfig         |    3 +--
 8 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/arch/sh/configs/kfr2r09_defconfig b/arch/sh/configs/kfr2r09_defconfig
index f22be49..94da62e 100644
--- a/arch/sh/configs/kfr2r09_defconfig
+++ b/arch/sh/configs/kfr2r09_defconfig
@@ -377,9 +377,7 @@ CONFIG_PM=y
 # CONFIG_SUSPEND is not set
 # CONFIG_HIBERNATION is not set
 CONFIG_PM_RUNTIME=y
-CONFIG_CPU_IDLE=y
-CONFIG_CPU_IDLE_GOV_LADDER=y
-CONFIG_CPU_IDLE_GOV_MENU=y
+# CONFIG_CPU_IDLE is not set
 CONFIG_NET=y
 
 #
diff --git a/arch/sh/configs/rsk7201_defconfig b/arch/sh/configs/rsk7201_defconfig
index 2fc635a..970ef1d 100644
--- a/arch/sh/configs/rsk7201_defconfig
+++ b/arch/sh/configs/rsk7201_defconfig
@@ -360,8 +360,7 @@ CONFIG_BINFMT_SHARED_FLAT=y
 CONFIG_PM=y
 # CONFIG_PM_DEBUG is not set
 # CONFIG_PM_RUNTIME is not set
-CONFIG_CPU_IDLE=y
-CONFIG_CPU_IDLE_GOV_LADDER=y
+# CONFIG_CPU_IDLE is not set
 # CONFIG_NET is not set
 
 #
diff --git a/arch/sh/configs/rsk7203_defconfig b/arch/sh/configs/rsk7203_defconfig
index 0169e60..178fce5 100644
--- a/arch/sh/configs/rsk7203_defconfig
+++ b/arch/sh/configs/rsk7203_defconfig
@@ -384,8 +384,7 @@ CONFIG_BINFMT_SHARED_FLAT=y
 CONFIG_PM=y
 # CONFIG_PM_DEBUG is not set
 # CONFIG_PM_RUNTIME is not set
-CONFIG_CPU_IDLE=y
-CONFIG_CPU_IDLE_GOV_LADDER=y
+# CONFIG_CPU_IDLE is not set
 CONFIG_NET=y
 
 #
diff --git a/arch/sh/configs/sdk7786_defconfig b/arch/sh/configs/sdk7786_defconfig
index 9b331ea..389f303 100644
--- a/arch/sh/configs/sdk7786_defconfig
+++ b/arch/sh/configs/sdk7786_defconfig
@@ -447,9 +447,7 @@ CONFIG_PM_DEBUG=y
 CONFIG_PM_VERBOSE=y
 # CONFIG_HIBERNATION is not set
 CONFIG_PM_RUNTIME=y
-CONFIG_CPU_IDLE=y
-CONFIG_CPU_IDLE_GOV_LADDER=y
-CONFIG_CPU_IDLE_GOV_MENU=y
+# CONFIG_CPU_IDLE is not set
 CONFIG_NET=y
 
 #
diff --git a/arch/sh/configs/sh7724_generic_defconfig b/arch/sh/configs/sh7724_generic_defconfig
index a3056b6..d256aee 100644
--- a/arch/sh/configs/sh7724_generic_defconfig
+++ b/arch/sh/configs/sh7724_generic_defconfig
@@ -390,9 +390,7 @@ CONFIG_HIBERNATION_NVS=y
 CONFIG_HIBERNATION=y
 CONFIG_PM_STD_PARTITION=""
 CONFIG_PM_RUNTIME=y
-CONFIG_CPU_IDLE=y
-CONFIG_CPU_IDLE_GOV_LADDER=y
-CONFIG_CPU_IDLE_GOV_MENU=y
+# CONFIG_CPU_IDLE is not set
 # CONFIG_NET is not set
 
 #
diff --git a/arch/sh/configs/sh7770_generic_defconfig b/arch/sh/configs/sh7770_generic_defconfig
index 7b24705..ca0be70 100644
--- a/arch/sh/configs/sh7770_generic_defconfig
+++ b/arch/sh/configs/sh7770_generic_defconfig
@@ -382,9 +382,7 @@ CONFIG_HIBERNATION_NVS=y
 CONFIG_HIBERNATION=y
 CONFIG_PM_STD_PARTITION=""
 # CONFIG_PM_RUNTIME is not set
-CONFIG_CPU_IDLE=y
-CONFIG_CPU_IDLE_GOV_LADDER=y
-CONFIG_CPU_IDLE_GOV_MENU=y
+# CONFIG_CPU_IDLE is not set
 # CONFIG_NET is not set
 
 #
diff --git a/arch/sh/configs/sh7785lcr_32bit_defconfig b/arch/sh/configs/sh7785lcr_32bit_defconfig
index 8330813..fb1f11c 100644
--- a/arch/sh/configs/sh7785lcr_32bit_defconfig
+++ b/arch/sh/configs/sh7785lcr_32bit_defconfig
@@ -412,9 +412,7 @@ CONFIG_PM=y
 # CONFIG_PM_DEBUG is not set
 # CONFIG_HIBERNATION is not set
 # CONFIG_PM_RUNTIME is not set
-CONFIG_CPU_IDLE=y
-CONFIG_CPU_IDLE_GOV_LADDER=y
-CONFIG_CPU_IDLE_GOV_MENU=y
+# CONFIG_CPU_IDLE is not set
 CONFIG_NET=y
 
 #
diff --git a/arch/sh/configs/urquell_defconfig b/arch/sh/configs/urquell_defconfig
index 23bda19..2e63dc5 100644
--- a/arch/sh/configs/urquell_defconfig
+++ b/arch/sh/configs/urquell_defconfig
@@ -420,8 +420,7 @@ CONFIG_PM=y
 # CONFIG_PM_DEBUG is not set
 # CONFIG_HIBERNATION is not set
 # CONFIG_PM_RUNTIME is not set
-CONFIG_CPU_IDLE=y
-CONFIG_CPU_IDLE_GOV_LADDER=y
+# CONFIG_CPU_IDLE is not set
 CONFIG_NET=y
 
 #
-- 
1.6.2.4

