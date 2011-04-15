From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 15 Apr 2011 07:44:27 +0000
Subject: [RFC][PATCH] sh: fixup fpu.o compile order
Message-Id: <w3paafs2c2z.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

According to arch/sh/include/asm/fpu.h,
"init_fpu" might be called in all environment.
OTOH the other function on fpu.c are implemented
under #ifdef CONFIG_SH_FPU.
This mean fpu.c can be compiled in all environment.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
Paul

We can not compile Migo-R or other board.
because there is no "init_fpu" function without CONFIG_SH_FPU
on current Kernel.

Iwamatsu-san's patch or this patch is needed.
I added [RFC] because I'm not familiar with FPU_EMU.

 arch/sh/kernel/cpu/Makefile |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/sh/kernel/cpu/Makefile b/arch/sh/kernel/cpu/Makefile
index d49c213..944db0b 100644
--- a/arch/sh/kernel/cpu/Makefile
+++ b/arch/sh/kernel/cpu/Makefile
@@ -17,7 +17,5 @@ obj-$(CONFIG_ARCH_SHMOBILE)	+= shmobile/
 
 obj-$(CONFIG_SH_ADC)		+= adc.o
 obj-$(CONFIG_SH_CLK_CPG_LEGACY)	+= clock-cpg.o
-obj-$(CONFIG_SH_FPU)		+= fpu.o
-obj-$(CONFIG_SH_FPU_EMU)	+= fpu.o
 
-obj-y	+= irq/ init.o clock.o hwblk.o proc.o
+obj-y	+= irq/ init.o clock.o hwblk.o proc.o fpu.o
-- 
1.7.1

