From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sat, 05 Dec 2015 02:12:50 +0000
Subject: [PATCH v2 16/32] v4l: vsp1: Document the vsp1_pipeline structure
Message-Id: <1449281586-25726-17-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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
 drivers/media/platform/vsp1/vsp1_pipe.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/vsp1/vsp1_pipe.h b/drivers/media/platform/vsp1/vsp1_pipe.h
index 8553d5a03aa3..9c8ded1c29f6 100644
--- a/drivers/media/platform/vsp1/vsp1_pipe.h
+++ b/drivers/media/platform/vsp1/vsp1_pipe.h
@@ -29,9 +29,23 @@ enum vsp1_pipeline_state {
 
 /*
  * struct vsp1_pipeline - A VSP1 hardware pipeline
- * @media: the media pipeline
+ * @pipe: the media pipeline
  * @irqlock: protects the pipeline state
+ * @state: current state
+ * @wq: work queue to wait for state change completion
+ * @frame_end: frame end interrupt handler
  * @lock: protects the pipeline use count and stream count
+ * @use_count: number of video nodes using the pipeline
+ * @stream_count: number of streaming video nodes
+ * @buffers_ready: bitmask of RPFs and WPFs with at least one buffer available
+ * @num_inputs: number of RPFs
+ * @inputs: array of RPFs in the pipeline
+ * @output: WPF at the output of the pipeline
+ * @bru: BRU entity, if present
+ * @lif: LIF entity, if present
+ * @uds: UDS entity, if present
+ * @uds_input: entity at the input of the UDS, if the UDS is present
+ * @entities: list of entities in the pipeline
  */
 struct vsp1_pipeline {
 	struct media_pipeline pipe;
-- 
2.4.10

