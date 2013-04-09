From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 09 Apr 2013 14:06:01 +0000
Subject: [PATCH] sh-pfc: Remove dependency on GPIOLIB
Message-Id: <1365516361-7544-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Make GPIO support optional for platforms that don't support GPIOLIB.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/Kconfig  | 2 --
 drivers/pinctrl/sh-pfc/core.h   | 1 +
 drivers/pinctrl/sh-pfc/sh_pfc.h | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/Kconfig b/drivers/pinctrl/sh-pfc/Kconfig
index 0e1f99c..3520088 100644
--- a/drivers/pinctrl/sh-pfc/Kconfig
+++ b/drivers/pinctrl/sh-pfc/Kconfig
@@ -5,8 +5,6 @@
 if ARCH_SHMOBILE || SUPERH
 
 config PINCTRL_SH_PFC
-	# XXX move off the gpio dependency
-	depends on GENERIC_GPIO
 	select GPIO_SH_PFC if ARCH_REQUIRE_GPIOLIB
 	select PINMUX
 	select PINCONF
diff --git a/drivers/pinctrl/sh-pfc/core.h b/drivers/pinctrl/sh-pfc/core.h
index 89cb428..6b735b7 100644
--- a/drivers/pinctrl/sh-pfc/core.h
+++ b/drivers/pinctrl/sh-pfc/core.h
@@ -11,6 +11,7 @@
 #define __SH_PFC_CORE_H__
 
 #include <linux/compiler.h>
+#include <linux/spinlock.h>
 #include <linux/types.h>
 
 #include "sh_pfc.h"
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 3b785fc..b170761 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -11,8 +11,8 @@
 #ifndef __SH_PFC_H
 #define __SH_PFC_H
 
+#include <linux/bug.h>
 #include <linux/stringify.h>
-#include <asm-generic/gpio.h>
 
 typedef unsigned short pinmux_enum_t;
 
-- 
Regards,

Laurent Pinchart

