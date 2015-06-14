From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Sun, 14 Jun 2015 17:29:14 +0000
Subject: [PATCH/RFC] v4l: vsp1: Change pixel count at scale-up setting
Message-Id: <1434302954-31273-1-git-send-email-ykaneko0929@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: Mauro Carvalho Chehab <m.chehab@samsung.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Damian Hobson-Garcia <dhobsong@igel.co.jp>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

From: Atsushi Akatsuka <atsushi.akatsuka.vb@hitachi.com>

This commit sets AMD bit of VI6_UDSn_CTRL register,
and modifies scaling formula to fit AMD bit.

Signed-off-by: Atsushi Akatsuka <atsushi.akatsuka.vb@hitachi.com>
Signed-off-by: Hiroki Negishi <hiroki.negishi.zr@hitachi-solutions.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on the master branch of linuxtv.org/media_tree.git.

 drivers/media/platform/vsp1/vsp1_uds.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/vsp1/vsp1_uds.c b/drivers/media/platform/vsp1/vsp1_uds.c
index ccc8243..e7a046d 100644
--- a/drivers/media/platform/vsp1/vsp1_uds.c
+++ b/drivers/media/platform/vsp1/vsp1_uds.c
@@ -64,10 +64,10 @@ static unsigned int uds_output_size(unsigned int input, unsigned int ratio)
 		mp = ratio / 4096;
 		mp = mp < 4 ? 1 : (mp < 8 ? 2 : 4);
 
-		return (input - 1) / mp * mp * 4096 / ratio + 1;
+		return input / mp * mp * 4096 / ratio;
 	} else {
 		/* Up-scaling */
-		return (input - 1) * 4096 / ratio + 1;
+		return input * 4096 / ratio;
 	}
 }
 
@@ -145,7 +145,8 @@ static int uds_s_stream(struct v4l2_subdev *subdev, int enable)
 
 	vsp1_uds_write(uds, VI6_UDS_CTRL,
 		       (uds->scale_alpha ? VI6_UDS_CTRL_AON : 0) |
-		       (multitap ? VI6_UDS_CTRL_BC : 0));
+		       (multitap ? VI6_UDS_CTRL_BC : 0) |
+		       VI6_UDS_CTRL_AMD);
 
 	vsp1_uds_write(uds, VI6_UDS_PASS_BWIDTH,
 		       (uds_passband_width(hscale)
-- 
1.9.1

