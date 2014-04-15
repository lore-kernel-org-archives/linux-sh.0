From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 15 Apr 2014 12:34:08 +0000
Subject: [PATCH v2 12/17] clk: shmobile: mstp: Fix the is_enabled() operation
Message-Id: <1397565253-22741-13-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The MSTP[SC]R registers have clock stop bits, not clock enable bits. The
bit value should thus be inverted in the is_enabled() operation.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Mike Turquette <mturquette@linaro.org>
---
This depends on the actual fixes, so either we need Mike's ack, or this has
to wait until the fixes have landed in mainline.

v2:
  - New

 drivers/clk/shmobile/clk-mstp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/shmobile/clk-mstp.c b/drivers/clk/shmobile/clk-mstp.c
index 2e5810c88d11..4f5e2c6ec853 100644
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
1.7.9.5

