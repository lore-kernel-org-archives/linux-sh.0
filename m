From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue, 14 Jan 2014 18:43:27 +0000
Subject: [PATCH 2/2] ARM: shmobile: koelsch: fix error return code check from clk_get()
Message-Id: <1389725007-5023-3-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The koelsch_add_standard_devices() function calls clk_get() but then fails
to check that it returns an error pointer instead of NULL on failure.

This was added by f31239ef ("ARM: shmobile: koelsch-reference:
Instantiate clkdevs for SCIF and CMT") in horms' renesas-boards2-for-v3.14~6
release.

The issue is not serious as it does not cause a crash and seems to not be
actually causing any issues now the other clock bugs have been fixed.

Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/mach-shmobile/board-koelsch-reference.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
index 652b592..feb8d97 100644
--- a/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
@@ -45,14 +45,14 @@ static void __init koelsch_add_standard_devices(void)
 
 	for (i = 0; i < ARRAY_SIZE(scif_names); ++i) {
 		clk = clk_get(NULL, scif_names[i]);
-		if (clk) {
+		if (!IS_ERR(clk)) {
 			clk_register_clkdev(clk, NULL, "sh-sci.%u", i);
 			clk_put(clk);
 		}
 	}
 
 	clk = clk_get(NULL, "cmt0");
-	if (clk) {
+	if (!IS_ERR(clk)) {
 		clk_register_clkdev(clk, NULL, "sh_cmt.0");
 		clk_put(clk);
 	}
-- 
1.8.5.2

