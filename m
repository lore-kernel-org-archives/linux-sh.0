From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Sat, 28 Dec 2013 12:09:08 +0000
Subject: [PATCH V2 1/2] clk: shmobile: Fix MSTP clock index
Message-Id: <1388232549-6740-2-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Use clkidx when registering MSTP clocks instead of loop counter
since the value is then used to access the specific clock index bit
in the mstp register.

The issue was introduced by the following commit:
f94859c215b6d977 "clk: shmobile: Add MSTP clock support"

Changes in V2:
* none

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/clk/shmobile/clk-mstp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/shmobile/clk-mstp.c b/drivers/clk/shmobile/clk-mstp.c
index e576b60..be7d017 100644
--- a/drivers/clk/shmobile/clk-mstp.c
+++ b/drivers/clk/shmobile/clk-mstp.c
@@ -205,8 +205,8 @@ static void __init cpg_mstp_clocks_init(struct device_node *np)
 			continue;
 		}
 
-		clks[clkidx] = cpg_mstp_clock_register(name, parent_name, i,
-						       group);
+		clks[clkidx] = cpg_mstp_clock_register(name, parent_name,
+						       clkidx, group);
 		if (!IS_ERR(clks[clkidx])) {
 			group->data.clk_num = max(group->data.clk_num, clkidx);
 			/*
-- 
1.8.3.1

