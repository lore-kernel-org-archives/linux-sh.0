From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 23 Jun 2014 02:26:37 +0000
Subject: [PATCH 24/24] ARM: shmobile: marzen: Do not use workaround for scif devices
Message-Id: <c1a0f9932b66b2298163c31f8ac3f2844476e1c2.1403487423.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1403487423.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1403487423.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Now that SCIF devices are initialised using DT it should
not be necessary to use the work around to provide clocks any more.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-marzen-reference.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
index bb2df32..0a000b7 100644
--- a/arch/arm/mach-shmobile/board-marzen-reference.c
+++ b/arch/arm/mach-shmobile/board-marzen-reference.c
@@ -40,12 +40,6 @@ static void __init marzen_init_timer(void)
  * devices until they get moved to DT.
  */
 static const struct clk_name clk_names[] __initconst = {
-	{ "scif0", NULL, "sh-sci.0" },
-	{ "scif1", NULL, "sh-sci.1" },
-	{ "scif2", NULL, "sh-sci.2" },
-	{ "scif3", NULL, "sh-sci.3" },
-	{ "scif4", NULL, "sh-sci.4" },
-	{ "scif5", NULL, "sh-sci.5" },
 	{ "tmu0", "fck", "sh-tmu.0" },
 };
 
-- 
2.0.0.rc2

