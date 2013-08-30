From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Fri, 30 Aug 2013 14:53:21 +0000
Subject: [PATCH v6 4/5] clk: Assign module owner of a clock being registered
Message-Id: <1377874402-2944-5-git-send-email-s.nawrocki@samsung.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1377874402-2944-1-git-send-email-s.nawrocki@samsung.com>
In-Reply-To: <1377874402-2944-1-git-send-email-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Use dev->driver->owner as the owner module of a clock, it ensures
reference on the module is taken in the __clk_get(), __clk_put()
helpers.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
Changes since v5:
 - none.
---
 drivers/clk/clk.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index dcf061a..ac80e13 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1805,6 +1805,10 @@ struct clk *__clk_register(struct device *dev, struct clk_hw *hw)
 	clk->flags = hw->init->flags;
 	clk->parent_names = hw->init->parent_names;
 	clk->num_parents = hw->init->num_parents;
+	if (dev && dev->driver)
+		clk->owner = dev->driver->owner;
+	else
+		clk->owner = NULL;
 
 	ret = __clk_init(dev, clk);
 	if (ret)
@@ -1825,6 +1829,8 @@ static int _clk_register(struct device *dev, struct clk_hw *hw, struct clk *clk)
 		goto fail_name;
 	}
 	clk->ops = hw->init->ops;
+	if (dev && dev->driver)
+		clk->owner = dev->driver->owner;
 	clk->hw = hw;
 	clk->flags = hw->init->flags;
 	clk->num_parents = hw->init->num_parents;
-- 
1.7.9.5

