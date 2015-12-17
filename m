From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 17 Dec 2015 08:39:50 +0000
Subject: [PATCH/RFC 12/48] v4l: vsp1: Remove unneeded entity streaming flag
Message-Id: <1450341626-6695-13-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1450341626-6695-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1450341626-6695-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org

The flag is set but never read, remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/media/platform/vsp1/vsp1_bru.c    |  2 --
 drivers/media/platform/vsp1/vsp1_entity.c | 23 -----------------------
 drivers/media/platform/vsp1/vsp1_entity.h |  6 ------
 drivers/media/platform/vsp1/vsp1_rpf.c    |  2 --
 drivers/media/platform/vsp1/vsp1_sru.c    |  2 --
 drivers/media/platform/vsp1/vsp1_wpf.c    |  2 --
 6 files changed, 37 deletions(-)

diff --git a/drivers/media/platform/vsp1/vsp1_bru.c b/drivers/media/platform/vsp1/vsp1_bru.c
index 27a9043b11e2..74cc4903e858 100644
--- a/drivers/media/platform/vsp1/vsp1_bru.c
+++ b/drivers/media/platform/vsp1/vsp1_bru.c
@@ -67,8 +67,6 @@ static int bru_s_stream(struct v4l2_subdev *subdev, int enable)
 	unsigned int flags;
 	unsigned int i;
 
-	vsp1_entity_set_streaming(&bru->entity, enable);
-
 	if (!enable)
 		return 0;
 
diff --git a/drivers/media/platform/vsp1/vsp1_entity.c b/drivers/media/platform/vsp1/vsp1_entity.c
index a366cb64ae9d..69e11586087c 100644
--- a/drivers/media/platform/vsp1/vsp1_entity.c
+++ b/drivers/media/platform/vsp1/vsp1_entity.c
@@ -33,27 +33,6 @@ void vsp1_mod_write(struct vsp1_entity *e, u32 reg, u32 data)
 		vsp1_write(e->vsp1, reg, data);
 }
 
-bool vsp1_entity_is_streaming(struct vsp1_entity *entity)
-{
-	unsigned long flags;
-	bool streaming;
-
-	spin_lock_irqsave(&entity->lock, flags);
-	streaming = entity->streaming;
-	spin_unlock_irqrestore(&entity->lock, flags);
-
-	return streaming;
-}
-
-void vsp1_entity_set_streaming(struct vsp1_entity *entity, bool streaming)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&entity->lock, flags);
-	entity->streaming = streaming;
-	spin_unlock_irqrestore(&entity->lock, flags);
-}
-
 void vsp1_entity_route_setup(struct vsp1_entity *source)
 {
 	struct vsp1_entity *sink;
@@ -198,8 +177,6 @@ int vsp1_entity_init(struct vsp1_device *vsp1, struct vsp1_entity *entity,
 	if (i = ARRAY_SIZE(vsp1_routes))
 		return -EINVAL;
 
-	spin_lock_init(&entity->lock);
-
 	entity->vsp1 = vsp1;
 	entity->source_pad = num_pads - 1;
 
diff --git a/drivers/media/platform/vsp1/vsp1_entity.h b/drivers/media/platform/vsp1/vsp1_entity.h
index c0d6db82ebfb..203872164f8e 100644
--- a/drivers/media/platform/vsp1/vsp1_entity.h
+++ b/drivers/media/platform/vsp1/vsp1_entity.h
@@ -73,9 +73,6 @@ struct vsp1_entity {
 
 	struct v4l2_subdev subdev;
 	struct v4l2_mbus_framefmt *formats;
-
-	spinlock_t lock;		/* Protects the streaming field */
-	bool streaming;
 };
 
 static inline struct vsp1_entity *to_vsp1_entity(struct v4l2_subdev *subdev)
@@ -100,9 +97,6 @@ vsp1_entity_get_pad_format(struct vsp1_entity *entity,
 void vsp1_entity_init_formats(struct v4l2_subdev *subdev,
 			      struct v4l2_subdev_pad_config *cfg);
 
-bool vsp1_entity_is_streaming(struct vsp1_entity *entity);
-void vsp1_entity_set_streaming(struct vsp1_entity *entity, bool streaming);
-
 void vsp1_entity_route_setup(struct vsp1_entity *source);
 
 void vsp1_mod_write(struct vsp1_entity *e, u32 reg, u32 data);
diff --git a/drivers/media/platform/vsp1/vsp1_rpf.c b/drivers/media/platform/vsp1/vsp1_rpf.c
index 62d898c0ad65..ffe097b27a77 100644
--- a/drivers/media/platform/vsp1/vsp1_rpf.c
+++ b/drivers/media/platform/vsp1/vsp1_rpf.c
@@ -46,8 +46,6 @@ static int rpf_s_stream(struct v4l2_subdev *subdev, int enable)
 	u32 pstride;
 	u32 infmt;
 
-	vsp1_entity_set_streaming(&rpf->entity, enable);
-
 	if (!enable)
 		return 0;
 
diff --git a/drivers/media/platform/vsp1/vsp1_sru.c b/drivers/media/platform/vsp1/vsp1_sru.c
index 810c6b376e14..371b20ec5d1b 100644
--- a/drivers/media/platform/vsp1/vsp1_sru.c
+++ b/drivers/media/platform/vsp1/vsp1_sru.c
@@ -114,8 +114,6 @@ static int sru_s_stream(struct v4l2_subdev *subdev, int enable)
 	struct v4l2_mbus_framefmt *output;
 	u32 ctrl0;
 
-	vsp1_entity_set_streaming(&sru->entity, enable);
-
 	if (!enable)
 		return 0;
 
diff --git a/drivers/media/platform/vsp1/vsp1_wpf.c b/drivers/media/platform/vsp1/vsp1_wpf.c
index 28654cffeeca..1013190e440b 100644
--- a/drivers/media/platform/vsp1/vsp1_wpf.c
+++ b/drivers/media/platform/vsp1/vsp1_wpf.c
@@ -47,8 +47,6 @@ static int wpf_s_stream(struct v4l2_subdev *subdev, int enable)
 	u32 srcrpf = 0;
 	u32 outfmt = 0;
 
-	vsp1_entity_set_streaming(&wpf->entity, enable);
-
 	if (!enable) {
 		vsp1_write(vsp1, VI6_WPF_IRQ_ENB(wpf->entity.index), 0);
 		vsp1_write(vsp1, wpf->entity.index * VI6_WPF_OFFSET +
-- 
2.4.10

