From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 24 May 2011 10:24:03 +0000
Subject: [PATCH 2/3] ARM: mach-shmobile: mark DMA slave ID 0 as invalid
Message-Id: <Pine.LNX.4.64.1105241220240.31628@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1105241147010.31628@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1105241147010.31628@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Magnus Damm <damm@opensource.se>, Ian Molton <ian@mnementh.co.uk>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

This makes it possible to leave DMA slave IDs in the platform data
at default 0 value without hitting DMA channel allocation error paths.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/include/mach/sh7372.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/sh7372.h b/arch/arm/mach-shmobile/include/mach/sh7372.h
index 6a290b7..75076b1 100644
--- a/arch/arm/mach-shmobile/include/mach/sh7372.h
+++ b/arch/arm/mach-shmobile/include/mach/sh7372.h
@@ -436,6 +436,7 @@ enum {
 
 /* DMA slave IDs */
 enum {
+	SHDMA_SLAVE_INVALID,
 	SHDMA_SLAVE_SCIF0_TX,
 	SHDMA_SLAVE_SCIF0_RX,
 	SHDMA_SLAVE_SCIF1_TX,
-- 
1.7.2.5

