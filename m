From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Fri, 03 Dec 2010 04:16:56 +0000
Subject: [PATCH 1/2] sh: ecovec: Update clock of FSI to non-legacy
Message-Id: <1291349817-3077-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Current FSI clock of ecovec uses legacy clock.
This update to non-legacy.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 2eaeb9e..1f3377d 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -725,7 +725,7 @@ static struct platform_device camera_devices[] = {
  * So, we should change parent of fsi
  */
 #define FCLKBCR		0xa415000c
-static void fsimck_init(struct clk *clk)
+static int fsimck_enable(struct clk *clk)
 {
 	u32 status = __raw_readl(clk->enable_reg);
 
@@ -734,10 +734,23 @@ static void fsimck_init(struct clk *clk)
 	status |= 0x00000080;
 
 	__raw_writel(status, clk->enable_reg);
+
+	return 0;
+}
+
+static void fsimck_disable(struct clk *clk)
+{
+	u32 status = __raw_readl(clk->enable_reg);
+
+	/* use external clock */
+	status &= ~0x00000080;
+
+	__raw_writel(status, clk->enable_reg);
 }
 
 static struct clk_ops fsimck_clk_ops = {
-	.init = fsimck_init,
+	.enable = fsimck_enable,
+	.disable = fsimck_disable,
 };
 
 static struct clk fsimckb_clk = {
-- 
1.7.2.3

