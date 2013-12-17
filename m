From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 17 Dec 2013 17:18:49 +0000
Subject: [PATCH 1/2] iommu/shmobile: Allocate archdata with kzalloc()
Message-Id: <1387300730-28783-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387300730-28783-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1387300730-28783-1-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Nguyen Viet Dung <nv-dung-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The archdata attached_list field isn't initialized, leading to random
crashes when accessed. Use kzalloc() to allocate the whole structure and
make sure all fields get initialized properly.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/shmobile-iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/shmobile-iommu.c b/drivers/iommu/shmobile-iommu.c
index d572863..7a3b928 100644
--- a/drivers/iommu/shmobile-iommu.c
+++ b/drivers/iommu/shmobile-iommu.c
@@ -380,14 +380,13 @@ int ipmmu_iommu_init(struct shmobile_ipmmu *ipmmu)
 		kmem_cache_destroy(l1cache);
 		return -ENOMEM;
 	}
-	archdata = kmalloc(sizeof(*archdata), GFP_KERNEL);
+	archdata = kzalloc(sizeof(*archdata), GFP_KERNEL);
 	if (!archdata) {
 		kmem_cache_destroy(l1cache);
 		kmem_cache_destroy(l2cache);
 		return -ENOMEM;
 	}
 	spin_lock_init(&archdata->attach_lock);
-	archdata->attached = NULL;
 	archdata->ipmmu = ipmmu;
 	ipmmu_archdata = archdata;
 	bus_set_iommu(&platform_bus_type, &shmobile_iommu_ops);
-- 
1.8.3.2

