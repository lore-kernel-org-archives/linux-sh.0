From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 06 Jun 2013 15:47:23 +0000
Subject: [PATCH 1/3] OF: add a new phandle parsing function for grouped nodes
Message-Id: <1370533645-23690-2-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1370533645-23690-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1370533645-23690-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Sometimes it is useful to group similar DT nodes under a common parent,
when a different node can reference the group, meaning, that any subnode
will do the job. An example of such a group is a DMA multiplexer, when a
DMA slave can be served by any DMA controller from the group. This patch
slightly extends an internal __of_parse_phandle_with_args() function to
accept one more optional parameter and exports a new API function
of_parse_phandle_with_child_args(), which allows the caller to provide a
compatibility string for a group. In this case the function returns the
first matching node. Once a matching node is found, standard DT iterators
can be used to look for further matches.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/of/base.c  |   28 +++++++++++++++++++++++++---
 include/linux/of.h |   16 ++++++++++++++++
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index f53b992..33d4f3a 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1108,11 +1108,16 @@ EXPORT_SYMBOL(of_parse_phandle);
  * @cells_name:	property name that specifies phandles' arguments count
  * @index:	index of a phandle to parse out
  * @out_args:	optional pointer to output arguments structure (will be filled)
+ * @parent:	optional parent-compatibility string
  *
  * This function is useful to parse lists of phandles and their arguments.
  * Returns 0 on success and fills out_args, on error returns appropriate
  * errno value.
  *
+ * If @parent is specified and the DT node, pointed by the currently iterated
+ * phandle is compatible with it, it is assumed, that the phandle is a parent of
+ * DT nodes with equal cell counts. In that case the first child is taken.
+ *
  * Caller is responsible to call of_node_put() on the returned out_args->node
  * pointer.
  *
@@ -1136,7 +1141,8 @@ EXPORT_SYMBOL(of_parse_phandle);
 static int __of_parse_phandle_with_args(const struct device_node *np,
 					const char *list_name,
 					const char *cells_name, int index,
-					struct of_phandle_args *out_args)
+					struct of_phandle_args *out_args,
+					const char *parent)
 {
 	const __be32 *list, *list_end;
 	int rc = 0, size, cur_index = 0;
@@ -1171,6 +1177,12 @@ static int __of_parse_phandle_with_args(const struct device_node *np,
 					 np->full_name);
 				goto err;
 			}
+			if (parent && of_device_is_compatible(node, parent)) {
+				struct device_node *child +					of_get_next_available_child(node, NULL);
+				of_node_put(node);
+				node = child;
+			}
 			if (of_property_read_u32(node, cells_name, &count)) {
 				pr_err("%s: could not get %s for %s\n",
 					 np->full_name, cells_name,
@@ -1241,10 +1253,20 @@ int of_parse_phandle_with_args(const struct device_node *np, const char *list_na
 {
 	if (index < 0)
 		return -EINVAL;
-	return __of_parse_phandle_with_args(np, list_name, cells_name, index, out_args);
+	return __of_parse_phandle_with_args(np, list_name, cells_name, index, out_args, NULL);
 }
 EXPORT_SYMBOL(of_parse_phandle_with_args);
 
+int of_parse_phandle_with_child_args(const struct device_node *np, const char *list_name,
+				     const char *cells_name, int index,
+				     struct of_phandle_args *out_args, const char *parent)
+{
+	if (index < 0)
+		return -EINVAL;
+	return __of_parse_phandle_with_args(np, list_name, cells_name, index, out_args, parent);
+}
+EXPORT_SYMBOL(of_parse_phandle_with_child_args);
+
 /**
  * of_count_phandle_with_args() - Find the number of phandles references in a property
  * @np:		pointer to a device tree node containing a list
@@ -1263,7 +1285,7 @@ EXPORT_SYMBOL(of_parse_phandle_with_args);
 int of_count_phandle_with_args(const struct device_node *np, const char *list_name,
 				const char *cells_name)
 {
-	return __of_parse_phandle_with_args(np, list_name, cells_name, -1, NULL);
+	return __of_parse_phandle_with_args(np, list_name, cells_name, -1, NULL, NULL);
 }
 EXPORT_SYMBOL(of_count_phandle_with_args);
 
diff --git a/include/linux/of.h b/include/linux/of.h
index 6e10f8f..d3fdce2 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -280,6 +280,12 @@ extern struct device_node *of_parse_phandle(const struct device_node *np,
 extern int of_parse_phandle_with_args(const struct device_node *np,
 	const char *list_name, const char *cells_name, int index,
 	struct of_phandle_args *out_args);
+extern int of_parse_phandle_with_child_args(const struct device_node *np,
+					    const char *list_name,
+					    const char *cells_name,
+					    int index,
+					    struct of_phandle_args *out_args,
+					    const char *parent);
 extern int of_count_phandle_with_args(const struct device_node *np,
 	const char *list_name, const char *cells_name);
 
@@ -488,6 +494,16 @@ static inline int of_parse_phandle_with_args(const struct device_node *np,
 	return -ENOSYS;
 }
 
+static inline int of_parse_phandle_with_child_args(const struct device_node *np,
+						   const char *list_name,
+						   const char *cells_name,
+						   int index,
+						   struct of_phandle_args *out_args,
+						   const char *parent)
+{
+	return -ENOSYS;
+}
+
 static inline int of_count_phandle_with_args(const struct device_node *np,
 					     const char *list_name,
 					     const char *cells_name)
-- 
1.7.2.5

