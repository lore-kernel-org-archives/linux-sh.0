From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 22 May 2014 18:02:14 +0000
Subject: [PATCH v3] clk: shmobile: mstp: Fix the is_enabled() operation
Message-Id: <1400781734-19002-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Turquette <mturquette@linaro.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The MSTP[SC]R registers have clock stop bits, not clock enable bits. The
bit value should thus be inverted in the is_enabled() operation.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Mike Turquette <mturquette@linaro.org>
---
v3:
  - This depends on commit 3c90c55dcde745bed81f6447f24ba96bda43d984
    ("drivers: sh: compile drivers/sh/pm_runtime.c if
    ARCH_SHMOBILE_MULTI"), which has entered mainline in v3.15-rc6.

v2:
  - New
---
 drivers/clk/shmobile/clk-mstp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/shmobile/clk-mstp.c b/drivers/clk/shmobile/clk-mstp.c
index 1f6324e29a80..2d2fe773ac81 100644
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
1.9.1

