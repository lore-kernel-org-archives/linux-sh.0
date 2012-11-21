From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 21 Nov 2012 02:53:24 +0000
Subject: [PATCH 08/42] sh-pfc: Sort headers alphabetically
Message-Id: <1353466438-10929-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/sh/pfc/core.c    |   10 +++++-----
 drivers/sh/pfc/gpio.c    |    6 +++---
 drivers/sh/pfc/pinctrl.c |    6 +++---
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/sh/pfc/core.c b/drivers/sh/pfc/core.c
index 3593de5..f1a0c85 100644
--- a/drivers/sh/pfc/core.c
+++ b/drivers/sh/pfc/core.c
@@ -12,15 +12,15 @@
 #define DRV_NAME "sh-pfc"
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/bitops.h>
+#include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
 #include <linux/kernel.h>
-#include <linux/sh_pfc.h>
 #include <linux/module.h>
-#include <linux/err.h>
-#include <linux/io.h>
-#include <linux/bitops.h>
+#include <linux/sh_pfc.h>
 #include <linux/slab.h>
-#include <linux/ioport.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_device.h>
 
diff --git a/drivers/sh/pfc/gpio.c b/drivers/sh/pfc/gpio.c
index 0a85159..9f4f0fd 100644
--- a/drivers/sh/pfc/gpio.c
+++ b/drivers/sh/pfc/gpio.c
@@ -11,13 +11,13 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME " gpio: " fmt
 
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
index 21b8678..c0c8271 100644
--- a/drivers/sh/pfc/pinctrl.c
+++ b/drivers/sh/pfc/pinctrl.c
@@ -11,17 +11,17 @@
 #define DRV_NAME "sh-pfc"
 #define pr_fmt(fmt) KBUILD_MODNAME " pinctrl: " fmt
 
+#include <linux/err.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/sh_pfc.h>
-#include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/pinctrl/consumer.h>
-#include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinconf.h>
-#include <linux/pinctrl/pinmux.h>
 #include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
 
 #include "core.h"
 
-- 
1.7.8.6

