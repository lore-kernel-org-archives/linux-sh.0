From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 11 Apr 2012 03:22:25 +0000
Subject: Re: [PATCH 1/4] sh: Add support for 8-bit module stop registers
Message-Id: <20120411032224.GA13606@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1334062853-23045-2-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1334062853-23045-2-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 10, 2012 at 02:00:50PM +0100, Phil Edworthy wrote:
> sh2a uses the same mechanism for module stop, but uses 8-bit regs
> containing the module stops bits, rather than 32-bit regs.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

We still need to use the ioread/write API, and it's really not worth
bloating up the API further for this, either. Something like this ought
to do the trick..

---

diff --git a/drivers/sh/clk/cpg.c b/drivers/sh/clk/cpg.c
index 91b6d52..6cbda48 100644
--- a/drivers/sh/clk/cpg.c
+++ b/drivers/sh/clk/cpg.c
@@ -13,26 +14,41 @@
 #include <linux/io.h>
 #include <linux/sh_clk.h>
 
-static int sh_clk_mstp32_enable(struct clk *clk)
+static int sh_clk_mstp_enable(struct clk *clk)
 {
-	iowrite32(ioread32(clk->mapped_reg) & ~(1 << clk->enable_bit),
-		  clk->mapped_reg);
+	if (clk->flags & CLK_ENABLE_REG_8BIT)
+		iowrite8(ioread8(clk->mapped_reg) & ~(1 << clk->enable_bit),
+			 clk->mapped_reg);
+	else if (clk->flags & CLK_ENABLE_REG_16BIT)
+		iowrite16(ioread16(clk->mapped_reg) & ~(1 << clk->enable_bit),
+			  clk->mapped_reg);
+	else
+		iowrite32(ioread32(clk->mapped_reg) & ~(1 << clk->enable_bit),
+			  clk->mapped_reg);
+
 	return 0;
 }
 
-static void sh_clk_mstp32_disable(struct clk *clk)
+static void sh_clk_mstp_disable(struct clk *clk)
 {
-	iowrite32(ioread32(clk->mapped_reg) | (1 << clk->enable_bit),
-		  clk->mapped_reg);
+	if (clk->flags & CLK_ENABLE_REG_8BIT)
+		iowrite8(ioread8(clk->mapped_reg) | (1 << clk->enable_bit),
+			 clk->mapped_reg);
+	else if (clk->flags & CLK_ENABLE_REG_16BIT)
+		iowrite16(ioread16(clk->mapped_reg) | (1 << clk->enable_bit),
+			  clk->mapped_reg);
+	else
+		iowrite32(ioread32(clk->mapped_reg) | (1 << clk->enable_bit),
+			  clk->mapped_reg);
 }
 
-static struct sh_clk_ops sh_clk_mstp32_clk_ops = {
-	.enable		= sh_clk_mstp32_enable,
-	.disable	= sh_clk_mstp32_disable,
+static struct sh_clk_ops sh_clk_mstp_clk_ops = {
+	.enable		= sh_clk_mstp_enable,
+	.disable	= sh_clk_mstp_disable,
 	.recalc		= followparent_recalc,
 };
 
-int __init sh_clk_mstp32_register(struct clk *clks, int nr)
+int __init sh_clk_mstp_register(struct clk *clks, int nr)
 {
 	struct clk *clkp;
 	int ret = 0;
@@ -40,7 +56,7 @@ int __init sh_clk_mstp32_register(struct clk *clks, int nr)
 
 	for (k = 0; !ret && (k < nr); k++) {
 		clkp = clks + k;
-		clkp->ops = &sh_clk_mstp32_clk_ops;
+		clkp->ops = &sh_clk_mstp_clk_ops;
 		ret |= clk_register(clkp);
 	}
 
diff --git a/include/linux/sh_clk.h b/include/linux/sh_clk.h
index 0a9d8f2..c513b73 100644
--- a/include/linux/sh_clk.h
+++ b/include/linux/sh_clk.h
@@ -59,7 +59,15 @@ struct clk {
 	unsigned int		nr_freqs;
 };
 
-#define CLK_ENABLE_ON_INIT	(1 << 0)
+#define CLK_ENABLE_ON_INIT	BIT(0)
+
+#define CLK_ENABLE_REG_32BIT	BIT(1)	/* default access size */
+#define CLK_ENABLE_REG_16BIT	BIT(2)
+#define CLK_ENABLE_REG_8BIT	BIT(3)
+
+#define CLK_ENABLE_REG_MASK	(CLK_ENABLE_REG_32BIT | \
+				 CLK_ENABLE_REG_16BIT | \
+				 CLK_ENABLE_REG_8BIT)
 
 /* drivers/sh/clk.c */
 unsigned long followparent_recalc(struct clk *);
@@ -102,7 +110,7 @@ long clk_round_parent(struct clk *clk, unsigned long target,
 		      unsigned long *best_freq, unsigned long *parent_freq,
 		      unsigned int div_min, unsigned int div_max);
 
-#define SH_CLK_MSTP32(_parent, _enable_reg, _enable_bit, _flags)	\
+#define SH_CLK_MSTP(_parent, _enable_reg, _enable_bit, _flags)		\
 {									\
 	.parent		= _parent,					\
 	.enable_reg	= (void __iomem *)_enable_reg,			\
@@ -110,7 +118,27 @@ long clk_round_parent(struct clk *clk, unsigned long target,
 	.flags		= _flags,					\
 }
 
-int sh_clk_mstp32_register(struct clk *clks, int nr);
+#define SH_CLK_MSTP32(_p, _r, _b, _f)					\
+	SH_CLK_MSTP(_p, _r, _b, _f | CLK_ENABLE_REG_32BIT)
+
+#define SH_CLK_MSTP16(_p, _r, _b, _f)					\
+	SH_CLK_MSTP(_p, _r, _b, _f | CLK_ENABLE_REG_16BIT)
+
+#define SH_CLK_MSTP8(_p, _r, _b, _f)					\
+	SH_CLK_MSTP(_p, _r, _b, _f | CLK_ENABLE_REG_8BIT)
+
+int sh_clk_mstp_register(struct clk *clks, int nr);
+
+/*
+ * MSTP registration never really cared about access size, despite the
+ * original enable/disable pairs assuming a 32-bit access. Clocks are
+ * responsible for defining their access sizes either directly or via the
+ * clock definition wrappers.
+ */
+static inline int __deprecated sh_clk_mstp32_register(struct clk *clks, int nr)
+{
+	return sh_clk_mstp_register(clks, nr);
+}
 
 #define SH_CLK_DIV4(_parent, _reg, _shift, _div_bitmap, _flags)	\
 {								\
