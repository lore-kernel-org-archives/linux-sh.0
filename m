From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 24 Sep 2014 20:04:24 +0000
Subject: [PATCH 04/12] drm: rcar-du: Use for_each_endpoint_of_node()
Message-Id: <1411589072-28609-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1411589072-28609-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1411589072-28609-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

Replace the manual loop implementation with the macro to simplify the
code.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_kms.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index c6a7fd6..6575681 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -299,27 +299,19 @@ static int rcar_du_encoders_init_one(struct rcar_du_device *rcdu,
 static int rcar_du_encoders_init(struct rcar_du_device *rcdu)
 {
 	struct device_node *np = rcdu->dev->of_node;
-	struct device_node *prev = NULL;
 	unsigned int num_encoders = 0;
+	struct device_node *ep_node;
 
 	/*
 	 * Iterate over the endpoints and create one encoder for each output
 	 * pipeline.
 	 */
-	while (1) {
-		struct device_node *ep_node;
+	for_each_endpoint_of_node(np, ep_node) {
 		enum rcar_du_output output;
 		struct of_endpoint ep;
 		unsigned int i;
 		int ret;
 
-		ep_node = of_graph_get_next_endpoint(np, prev);
-		of_node_put(prev);
-		prev = ep_node;
-
-		if (ep_node = NULL)
-			break;
-
 		ret = of_graph_parse_endpoint(ep_node, &ep);
 		if (ret < 0) {
 			of_node_put(ep_node);
-- 
1.8.5.5

