From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 24 Sep 2014 20:04:21 +0000
Subject: [PATCH 01/12] of: Decrement refcount of previous endpoint in of_graph_get_next_endpoint
Message-Id: <1411589072-28609-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1411589072-28609-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1411589072-28609-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>

From: Philipp Zabel <p.zabel@pengutronix.de>

Decrementing the reference count of the previous endpoint node allows to
use the of_graph_get_next_endpoint function in a for_each_... style macro.
Prior to this patch, all current users of this function that actually pass
a non-NULL prev parameter should be changed to not decrement the passed
prev argument's refcount themselves.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/of/base.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index d8574ad..a49b5628 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2058,8 +2058,7 @@ EXPORT_SYMBOL(of_graph_parse_endpoint);
  * @prev: previous endpoint node, or NULL to get first
  *
  * Return: An 'endpoint' node pointer with refcount incremented. Refcount
- * of the passed @prev node is not decremented, the caller have to use
- * of_node_put() on it when done.
+ * of the passed @prev node is decremented.
  */
 struct device_node *of_graph_get_next_endpoint(const struct device_node *parent,
 					struct device_node *prev)
@@ -2095,12 +2094,6 @@ struct device_node *of_graph_get_next_endpoint(const struct device_node *parent,
 		if (WARN_ONCE(!port, "%s(): endpoint %s has no parent node\n",
 			      __func__, prev->full_name))
 			return NULL;
-
-		/*
-		 * Avoid dropping prev node refcount to 0 when getting the next
-		 * child below.
-		 */
-		of_node_get(prev);
 	}
 
 	while (1) {
-- 
1.8.5.5

