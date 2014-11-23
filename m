From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sun, 23 Nov 2014 13:11:17 +0000
Subject: [PATCH 4/5] drm/rcar-du: fix error return code
Message-Id: <1416748278-22881-5-git-send-email-Julia.Lawall@lip6.fr>
List-Id: <linux-sh.vger.kernel.org>
References: <1416748278-22881-1-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1416748278-22881-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: kernel-janitors@vger.kernel.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Propagate the error code on failure.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
identifier ret; expression e1,e2;
@@
(
if (\(ret < 0\|ret != 0\))
 { ... return ret; }
|
ret = 0
)
... when != ret = e1
    when != &ret
*if(...)
{
  ... when != ret = e2
      when forall
 return ret;
}
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 088bfd8..23cc910 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -586,7 +586,7 @@ int rcar_du_crtc_create(struct rcar_du_group *rgrp, unsigned int index)
 
 	if (irq < 0) {
 		dev_err(rcdu->dev, "no IRQ for CRTC %u\n", index);
-		return ret;
+		return irq;
 	}
 
 	ret = devm_request_irq(rcdu->dev, irq, rcar_du_crtc_irq, irqflags,

