From: Daniel Palmer <daniel@0x0f.com>
Date: Mon, 03 Dec 2018 12:23:23 +0000
Subject: [PATCH] SH: Add dma mask for sh_eth on ecovec24.
Message-Id: <20181203122323.765-1-daniel@0x0f.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Cleans up the warnings and makes ethernet work again on the ecovec24 board.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/sh/boards/mach-ecovec24/setup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 06a894526a0b..3e8e7e915c7f 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -175,6 +175,8 @@ static struct platform_device sh_eth_device = {
 	.id = 0,
 	.dev = {
 		.platform_data = &sh_eth_plat,
+		.dma_mask = &sh_eth_device.dev.coherent_dma_mask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 	.num_resources = ARRAY_SIZE(sh_eth_resources),
 	.resource = sh_eth_resources,
-- 
2.20.0.rc1
