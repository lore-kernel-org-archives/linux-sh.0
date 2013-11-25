From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 25 Nov 2013 01:18:22 +0000
Subject: [RFC 07/17] ARM: shmobile: r8a7779: Sort headers alphabetically
Message-Id: <1385342312-1967-8-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-marzen.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index 4f9e3ec..e202c64 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -19,35 +19,35 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#include <linux/kernel.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/traps.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/platform_device.h>
-#include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
 #include <linux/leds.h>
-#include <linux/dma-mapping.h>
+#include <linux/mfd/tmio.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_data/camera-rcar.h>
 #include <linux/platform_data/gpio-rcar.h>
 #include <linux/platform_data/rcar-du.h>
 #include <linux/platform_data/usb-rcar-phy.h>
+#include <linux/platform_device.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/smsc911x.h>
-#include <linux/spi/spi.h>
 #include <linux/spi/sh_hspi.h>
-#include <linux/mmc/host.h>
-#include <linux/mmc/sh_mobile_sdhi.h>
-#include <linux/mfd/tmio.h>
-#include <media/soc_camera.h>
-#include <mach/r8a7779.h>
+#include <linux/spi/spi.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/traps.h>
+#include <mach/r8a7779.h>
+#include <media/soc_camera.h>
 
 /* Fixed 3.3V regulator to be used by SDHI0 */
 static struct regulator_consumer_supply fixed3v3_power_consumers[] = {
-- 
1.8.4

