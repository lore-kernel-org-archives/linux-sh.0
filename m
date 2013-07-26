From: Katsuya Matsubara <matsu@igel.co.jp>
Date: Fri, 26 Jul 2013 09:32:12 +0000
Subject: [PATCH 2/7] [media] vsp1: Use the maximum number defined in platform data
Message-Id: <1374831137-9219-3-git-send-email-matsu@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1374831137-9219-1-git-send-email-matsu@igel.co.jp>
In-Reply-To: <1374831137-9219-1-git-send-email-matsu@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-sh@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>, Sakari Ailus <sakari.ailus@iki.fi>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Katsuya Matsubara <matsu@igel.co.jp>

The VSP1 driver allows to define the maximum number of each module
such as RPF, WPF, and UDS in a platform data definition.
This suppresses operations for nonexistent or unused modules.

Signed-off-by: Katsuya Matsubara <matsu@igel.co.jp>
---
 drivers/media/platform/vsp1/vsp1_drv.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/vsp1/vsp1_drv.c b/drivers/media/platform/vsp1/vsp1_drv.c
index 0ead308..a8c21f8 100644
--- a/drivers/media/platform/vsp1/vsp1_drv.c
+++ b/drivers/media/platform/vsp1/vsp1_drv.c
@@ -35,7 +35,7 @@ static irqreturn_t vsp1_irq_handler(int irq, void *data)
 	irqreturn_t ret = IRQ_NONE;
 	unsigned int i;
 
-	for (i = 0; i < VPS1_MAX_WPF; ++i) {
+	for (i = 0; i < vsp1->pdata->wpf_count; ++i) {
 		struct vsp1_rwpf *wpf = vsp1->wpf[i];
 		struct vsp1_pipeline *pipe;
 		u32 status;
@@ -243,7 +243,7 @@ static void vsp1_device_init(struct vsp1_device *vsp1)
 	/* Reset any channel that might be running. */
 	status = vsp1_read(vsp1, VI6_STATUS);
 
-	for (i = 0; i < VPS1_MAX_WPF; ++i) {
+	for (i = 0; i < vsp1->pdata->wpf_count; ++i) {
 		unsigned int timeout;
 
 		if (!(status & VI6_STATUS_SYS_ACT(i)))
@@ -265,10 +265,10 @@ static void vsp1_device_init(struct vsp1_device *vsp1)
 	vsp1_write(vsp1, VI6_CLK_DCSWT, (8 << VI6_CLK_DCSWT_CSTPW_SHIFT) |
 		   (8 << VI6_CLK_DCSWT_CSTRW_SHIFT));
 
-	for (i = 0; i < VPS1_MAX_RPF; ++i)
+	for (i = 0; i < vsp1->pdata->rpf_count; ++i)
 		vsp1_write(vsp1, VI6_DPR_RPF_ROUTE(i), VI6_DPR_NODE_UNUSED);
 
-	for (i = 0; i < VPS1_MAX_UDS; ++i)
+	for (i = 0; i < vsp1->pdata->uds_count; ++i)
 		vsp1_write(vsp1, VI6_DPR_UDS_ROUTE(i), VI6_DPR_NODE_UNUSED);
 
 	vsp1_write(vsp1, VI6_DPR_SRU_ROUTE, VI6_DPR_NODE_UNUSED);
-- 
1.7.9.5

