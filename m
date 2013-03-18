From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 18 Mar 2013 11:05:34 +0000
Subject: [PATCH 038/142] sh: sh7785: Add pin control resources
Message-Id: <1363604838-29359-39-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Add memory resources for the pin control platform device to let the
sh-pfc driver ioremap() registers properly instead of evily casting
register physical addresses to virtual addresses.

The memory resource address range has been extracted from the config and
data registes lists in the sh-pfc driver.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/sh/kernel/cpu/sh4a/pinmux-sh7785.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/pinmux-sh7785.c b/arch/sh/kernel/cpu/sh4a/pinmux-sh7785.c
index 01055b8..e336ab8 100644
--- a/arch/sh/kernel/cpu/sh4a/pinmux-sh7785.c
+++ b/arch/sh/kernel/cpu/sh4a/pinmux-sh7785.c
@@ -8,13 +8,23 @@
  * for more details.
  */
 
+#include <linux/bug.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/ioport.h>
 #include <cpu/pfc.h>
 
+static struct resource sh7785_pfc_resources[] = {
+	[0] = {
+		.start	= 0xffe70000,
+		.end	= 0xffe7008f,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
 static int __init plat_pinmux_setup(void)
 {
-	return sh_pfc_register("pfc-sh7785", NULL, 0);
+	return sh_pfc_register("pfc-sh7785", sh7785_pfc_resources,
+			       ARRAY_SIZE(sh7785_pfc_resources));
 }
-
 arch_initcall(plat_pinmux_setup);
-- 
1.7.10.4

