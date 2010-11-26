From: Vasiliy Kulikov <segoon@openwall.com>
Date: Fri, 26 Nov 2010 17:06:28 +0000
Subject: [PATCH] sh: boards: mach-se: use IS_ERR() instead of NULL check
Message-Id: <1290791190-21358-1-git-send-email-segoon@openwall.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org
Cc: Paul Mundt <lethal@linux-sh.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus Damm <damm@opensource.se>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

clk_get() returns ERR_PTR() on error, not NULL.

Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>
---
 Cannot compile this driver, so it is not tested at all.

 arch/sh/boards/mach-se/7724/setup.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index c31d228..6735305 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -871,14 +871,14 @@ static int __init devices_setup(void)
 
 	/* set SPU2 clock to 83.4 MHz */
 	clk = clk_get(NULL, "spu_clk");
-	if (clk) {
+	if (!IS_ERR(clk)) {
 		clk_set_rate(clk, clk_round_rate(clk, 83333333));
 		clk_put(clk);
 	}
 
 	/* change parent of FSI A */
 	clk = clk_get(NULL, "fsia_clk");
-	if (clk) {
+	if (!IS_ERR(clk)) {
 		clk_register(&fsimcka_clk);
 		clk_set_parent(clk, &fsimcka_clk);
 		clk_set_rate(clk, 11000);
-- 
1.7.0.4

