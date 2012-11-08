From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 08 Nov 2012 03:09:01 +0000
Subject: [PATCH 3/8] ARM: shmobile: mackerel: enable DMAEngine on USB Host
Message-Id: <871ug423lh.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-mackerel.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index f274252..d5fe365 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -816,6 +816,8 @@ static struct platform_device usbhs1_device = {
 	.id	= 1,
 	.dev = {
 		.platform_data		= &usbhs1_private.info,
+		.dma_mask		= &usbhs1_device.dev.coherent_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
 	},
 	.num_resources	= ARRAY_SIZE(usbhs1_resources),
 	.resource	= usbhs1_resources,
-- 
1.7.9.5

