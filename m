From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 05 Aug 2014 13:21:29 +0000
Subject: [PATCH resend] ARM: shmobile: dma: Use defines instead of hardcoded numbers
Message-Id: <1407244889-26655-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Commit  6b32fafee2bb5fcf0b3d3d04a9762d3a0212089e ("dmaengine: shdma: Add
more register documentation") has landed in
git://git.infradead.org/users/vkoul/slave-dma.git#next

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

