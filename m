From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 21 Apr 2010 15:14:19 +0000
Subject: [PATCH] SH: fix TS field shift calculation for DMA drivers
Message-Id: <Pine.LNX.4.64.1004211712500.5292@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

CHCR_TS_HIGH_SHIFT is defined as a shift of TS high bits in CHCR register,
relative to low bits. The TS_INDEX2VAL() macro has to take this into account.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Should be good for 2.6.34

 arch/sh/include/cpu-sh4/cpu/dma-register.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/include/cpu-sh4/cpu/dma-register.h b/arch/sh/include/cpu-sh4/cpu/dma-register.h
index 55f9fec..de23595 100644
--- a/arch/sh/include/cpu-sh4/cpu/dma-register.h
+++ b/arch/sh/include/cpu-sh4/cpu/dma-register.h
@@ -76,7 +76,7 @@ enum {
 }
 
 #define TS_INDEX2VAL(i)	((((i) & 3) << CHCR_TS_LOW_SHIFT) | \
-			 ((((i) >> 2) & 3) << CHCR_TS_HIGH_SHIFT))
+			 (((i) & 0xc) << CHCR_TS_HIGH_SHIFT))
 
 #else /* CONFIG_CPU_SH4A */
 
-- 
1.6.2.4

