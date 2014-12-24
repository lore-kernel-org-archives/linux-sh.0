From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 24 Dec 2014 14:43:27 +0000
Subject: [PATCH] clk-gate: fix bit # check in clk_register_gate()
Message-Id: <2500887.6mMDBajo0S@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mturquette@linaro.org, linux-kernel@vger.kernel.org, sboyd@codeaurora.org
Cc: linux-sh@vger.kernel.org

In case CLK_GATE_HIWORD_MASK flag is passed to clk_register_gate(), the bit #
should be no higher than 15, however the corresponding check is obviously off-
by-one.

Fixes: 045779942c04 ("clk: gate: add CLK_GATE_HIWORD_MASK")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against Linus' repo because the 'clk-fixes' branch  in  Mike
Turquette's 'linux.git' repo at Linaro seems very outdated. BTW, the repo
at kernel.org specified by the MAINTAINERS file doesn't seem to exist --
can something be done about that?

 drivers/clk/clk-gate.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/drivers/clk/clk-gate.c
=================================--- linux.orig/drivers/clk/clk-gate.c
+++ linux/drivers/clk/clk-gate.c
@@ -128,7 +128,7 @@ struct clk *clk_register_gate(struct dev
 	struct clk_init_data init;
 
 	if (clk_gate_flags & CLK_GATE_HIWORD_MASK) {
-		if (bit_idx > 16) {
+		if (bit_idx > 15) {
 			pr_err("gate bit exceeds LOWORD field\n");
 			return ERR_PTR(-EINVAL);
 		}

