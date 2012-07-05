From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 05 Jul 2012 10:29:39 +0000
Subject: [PATCH 3/7 v2] sh: remove unused DMA device pointer from SIU platform data
Message-Id: <1341484183-10757-4-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1341484183-10757-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1341484183-10757-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>

The SIU ALSA driver is not using the DMA device pointer for DMA channel
filtering any more, it can be now removed.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Paul Mundt <lethal@linux-sh.org>
---
 arch/sh/include/asm/siu.h              |    1 -
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/asm/siu.h b/arch/sh/include/asm/siu.h
index 1d95c78..580b7ac 100644
--- a/arch/sh/include/asm/siu.h
+++ b/arch/sh/include/asm/siu.h
@@ -14,7 +14,6 @@
 struct device;
 
 struct siu_platform {
-	struct device *dma_dev;
 	unsigned int dma_slave_tx_a;
 	unsigned int dma_slave_rx_a;
 	unsigned int dma_slave_tx_b;
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
index 0f5a219..65786c7 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
@@ -512,7 +512,6 @@ static struct platform_device tmu2_device = {
 };
 
 static struct siu_platform siu_platform_data = {
-	.dma_dev	= &dma_device.dev,
 	.dma_slave_tx_a	= SHDMA_SLAVE_SIUA_TX,
 	.dma_slave_rx_a	= SHDMA_SLAVE_SIUA_RX,
 	.dma_slave_tx_b	= SHDMA_SLAVE_SIUB_TX,
-- 
1.7.2.5

