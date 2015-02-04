From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 04 Feb 2015 12:27:21 +0000
Subject: [PATCH] clk: shmobile: div6: Avoid division by zero in .round_rate()
Message-Id: <1423052841-15194-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Wolfram Sang <wsa@sang-engineering.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Anyone may call clk_round_rate() with a zero rate value, so we have to
protect against that.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This was triggered by the bad version of "clk: Add rate constraints to
clocks", but can happen regardless, cfr.
https://lkml.org/lkml/2015/1/29/560

 drivers/clk/shmobile/clk-div6.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/shmobile/clk-div6.c b/drivers/clk/shmobile/clk-div6.c
index efbaf6c81b7530b8..036a692c72195db9 100644
--- a/drivers/clk/shmobile/clk-div6.c
+++ b/drivers/clk/shmobile/clk-div6.c
@@ -90,6 +90,9 @@ static unsigned int cpg_div6_clock_calc_div(unsigned long rate,
 {
 	unsigned int div;
 
+	if (!rate)
+		rate = 1;
+
 	div = DIV_ROUND_CLOSEST(parent_rate, rate);
 	return clamp_t(unsigned int, div, 1, 64);
 }
-- 
1.9.1

