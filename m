From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 20 Dec 2015 18:31:20 +0000
Subject: [PATCH] extcon: max3355: kill unneeded #include's
Message-Id: <6137530.8k1Rzov2Uy@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: myungjoo.ham@samsung.com, cw00.choi@samsung.com, linux-kernel@vger.kernel.org
Cc: linux-usb@vger.kernel.org, linux-sh@vger.kernel.org

Some #include's weren't needed from the start, some are left overs from the
earlier driver versions... Kill 'em all! :-)

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the 'extcon-next' branch of the 'extcon.git' repo.
If possible, please fold this patch into the main MAX3355 driver patch.

 drivers/extcon/extcon-max3355.c |    5 -----
 1 file changed, 5 deletions(-)

Index: extcon/drivers/extcon/extcon-max3355.c
=================================--- extcon.orig/drivers/extcon/extcon-max3355.c
+++ extcon/drivers/extcon/extcon-max3355.c
@@ -11,14 +11,9 @@
 
 #include <linux/extcon.h>
 #include <linux/gpio.h>
-#include <linux/init.h>
 #include <linux/interrupt.h>
-#include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/workqueue.h>
 
 struct max3355_data {
 	struct extcon_dev *edev;

