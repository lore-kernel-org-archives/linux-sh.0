From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 04 Mar 2014 17:47:24 +0000
Subject: [PATCH 17/22] clocksource: sh_mtu2: Sort headers alphabetically
Message-Id: <1393955249-18736-18-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This helps locating duplicates and inserting new headers.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clocksource/sh_mtu2.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/clocksource/sh_mtu2.c b/drivers/clocksource/sh_mtu2.c
index 510bd32..f2c1c36 100644
--- a/drivers/clocksource/sh_mtu2.c
+++ b/drivers/clocksource/sh_mtu2.c
@@ -13,22 +13,22 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/delay.h>
+#include <linux/err.h>
 #include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/spinlock.h>
 #include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/delay.h>
 #include <linux/io.h>
-#include <linux/clk.h>
+#include <linux/ioport.h>
 #include <linux/irq.h>
-#include <linux/err.h>
-#include <linux/clockchips.h>
-#include <linux/sh_timer.h>
-#include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
+#include <linux/sh_timer.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
 
 struct sh_mtu2_device;
 
-- 
1.8.3.2

