From: Javier Martinez Canillas <javier@osg.samsung.com>
Date: Tue, 19 Jan 2016 13:45:12 +0000
Subject: [PATCH] [media] v4l: vsp1: Fix wrong entities links creation
Message-Id: <1453211112-3686-1-git-send-email-javier@osg.samsung.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Geert Uytterhoeven <geert@linux-m68k.org>, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-media@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>

The Media Control framework now requires entities to be registered with
the media device before creating links so commit c7621b3044f7 ("[media]
v4l: vsp1: separate links creation from entities init") separated link
creation from entities init.

But unfortunately that patch introduced a regression since wrong links
were created causing a boot failure on Renesas boards.

This patch fixes the boot issue and also the media graph was compared
by Geert Uytterhoeven to make sure that the driver changes required by
the Media Control framework next generation did not affect the graph.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/media/platform/vsp1/vsp1_drv.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/vsp1/vsp1_drv.c b/drivers/media/platform/vsp1/vsp1_drv.c
index 42dff9d020af..533bc796391e 100644
--- a/drivers/media/platform/vsp1/vsp1_drv.c
+++ b/drivers/media/platform/vsp1/vsp1_drv.c
@@ -256,7 +256,7 @@ static int vsp1_create_entities(struct vsp1_device *vsp1)
 
 	/* Create links. */
 	list_for_each_entry(entity, &vsp1->entities, list_dev) {
-		if (entity->type = VSP1_ENTITY_LIF) {
+		if (entity->type = VSP1_ENTITY_WPF) {
 			ret = vsp1_wpf_create_links(vsp1, entity);
 			if (ret < 0)
 				goto done;
@@ -264,7 +264,10 @@ static int vsp1_create_entities(struct vsp1_device *vsp1)
 			ret = vsp1_rpf_create_links(vsp1, entity);
 			if (ret < 0)
 				goto done;
-		} else {
+		}
+
+		if (entity->type != VSP1_ENTITY_LIF &&
+		    entity->type != VSP1_ENTITY_RPF) {
 			ret = vsp1_create_links(vsp1, entity);
 			if (ret < 0)
 				goto done;
-- 
2.5.0

