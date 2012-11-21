From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 21 Nov 2012 02:53:57 +0000
Subject: [PATCH 41/42] ARM: shmobile: r8a7740: Add pin control resources
Message-Id: <1353466438-10929-42-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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
 arch/arm/mach-shmobile/pfc-r8a7740.c |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/pfc-r8a7740.c b/arch/arm/mach-shmobile/pfc-r8a7740.c
index c711365..0ef8287 100644
--- a/arch/arm/mach-shmobile/pfc-r8a7740.c
+++ b/arch/arm/mach-shmobile/pfc-r8a7740.c
@@ -19,9 +19,27 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/bug.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+
 #include "devices.h"
 
+static struct resource r8a7740_pfc_resources[] = {
+	[0] = {
+		.start	= 0xe6050000,
+		.end	= 0xe6057fff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 0xe605800c,
+		.end	= 0xe605802b,
+		.flags	= IORESOURCE_MEM,
+	}
+};
+
 void r8a7740_pinmux_init(void)
 {
-	sh_pfc_register("pfc-r8a7740", NULL, 0);
+	sh_pfc_register("pfc-r8a7740", r8a7740_pfc_resources,
+			ARRAY_SIZE(r8a7740_pfc_resources));
 }
-- 
1.7.8.6

