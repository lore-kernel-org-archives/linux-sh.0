From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Fri, 04 May 2012 15:00:35 +0000
Subject: Re: [PATCH 2/4] sh: Add sh7264 device
Message-Id: <1336143635-9381-1-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1334062853-23045-3-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1334062853-23045-3-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul,

I found some time to look at the issue with 16-bit clock source registers
on sh2a. This is on top of your changes to extend sh_clk_mstp for 8 & 16
bti regs. Is this the sort of thing you were thinking of?

Thanks
Phil

---

diff --git a/drivers/sh/clk/cpg.c b/drivers/sh/clk/cpg.c
index fd72f16..0413184 100644
--- a/drivers/sh/clk/cpg.c
+++ b/drivers/sh/clk/cpg.c
@@ -13,32 +13,38 @@
 #include <linux/io.h>
 #include <linux/sh_clk.h>
 
-static int sh_clk_mstp_enable(struct clk *clk)
+static unsigned long sh_clk_reg_read(struct clk *clk)
 {
 	if (clk->flags & CLK_ENABLE_REG_8BIT)
-		iowrite8(ioread8(clk->mapped_reg) & ~(1 << clk->enable_bit),
-			clk->mapped_reg);
+		return ioread8(clk->mapped_reg);
 	else if (clk->flags & CLK_ENABLE_REG_16BIT)
-		iowrite16(ioread16(clk->mapped_reg) & ~(1 << clk->enable_bit),
-			 clk->mapped_reg);
+		return ioread16(clk->mapped_reg);
 	else
-		iowrite32(ioread32(clk->mapped_reg) & ~(1 << clk->enable_bit),
-			 clk->mapped_reg);
-
-	return 0;
+		return ioread32(clk->mapped_reg);
 }
 
-static void sh_clk_mstp_disable(struct clk *clk)
+static void sh_clk_reg_write(struct clk *clk, unsigned long data)
 {
 	if (clk->flags & CLK_ENABLE_REG_8BIT)
-		iowrite8(ioread8(clk->mapped_reg) | (1 << clk->enable_bit),
-			clk->mapped_reg);
+		iowrite8(data, clk->mapped_reg);
 	else if (clk->flags & CLK_ENABLE_REG_16BIT)
-		iowrite16(ioread16(clk->mapped_reg) | (1 << clk->enable_bit),
-			 clk->mapped_reg);
+		iowrite16(data, clk->mapped_reg);
 	else
-		iowrite32(ioread32(clk->mapped_reg) | (1 << clk->enable_bit),
-			 clk->mapped_reg);
+		iowrite32(data, clk->mapped_reg);
+}
+
+static int sh_clk_mstp_enable(struct clk *clk)
+{
+	unsigned long data = sh_clk_reg_read(clk);
+	sh_clk_reg_write(clk, data & ~(1 << clk->enable_bit));
+
+	return 0;
+}
+
+static void sh_clk_mstp_disable(struct clk *clk)
+{
+	unsigned long data = sh_clk_reg_read(clk);
+	sh_clk_reg_write(clk, data | (1 << clk->enable_bit));
 }
 
 static struct sh_clk_ops sh_clk_mstp_clk_ops = {
@@ -87,7 +93,7 @@ static unsigned long sh_clk_div6_recalc(struct clk *clk)
 	clk_rate_table_build(clk, clk->freq_table, table->nr_divisors,
 		   table, NULL);
 
-	idx = ioread32(clk->mapped_reg) & 0x003f;
+	idx = sh_clk_reg_read(clk) & 0x003f;
 
 	return clk->freq_table[idx].frequency;
 }
@@ -113,10 +119,10 @@ static int sh_clk_div6_set_parent(struct clk *clk, struct clk *parent)
 	if (ret < 0)
 		return ret;
 
-	value = ioread32(clk->mapped_reg) &
+	value = sh_clk_reg_read(clk) &
 		~(((1 << clk->src_width) - 1) << clk->src_shift);
 
-	iowrite32(value | (i << clk->src_shift), clk->mapped_reg);
+	sh_clk_reg_write(clk, value | (i << clk->src_shift));
 
 	/* Rebuild the frequency table */
 	clk_rate_table_build(clk, clk->freq_table, table->nr_divisors,
@@ -134,10 +140,10 @@ static int sh_clk_div6_set_rate(struct clk *clk, unsigned long rate)
 	if (idx < 0)
 		return idx;
 
-	value = ioread32(clk->mapped_reg);
+	value = sh_clk_reg_read(clk);
 	value &= ~0x3f;
 	value |= idx;
-	iowrite32(value, clk->mapped_reg);
+	sh_clk_reg_write(clk, value);
 	return 0;
 }
 
@@ -148,9 +154,9 @@ static int sh_clk_div6_enable(struct clk *clk)
 
 	ret = sh_clk_div6_set_rate(clk, clk->rate);
 	if (ret = 0) {
-		value = ioread32(clk->mapped_reg);
+		value = sh_clk_reg_read(clk);
 		value &= ~0x100; /* clear stop bit to enable clock */
-		iowrite32(value, clk->mapped_reg);
+		sh_clk_reg_write(clk, value);
 	}
 	return ret;
 }
@@ -159,10 +165,10 @@ static void sh_clk_div6_disable(struct clk *clk)
 {
 	unsigned long value;
 
-	value = ioread32(clk->mapped_reg);
+	value = sh_clk_reg_read(clk);
 	value |= 0x100; /* stop clock */
 	value |= 0x3f; /* VDIV bits must be non-zero, overwrite divider */
-	iowrite32(value, clk->mapped_reg);
+	sh_clk_reg_write(clk, value);
 }
 
 static struct sh_clk_ops sh_clk_div6_clk_ops = {
@@ -197,7 +203,7 @@ static int __init sh_clk_init_parent(struct clk *clk)
 		return -EINVAL;
 	}
 
-	val  = (ioread32(clk->mapped_reg) >> clk->src_shift);
+	val  = (sh_clk_reg_read(clk) >> clk->src_shift);
 	val &= (1 << clk->src_width) - 1;
 
 	if (val >= clk->parent_num) {
@@ -267,7 +273,7 @@ static unsigned long sh_clk_div4_recalc(struct clk *clk)
 	clk_rate_table_build(clk, clk->freq_table, table->nr_divisors,
 		   table, &clk->arch_flags);
 
-	idx = (ioread32(clk->mapped_reg) >> clk->enable_bit) & 0x000f;
+	idx = (sh_clk_reg_read(clk) >> clk->enable_bit) & 0x000f;
 
 	return clk->freq_table[idx].frequency;
 }
@@ -285,15 +291,15 @@ static int sh_clk_div4_set_parent(struct clk *clk, struct clk *parent)
 	*/
 
 	if (parent->flags & CLK_ENABLE_ON_INIT)
-		value = ioread32(clk->mapped_reg) & ~(1 << 7);
+		value = sh_clk_reg_read(clk) & ~(1 << 7);
 	else
-		value = ioread32(clk->mapped_reg) | (1 << 7);
+		value = sh_clk_reg_read(clk) | (1 << 7);
 
 	ret = clk_reparent(clk, parent);
 	if (ret < 0)
 		return ret;
 
-	iowrite32(value, clk->mapped_reg);
+	sh_clk_reg_write(clk, value);
 
 	/* Rebiuld the frequency table */
 	clk_rate_table_build(clk, clk->freq_table, table->nr_divisors,
@@ -310,10 +316,10 @@ static int sh_clk_div4_set_rate(struct clk *clk, unsigned long rate)
 	if (idx < 0)
 		return idx;
 
-	value = ioread32(clk->mapped_reg);
+	value = sh_clk_reg_read(clk);
 	value &= ~(0xf << clk->enable_bit);
 	value |= (idx << clk->enable_bit);
-	iowrite32(value, clk->mapped_reg);
+	sh_clk_reg_write(clk, value);
 
 	if (d4t->kick)
 		d4t->kick(clk);
@@ -323,13 +329,15 @@ static int sh_clk_div4_set_rate(struct clk *clk, unsigned long rate)
 
 static int sh_clk_div4_enable(struct clk *clk)
 {
-	iowrite32(ioread32(clk->mapped_reg) & ~(1 << 8), clk->mapped_reg);
+	unsigned long data = sh_clk_reg_read(clk);
+	sh_clk_reg_write(clk, data & ~(1 << 8));
 	return 0;
 }
 
 static void sh_clk_div4_disable(struct clk *clk)
 {
-	iowrite32(ioread32(clk->mapped_reg) | (1 << 8), clk->mapped_reg);
+	unsigned long data = sh_clk_reg_read(clk);
+	sh_clk_reg_write(clk,data | (1 << 8));
 }
 
 static struct sh_clk_ops sh_clk_div4_clk_ops = {
diff --git a/include/linux/sh_clk.h b/include/linux/sh_clk.h
index 7e8a292..6a3060c 100644
--- a/include/linux/sh_clk.h
+++ b/include/linux/sh_clk.h
@@ -140,7 +140,7 @@ static inline int __deprecated sh_clk_mstp32_register(struct clk *clks, int nr)
 		 return sh_clk_mstp_register(clks, nr);
 }
 
-#define SH_CLK_DIV4(_parent, _reg, _shift, _div_bitmap, _flags)	\
+#define SH_CLK_DIV4_X(_parent, _reg, _shift, _div_bitmap, _flags)	\
 {								\
 	.parent = _parent,					\
 	.enable_reg = (void __iomem *)_reg,			\
@@ -149,6 +149,18 @@ static inline int __deprecated sh_clk_mstp32_register(struct clk *clks, int nr)
 	.flags = _flags,					\
 }
 
+#define SH_CLK_DIV4(_p, _r, _s, _b, _f)				\
+	SH_CLK_DIV4_X(_p, _r, _s, _b, _f | CLK_ENABLE_REG_32BIT)
+
+#define SH_CLK_DIV4_32(_p, _r, _s, _b, _f)			\
+	SH_CLK_DIV4_X(_p, _r, _s, _b, _f | CLK_ENABLE_REG_32BIT)
+
+#define SH_CLK_DIV4_16(_p, _r, _s, _b, _f)			\
+	SH_CLK_DIV4_X(_p, _r, _s, _b, _f | CLK_ENABLE_REG_16BIT)
+
+#define SH_CLK_DIV4_8(_p, _r, _s, _b, _f)			\
+	SH_CLK_DIV4_X(_p, _r, _s, _b, _f | CLK_ENABLE_REG_8BIT)
+
 struct clk_div4_table {
 	struct clk_div_mult_table *div_mult_table;
 	void (*kick)(struct clk *clk);
-- 
1.7.5.4

