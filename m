From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 26 May 2015 15:01:56 +0000
Subject: [PATCH 3/3] drm: rcar-du: Convert rcar_du_encoders_init_one() return value to 0/<0
Message-Id: <1432652516-15085-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1432652516-15085-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1432652516-15085-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: Cao Minh Hiep <cm-hiep@jinso.co.jp>, linux-sh@vger.kernel.org

The function returns 1 on success, and either 0 or a negative error code
on failure. As the 0 and negative values don't need to be differentiated
by the caller, convert it to the usual scheme of returning 0 on success
and a negative error code on failure.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_kms.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index bca859ad204c..acbf3087a7f2 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -573,7 +573,7 @@ static int rcar_du_encoders_init_one(struct rcar_du_device *rcdu,
 	if (!entity) {
 		dev_dbg(rcdu->dev, "unconnected endpoint %s, skipping\n",
 			ep->local_node->full_name);
-		return 0;
+		return -ENODEV;
 	}
 
 	entity_ep_node = of_parse_phandle(ep->local_node, "remote-endpoint", 0);
@@ -596,7 +596,7 @@ static int rcar_du_encoders_init_one(struct rcar_du_device *rcdu,
 				 encoder->full_name);
 			of_node_put(entity_ep_node);
 			of_node_put(encoder);
-			return 0;
+			return -ENODEV;
 		}
 
 		break;
@@ -625,7 +625,7 @@ static int rcar_du_encoders_init_one(struct rcar_du_device *rcdu,
 				 encoder->full_name);
 			of_node_put(encoder);
 			of_node_put(connector);
-			return 0;
+			return -EINVAL;
 		}
 	} else {
 		/*
@@ -640,14 +640,14 @@ static int rcar_du_encoders_init_one(struct rcar_du_device *rcdu,
 	of_node_put(connector);
 
 	if (!ret)
-		return 1;
+		return 0;
 
 	if (ret != -EPROBE_DEFER)
 		dev_warn(rcdu->dev,
 			 "failed to initialize encoder %s (%d), skipping\n",
 			 encoder->full_name, ret);
 
-	return 0;
+	return ret;
 }
 
 static int rcar_du_encoders_init(struct rcar_du_device *rcdu)
@@ -699,7 +699,7 @@ static int rcar_du_encoders_init(struct rcar_du_device *rcdu)
 			continue;
 		}
 
-		num_encoders += ret;
+		num_encoders++;
 	}
 
 	return num_encoders;
-- 
2.3.6

