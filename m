From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 15 Oct 2010 14:37:24 +0000
Subject: [PATCH] sh: fix clk_get() error handling
Message-Id: <Pine.LNX.4.64.1010151637031.3945@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

clk_get() returns an ERR_PTR(errno) on error and not NULL.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/boards/mach-ecovec24/setup.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index feadf5d..0161deb 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -1260,14 +1260,14 @@ static int __init arch_setup(void)
 
 	/* set SPU2 clock to 83.4 MHz */
 	clk = clk_get(NULL, "spu_clk");
-	if (clk) {
+	if (!IS_ERR(clk)) {
 		clk_set_rate(clk, clk_round_rate(clk, 83333333));
 		clk_put(clk);
 	}
 
 	/* change parent of FSI B */
 	clk = clk_get(NULL, "fsib_clk");
-	if (clk) {
+	if (!IS_ERR(clk)) {
 		clk_register(&fsimckb_clk);
 		clk_set_parent(clk, &fsimckb_clk);
 		clk_set_rate(clk, 11000);
@@ -1285,7 +1285,7 @@ static int __init arch_setup(void)
 
 	/* set VPU clock to 166 MHz */
 	clk = clk_get(NULL, "vpu_clk");
-	if (clk) {
+	if (!IS_ERR(clk)) {
 		clk_set_rate(clk, clk_round_rate(clk, 166000000));
 		clk_put(clk);
 	}
-- 
1.7.1

