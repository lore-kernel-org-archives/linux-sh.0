From: Katsuya Matsubara <matsu@igel.co.jp>
Date: Fri, 26 Jul 2013 09:32:11 +0000
Subject: [PATCH 1/7] [media] vsp1: Fix lack of the sink entity registration for enabled links
Message-Id: <1374831137-9219-2-git-send-email-matsu@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1374831137-9219-1-git-send-email-matsu@igel.co.jp>
In-Reply-To: <1374831137-9219-1-git-send-email-matsu@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-sh@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>, Sakari Ailus <sakari.ailus@iki.fi>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Katsuya Matsubara <matsu@igel.co.jp>

Each source entity maintains a pointer to the counterpart sink
entity while an enabled link connects them. It should be managed by
the setup_link callback in the media controller framework at runtime.
However, enabled links which connect RPFs and WPFs that have an
equivalent index number are created during initialization.
This registers the pointer to a sink entity from the source entity
when an enabled link is created.

Signed-off-by: Katsuya Matsubara <matsu@igel.co.jp>
---
 drivers/media/platform/vsp1/vsp1_drv.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/vsp1/vsp1_drv.c b/drivers/media/platform/vsp1/vsp1_drv.c
index 756929e..0ead308 100644
--- a/drivers/media/platform/vsp1/vsp1_drv.c
+++ b/drivers/media/platform/vsp1/vsp1_drv.c
@@ -101,6 +101,9 @@ static int vsp1_create_links(struct vsp1_device *vsp1, struct vsp1_entity *sink)
 						       entity, pad, flags);
 			if (ret < 0)
 				return ret;
+
+			if (flags & MEDIA_LNK_FL_ENABLED)
+				source->sink = entity;
 		}
 	}
 
-- 
1.7.9.5

