From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 06 Jul 2015 21:04:55 +0000
Subject: [PATCH] clk: shmobile: emev2: annotate smu base pointer
Message-Id: <1436216708-1815-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

sparse rightfully says:

drivers/clk/shmobile/clk-emev2.c:39:14: warning: symbol 'smu_base' was not declared. Should it be static?

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/clk/shmobile/clk-emev2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/shmobile/clk-emev2.c b/drivers/clk/shmobile/clk-emev2.c
index 6c7c929c776557..5b60beb7d0ebce 100644
--- a/drivers/clk/shmobile/clk-emev2.c
+++ b/drivers/clk/shmobile/clk-emev2.c
@@ -34,7 +34,7 @@
 static DEFINE_SPINLOCK(lock);
 
 /* not pretty, but hey */
-void __iomem *smu_base;
+static void __iomem *smu_base;
 
 static void __init emev2_smu_write(unsigned long value, int offs)
 {
-- 
2.1.4

