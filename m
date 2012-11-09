From: Simon Horman <horms@verge.net.au>
Date: Fri, 09 Nov 2012 07:31:43 +0000
Subject: [PATCH 4/7] ARM: shmobile: mackerel: enable DMAEngine on USB Host
Message-Id: <1352446306-19945-5-git-send-email-horms@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1352446306-19945-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1352446306-19945-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
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
1.7.10.4

