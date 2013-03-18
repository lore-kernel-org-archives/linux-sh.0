From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 18 Mar 2013 11:05:27 +0000
Subject: [PATCH 031/142] sh: sh7264: Add pin control resources
Message-Id: <1363604838-29359-32-git-send-email-horms+renesas@verge.net.au>
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
 arch/sh/kernel/cpu/sh2a/pinmux-sh7264.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/sh/kernel/cpu/sh2a/pinmux-sh7264.c b/arch/sh/kernel/cpu/sh2a/pinmux-sh7264.c
index b1b7c1b..569decb 100644
--- a/arch/sh/kernel/cpu/sh2a/pinmux-sh7264.c
+++ b/arch/sh/kernel/cpu/sh2a/pinmux-sh7264.c
@@ -8,12 +8,23 @@
  * for more details.
  */
 
+#include <linux/bug.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/ioport.h>
 #include <cpu/pfc.h>
 
+static struct resource sh7264_pfc_resources[] = {
+	[0] = {
+		.start	= 0xfffe3800,
+		.end	= 0xfffe393f,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
 static int __init plat_pinmux_setup(void)
 {
-	return sh_pfc_register("pfc-sh7264", NULL, 0);
+	return sh_pfc_register("pfc-sh7264", sh7264_pfc_resources,
+			       ARRAY_SIZE(sh7264_pfc_resources));
 }
 arch_initcall(plat_pinmux_setup);
-- 
1.7.10.4

