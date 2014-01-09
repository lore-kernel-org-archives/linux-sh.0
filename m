From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 09 Jan 2014 15:33:43 +0000
Subject: [PATCH] ARM: shmobile: clk_get() returns error code on failure
Message-Id: <1389281623-10253-1-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The lager_add_standard_devices() function calls clk_get() but then fails
to check that it returns an error pointer instead of NULL on failure.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>
---
 arch/arm/mach-shmobile/board-lager-reference.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index a6e271d..dc8d76b 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -44,14 +44,14 @@ static void __init lager_add_standard_devices(void)
 
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

