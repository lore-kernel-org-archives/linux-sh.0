From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 07 Nov 2014 10:11:40 +0000
Subject: [PATCH 1/5] i2c: sh_mobile: sort includes alphabetically
Message-Id: <1415355104-2031-2-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1415355104-2031-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1415355104-2031-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Improves readability and reduces chances of duplicates.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 8b5e79cb4468..84efe09eb898 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -20,20 +20,20 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/i2c/i2c-sh_mobile.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/init.h>
-#include <linux/delay.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
-#include <linux/interrupt.h>
-#include <linux/i2c.h>
-#include <linux/err.h>
 #include <linux/pm_runtime.h>
-#include <linux/clk.h>
-#include <linux/io.h>
 #include <linux/slab.h>
-#include <linux/of_device.h>
-#include <linux/i2c/i2c-sh_mobile.h>
 
 /* Transmit operation:                                                      */
 /*                                                                          */
-- 
2.1.1

