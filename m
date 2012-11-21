From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 21 Nov 2012 02:53:58 +0000
Subject: [PATCH 42/42] ARM: shmobile: sh7372: Add pin control resources
Message-Id: <1353466438-10929-43-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add memory resources for the pin control platform device to let the
sh-pfc driver ioremap() registers properly instead of evily casting
register physical addresses to virtual addresses.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/pfc-sh7372.c |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/pfc-sh7372.c b/arch/arm/mach-shmobile/pfc-sh7372.c
index 8701118..fa1386b 100644
--- a/arch/arm/mach-shmobile/pfc-sh7372.c
+++ b/arch/arm/mach-shmobile/pfc-sh7372.c
@@ -21,9 +21,27 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/bug.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+
 #include "devices.h"
 
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
 void sh7372_pinmux_init(void)
 {
-	sh_pfc_register("pfc-sh7372", NULL, 0);
+	sh_pfc_register("pfc-sh7372", sh7372_pfc_resources,
+			ARRAY_SIZE(sh7372_pfc_resources));
 }
-- 
1.7.8.6

