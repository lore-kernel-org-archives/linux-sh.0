From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 17 Jun 2020 14:36:36 +0000
Subject: [PATCH v2 6/9] sh: process: Fix broken lines in register dumps
Message-Id: <20200617143639.18315-7-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20200617143639.18315-1-geert+renesas@glider.be>
In-Reply-To: <20200617143639.18315-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Guenter Roeck <linux@roeck-us.net>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Rejoin the broken lines by using pr_cont().
Convert the remaining printk() calls to pr_*() while at it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Guenter Roeck <linux@roeck-us.net>
---
v2:
  - Add Tested-by.

Sample impact:

 PC is at dma_alloc_attrs+0x32/0xb0
 PR is at platform_resource_setup_memory+0xbc/0x150
-PC  : 8c043d06 SP  : 8f41fe9c SR  : 40000001
-TEA : 00000000
-R0  : 8c043cd4 R1  : 00000000 R2  : 00000000 R3  : 8c213e7c
+PC  : 8c043cfa SP  : 8f41fe9c SR  : 40000001 TEA : 8c00369e
+R0  : 8c043cc8 R1  : 00000000 R2  : 00000000 R3  : 8c213e7c
 R4  : 8c29cc38 R5  : 00100000 R6  : 8f41fecc R7  : 00000cc0
 R8  : 8c29cc38 R9  : 8c29720c R10 : 00000cc0 R11 : 00100000
-R12 : 00000000 R13 : 8f41fecc R14 : 8c274773
-MACH: 00000001 MACL: b16b1ded GBR : 09102e96 PR  : 8c2c0524
+R12 : 00000000 R13 : 8f41fecc R14 : 8c27479f
+MACH: 00000001 MACL: b16b1ded GBR : 004c5450 PR  : 8c2c0524
---
 arch/sh/kernel/process_32.c | 38 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/arch/sh/kernel/process_32.c b/arch/sh/kernel/process_32.c
index 456cc8d171f7258a..049f11a5f9abae7a 100644
--- a/arch/sh/kernel/process_32.c
+++ b/arch/sh/kernel/process_32.c
@@ -30,34 +30,30 @@
 
 void show_regs(struct pt_regs * regs)
 {
-	printk("\n");
+	pr_info("\n");
 	show_regs_print_info(KERN_DEFAULT);
 
-	printk("PC is at %pS\n", (void *)instruction_pointer(regs));
-	printk("PR is at %pS\n", (void *)regs->pr);
+	pr_info("PC is at %pS\n", (void *)instruction_pointer(regs));
+	pr_info("PR is at %pS\n", (void *)regs->pr);
 
-	printk("PC  : %08lx SP  : %08lx SR  : %08lx ",
-	       regs->pc, regs->regs[15], regs->sr);
+	pr_info("PC  : %08lx SP  : %08lx SR  : %08lx ", regs->pc,
+		regs->regs[15], regs->sr);
 #ifdef CONFIG_MMU
-	printk("TEA : %08x\n", __raw_readl(MMU_TEA));
+	pr_cont("TEA : %08x\n", __raw_readl(MMU_TEA));
 #else
-	printk("\n");
+	pr_cont("\n");
 #endif
 
-	printk("R0  : %08lx R1  : %08lx R2  : %08lx R3  : %08lx\n",
-	       regs->regs[0],regs->regs[1],
-	       regs->regs[2],regs->regs[3]);
-	printk("R4  : %08lx R5  : %08lx R6  : %08lx R7  : %08lx\n",
-	       regs->regs[4],regs->regs[5],
-	       regs->regs[6],regs->regs[7]);
-	printk("R8  : %08lx R9  : %08lx R10 : %08lx R11 : %08lx\n",
-	       regs->regs[8],regs->regs[9],
-	       regs->regs[10],regs->regs[11]);
-	printk("R12 : %08lx R13 : %08lx R14 : %08lx\n",
-	       regs->regs[12],regs->regs[13],
-	       regs->regs[14]);
-	printk("MACH: %08lx MACL: %08lx GBR : %08lx PR  : %08lx\n",
-	       regs->mach, regs->macl, regs->gbr, regs->pr);
+	pr_info("R0  : %08lx R1  : %08lx R2  : %08lx R3  : %08lx\n",
+		regs->regs[0], regs->regs[1], regs->regs[2], regs->regs[3]);
+	pr_info("R4  : %08lx R5  : %08lx R6  : %08lx R7  : %08lx\n",
+		regs->regs[4], regs->regs[5], regs->regs[6], regs->regs[7]);
+	pr_info("R8  : %08lx R9  : %08lx R10 : %08lx R11 : %08lx\n",
+		regs->regs[8], regs->regs[9], regs->regs[10], regs->regs[11]);
+	pr_info("R12 : %08lx R13 : %08lx R14 : %08lx\n",
+		regs->regs[12], regs->regs[13], regs->regs[14]);
+	pr_info("MACH: %08lx MACL: %08lx GBR : %08lx PR  : %08lx\n",
+		regs->mach, regs->macl, regs->gbr, regs->pr);
 
 	show_trace(NULL, (unsigned long *)regs->regs[15], regs, KERN_DEFAULT);
 	show_code(regs);
-- 
2.17.1
