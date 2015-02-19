From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 19 Feb 2015 01:06:39 +0000
Subject: [PATCH] drm/cma: Fix 64-bit size_t build warnings
Message-Id: <20150219010639.1654.35019.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: dri-devel@lists.freedesktop.org
Cc: airlied@linux.ie, Magnus Damm <magnus.damm@gmail.com>, laurent.pinchart+renesas@ideasonboard.com, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Fix warnings related to size_t when building for 64-bit architectures:

drivers/gpu/drm/drm_gem_cma_helper.c: In function ‘drm_gem_cma_create’:
drivers/gpu/drm/drm_gem_cma_helper.c:114:4: warning: format ‘%d’ expects argument of type ‘int’, but argument 3 has type ‘size_t’ [-Wformat=]
    size);
    ^
drivers/gpu/drm/drm_gem_cma_helper.c: In function ‘drm_gem_cma_describe’:
drivers/gpu/drm/drm_gem_cma_helper.c:393:4: warning: format ‘%d’ expects argument of type ‘int’, but argument 8 has type ‘size_t’ [-Wformat=]
    off, &cma_obj->paddr, cma_obj->vaddr, obj->size);

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/gpu/drm/drm_gem_cma_helper.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- 0001/drivers/gpu/drm/drm_gem_cma_helper.c
+++ work/drivers/gpu/drm/drm_gem_cma_helper.c	2015-02-19 06:29:39.155526831 +0900
@@ -110,7 +110,7 @@ struct drm_gem_cma_object *drm_gem_cma_c
 	cma_obj->vaddr = dma_alloc_writecombine(drm->dev, size,
 			&cma_obj->paddr, GFP_KERNEL | __GFP_NOWARN);
 	if (!cma_obj->vaddr) {
-		dev_err(drm->dev, "failed to allocate buffer with size %d\n",
+		dev_err(drm->dev, "failed to allocate buffer with size %zu\n",
 			size);
 		ret = -ENOMEM;
 		goto error;
@@ -388,7 +388,7 @@ void drm_gem_cma_describe(struct drm_gem
 
 	off = drm_vma_node_start(&obj->vma_node);
 
-	seq_printf(m, "%2d (%2d) %08llx %pad %p %d",
+	seq_printf(m, "%2d (%2d) %08llx %pad %p %zu",
 			obj->name, obj->refcount.refcount.counter,
 			off, &cma_obj->paddr, cma_obj->vaddr, obj->size);
 
