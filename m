From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 15 May 2013 02:57:28 +0000
Subject: [PATCH v2 2/4] ARM: shmobile: marzen-reference: Update lan device name in pinctrl maps
Message-Id: <1368586650-26263-3-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1368586650-26263-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1368586650-26263-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The ethernet device is instantiated from the device tree, use the
correct name in the pinctrl mappings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-marzen-reference.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
index 480d882..5332e89 100644
--- a/arch/arm/mach-shmobile/board-marzen-reference.c
+++ b/arch/arm/mach-shmobile/board-marzen-reference.c
@@ -43,9 +43,9 @@ static const struct pinctrl_map marzen_pinctrl_map[] = {
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7779",
 				  "sdhi0_wp", "sdhi0"),
 	/* SMSC */
-	PIN_MAP_MUX_GROUP_DEFAULT("smsc911x", "pfc-r8a7779",
+	PIN_MAP_MUX_GROUP_DEFAULT("18000000.lan0", "pfc-r8a7779",
 				  "intc_irq1_b", "intc"),
-	PIN_MAP_MUX_GROUP_DEFAULT("smsc911x", "pfc-r8a7779",
+	PIN_MAP_MUX_GROUP_DEFAULT("18000000.lan0", "pfc-r8a7779",
 				  "lbsc_ex_cs0", "lbsc"),
 };
 
-- 
1.8.2.1

