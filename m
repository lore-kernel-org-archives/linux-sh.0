From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 28 Dec 2012 22:54:00 +0000
Subject: [PATCH v4 18/81] sh-pfc: Sort headers alphabetically
Message-Id: <1356735303-29474-19-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Paul Mundt <lethal@linux-sh.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/sh/pfc/core.c    |   12 ++++++------
 drivers/sh/pfc/gpio.c    |    6 +++---
 drivers/sh/pfc/pinctrl.c |   12 ++++++------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/sh/pfc/core.c b/drivers/sh/pfc/core.c
index 8ec57bd..ccf4b7a 100644
--- a/drivers/sh/pfc/core.c
+++ b/drivers/sh/pfc/core.c
@@ -12,17 +12,17 @@
 #define DRV_NAME "sh-pfc"
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/errno.h>
-#include <linux/kernel.h>
-#include <linux/sh_pfc.h>
-#include <linux/module.h>
+#include <linux/bitops.h>
 #include <linux/err.h>
+#include <linux/errno.h>
 #include <linux/io.h>
-#include <linux/bitops.h>
-#include <linux/slab.h>
 #include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_device.h>
+#include <linux/sh_pfc.h>
+#include <linux/slab.h>
 
 #include "core.h"
 
diff --git a/drivers/sh/pfc/gpio.c b/drivers/sh/pfc/gpio.c
index c11c1bb..a0454f3 100644
--- a/drivers/sh/pfc/gpio.c
+++ b/drivers/sh/pfc/gpio.c
@@ -12,13 +12,13 @@
 #define pr_fmt(fmt) KBUILD_MODNAME " gpio: " fmt
 
 #include <linux/device.h>
-#include <linux/init.h>
 #include <linux/gpio.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
+#include <linux/init.h>
 #include <linux/module.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/sh_pfc.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
 
 #include "core.h"
 
diff --git a/drivers/sh/pfc/pinctrl.c b/drivers/sh/pfc/pinctrl.c
index 47dbd02..221bde0 100644
--- a/drivers/sh/pfc/pinctrl.c
+++ b/drivers/sh/pfc/pinctrl.c
@@ -12,17 +12,17 @@
 #define pr_fmt(fmt) KBUILD_MODNAME " pinctrl: " fmt
 
 #include <linux/device.h>
+#include <linux/err.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/sh_pfc.h>
-#include <linux/err.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
 #include <linux/pinctrl/consumer.h>
-#include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinconf.h>
-#include <linux/pinctrl/pinmux.h>
 #include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/sh_pfc.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
 
 #include "core.h"
 
-- 
1.7.8.6

