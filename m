From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 08 Feb 2010 10:53:13 +0000
Subject: [PATCH] ARM: mach-shmobile: optimize get_irqnr_preamble/and_base macros
Message-Id: <20100208105313.5976.54002.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Optimize the SH-Mobile interrupt assembly macros to avoid
reloading the INTFLGA register address in case of multiple
pending interrupts. Kindly pointed out by Russell King.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/entry-macro.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0002/arch/arm/mach-shmobile/include/mach/entry-macro.S
+++ work/arch/arm/mach-shmobile/include/mach/entry-macro.S	2010-02-08 14:47:31.000000000 +0900
@@ -21,13 +21,13 @@
 	.endm
 
 	.macro  get_irqnr_preamble, base, tmp
+	ldr     \base, =INTFLGA
 	.endm
 
 	.macro  arch_ret_to_user, tmp1, tmp2
 	.endm
 
 	.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
-	ldr     \base, =INTFLGA
 	ldr     \irqnr, [\base]
 	cmp	\irqnr, #0
 	beq	1000f
