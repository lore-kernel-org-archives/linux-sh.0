From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 13 Sep 2015 20:56:56 +0000
Subject: [PATCH 18/32] v4l: vsp1: Set the SRU CTRL0 register when starting the stream
Message-Id: <1442177830-24536-19-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442177830-24536-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1442177830-24536-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Commit 58f896d859ce ("[media] v4l: vsp1: sru: Make the intensity
controllable during streaming") refactored the stream start code and
removed the SRU CTRL0 register write by mistake. Add it back.

Fixes: 58f896d859ce ("[media] v4l: vsp1: sru: Make the intensity controllable during streaming")
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/media/platform/vsp1/vsp1_sru.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/vsp1/vsp1_sru.c b/drivers/media/platform/vsp1/vsp1_sru.c
index 6310acab60e7..d41ae950d1a1 100644
--- a/drivers/media/platform/vsp1/vsp1_sru.c
+++ b/drivers/media/platform/vsp1/vsp1_sru.c
@@ -154,6 +154,7 @@ static int sru_s_stream(struct v4l2_subdev *subdev, int enable)
 	mutex_lock(sru->ctrls.lock);
 	ctrl0 |= vsp1_sru_read(sru, VI6_SRU_CTRL0)
 	       & (VI6_SRU_CTRL0_PARAM0_MASK | VI6_SRU_CTRL0_PARAM1_MASK);
+	vsp1_sru_write(sru, VI6_SRU_CTRL0, ctrl0);
 	mutex_unlock(sru->ctrls.lock);
 
 	vsp1_sru_write(sru, VI6_SRU_CTRL1, VI6_SRU_CTRL1_PARAM5);
-- 
2.4.6

