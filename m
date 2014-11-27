From: Takanari Hayama <taki@igel.co.jp>
Date: Thu, 27 Nov 2014 01:25:02 +0000
Subject: [PATCH v2 2/2] v4l: vsp1: Always enable virtual RPF when BRU is in use
Message-Id: <1417051502-30169-3-git-send-email-taki@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1417051502-30169-1-git-send-email-taki@igel.co.jp>
In-Reply-To: <1417051502-30169-1-git-send-email-taki@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Regardless of a number of inputs, we should always enable virtual RPF
when BRU is used. This allows the case when there's only one input to
BRU, and a size of the input is smaller than a size of an output of BRU.

Signed-off-by: Takanari Hayama <taki@igel.co.jp>
---
 drivers/media/platform/vsp1/vsp1_wpf.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/vsp1/vsp1_wpf.c b/drivers/media/platform/vsp1/vsp1_wpf.c
index 6e05776..cb17c4d 100644
--- a/drivers/media/platform/vsp1/vsp1_wpf.c
+++ b/drivers/media/platform/vsp1/vsp1_wpf.c
@@ -92,19 +92,20 @@ static int wpf_s_stream(struct v4l2_subdev *subdev, int enable)
 		return 0;
 	}
 
-	/* Sources. If the pipeline has a single input configure it as the
-	 * master layer. Otherwise configure all inputs as sub-layers and
-	 * select the virtual RPF as the master layer.
+	/* Sources. If the pipeline has a single input and BRU is not used,
+	 * configure it as the master layer. Otherwise configure all
+	 * inputs as sub-layers and select the virtual RPF as the master
+	 * layer.
 	 */
 	for (i = 0; i < pipe->num_inputs; ++i) {
 		struct vsp1_rwpf *input = pipe->inputs[i];
 
-		srcrpf |= pipe->num_inputs = 1
+		srcrpf |= (!pipe->bru && pipe->num_inputs = 1)
 			? VI6_WPF_SRCRPF_RPF_ACT_MST(input->entity.index)
 			: VI6_WPF_SRCRPF_RPF_ACT_SUB(input->entity.index);
 	}
 
-	if (pipe->num_inputs > 1)
+	if (pipe->bru || pipe->num_inputs > 1)
 		srcrpf |= VI6_WPF_SRCRPF_VIRACT_MST;
 
 	vsp1_wpf_write(wpf, VI6_WPF_SRCRPF, srcrpf);
-- 
1.8.0

