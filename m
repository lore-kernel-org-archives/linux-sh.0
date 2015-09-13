From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 13 Sep 2015 20:56:50 +0000
Subject: [PATCH 12/32] v4l: vsp1: Rename video pipeline functions to use vsp1_video prefix
Message-Id: <1442177830-24536-13-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442177830-24536-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1442177830-24536-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Those functions are specific to video nodes, rename them for
consistency.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/media/platform/vsp1/vsp1_video.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/media/platform/vsp1/vsp1_video.c b/drivers/media/platform/vsp1/vsp1_video.c
index 1a909ab34ea1..8569836ea51b 100644
--- a/drivers/media/platform/vsp1/vsp1_video.c
+++ b/drivers/media/platform/vsp1/vsp1_video.c
@@ -308,9 +308,9 @@ vsp1_video_format_adjust(struct vsp1_video *video,
  * Pipeline Management
  */
 
-static int vsp1_pipeline_validate_branch(struct vsp1_pipeline *pipe,
-					 struct vsp1_rwpf *input,
-					 struct vsp1_rwpf *output)
+static int vsp1_video_pipeline_validate_branch(struct vsp1_pipeline *pipe,
+					       struct vsp1_rwpf *input,
+					       struct vsp1_rwpf *output)
 {
 	struct vsp1_entity *entity;
 	unsigned int entities = 0;
@@ -384,8 +384,8 @@ static int vsp1_pipeline_validate_branch(struct vsp1_pipeline *pipe,
 	return 0;
 }
 
-static int vsp1_pipeline_validate(struct vsp1_pipeline *pipe,
-				  struct vsp1_video *video)
+static int vsp1_video_pipeline_validate(struct vsp1_pipeline *pipe,
+					struct vsp1_video *video)
 {
 	struct media_entity_graph graph;
 	struct media_entity *entity = &video->video.entity;
@@ -437,8 +437,8 @@ static int vsp1_pipeline_validate(struct vsp1_pipeline *pipe,
 	 * contains no loop and that all branches end at the output WPF.
 	 */
 	for (i = 0; i < pipe->num_inputs; ++i) {
-		ret = vsp1_pipeline_validate_branch(pipe, pipe->inputs[i],
-						    pipe->output);
+		ret = vsp1_video_pipeline_validate_branch(pipe, pipe->inputs[i],
+							  pipe->output);
 		if (ret < 0)
 			goto error;
 	}
@@ -450,8 +450,8 @@ error:
 	return ret;
 }
 
-static int vsp1_pipeline_init(struct vsp1_pipeline *pipe,
-			      struct vsp1_video *video)
+static int vsp1_video_pipeline_init(struct vsp1_pipeline *pipe,
+				    struct vsp1_video *video)
 {
 	int ret;
 
@@ -459,7 +459,7 @@ static int vsp1_pipeline_init(struct vsp1_pipeline *pipe,
 
 	/* If we're the first user validate and initialize the pipeline. */
 	if (pipe->use_count = 0) {
-		ret = vsp1_pipeline_validate(pipe, video);
+		ret = vsp1_video_pipeline_validate(pipe, video);
 		if (ret < 0)
 			goto done;
 	}
@@ -472,7 +472,7 @@ done:
 	return ret;
 }
 
-static void vsp1_pipeline_cleanup(struct vsp1_pipeline *pipe)
+static void vsp1_video_pipeline_cleanup(struct vsp1_pipeline *pipe)
 {
 	mutex_lock(&pipe->lock);
 
@@ -738,7 +738,7 @@ static void vsp1_video_stop_streaming(struct vb2_queue *vq)
 	}
 	mutex_unlock(&pipe->lock);
 
-	vsp1_pipeline_cleanup(pipe);
+	vsp1_video_pipeline_cleanup(pipe);
 	media_entity_pipeline_stop(&video->video.entity);
 
 	/* Remove all buffers from the IRQ queue. */
@@ -879,7 +879,7 @@ vsp1_video_streamon(struct file *file, void *fh, enum v4l2_buf_type type)
 	if (ret < 0)
 		goto err_stop;
 
-	ret = vsp1_pipeline_init(pipe, video);
+	ret = vsp1_video_pipeline_init(pipe, video);
 	if (ret < 0)
 		goto err_stop;
 
@@ -891,7 +891,7 @@ vsp1_video_streamon(struct file *file, void *fh, enum v4l2_buf_type type)
 	return 0;
 
 err_cleanup:
-	vsp1_pipeline_cleanup(pipe);
+	vsp1_video_pipeline_cleanup(pipe);
 err_stop:
 	media_entity_pipeline_stop(&video->video.entity);
 	return ret;
-- 
2.4.6

