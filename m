From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Tue, 30 Jun 2015 16:25:05 +0000
Subject: [PATCH v2 1/2] v4l: vsp1: Fix ref_count bug
Message-Id: <1435681506-24296-2-git-send-email-ykaneko0929@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1435681506-24296-1-git-send-email-ykaneko0929@gmail.com>
In-Reply-To: <1435681506-24296-1-git-send-email-ykaneko0929@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: Mauro Carvalho Chehab <m.chehab@samsung.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Damian Hobson-Garcia <dhobsong@igel.co.jp>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

This patch fixes the judgement error of ref count in vsp1_pm_resume().

This patch was separated from the patch written by Sei Fumizono.

Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>

---

This patch is based on the master branch of linuxtv.org/media_tree.git.

v2 [Yoshihiro Kaneko]
* compile tested only

 drivers/media/platform/vsp1/vsp1_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/vsp1/vsp1_drv.c b/drivers/media/platform/vsp1/vsp1_drv.c
index 913485a..a7dfbb0 100644
--- a/drivers/media/platform/vsp1/vsp1_drv.c
+++ b/drivers/media/platform/vsp1/vsp1_drv.c
@@ -413,7 +413,7 @@ static int vsp1_pm_resume(struct device *dev)
 
 	WARN_ON(mutex_is_locked(&vsp1->lock));
 
-	if (vsp1->ref_count)
+	if (vsp1->ref_count = 0)
 		return 0;
 
 	return clk_prepare_enable(vsp1->clock);
-- 
1.9.1

