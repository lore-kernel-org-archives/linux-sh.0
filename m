From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 04 Dec 2009 18:44:41 +0000
Subject: [PATCH 1/5] sh: DMA driver has to specify its alignment requirements
Message-Id: <Pine.LNX.4.64.0912041940110.3981@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0912041936541.3981@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.0912041936541.3981@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, linux-sh@vger.kernel.org

The SH DMA driver by default uses 32-byte transfers, in this mode buffers and
sizes have to be 32-byte aligned. Specifying this requirement also fixes Oopses
with dmatest.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/dma/shdma.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index b3b065c..f5fae12 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -677,6 +677,8 @@ static int __init sh_dmae_probe(struct platform_device *pdev)
 	shdev->common.device_is_tx_complete = sh_dmae_is_complete;
 	shdev->common.device_issue_pending = sh_dmae_memcpy_issue_pending;
 	shdev->common.dev = &pdev->dev;
+	/* Default transfer size of 32 bytes requires 32-byte alignment */
+	shdev->common.copy_align = 5;
 
 #if defined(CONFIG_CPU_SH4)
 	/* Non Mix IRQ mode SH7722/SH7730 etc... */
-- 
1.6.2.4

