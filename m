From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 13 Mar 2013 22:39:23 +0000
Subject: [PATCH 04/25] sh: sh7720: Add pin control resources
Message-Id: <1363214384-3870-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add memory resources for the pin control platform device to let the
sh-pfc driver ioremap() registers properly instead of evily casting
register physical addresses to virtual addresses.

The memory resource address range has been extracted from the config and
data registes lists in the sh-pfc driver.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/sh/kernel/cpu/sh3/pinmux-sh7720.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh3/pinmux-sh7720.c b/arch/sh/kernel/cpu/sh3/pinmux-sh7720.c
index 7d3744a..26e90a6 100644
--- a/arch/sh/kernel/cpu/sh3/pinmux-sh7720.c
+++ b/arch/sh/kernel/cpu/sh3/pinmux-sh7720.c
@@ -8,13 +8,23 @@
  * for more details.
  */
 
+#include <linux/bug.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/ioport.h>
 #include <cpu/pfc.h>
 
+static struct resource sh7720_pfc_resources[] = {
+	[0] = {
+		.start	= 0xa4050100,
+		.end	= 0xa405016f,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
 static int __init plat_pinmux_setup(void)
 {
-	return sh_pfc_register("pfc-sh7720", NULL, 0);
+	return sh_pfc_register("pfc-sh7720", sh7720_pfc_resources,
+			       ARRAY_SIZE(sh7720_pfc_resources));
 }
-
 arch_initcall(plat_pinmux_setup);
-- 
1.8.1.5

