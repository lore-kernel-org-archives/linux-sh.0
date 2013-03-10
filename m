From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 10 Mar 2013 18:35:42 +0000
Subject: [PATCH 03/23] sh: sh7269: Add pin control resources
Message-Id: <1362940562-8570-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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
 arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c b/arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c
index dc2a868..1825b0b 100644
--- a/arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c
+++ b/arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c
@@ -13,8 +13,17 @@
 #include <linux/kernel.h>
 #include <cpu/pfc.h>
 
+static struct resource sh7269_pfc_resources[] = {
+	[0] = {
+		.start	= 0xfffe3800,
+		.end	= 0xfffe391f,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
 static int __init plat_pinmux_setup(void)
 {
-	return sh_pfc_register("pfc-sh7269", NULL, 0);
+	return sh_pfc_register("pfc-sh7269", sh7269_pfc_resources,
+			       ARRAY_SIZE(sh7269_pfc_resources));
 }
 arch_initcall(plat_pinmux_setup);
-- 
1.8.1.5

