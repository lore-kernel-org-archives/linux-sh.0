From: Aurelien Jarno <aurelien@aurel32.net>
Date: Tue, 16 May 2017 22:35:21 +0000
Subject: [PATCH] sh: use pr_cont in code dump
Message-Id: <20170516223522.19094-1-aurelien@aurel32.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Aurelien Jarno <aurelien@aurel32.net>

Using using printk to continue logging messages now produces multiple
line logging output unless the continuations use KERN_CONT. This causes
the code dump on SH do be unreadable:

[   40.036000] Code:
[   40.036000]   8c0128f0:
[   40.036000] stc
[   40.036000] r6_bank
[   40.036000] ,
[   40.036000] r1
[   40.036000]
[   40.036000]   8c0128f2:
[   40.036000] or
[   40.036000] r1
[   40.036000] ,
[   40.036000] r2
[   40.036000]
[   40.036000]   8c0128f4:
[   40.036000] ldc
[   40.036000] r2
[   40.036000] ,
[   40.036000] sr
[   40.036000]

Convert the calls to printk but the first one to pr_cont. This makes the
code dump readable again.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 arch/sh/kernel/disassemble.c | 98 ++++++++++++++++++++++----------------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/arch/sh/kernel/disassemble.c b/arch/sh/kernel/disassemble.c
index 015fee58014b..b5b864aba7bf 100644
--- a/arch/sh/kernel/disassemble.c
+++ b/arch/sh/kernel/disassemble.c
@@ -379,149 +379,149 @@ static void print_sh_insn(u32 memaddr, u16 insn)
 		}
 
 	ok:
-		printk("%-8s  ", op->name);
+		pr_cont("%-8s  ", op->name);
 		lastsp = (op->arg[0] = A_END);
 		disp_pc = 0;
 		for (n = 0; n < 6 && op->arg[n] != A_END; n++) {
 			if (n && op->arg[1] != A_END)
-				printk(", ");
+				pr_cont(", ");
 			switch (op->arg[n]) {
 			case A_IMM:
-				printk("#%d", (char)(imm));
+				pr_cont("#%d", (char)(imm));
 				break;
 			case A_R0:
-				printk("r0");
+				pr_cont("r0");
 				break;
 			case A_REG_N:
-				printk("r%d", rn);
+				pr_cont("r%d", rn);
 				break;
 			case A_INC_N:
-				printk("@r%d+", rn);
+				pr_cont("@r%d+", rn);
 				break;
 			case A_DEC_N:
-				printk("@-r%d", rn);
+				pr_cont("@-r%d", rn);
 				break;
 			case A_IND_N:
-				printk("@r%d", rn);
+				pr_cont("@r%d", rn);
 				break;
 			case A_DISP_REG_N:
-				printk("@(%d,r%d)", imm, rn);
+				pr_cont("@(%d,r%d)", imm, rn);
 				break;
 			case A_REG_M:
-				printk("r%d", rm);
+				pr_cont("r%d", rm);
 				break;
 			case A_INC_M:
-				printk("@r%d+", rm);
+				pr_cont("@r%d+", rm);
 				break;
 			case A_DEC_M:
-				printk("@-r%d", rm);
+				pr_cont("@-r%d", rm);
 				break;
 			case A_IND_M:
-				printk("@r%d", rm);
+				pr_cont("@r%d", rm);
 				break;
 			case A_DISP_REG_M:
-				printk("@(%d,r%d)", imm, rm);
+				pr_cont("@(%d,r%d)", imm, rm);
 				break;
 			case A_REG_B:
-				printk("r%d_bank", rb);
+				pr_cont("r%d_bank", rb);
 				break;
 			case A_DISP_PC:
 				disp_pc = 1;
 				disp_pc_addr = imm + 4 + (memaddr & relmask);
-				printk("%08x <%pS>", disp_pc_addr,
+				pr_cont("%08x <%pS>", disp_pc_addr,
 				       (void *)disp_pc_addr);
 				break;
 			case A_IND_R0_REG_N:
-				printk("@(r0,r%d)", rn);
+				pr_cont("@(r0,r%d)", rn);
 				break;
 			case A_IND_R0_REG_M:
-				printk("@(r0,r%d)", rm);
+				pr_cont("@(r0,r%d)", rm);
 				break;
 			case A_DISP_GBR:
-				printk("@(%d,gbr)",imm);
+				pr_cont("@(%d,gbr)",imm);
 				break;
 			case A_R0_GBR:
-				printk("@(r0,gbr)");
+				pr_cont("@(r0,gbr)");
 				break;
 			case A_BDISP12:
 			case A_BDISP8:
-				printk("%08x", imm + memaddr);
+				pr_cont("%08x", imm + memaddr);
 				break;
 			case A_SR:
-				printk("sr");
+				pr_cont("sr");
 				break;
 			case A_GBR:
-				printk("gbr");
+				pr_cont("gbr");
 				break;
 			case A_VBR:
-				printk("vbr");
+				pr_cont("vbr");
 				break;
 			case A_SSR:
-				printk("ssr");
+				pr_cont("ssr");
 				break;
 			case A_SPC:
-				printk("spc");
+				pr_cont("spc");
 				break;
 			case A_MACH:
-				printk("mach");
+				pr_cont("mach");
 				break;
 			case A_MACL:
-				printk("macl");
+				pr_cont("macl");
 				break;
 			case A_PR:
-				printk("pr");
+				pr_cont("pr");
 				break;
 			case A_SGR:
-				printk("sgr");
+				pr_cont("sgr");
 				break;
 			case A_DBR:
-				printk("dbr");
+				pr_cont("dbr");
 				break;
 			case FD_REG_N:
 				if (0)
 					goto d_reg_n;
 			case F_REG_N:
-				printk("fr%d", rn);
+				pr_cont("fr%d", rn);
 				break;
 			case F_REG_M:
-				printk("fr%d", rm);
+				pr_cont("fr%d", rm);
 				break;
 			case DX_REG_N:
 				if (rn & 1) {
-					printk("xd%d", rn & ~1);
+					pr_cont("xd%d", rn & ~1);
 					break;
 				}
 			d_reg_n:
 			case D_REG_N:
-				printk("dr%d", rn);
+				pr_cont("dr%d", rn);
 				break;
 			case DX_REG_M:
 				if (rm & 1) {
-					printk("xd%d", rm & ~1);
+					pr_cont("xd%d", rm & ~1);
 					break;
 				}
 			case D_REG_M:
-				printk("dr%d", rm);
+				pr_cont("dr%d", rm);
 				break;
 			case FPSCR_M:
 			case FPSCR_N:
-				printk("fpscr");
+				pr_cont("fpscr");
 				break;
 			case FPUL_M:
 			case FPUL_N:
-				printk("fpul");
+				pr_cont("fpul");
 				break;
 			case F_FR0:
-				printk("fr0");
+				pr_cont("fr0");
 				break;
 			case V_REG_N:
-				printk("fv%d", rn*4);
+				pr_cont("fv%d", rn*4);
 				break;
 			case V_REG_M:
-				printk("fv%d", rm*4);
+				pr_cont("fv%d", rm*4);
 				break;
 			case XMTRX_M4:
-				printk("xmtrx");
+				pr_cont("xmtrx");
 				break;
 			default:
 				return;
@@ -536,7 +536,7 @@ static void print_sh_insn(u32 memaddr, u16 insn)
 			else
 				__get_user(val, (u32 *)disp_pc_addr);
 
-			printk("  ! %08x <%pS>", val, (void *)val);
+			pr_cont("  ! %08x <%pS>", val, (void *)val);
 		}
 
 		return;
@@ -545,7 +545,7 @@ static void print_sh_insn(u32 memaddr, u16 insn)
 
 	}
 
-	printk(".word 0x%x%x%x%x", nibs[0], nibs[1], nibs[2], nibs[3]);
+	pr_cont(".word 0x%x%x%x%x", nibs[0], nibs[1], nibs[2], nibs[3]);
 }
 
 void show_code(struct pt_regs *regs)
@@ -562,14 +562,14 @@ void show_code(struct pt_regs *regs)
 		unsigned short insn;
 
 		if (__get_user(insn, pc + i)) {
-			printk(" (Bad address in pc)\n");
+			pr_cont(" (Bad address in pc)\n");
 			break;
 		}
 
-		printk("%s%08lx:  ", (i ? "  ": "->"), (unsigned long)(pc + i));
+		pr_cont("%s%08lx:  ", (i ? "  ": "->"), (unsigned long)(pc + i));
 		print_sh_insn((unsigned long)(pc + i), insn);
-		printk("\n");
+		pr_cont("\n");
 	}
 
-	printk("\n");
+	pr_cont("\n");
 }
-- 
2.11.0

