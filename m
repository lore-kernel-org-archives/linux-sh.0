From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Mon, 11 Jul 2011 02:53:54 +0000
Subject: [PATCH 3/6] clk: Constify struct clk_hw_ops
Message-Id: <1310352837-4277-3-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20110711025344.GA27497@opensource.wolfsonmicro.com>
	<1310352837-4277-1-git-send-email-broonie@opensource.wolfsonmicro.com>
In-Reply-To: <1310352837-4277-1-git-send-email-broonie@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/clk/clk.c   |    4 ++--
 include/linux/clk.h |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 3a4d70e..1df6e23 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -16,7 +16,7 @@
 
 struct clk {
 	const char		*name;
-	struct clk_hw_ops	*ops;
+	const struct clk_hw_ops	*ops;
 	struct clk_hw		*hw;
 	unsigned int		enable_count;
 	unsigned int		prepare_count;
@@ -252,7 +252,7 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 }
 EXPORT_SYMBOL_GPL(clk_set_parent);
 
-struct clk *clk_register(struct clk_hw_ops *ops, struct clk_hw *hw,
+struct clk *clk_register(const struct clk_hw_ops *ops, struct clk_hw *hw,
 		const char *name)
 {
 	struct clk *clk;
diff --git a/include/linux/clk.h b/include/linux/clk.h
index df5c64f..fb5e435 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -146,7 +146,7 @@ extern struct clk_hw_ops clk_gate_ops;
  * Register a new clock with the clk subsytem.  Returns either a
  * struct clk for the new clock or a NULL pointer.
  */
-struct clk *clk_register(struct clk_hw_ops *ops, struct clk_hw *hw,
+struct clk *clk_register(const struct clk_hw_ops *ops, struct clk_hw *hw,
 			 const char *name);
 
 /**
-- 
1.7.5.4

