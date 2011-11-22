From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 22 Nov 2011 02:59:54 +0000
Subject: [PATCH 1/2] sh: sh7724.h: bugfix: remove unused clock index
Message-Id: <87y5v8yi8p.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Current sh clocks are using pm_runtime frame work instead of old hwblk.
So, HWBLK_UNKNOWN and HWBLK_DBG are not needed for now.

Now mstp32 clocks are registered by sh_clk_mstp32_register(),
but the clock which isn't defined by SH_CLK_MSTP32() macro
will be crash. because it doesn't have enable_reg.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/sh/include/cpu-sh4/cpu/sh7724.h |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/cpu-sh4/cpu/sh7724.h b/arch/sh/include/cpu-sh4/cpu/sh7724.h
index cbc47e6..ea9ada3 100644
--- a/arch/sh/include/cpu-sh4/cpu/sh7724.h
+++ b/arch/sh/include/cpu-sh4/cpu/sh7724.h
@@ -268,10 +268,9 @@ enum {
 };
 
 enum {
-	HWBLK_UNKNOWN = 0,
 	HWBLK_TLB, HWBLK_IC, HWBLK_OC, HWBLK_RSMEM, HWBLK_ILMEM, HWBLK_L2C,
 	HWBLK_FPU, HWBLK_INTC, HWBLK_DMAC0, HWBLK_SHYWAY,
-	HWBLK_HUDI, HWBLK_DBG, HWBLK_UBC,
+	HWBLK_HUDI, HWBLK_UBC,
 	HWBLK_TMU0, HWBLK_CMT, HWBLK_RWDT, HWBLK_DMAC1, HWBLK_TMU1,
 	HWBLK_SCIF0, HWBLK_SCIF1, HWBLK_SCIF2, HWBLK_SCIF3,
 	HWBLK_SCIF4, HWBLK_SCIF5, HWBLK_MSIOF0, HWBLK_MSIOF1,
-- 
1.7.5.4

