From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 08 Dec 2011 13:58:54 +0000
Subject: [PATCH 01/04] sh: extend clock struct with mapped_reg member
Message-Id: <20111208135854.18394.11107.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add a "mapped_reg" member to struct clk and use that
to keep the ioremapped register based on enable_reg.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/sh/clk/core.c  |    9 +++++++--
 include/linux/sh_clk.h |    1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

--- 0001/drivers/sh/clk/core.c
+++ work/drivers/sh/clk/core.c	2011-12-08 22:26:25.000000000 +0900
@@ -355,7 +355,7 @@ static int clk_establish_mapping(struct
 		 */
 		if (!clk->parent) {
 			clk->mapping = &dummy_mapping;
-			return 0;
+			goto out;
 		}
 
 		/*
@@ -384,6 +384,9 @@ static int clk_establish_mapping(struct
 	}
 
 	clk->mapping = mapping;
+ out:
+	clk->mapped_reg = clk->mapping->base;
+	clk->mapped_reg += (phys_addr_t)clk->enable_reg - clk->mapping->phys;
 	return 0;
 }
 
@@ -402,10 +405,12 @@ static void clk_teardown_mapping(struct
 
 	/* Nothing to do */
 	if (mapping = &dummy_mapping)
-		return;
+		goto out;
 
 	kref_put(&mapping->ref, clk_destroy_mapping);
 	clk->mapping = NULL;
+ out:
+	clk->mapped_reg = NULL;
 }
 
 int clk_register(struct clk *clk)
--- 0001/include/linux/sh_clk.h
+++ work/include/linux/sh_clk.h	2011-12-08 13:30:41.000000000 +0900
@@ -49,6 +49,7 @@ struct clk {
 
 	void __iomem		*enable_reg;
 	unsigned int		enable_bit;
+	void __iomem		*mapped_reg;
 
 	unsigned long		arch_flags;
 	void			*priv;
