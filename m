From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 13 Oct 2010 14:21:11 +0000
Subject: Re: [PATCH 1/2] ARM: mach-shmobile: clock-sh7372: Add FSIDIV clock support
Message-Id: <20101013142111.GA13310@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pzkuyihfm.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pzkuyihfm.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Oct 04, 2010 at 12:35:54PM +0900, Magnus Damm wrote:
> On Sat, Oct 2, 2010 at 1:21 AM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > On Fri, 1 Oct 2010, Kuninori Morimoto wrote:
> >> +static void fsidiv_init(struct clk *clk)
> >> +{
> >> + ? ? clk->enable_reg = ioremap_nocache((unsigned long)clk->enable_reg, 8);
> >
> > What happens, if ioremap() fails? On the whole, for some reason I don't
> > really like this
> 
> Perhaps ->init should have a return value?
> 
> But I recall Paul disliking that idea?
> 
Yes, ->init() had some special purposes back in a previous incarnation of
the clock framework, but it's not something that we want to really bother
with anymore. It was never intended for setting up mappings or anything
like that, which is why it never had a return value. As we move towards a
generic struct clk/clk_ops the ->init() thing will be wholly unsupported,
so the intent now is simply to keep it around for the legacy CPG users.

Having said that, I've spent a bit of time thinking about how to solve
this cleanly. At the moment we can assume that clocks nested under a
given topology will have their registers grouped fairly close together,
with the one-off clocks or root clocks/PLLs having special mappings of
their own to contend with.

The solution I've come up with is to associate a memory window mapping
with a struct clk, where they can set their own range, leave it unset to
inherit from the root clock, or if the root clock likewise fails to set a
mapping then we hand down a dummy mapping that provides BSS cleared
offsets for permitting the I/O routines to transparently take them in to
account. We can of course short-circuit the root clock groveling and bail
out on a previous extant mapping from any parent, and perhaps that's the
better option, but it's pretty trivial to change that behaviour later on
if a need arises.

Thoughts?

---


diff --git a/drivers/sh/clk.c b/drivers/sh/clk.c
index 661a801..a20d309 100644
--- a/drivers/sh/clk.c
+++ b/drivers/sh/clk.c
@@ -25,6 +25,7 @@
 #include <linux/sysdev.h>
 #include <linux/seq_file.h>
 #include <linux/err.h>
+#include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/debugfs.h>
 #include <linux/cpufreq.h>
@@ -233,6 +234,14 @@ EXPORT_SYMBOL_GPL(clk_enable);
 
 static LIST_HEAD(root_clks);
 
+static struct clk *lookup_root_clock(struct clk *clk)
+{
+	while (clk->parent)
+		clk = clk->parent;
+
+	return clk;
+}
+
 /**
  * recalculate_root_clocks - recalculate and propagate all root clocks
  *
@@ -251,8 +260,76 @@ void recalculate_root_clocks(void)
 	}
 }
 
+static struct clk_mapping dummy_mapping;
+
+static int clk_establish_mapping(struct clk *clk)
+{
+	struct clk_mapping *mapping = clk->mapping;
+
+	/*
+	 * Propagate mappings.
+	 */
+	if (!mapping) {
+		struct clk *clkp;
+
+		/*
+		 * dummy mapping for root clocks with no specified ranges
+		 */
+		if (!clk->parent) {
+			clk->mapping = &dummy_mapping;
+			return 0;
+		}
+
+		/*
+		 * If we're on a child clock and it provides no mapping of its
+		 * own, inherit the mapping from its root clock.
+		 */
+		clkp = lookup_root_clock(clk);
+		mapping = clkp->mapping;
+		BUG_ON(!mapping);
+	}
+
+	/*
+	 * Establish initial mapping.
+	 */
+	if (!mapping->base && mapping->phys) {
+		kref_init(&mapping->ref);
+		mapping->base = ioremap_nocache(mapping->phys, mapping->len);
+		if (unlikely(!mapping->base))
+			return -ENXIO;
+	} else
+		/* Existing mapping */
+		kref_get(&mapping->ref);
+
+	clk->mapping = mapping;
+	return 0;
+}
+
+static void clk_destroy_mapping(struct kref *kref)
+{
+	struct clk_mapping *mapping;
+
+	mapping = container_of(kref, struct clk_mapping, ref);
+
+	iounmap(mapping->base);
+}
+
+static void clk_teardown_mapping(struct clk *clk)
+{
+	struct clk_mapping *mapping = clk->mapping;
+
+	/* Nothing to do */
+	if (mapping = &dummy_mapping)
+		return;
+
+	kref_put(&mapping->ref, clk_destroy_mapping);
+	clk->mapping = NULL;
+}
+
 int clk_register(struct clk *clk)
 {
+	int ret;
+
 	if (clk = NULL || IS_ERR(clk))
 		return -EINVAL;
 
@@ -267,6 +344,10 @@ int clk_register(struct clk *clk)
 	INIT_LIST_HEAD(&clk->children);
 	clk->usecount = 0;
 
+	ret = clk_establish_mapping(clk);
+	if (unlikely(ret))
+		goto out_unlock;
+
 	if (clk->parent)
 		list_add(&clk->sibling, &clk->parent->children);
 	else
@@ -275,9 +356,11 @@ int clk_register(struct clk *clk)
 	list_add(&clk->node, &clock_list);
 	if (clk->ops && clk->ops->init)
 		clk->ops->init(clk);
+
+out_unlock:
 	mutex_unlock(&clock_list_sem);
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(clk_register);
 
@@ -286,6 +369,7 @@ void clk_unregister(struct clk *clk)
 	mutex_lock(&clock_list_sem);
 	list_del(&clk->sibling);
 	list_del(&clk->node);
+	clk_teardown_mapping(clk);
 	mutex_unlock(&clock_list_sem);
 }
 EXPORT_SYMBOL_GPL(clk_unregister);
diff --git a/include/linux/sh_clk.h b/include/linux/sh_clk.h
index ecdfea5..8ae3770 100644
--- a/include/linux/sh_clk.h
+++ b/include/linux/sh_clk.h
@@ -4,11 +4,20 @@
 #include <linux/list.h>
 #include <linux/seq_file.h>
 #include <linux/cpufreq.h>
+#include <linux/types.h>
+#include <linux/kref.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 
 struct clk;
 
+struct clk_mapping {
+	phys_addr_t		phys;
+	void __iomem		*base;
+	unsigned long		len;
+	struct kref		ref;
+};
+
 struct clk_ops {
 	void (*init)(struct clk *clk);
 	int (*enable)(struct clk *clk);
@@ -42,6 +51,7 @@ struct clk {
 	unsigned long		arch_flags;
 	void			*priv;
 	struct dentry		*dentry;
+	struct clk_mapping	*mapping;
 	struct cpufreq_frequency_table *freq_table;
 };
 
