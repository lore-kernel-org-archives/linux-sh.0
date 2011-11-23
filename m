From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 23 Nov 2011 21:53:46 +0000
Subject: [PATCH] sh: sh7722: fix Oops: remove empty clock entries
Message-Id: <Pine.LNX.4.64.1111232248500.5635@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Unused indices produce empty entries in the clock array, which then lead to
Oopses at boot-time.

Reported-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

This is against sh-latest with hwblk patches from sh/hwblk applied on top.

Morimoto-san, you were right, I was able to reproduce a hang on ecovec, 
and your patch fixes it - thanks! Here goes a similar one for sh7722 - 
tested on migor.

Thanks
Guennadi

 arch/sh/include/cpu-sh4/cpu/sh7722.h |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/sh/include/cpu-sh4/cpu/sh7722.h b/arch/sh/include/cpu-sh4/cpu/sh7722.h
index bd06227..3bb74e5 100644
--- a/arch/sh/include/cpu-sh4/cpu/sh7722.h
+++ b/arch/sh/include/cpu-sh4/cpu/sh7722.h
@@ -222,14 +222,11 @@ enum {
 };
 
 enum {
-	HWBLK_UNKNOWN = 0,
-	HWBLK_TLB, HWBLK_IC, HWBLK_OC, HWBLK_URAM, HWBLK_XYMEM,
-	HWBLK_INTC, HWBLK_DMAC, HWBLK_SHYWAY, HWBLK_HUDI,
-	HWBLK_UBC, HWBLK_TMU, HWBLK_CMT, HWBLK_RWDT, HWBLK_FLCTL,
-	HWBLK_SCIF0, HWBLK_SCIF1, HWBLK_SCIF2, HWBLK_SIO,
-	HWBLK_SIOF0, HWBLK_SIOF1, HWBLK_IIC, HWBLK_RTC,
-	HWBLK_TPU, HWBLK_IRDA, HWBLK_SDHI, HWBLK_SIM, HWBLK_KEYSC,
-	HWBLK_TSIF, HWBLK_USBF, HWBLK_2DG, HWBLK_SIU, HWBLK_VOU,
+	HWBLK_URAM, HWBLK_XYMEM,
+	HWBLK_TMU, HWBLK_CMT, HWBLK_RWDT, HWBLK_FLCTL,
+	HWBLK_SCIF0, HWBLK_SCIF1, HWBLK_SCIF2, HWBLK_IIC, HWBLK_RTC,
+	HWBLK_SDHI, HWBLK_KEYSC,
+	HWBLK_USBF, HWBLK_2DG, HWBLK_SIU, HWBLK_VOU,
 	HWBLK_JPU, HWBLK_BEU, HWBLK_CEU, HWBLK_VEU, HWBLK_VPU,
 	HWBLK_LCDC,
 	HWBLK_NR,
-- 
1.7.2.5

