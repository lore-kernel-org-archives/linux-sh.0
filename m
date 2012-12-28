From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 28 Dec 2012 22:54:10 +0000
Subject: [PATCH v4 28/81] ARM: shmobile: sh7372: Add pin control resources
Message-Id: <1356735303-29474-29-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add memory resources for the pin control platform device to let the
sh-pfc driver ioremap() registers properly instead of evily casting
register physical addresses to virtual addresses.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Paul Mundt <lethal@linux-sh.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/pfc-sh7372.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/pfc-sh7372.c b/arch/arm/mach-shmobile/pfc-sh7372.c
index dd5e145..91016b4 100644
--- a/arch/arm/mach-shmobile/pfc-sh7372.c
+++ b/arch/arm/mach-shmobile/pfc-sh7372.c
@@ -20,7 +20,9 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
+#include <linux/bug.h>
 #include <linux/init.h>
+#include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/sh_pfc.h>
@@ -1658,9 +1660,24 @@ static struct pinmux_info sh7372_pinmux_info = {
 	.gpio_irq_size = ARRAY_SIZE(pinmux_irqs),
 };
 
+static struct resource sh7372_pfc_resources[] = {
+	[0] = {
+		.start	= 0xe6050000,
+		.end	= 0xe6057fff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 0xe605800c,
+		.end	= 0xe6058027,
+		.flags	= IORESOURCE_MEM,
+	}
+};
+
 static struct platform_device sh7372_pfc_device = {
 	.name		= "sh-pfc",
 	.id		= -1,
+	.resource	= sh7372_pfc_resources,
+	.num_resources	= ARRAY_SIZE(sh7372_pfc_resources),
 	.dev = {
 		.platform_data = &sh7372_pinmux_info,
 	},
-- 
1.7.8.6

