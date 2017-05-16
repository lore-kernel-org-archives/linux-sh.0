From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 16 May 2017 17:31:20 +0000
Subject: [PATCH 2/2] sh-clk: Delete an error message for a failed memory allocation in two functions
Message-Id: <ba6c79d1-1d60-b20b-94b4-e9c31a80dd90@users.sourceforge.net>
List-Id: <linux-sh.vger.kernel.org>
References: <db01c452-5817-db62-bbde-c4c5cd232a3a@users.sourceforge.net>
In-Reply-To: <db01c452-5817-db62-bbde-c4c5cd232a3a@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 16 May 2017 19:05:36 +0200

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/sh/clk/cpg.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/sh/clk/cpg.c b/drivers/sh/clk/cpg.c
index f23464bbeb7c..b3afe5c4fa3b 100644
--- a/drivers/sh/clk/cpg.c
+++ b/drivers/sh/clk/cpg.c
@@ -253,7 +253,5 @@ static int __init sh_clk_div_register_ops(struct clk *clks, int nr,
-	if (!freq_table) {
-		pr_err("%s: unable to alloc memory\n", __func__);
+	if (!freq_table)
 		return -ENOMEM;
-	}
 
 	for (k = 0; !ret && (k < nr); k++) {
 		clkp = clks + k;
@@ -474,7 +472,5 @@ int __init sh_clk_fsidiv_register(struct clk *clks, int nr)
-		if (!map) {
-			pr_err("%s: unable to alloc memory\n", __func__);
+		if (!map)
 			return -ENOMEM;
-		}
 
 		/* clks[i].enable_reg came from SH_CLK_FSIDIV() */
 		map->phys		= (phys_addr_t)clks[i].enable_reg;
-- 
2.13.0

