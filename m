From: Hans Verkuil <hverkuil@xs4all.nl>
Date: Thu, 20 Aug 2015 12:43:11 +0000
Subject: Re: [PATCH 3/4] [media] media: use entity.graph_obj.mdev instead of .parent
Message-Id: <55D5CB5F.2010106@xs4all.nl>
List-Id: <linux-sh.vger.kernel.org>
References: <1439998526-12832-1-git-send-email-javier@osg.samsung.com>
 <1439998526-12832-4-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1439998526-12832-4-git-send-email-javier@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 08/19/15 17:35, Javier Martinez Canillas wrote:
> The struct media_entity has a .parent field that stores a pointer
> to the parent struct media_device. But recently a media_gobj was
> embedded into the entities and since struct media_gojb already has
> a pointer to a struct media_device in the .mdev field, the .parent
> field becomes redundant and can be removed.
> 
> This patch replaces all the usage of .parent by .graph_obj.mdev so
> that field will become unused and can be removed on a later patch.
> 
> No functional changes.
> 
> The transformation was made using the following coccinelle spatch:
> 
> @@
> struct media_entity *me;
> @@
> 
> - me->parent
> + me->graph_obj.mdev
> 
> @@
> struct media_entity *link;
> @@
> 
> - link->source->entity->parent
> + link->source->entity->graph_obj.mdev
> 
> @@
> struct exynos_video_entity *ve;
> @@
> 
> - ve->vdev.entity.parent
> + ve->vdev.entity.graph_obj.mdev
> 
> Suggested-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Acked-by: Hans Verkuil <hans.verkuil@cisco.com>

Regards,

	Hans
