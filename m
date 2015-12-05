From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sat, 05 Dec 2015 02:13:03 +0000
Subject: [PATCH v2 29/32] v4l: vsp1: Disconnect unused RPFs from the DRM pipeline
Message-Id: <1449281586-25726-30-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1449281586-25726-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1449281586-25726-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/media/platform/vsp1/vsp1_drm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/vsp1/vsp1_drm.c b/drivers/media/platform/vsp1/vsp1_drm.c
index 2969d570f462..5cef619b708d 100644
--- a/drivers/media/platform/vsp1/vsp1_drm.c
+++ b/drivers/media/platform/vsp1/vsp1_drm.c
@@ -38,13 +38,17 @@ static int vsp1_drm_pipeline_run(struct vsp1_pipeline *pipe)
 		struct vsp1_entity *entity;
 
 		list_for_each_entry(entity, &pipe->entities, list_pipe) {
-			/* Skip unused RPFs. */
+			/* Disconnect unused RPFs from the pipeline. */
 			if (entity->type = VSP1_ENTITY_RPF) {
 				struct vsp1_rwpf *rpf  					to_rwpf(&entity->subdev);
 
-				if (!pipe->inputs[rpf->entity.index])
+				if (!pipe->inputs[rpf->entity.index]) {
+					vsp1_write(entity->vsp1,
+						   entity->route->reg,
+						   VI6_DPR_NODE_UNUSED);
 					continue;
+				}
 			}
 
 			vsp1_entity_route_setup(entity);
-- 
2.4.10

