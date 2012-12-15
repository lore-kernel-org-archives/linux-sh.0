From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sat, 15 Dec 2012 22:51:19 +0000
Subject: [PATCH v3 45/81] sh-pfc: Move driver from drivers/sh/ to drivers/pinctrl/
Message-Id: <1355611915-25060-46-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Paul Mundt <lethal@linux-sh.org>
---
 drivers/pinctrl/Kconfig                      |    2 +-
 drivers/pinctrl/Makefile                     |    2 ++
 drivers/{sh/pfc => pinctrl/sh-pfc}/Kconfig   |   16 +++++++++++-----
 drivers/{sh/pfc => pinctrl/sh-pfc}/Makefile  |    2 +-
 drivers/{sh/pfc => pinctrl/sh-pfc}/core.c    |    0
 drivers/{sh/pfc => pinctrl/sh-pfc}/core.h    |    0
 drivers/{sh/pfc => pinctrl/sh-pfc}/gpio.c    |    0
 drivers/{sh/pfc => pinctrl/sh-pfc}/pinctrl.c |    0
 drivers/sh/Kconfig                           |    1 -
 drivers/sh/Makefile                          |    1 -
 10 files changed, 15 insertions(+), 9 deletions(-)
 rename drivers/{sh/pfc => pinctrl/sh-pfc}/Kconfig (57%)
 rename drivers/{sh/pfc => pinctrl/sh-pfc}/Makefile (69%)
 rename drivers/{sh/pfc => pinctrl/sh-pfc}/core.c (100%)
 rename drivers/{sh/pfc => pinctrl/sh-pfc}/core.h (100%)
 rename drivers/{sh/pfc => pinctrl/sh-pfc}/gpio.c (100%)
 rename drivers/{sh/pfc => pinctrl/sh-pfc}/pinctrl.c (100%)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index c31aeb0..a9d3904 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -196,7 +196,7 @@ config PINCTRL_EXYNOS5440
 	select PINCONF
 
 source "drivers/pinctrl/mvebu/Kconfig"
-
+source "drivers/pinctrl/sh-pfc/Kconfig"
 source "drivers/pinctrl/spear/Kconfig"
 
 config PINCTRL_XWAY
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index fc4606f..04e2c6d 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -42,4 +42,6 @@ obj-$(CONFIG_PINCTRL_XWAY)	+= pinctrl-xway.o
 obj-$(CONFIG_PINCTRL_LANTIQ)	+= pinctrl-lantiq.o
 
 obj-$(CONFIG_PLAT_ORION)        += mvebu/
+obj-$(CONFIG_ARCH_SHMOBILE)	+= sh-pfc/
+obj-$(CONFIG_SUPERH)		+= sh-pfc/
 obj-$(CONFIG_PLAT_SPEAR)	+= spear/
diff --git a/drivers/sh/pfc/Kconfig b/drivers/pinctrl/sh-pfc/Kconfig
similarity index 57%
rename from drivers/sh/pfc/Kconfig
rename to drivers/pinctrl/sh-pfc/Kconfig
index eaeabc5..ae69dbe 100644
--- a/drivers/sh/pfc/Kconfig
+++ b/drivers/pinctrl/sh-pfc/Kconfig
@@ -1,18 +1,24 @@
-comment "Pin function controller options"
+#
+# Renesas SH and SH Mobile PINCTRL drivers
+#
 
-config SH_PFC
+if ARCH_SHMOBILE || SUPERH
+
+config PINCTRL_SH_PFC
 	# XXX move off the gpio dependency
 	depends on GENERIC_GPIO
 	select GPIO_SH_PFC if ARCH_REQUIRE_GPIOLIB
-	select PINCTRL_SH_PFC
-	select PINCTRL
 	select PINMUX
 	select PINCONF
 	def_bool y
+	help
+	  This enables pin control drivers for SH and SH Mobile platforms
 
 config GPIO_SH_PFC
 	bool "SuperH PFC GPIO support"
-	depends on SH_PFC && GPIOLIB
+	depends on PINCTRL_SH_PFC && GPIOLIB
 	help
 	  This enables support for GPIOs within the SoC's pin function
 	  controller.
+
+endif
diff --git a/drivers/sh/pfc/Makefile b/drivers/pinctrl/sh-pfc/Makefile
similarity index 69%
rename from drivers/sh/pfc/Makefile
rename to drivers/pinctrl/sh-pfc/Makefile
index 6315cf3..6ba6fb2 100644
--- a/drivers/sh/pfc/Makefile
+++ b/drivers/pinctrl/sh-pfc/Makefile
@@ -2,4 +2,4 @@ sh-pfc-objs			= core.o pinctrl.o
 ifeq ($(CONFIG_GPIO_SH_PFC),y)
 sh-pfc-objs			+= gpio.o
 endif
-obj-y				+= sh-pfc.o
+obj-$(CONFIG_PINCTRL_SH_PFC)	+= sh-pfc.o
diff --git a/drivers/sh/pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
similarity index 100%
rename from drivers/sh/pfc/core.c
rename to drivers/pinctrl/sh-pfc/core.c
diff --git a/drivers/sh/pfc/core.h b/drivers/pinctrl/sh-pfc/core.h
similarity index 100%
rename from drivers/sh/pfc/core.h
rename to drivers/pinctrl/sh-pfc/core.h
diff --git a/drivers/sh/pfc/gpio.c b/drivers/pinctrl/sh-pfc/gpio.c
similarity index 100%
rename from drivers/sh/pfc/gpio.c
rename to drivers/pinctrl/sh-pfc/gpio.c
diff --git a/drivers/sh/pfc/pinctrl.c b/drivers/pinctrl/sh-pfc/pinctrl.c
similarity index 100%
rename from drivers/sh/pfc/pinctrl.c
rename to drivers/pinctrl/sh-pfc/pinctrl.c
diff --git a/drivers/sh/Kconfig b/drivers/sh/Kconfig
index d860ef7..f168a61 100644
--- a/drivers/sh/Kconfig
+++ b/drivers/sh/Kconfig
@@ -1,6 +1,5 @@
 menu "SuperH / SH-Mobile Driver Options"
 
 source "drivers/sh/intc/Kconfig"
-source "drivers/sh/pfc/Kconfig"
 
 endmenu
diff --git a/drivers/sh/Makefile b/drivers/sh/Makefile
index e57895b..fc67f56 100644
--- a/drivers/sh/Makefile
+++ b/drivers/sh/Makefile
@@ -5,7 +5,6 @@ obj-y	:= intc/
 
 obj-$(CONFIG_HAVE_CLK)		+= clk/
 obj-$(CONFIG_MAPLE)		+= maple/
-obj-$(CONFIG_SH_PFC)		+= pfc/
 obj-$(CONFIG_SUPERHYWAY)	+= superhyway/
 
 obj-y				+= pm_runtime.o
-- 
1.7.8.6

