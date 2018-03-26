From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Mon, 26 Mar 2018 21:25:23 +0000
Subject: [PATCH 1/5] drivers/sh/clk: add support for CLK_SET_TO_ENABLE flag
Message-Id: <20180326212527.12565-2-thomas.petazzoni@bootlin.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The current sh_clk_mstp_{enable,disable} functions assume that
enable_bit must be cleared to enable the clock, and set to disable the
clock.

However, this clock type is used for the PHY of the SH7786 PCIe
controller, which has the opposite polarity: set to enable, clear to
disable. In order to properly support this clock, we introduce a
CLK_SET_TO_ENABLE flag.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 drivers/sh/clk/cpg.c   | 10 ++++++++--
 include/linux/sh_clk.h |  2 ++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/sh/clk/cpg.c b/drivers/sh/clk/cpg.c
index 7442bc130055..ecb1ab9a8f1d 100644
--- a/drivers/sh/clk/cpg.c
+++ b/drivers/sh/clk/cpg.c
@@ -53,7 +53,10 @@ static unsigned int r32(const void __iomem *addr)
 
 static int sh_clk_mstp_enable(struct clk *clk)
 {
-	sh_clk_write(sh_clk_read(clk) & ~(1 << clk->enable_bit), clk);
+	if (clk->flags & CLK_SET_TO_ENABLE)
+		sh_clk_write(sh_clk_read(clk) | (1 << clk->enable_bit), clk);
+	else
+		sh_clk_write(sh_clk_read(clk) & ~(1 << clk->enable_bit), clk);
 	if (clk->status_reg) {
 		unsigned int (*read)(const void __iomem *addr);
 		int i;
@@ -82,7 +85,10 @@ static int sh_clk_mstp_enable(struct clk *clk)
 
 static void sh_clk_mstp_disable(struct clk *clk)
 {
-	sh_clk_write(sh_clk_read(clk) | (1 << clk->enable_bit), clk);
+	if (clk->flags & CLK_SET_TO_ENABLE)
+		sh_clk_write(sh_clk_read(clk) & ~(1 << clk->enable_bit), clk);
+	else
+		sh_clk_write(sh_clk_read(clk) | (1 << clk->enable_bit), clk);
 }
 
 static struct sh_clk_ops sh_clk_mstp_clk_ops = {
diff --git a/include/linux/sh_clk.h b/include/linux/sh_clk.h
index 7bed5be886c6..0413570a7141 100644
--- a/include/linux/sh_clk.h
+++ b/include/linux/sh_clk.h
@@ -73,6 +73,8 @@ struct clk {
 
 #define CLK_MASK_DIV_ON_DISABLE	BIT(4)
 
+#define CLK_SET_TO_ENABLE	BIT(5)
+
 #define CLK_ENABLE_REG_MASK	(CLK_ENABLE_REG_32BIT | \
 				 CLK_ENABLE_REG_16BIT | \
 				 CLK_ENABLE_REG_8BIT)
-- 
2.14.3

