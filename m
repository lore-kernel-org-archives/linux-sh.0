From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 29 Apr 2009 14:50:37 +0000
Subject: [PATCH] clocksource: sh_cmt 16-bit fixes
Message-Id: <20090429145037.16210.25996.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch contains various fixes for 16-bit cmt hardware.
With this applied periodic clockevents work fine on sh7203.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/clocksource/sh_cmt.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- 0001/drivers/clocksource/sh_cmt.c
+++ work/drivers/clocksource/sh_cmt.c	2009-04-21 21:58:39.000000000 +0900
@@ -153,16 +153,18 @@ static int sh_cmt_enable(struct sh_cmt_p
 		pr_err("sh_cmt: cannot enable clock \"%s\"\n", cfg->clk);
 		return ret;
 	}
-	*rate = clk_get_rate(p->clk) / 8;
 
 	/* make sure channel is disabled */
 	sh_cmt_start_stop_ch(p, 0);
 
 	/* configure channel, periodic mode and maximum timeout */
-	if (p->width = 16)
-		sh_cmt_write(p, CMCSR, 0);
-	else
+	if (p->width = 16) {
+		*rate = clk_get_rate(p->clk) / 512;
+		sh_cmt_write(p, CMCSR, 0x43);
+	} else {
+		*rate = clk_get_rate(p->clk) / 8;
 		sh_cmt_write(p, CMCSR, 0x01a4);
+	}
 
 	sh_cmt_write(p, CMCOR, 0xffffffff);
 	sh_cmt_write(p, CMCNT, 0);
@@ -545,7 +547,7 @@ static int sh_cmt_setup(struct sh_cmt_pr
 	if (resource_size(res) = 6) {
 		p->width = 16;
 		p->overflow_bit = 0x80;
-		p->clear_bits = ~0xc0;
+		p->clear_bits = ~0x80;
 	} else {
 		p->width = 32;
 		p->overflow_bit = 0x8000;
