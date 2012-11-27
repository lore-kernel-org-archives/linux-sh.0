From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 27 Nov 2012 00:03:09 +0000
Subject: [PATCH v2 70/77] sh-pfc: Move sh_pfc.h from include/linux/ to driver directory
Message-Id: <1353974596-30033-71-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The header file isn't used by arch code anymore. Make it private to the
driver.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Paul Mundt <lethal@linux-sh.org>
---
 drivers/pinctrl/sh-pfc/core.c                      |    1 -
 drivers/pinctrl/sh-pfc/core.h                      |    3 ++-
 drivers/pinctrl/sh-pfc/gpio.c                      |    1 -
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c               |    3 ++-
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c               |    3 ++-
 drivers/pinctrl/sh-pfc/pfc-sh7203.c                |    3 ++-
 drivers/pinctrl/sh-pfc/pfc-sh7264.c                |    3 ++-
 drivers/pinctrl/sh-pfc/pfc-sh7269.c                |    3 ++-
 drivers/pinctrl/sh-pfc/pfc-sh7372.c                |    3 ++-
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c                |    3 ++-
 drivers/pinctrl/sh-pfc/pfc-sh7720.c                |    3 ++-
 drivers/pinctrl/sh-pfc/pfc-sh7722.c                |    3 ++-
 drivers/pinctrl/sh-pfc/pfc-sh7723.c                |    3 ++-
 drivers/pinctrl/sh-pfc/pfc-sh7724.c                |    3 ++-
 drivers/pinctrl/sh-pfc/pfc-sh7734.c                |    3 ++-
 drivers/pinctrl/sh-pfc/pfc-sh7757.c                |    3 ++-
 drivers/pinctrl/sh-pfc/pfc-sh7785.c                |    3 ++-
 drivers/pinctrl/sh-pfc/pfc-sh7786.c                |    3 ++-
 drivers/pinctrl/sh-pfc/pfc-shx3.c                  |    3 ++-
 drivers/pinctrl/sh-pfc/pinctrl.c                   |    1 -
 {include/linux => drivers/pinctrl/sh-pfc}/sh_pfc.h |    0
 21 files changed, 34 insertions(+), 20 deletions(-)
 rename {include/linux => drivers/pinctrl/sh-pfc}/sh_pfc.h (100%)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 300e55d..062308f 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -19,7 +19,6 @@
 #include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/sh_pfc.h>
 #include <linux/slab.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_device.h>
diff --git a/drivers/pinctrl/sh-pfc/core.h b/drivers/pinctrl/sh-pfc/core.h
index 8b3a0a5..19e2061 100644
--- a/drivers/pinctrl/sh-pfc/core.h
+++ b/drivers/pinctrl/sh-pfc/core.h
@@ -11,9 +11,10 @@
 #define __SH_PFC_CORE_H__
 
 #include <linux/compiler.h>
-#include <linux/sh_pfc.h>
 #include <linux/types.h>
 
+#include "sh_pfc.h"
+
 struct pfc_window {
 	phys_addr_t phys;
 	void __iomem *virt;
diff --git a/drivers/pinctrl/sh-pfc/gpio.c b/drivers/pinctrl/sh-pfc/gpio.c
index 2a68c12..22df3fe 100644
--- a/drivers/pinctrl/sh-pfc/gpio.c
+++ b/drivers/pinctrl/sh-pfc/gpio.c
@@ -15,7 +15,6 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/pinctrl/consumer.h>
-#include <linux/sh_pfc.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index 0ab4cb6..214788c 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -19,10 +19,11 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 #include <linux/kernel.h>
-#include <linux/sh_pfc.h>
 #include <mach/r8a7740.h>
 #include <mach/irqs.h>
 
+#include "sh_pfc.h"
+
 #define CPU_ALL_PORT(fn, pfx, sfx)					\
 	PORT_10(fn, pfx, sfx),		PORT_90(fn, pfx, sfx),		\
 	PORT_10(fn, pfx##10, sfx),	PORT_90(fn, pfx##1, sfx),	\
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
index 16c9e8c..2ab9ec1 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
@@ -19,9 +19,10 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/sh_pfc.h>
 #include <mach/r8a7779.h>
 
+#include "sh_pfc.h"
+
 #define CPU_32_PORT(fn, pfx, sfx)				\
 	PORT_10(fn, pfx, sfx), PORT_10(fn, pfx##1, sfx),	\
 	PORT_10(fn, pfx##2, sfx), PORT_1(fn, pfx##30, sfx),	\
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7203.c b/drivers/pinctrl/sh-pfc/pfc-sh7203.c
index 62bd173..01b425d 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7203.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7203.c
@@ -10,9 +10,10 @@
 
 #include <linux/kernel.h>
 #include <linux/gpio.h>
-#include <linux/sh_pfc.h>
 #include <cpu/sh7203.h>
 
+#include "sh_pfc.h"
+
 enum {
 	PINMUX_RESERVED = 0,
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7264.c b/drivers/pinctrl/sh-pfc/pfc-sh7264.c
index 66d7692..8270493 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7264.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7264.c
@@ -10,9 +10,10 @@
 
 #include <linux/kernel.h>
 #include <linux/gpio.h>
-#include <linux/sh_pfc.h>
 #include <cpu/sh7264.h>
 
+#include "sh_pfc.h"
+
 enum {
 	PINMUX_RESERVED = 0,
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7269.c b/drivers/pinctrl/sh-pfc/pfc-sh7269.c
index 80da98d..d25825b 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7269.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7269.c
@@ -11,9 +11,10 @@
 
 #include <linux/kernel.h>
 #include <linux/gpio.h>
-#include <linux/sh_pfc.h>
 #include <cpu/sh7269.h>
 
+#include "sh_pfc.h"
+
 enum {
 	PINMUX_RESERVED = 0,
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7372.c b/drivers/pinctrl/sh-pfc/pfc-sh7372.c
index a52fabe..d44e7f0 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7372.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7372.c
@@ -21,10 +21,11 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 #include <linux/kernel.h>
-#include <linux/sh_pfc.h>
 #include <mach/irqs.h>
 #include <mach/sh7372.h>
 
+#include "sh_pfc.h"
+
 #define CPU_ALL_PORT(fn, pfx, sfx) \
 	PORT_10(fn, pfx, sfx),		PORT_90(fn, pfx, sfx), \
 	PORT_10(fn, pfx##10, sfx),	PORT_10(fn, pfx##11, sfx), \
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index 8a0eee9..709008e 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -19,10 +19,11 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 #include <linux/kernel.h>
-#include <linux/sh_pfc.h>
 #include <mach/sh73a0.h>
 #include <mach/irqs.h>
 
+#include "sh_pfc.h"
+
 #define CPU_ALL_PORT(fn, pfx, sfx)				\
 	PORT_10(fn, pfx,    sfx), PORT_10(fn, pfx##1, sfx),	\
 	PORT_10(fn, pfx##2, sfx), PORT_10(fn, pfx##3, sfx),	\
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7720.c b/drivers/pinctrl/sh-pfc/pfc-sh7720.c
index 20d0577..10872ed 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7720.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7720.c
@@ -10,9 +10,10 @@
 
 #include <linux/kernel.h>
 #include <linux/gpio.h>
-#include <linux/sh_pfc.h>
 #include <cpu/sh7720.h>
 
+#include "sh_pfc.h"
+
 enum {
 	PINMUX_RESERVED = 0,
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7722.c b/drivers/pinctrl/sh-pfc/pfc-sh7722.c
index f58f009..2de0929 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7722.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7722.c
@@ -1,9 +1,10 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/gpio.h>
-#include <linux/sh_pfc.h>
 #include <cpu/sh7722.h>
 
+#include "sh_pfc.h"
+
 enum {
 	PINMUX_RESERVED = 0,
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7723.c b/drivers/pinctrl/sh-pfc/pfc-sh7723.c
index 0564099..7943a7a 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7723.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7723.c
@@ -10,9 +10,10 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/sh_pfc.h>
 #include <cpu/sh7723.h>
 
+#include "sh_pfc.h"
+
 enum {
 	PINMUX_RESERVED = 0,
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7724.c b/drivers/pinctrl/sh-pfc/pfc-sh7724.c
index 85b6253..1e3a6c2 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7724.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7724.c
@@ -15,9 +15,10 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/sh_pfc.h>
 #include <cpu/sh7724.h>
 
+#include "sh_pfc.h"
+
 enum {
 	PINMUX_RESERVED = 0,
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7734.c b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
index cbb5f4c..23d76d2 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7734.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
@@ -10,9 +10,10 @@
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/sh_pfc.h>
 #include <cpu/sh7734.h>
 
+#include "sh_pfc.h"
+
 #define CPU_32_PORT(fn, pfx, sfx)				\
 	PORT_10(fn, pfx, sfx), PORT_10(fn, pfx##1, sfx),	\
 	PORT_10(fn, pfx##2, sfx), PORT_1(fn, pfx##30, sfx),	\
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7757.c b/drivers/pinctrl/sh-pfc/pfc-sh7757.c
index 09433b3..07553e3 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7757.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7757.c
@@ -15,9 +15,10 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/sh_pfc.h>
 #include <cpu/sh7757.h>
 
+#include "sh_pfc.h"
+
 enum {
 	PINMUX_RESERVED = 0,
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7785.c b/drivers/pinctrl/sh-pfc/pfc-sh7785.c
index 23f2c31..3b1825d 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7785.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7785.c
@@ -10,9 +10,10 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/sh_pfc.h>
 #include <cpu/sh7785.h>
 
+#include "sh_pfc.h"
+
 enum {
 	PINMUX_RESERVED = 0,
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7786.c b/drivers/pinctrl/sh-pfc/pfc-sh7786.c
index 1d80461..15f1d5a 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7786.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7786.c
@@ -15,9 +15,10 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/sh_pfc.h>
 #include <cpu/sh7786.h>
 
+#include "sh_pfc.h"
+
 enum {
 	PINMUX_RESERVED = 0,
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-shx3.c b/drivers/pinctrl/sh-pfc/pfc-shx3.c
index e21eb24..c5af0cc 100644
--- a/drivers/pinctrl/sh-pfc/pfc-shx3.c
+++ b/drivers/pinctrl/sh-pfc/pfc-shx3.c
@@ -9,9 +9,10 @@
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/sh_pfc.h>
 #include <cpu/shx3.h>
 
+#include "sh_pfc.h"
+
 enum {
 	PINMUX_RESERVED = 0,
 
diff --git a/drivers/pinctrl/sh-pfc/pinctrl.c b/drivers/pinctrl/sh-pfc/pinctrl.c
index 7f3187a..0914f5c 100644
--- a/drivers/pinctrl/sh-pfc/pinctrl.c
+++ b/drivers/pinctrl/sh-pfc/pinctrl.c
@@ -14,7 +14,6 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/sh_pfc.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/pinctrl/consumer.h>
diff --git a/include/linux/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
similarity index 100%
rename from include/linux/sh_pfc.h
rename to drivers/pinctrl/sh-pfc/sh_pfc.h
-- 
1.7.8.6

