From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 20 Jun 2014 12:37:39 +0000
Subject: [PATCH 2/4] ARM: shmobile: dma: Use defines instead of hardcoded numbers
Message-Id: <1403267861-15609-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1403267861-15609-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1403267861-15609-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Vinod Koul <vinod.koul@intel.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-sh@vger.kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/dma-register.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/dma-register.h b/arch/arm/mach-shmobile/dma-register.h
index 97c40bd9b94f..52a2f66e600f 100644
--- a/arch/arm/mach-shmobile/dma-register.h
+++ b/arch/arm/mach-shmobile/dma-register.h
@@ -52,8 +52,8 @@ static const unsigned int dma_ts_shift[] = {
 	((((i) & TS_LOW_BIT) << TS_LOW_SHIFT) |\
 	 (((i) & TS_HI_BIT)  << TS_HI_SHIFT))
 
-#define CHCR_TX(xmit_sz) (DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL((xmit_sz)))
-#define CHCR_RX(xmit_sz) (DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL((xmit_sz)))
+#define CHCR_TX(xmit_sz) (DM_FIX | SM_INC | RS_ERS | TS_INDEX2VAL((xmit_sz)))
+#define CHCR_RX(xmit_sz) (DM_INC | SM_FIX | RS_ERS | TS_INDEX2VAL((xmit_sz)))
 
 
 /*
-- 
1.9.1

