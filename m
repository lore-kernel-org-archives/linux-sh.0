From: Russell King <rmk+kernel@arm.linux.org.uk>
Date: Fri, 03 Apr 2015 17:12:32 +0000
Subject: [PATCH 02/14] clkdev: drop __init from clkdev_add_table()
Message-Id: <E1Ye58y-0001Ax-Qy@rmk-PC.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <20150403171149.GC13898@n2100.arm.linux.org.uk>
In-Reply-To: <20150403171149.GC13898@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org

We want to be able to call clkdev_add_table() from non-init code, so we
need to drop the __init marker from it.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/clk/clkdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 043fd3633373..156f2e2f972c 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -251,7 +251,7 @@ void clkdev_add(struct clk_lookup *cl)
 }
 EXPORT_SYMBOL(clkdev_add);
 
-void __init clkdev_add_table(struct clk_lookup *cl, size_t num)
+void clkdev_add_table(struct clk_lookup *cl, size_t num)
 {
 	mutex_lock(&clocks_mutex);
 	while (num--) {
-- 
1.8.3.1

