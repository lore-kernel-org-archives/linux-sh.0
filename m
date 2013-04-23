From: Katsuya Matsubara <matsu@igel.co.jp>
Date: Tue, 23 Apr 2013 10:51:36 +0000
Subject: [PATCH 2/3] [media] sh_veu: keep power supply until the m2m context is released
Message-Id: <1366714297-2784-3-git-send-email-matsu@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1366714297-2784-1-git-send-email-matsu@igel.co.jp>
In-Reply-To: <1366714297-2784-1-git-send-email-matsu@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org, linux-sh@vger.kernel.org, Katsuya Matsubara <matsu@igel.co.jp>

In the sh_veu driver, only the interrupt handler 'sh_veu_bh'
can invoke the v4l2_m2m_job_finish() function.
So the hardware must be alive for handling interrupts
until returning from v4l2_m2m_ctx_release().

Signed-off-by: Katsuya Matsubara <matsu@igel.co.jp>
---
 drivers/media/platform/sh_veu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/sh_veu.c b/drivers/media/platform/sh_veu.c
index f88c0e8..fa86c6f 100644
--- a/drivers/media/platform/sh_veu.c
+++ b/drivers/media/platform/sh_veu.c
@@ -1032,8 +1032,6 @@ static int sh_veu_release(struct file *file)
 
 	dev_dbg(veu->dev, "Releasing instance %p\n", veu_file);
 
-	pm_runtime_put(veu->dev);
-
 	if (veu_file = veu->capture) {
 		veu->capture = NULL;
 		vb2_queue_release(v4l2_m2m_get_vq(veu->m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE));
@@ -1049,6 +1047,8 @@ static int sh_veu_release(struct file *file)
 		veu->m2m_ctx = NULL;
 	}
 
+	pm_runtime_put(veu->dev);
+
 	kfree(veu_file);
 
 	return 0;
-- 
1.7.0.4

