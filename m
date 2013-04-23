From: Katsuya Matsubara <matsu@igel.co.jp>
Date: Tue, 23 Apr 2013 10:51:35 +0000
Subject: [PATCH 1/3] [media] sh_veu: invoke v4l2_m2m_job_finish() even if a job has been aborted
Message-Id: <1366714297-2784-2-git-send-email-matsu@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1366714297-2784-1-git-send-email-matsu@igel.co.jp>
In-Reply-To: <1366714297-2784-1-git-send-email-matsu@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org, linux-sh@vger.kernel.org, Katsuya Matsubara <matsu@igel.co.jp>

v4l2_m2m_job_finish() should be invoked even if the current
ongoing job has been aborted since v4l2_m2m_ctx_release() which
has issued the job abort may wait until the finish function is invoked.

Signed-off-by: Katsuya Matsubara <matsu@igel.co.jp>
---
 drivers/media/platform/sh_veu.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/sh_veu.c b/drivers/media/platform/sh_veu.c
index cb54c69..f88c0e8 100644
--- a/drivers/media/platform/sh_veu.c
+++ b/drivers/media/platform/sh_veu.c
@@ -1137,10 +1137,7 @@ static irqreturn_t sh_veu_isr(int irq, void *dev_id)
 
 	veu->xaction++;
 
-	if (!veu->aborting)
-		return IRQ_WAKE_THREAD;
-
-	return IRQ_HANDLED;
+	return IRQ_WAKE_THREAD;
 }
 
 static int sh_veu_probe(struct platform_device *pdev)
-- 
1.7.0.4

