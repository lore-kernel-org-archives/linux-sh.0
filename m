From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 19 Mar 2014 19:06:48 +0000
Subject: [PATCH 3/5] drivers: sh: compile drivers/sh/pm_runtime.c if ARCH_SHMOBILE_MULTI
Message-Id: <1395256010-12222-4-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

If the kernel is built to support multi-ARM configuration with shmobile
support built in, then drivers/sh is not built. This contains the PM
runtime code in drivers/sh/pm_runtime.c, which implicitly enables the bus
clocks for all devices, and thus is quite essential.
Without this, the state of clocks depends on implicit reset state, or on
the bootloader.

If ARCH_SHMOBILE_MULTI then build the drivers/sh directory, but ensure that
bits that may conflict (drivers/sh/clk if the common clock framework is
enabled) or are not used (drivers/sh/intc), are not built.

ARCH_SHMOBILE_MULTI was added a while ago by commit
efacfce5f8a523457e9419a25d52fe39db00b26a ("ARM: shmobile: Introduce
ARCH_SHMOBILE_MULTI"), but drivers/sh was compiled for both
ARCH_SHMOBILE_LEGACY and ARCH_SHMOBILE_MULTI until commit
bf98c1eac1d4a6bcf00532e4fa41d8126cd6c187 ("ARM: Rename ARCH_SHMOBILE to
ARCH_SHMOBILE_LEGACY").

Note that the PM runtime code is not automatically enabled on
ARCH_SHMOBILE_MULTI, to protected the code from running on non-shmobile
platforms.  sh_pm_runtime_init() must be explicitly called from shmobile
platform code. A temporary check is added to make sure the PM runtime code
is enabled only once on ARCH_SHMOBILE_LEGACY.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
[geert: Do not compile intc if ARCH_SHMOBILE_MULTI]
[geert: Do not enable the PM runtime code if ARCH_SHMOBILE_MULTI, based
        on other patches from Ben]
[geert: Reword]
Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 drivers/Makefile        |    2 +-
 drivers/sh/Makefile     |   14 ++++++++------
 drivers/sh/pm_runtime.c |   14 ++++++++++++--
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 8e3b8b06c0b2..3cc8214f9b26 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -118,7 +118,7 @@ obj-$(CONFIG_SGI_SN)		+= sn/
 obj-y				+= firmware/
 obj-$(CONFIG_CRYPTO)		+= crypto/
 obj-$(CONFIG_SUPERH)		+= sh/
-obj-$(CONFIG_ARCH_SHMOBILE_LEGACY)	+= sh/
+obj-$(CONFIG_ARCH_SHMOBILE)	+= sh/
 ifndef CONFIG_ARCH_USES_GETTIMEOFFSET
 obj-y				+= clocksource/
 endif
diff --git a/drivers/sh/Makefile b/drivers/sh/Makefile
index fc67f564f02c..788ed9b59b4e 100644
--- a/drivers/sh/Makefile
+++ b/drivers/sh/Makefile
@@ -1,10 +1,12 @@
 #
 # Makefile for the SuperH specific drivers.
 #
-obj-y	:= intc/
+obj-$(CONFIG_SUPERH)			+= intc/
+obj-$(CONFIG_ARCH_SHMOBILE_LEGACY)	+= intc/
+ifneq ($(CONFIG_COMMON_CLK),y)
+obj-$(CONFIG_HAVE_CLK)			+= clk/
+endif
+obj-$(CONFIG_MAPLE)			+= maple/
+obj-$(CONFIG_SUPERHYWAY)		+= superhyway/
 
-obj-$(CONFIG_HAVE_CLK)		+= clk/
-obj-$(CONFIG_MAPLE)		+= maple/
-obj-$(CONFIG_SUPERHYWAY)	+= superhyway/
-
-obj-y				+= pm_runtime.o
+obj-y					+= pm_runtime.o
diff --git a/drivers/sh/pm_runtime.c b/drivers/sh/pm_runtime.c
index 5cfbd825a9c8..58c114464831 100644
--- a/drivers/sh/pm_runtime.c
+++ b/drivers/sh/pm_runtime.c
@@ -42,16 +42,26 @@ static struct pm_clk_notifier_block platform_bus_notifier = {
 	.con_ids = { NULL, },
 };
 
-static int __init sh_pm_runtime_init(void)
+static bool default_pm_on;
+
+int __init sh_pm_runtime_init(void)
 {
+	if (default_pm_on)
+		return 0;
+
+	default_pm_on = true;
 	pm_clk_add_notifier(&platform_bus_type, &platform_bus_notifier);
 	return 0;
 }
+#if defined(CONFIG_SUPERH) || defined(CONFIG_ARCH_SHMOBILE_LEGACY)
 core_initcall(sh_pm_runtime_init);
+#endif
 
 static int __init sh_pm_runtime_late_init(void)
 {
-	pm_genpd_poweroff_unused();
+	if (default_pm_on)
+		pm_genpd_poweroff_unused();
 	return 0;
 }
+
 late_initcall(sh_pm_runtime_late_init);
-- 
1.7.9.5

