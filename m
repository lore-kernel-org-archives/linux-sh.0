From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 08 Oct 2013 09:01:28 +0000
Subject: [PATCH] clocksource: em_sti: convert to clk_prepare/unprepare
Message-Id: <1381222888-4199-2-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1381222888-4199-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1381222888-4199-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>

Add calls to clk_prepare and unprepare so that EMMA Mobile EV2 can
migrate to the common clock framework.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/clocksource/em_sti.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/em_sti.c b/drivers/clocksource/em_sti.c
index b9c81b7..a71907c 100644
--- a/drivers/clocksource/em_sti.c
+++ b/drivers/clocksource/em_sti.c
@@ -78,7 +78,7 @@ static int em_sti_enable(struct em_sti_priv *p)
 	int ret;
 
 	/* enable clock */
-	ret = clk_enable(p->clk);
+	ret = clk_prepare_enable(p->clk);
 	if (ret) {
 		dev_err(&p->pdev->dev, "cannot enable clock\n");
 		return ret;
@@ -107,7 +107,7 @@ static void em_sti_disable(struct em_sti_priv *p)
 	em_sti_write(p, STI_INTENCLR, 3);
 
 	/* stop clock */
-	clk_disable(p->clk);
+	clk_disable_unprepare(p->clk);
 }
 
 static cycle_t em_sti_count(struct em_sti_priv *p)
-- 
1.8.4

