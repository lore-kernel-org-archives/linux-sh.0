From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 28 Aug 2013 01:37:55 +0000
Subject: [PATCH 5/5] ARM: shmobile: lager: Fix Display Unit platform data
Message-Id: <8034dc4a1d615c84932c74633b7399603f7cc2a4.1377653181.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1377653181.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1377653181.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The DU device erroneously receives the DU resources array as platform
data instead of the DU platform data structure. Fix it.

This problem was introduced by f631fa0 ("ARM: shmobile: lager: Add Display
Unit support").

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-lager.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index 5facfc9..bfca58b 100644
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
1.8.3.2

