From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 17 Mar 2014 02:19:56 +0000
Subject: [PATCH] ARM: shmobile: koelsch-reference: Annotate clk_names as __initconst
Message-Id: <1395022796-3199-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-koelsch-reference.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Based on renesas-devel-v3.14-rc6-20140314
Requires "ARM: shmobile: koelsch-reference: Work around core clock issues"

diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
index a39114a..63117d52 100644
--- a/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
@@ -110,7 +110,7 @@ static const struct clk_name clk_names[] __initconst = {
 /*
  * This is a really crude hack to work around core platform clock issues
  */
-static const struct clk_name clk_enables[] = {
+static const struct clk_name clk_enables[] __initconst = {
 	{ "ether", NULL, "ee700000.ethernet" },
 	{ "i2c2", NULL, "e6530000.i2c" },
 	{ "msiof0", NULL, "e6e20000.spi" },
-- 
1.8.5.2

