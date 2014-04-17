From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 17 Apr 2014 22:44:53 +0000
Subject: [PATCH 04/14] ARM: shmobile: lager: Annotate clk_names with __initconst
Message-Id: <f71c77286b2c1f809a85e8e42df88eb2ec132e5f.1397774191.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1397774190.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1397774190.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/arm/mach-shmobile/board-lager-reference.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index c76248b..7ff395e 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -89,7 +89,7 @@ static void __init lager_add_du_device(void)
  * This is a really crude hack to provide clkdev support to platform
  * devices until they get moved to DT.
  */
-static const struct clk_name clk_names[] = {
+static const struct clk_name clk_names[] __initconst = {
 	{ "cmt0", NULL, "sh_cmt.0" },
 	{ "scifa0", NULL, "sh-sci.0" },
 	{ "scifa1", NULL, "sh-sci.1" },
-- 
1.8.4

