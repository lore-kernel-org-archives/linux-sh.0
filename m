From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 12 Mar 2014 21:04:34 +0000
Subject: [PATCH] clk: shmobile: mstp: Fix the is_enabled() operation
Message-Id: <1394658274-6348-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The MSTP[SC]R registers have clock stop bits, not clock enable bits. The
bit value should thus be inverted in the is_enabled() operation.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clk/shmobile/clk-mstp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Geert, I believe this patch should fix the problem we've noticed with
clk_disable_unused() not disabling unused clocks. Could you please test it ?

diff --git a/drivers/clk/shmobile/clk-mstp.c b/drivers/clk/shmobile/clk-mstp.c
index 42d5912..be45b45 100644
--- a/drivers/clk/shmobile/clk-mstp.c
+++ b/drivers/clk/shmobile/clk-mstp.c
@@ -112,7 +112,7 @@ static int cpg_mstp_clock_is_enabled(struct clk_hw *hw)
 	else
 		value = clk_readl(group->smstpcr);
 
-	return !!(value & BIT(clock->bit_index));
+	return !(value & BIT(clock->bit_index));
 }
 
 static const struct clk_ops cpg_mstp_clock_ops = {
-- 
Regards,

Laurent Pinchart

