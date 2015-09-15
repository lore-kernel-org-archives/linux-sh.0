From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 15 Sep 2015 10:23:07 +0000
Subject: [PATCH 03/05][RFC] clk: Allow NULL as parent names
Message-Id: <20150915102307.15716.26976.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150915102238.15716.91170.sendpatchset@little-apple>
In-Reply-To: <20150915102238.15716.91170.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-clk@vger.kernel.org
Cc: linux-sh@vger.kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, horms@verge.net.au, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm+renesas@opensource.se>

Relax the parent name requirement now when struct clk_init_data
allows passing in an array of parent clocks during registration.

With this patch the parent name pointer can be set to NULL in
case parent clocks instead are passed in the parent array.

TODO: Check if kfree_const() cleanup code needs to be updated.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/clk/clk.c |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

--- 0003/drivers/clk/clk.c
+++ work/drivers/clk/clk.c	2015-09-15 18:32:55.420513000 +0900
@@ -1081,7 +1081,8 @@ static int clk_fetch_parent_index(struct
 		if (core->parents[i])
 			continue;
 
-		if (!strcmp(core->parent_names[i], parent->name)) {
+		if (core->parent_names[i] && !strcmp(core->parent_names[i],
+						     parent->name)) {
 			core->parents[i] = clk_core_lookup(parent->name);
 			return i;
 		}
@@ -1675,7 +1676,7 @@ static struct clk_core *__clk_init_paren
 
 	if (core->num_parents = 1) {
 		if (IS_ERR_OR_NULL(core->parent))
-			core->parent = clk_core_lookup(core->parent_names[0]);
+			core->parent = clk_core_get_parent_by_index(core, 0);
 		ret = core->parent;
 		goto out;
 	}
@@ -1749,7 +1750,8 @@ bool clk_has_parent(struct clk *clk, str
 		return true;
 
 	for (i = 0; i < core->num_parents; i++)
-		if (strcmp(core->parent_names[i], parent_core->name) = 0)
+		if (core->parent_names[i] && strcmp(core->parent_names[i],
+						    parent_core->name) = 0)
 			return true;
 
 	return false;
@@ -2337,7 +2339,7 @@ static int __clk_init(struct device *dev
 
 	/* throw a WARN if any entries in parent_names are NULL */
 	for (i = 0; i < core->num_parents; i++)
-		WARN(!core->parent_names[i],
+		WARN(!core->parents && !core->parent_names[i],
 				"%s: invalid NULL in %s's .parent_names\n",
 				__func__, core->name);
 
@@ -2437,13 +2439,15 @@ static int __clk_init(struct device *dev
 	hlist_for_each_entry_safe(orphan, tmp2, &clk_orphan_list, child_node) {
 		if (orphan->num_parents && orphan->ops->get_parent) {
 			i = orphan->ops->get_parent(orphan->hw);
-			if (!strcmp(core->name, orphan->parent_names[i]))
+			if (orphan->parent_names[i] &&
+			    !strcmp(core->name, orphan->parent_names[i]))
 				clk_core_reparent(orphan, core);
 			continue;
 		}
 
 		for (i = 0; i < orphan->num_parents; i++)
-			if (!strcmp(core->name, orphan->parent_names[i])) {
+			if (orphan->parent_names[i] &&
+			    !strcmp(core->name, orphan->parent_names[i])) {
 				clk_core_reparent(orphan, core);
 				break;
 			}
@@ -2555,6 +2559,9 @@ struct clk *clk_register(struct device *
 
 	/* copy each string name in case parent_names is __initdata */
 	for (i = 0; i < core->num_parents; i++) {
+		if (!hw->init->parent_names[i])
+			continue;
+
 		core->parent_names[i] = kstrdup_const(hw->init->parent_names[i],
 						GFP_KERNEL);
 		if (!core->parent_names[i]) {
