From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 18 Mar 2013 11:05:36 +0000
Subject: [PATCH 040/142] sh: shx3: Add pin control resources
Message-Id: <1363604838-29359-41-git-send-email-horms+renesas@verge.net.au>
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
 arch/sh/kernel/cpu/sh4a/pinmux-shx3.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/pinmux-shx3.c b/arch/sh/kernel/cpu/sh4a/pinmux-shx3.c
index ace84ac..444bf25 100644
--- a/arch/sh/kernel/cpu/sh4a/pinmux-shx3.c
+++ b/arch/sh/kernel/cpu/sh4a/pinmux-shx3.c
@@ -7,12 +7,23 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  */
+#include <linux/bug.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/ioport.h>
 #include <cpu/pfc.h>
 
-static int __init shx3_pinmux_setup(void)
+static struct resource shx3_pfc_resources[] = {
+	[0] = {
+		.start	= 0xffc70000,
+		.end	= 0xffc7001f,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static int __init plat_pinmux_setup(void)
 {
-	return sh_pfc_register("pfc-shx3", NULL, 0);
+	return sh_pfc_register("pfc-shx3", shx3_pfc_resources,
+			       ARRAY_SIZE(shx3_pfc_resources));
 }
-arch_initcall(shx3_pinmux_setup);
+arch_initcall(plat_pinmux_setup);
-- 
1.7.10.4

