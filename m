From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 26 May 2015 15:01:55 +0000
Subject: [PATCH 2/3] drm: rcar-du: Clarify error message when encoder initialization fails
Message-Id: <1432652516-15085-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1432652516-15085-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1432652516-15085-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: Cao Minh Hiep <cm-hiep@jinso.co.jp>, linux-sh@vger.kernel.org

A failure to initialize an encoder currently prints an error message in
the kernel log without mentioning which encoder failed to initialize. To
help debugging initialization issues print the encoder DT node name.

This requires moving the error message to the rcar_du_encoders_init_one
function and refactoring it slightly.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_kms.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index 4bb5af4bc474..bca859ad204c 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -639,7 +639,15 @@ static int rcar_du_encoders_init_one(struct rcar_du_device *rcdu,
 	of_node_put(encoder);
 	of_node_put(connector);
 
-	return ret < 0 ? ret : 1;
+	if (!ret)
+		return 1;
+
+	if (ret != -EPROBE_DEFER)
+		dev_warn(rcdu->dev,
+			 "failed to initialize encoder %s (%d), skipping\n",
+			 encoder->full_name, ret);
+
+	return 0;
 }
 
 static int rcar_du_encoders_init(struct rcar_du_device *rcdu)
@@ -688,8 +696,6 @@ static int rcar_du_encoders_init(struct rcar_du_device *rcdu)
 				return ret;
 			}
 
-			dev_info(rcdu->dev,
-				 "encoder initialization failed, skipping\n");
 			continue;
 		}
 
-- 
2.3.6

