From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 22 Aug 2013 15:55:08 +0000
Subject: [PATCH] ARM: shmobile: lager: Fix Display Unit platform data
Message-Id: <1377186908-30428-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The DU device erroneously receives the DU resources array as platform
data instead of the DU platform data structure. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-lager.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Hi Simon,

This patch fixes a bug introduced by

commit f631fa0e380a76504bd65545ed094f04b5c6559a
Author: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date:   Tue Apr 16 12:39:11 2013 +0200

    ARM: shmobile: lager: Add Display Unit support
    
    Only the VGA output is currently supported.
    
    Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
    Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Can you squash it into the faulty commit, or push it on top and make sure it
will got to mainline at the same time ?

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index 219cad8..4c3e694 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -87,8 +87,8 @@ static void __init lager_add_du_device(void)
 		.id = -1,
 		.res = du_resources,
 		.num_res = ARRAY_SIZE(du_resources),
-		.data = &du_resources,
-		.size_data = sizeof(du_resources),
+		.data = &lager_du_pdata,
+		.size_data = sizeof(lager_du_pdata),
 		.dma_mask = DMA_BIT_MASK(32),
 	};
 
-- 
Regards,

Laurent Pinchart

