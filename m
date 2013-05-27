From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 27 May 2013 09:59:42 +0000
Subject: [PATCH] ARM: shmobile: sh7372 pinmux platform device cleanup
Message-Id: <1369648782-8024-2-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1369648782-8024-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1369648782-8024-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Use DEFINE_RES_MEM() and platform_device_register_simple()
to save a couple of lines of code.

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-sh7372.c |   24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index 5502d62..c70a3cc 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -62,29 +62,15 @@ void __init sh7372_map_io(void)
 }
 
 /* PFC */
-static struct resource sh7372_pfc_resources[] = {
-	[0] = {
-		.start	= 0xe6050000,
-		.end	= 0xe6057fff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= 0xe605800c,
-		.end	= 0xe6058027,
-		.flags	= IORESOURCE_MEM,
-	}
-};
-
-static struct platform_device sh7372_pfc_device = {
-	.name		= "pfc-sh7372",
-	.id		= -1,
-	.resource	= sh7372_pfc_resources,
-	.num_resources	= ARRAY_SIZE(sh7372_pfc_resources),
+static const struct resource pfc_resources[] = {
+	DEFINE_RES_MEM(0xe6050000, 0x8000),
+	DEFINE_RES_MEM(0xe605800c, 0x001c),
 };
 
 void __init sh7372_pinmux_init(void)
 {
-	platform_device_register(&sh7372_pfc_device);
+	platform_device_register_simple("pfc-sh7372", -1, pfc_resources,
+					ARRAY_SIZE(pfc_resources));
 }
 
 /* SCIFA0 */
-- 
1.7.10.4

