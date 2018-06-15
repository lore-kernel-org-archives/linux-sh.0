From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Fri, 15 Jun 2018 15:49:17 +0000
Subject: [PATCH] arch/sh: kernel: use KERN_CONT in print_sh_insn()
Message-Id: <20180615154917.7888-1-thomas.petazzoni@bootlin.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The sequence of printk() used in print_sh_insn() to show disassembled
instructions are used to create a single line per instruction, with
multiple printk() calls.

However, without KERN_CONT, a newline is introduced by every printk()
call, leading to a very ugly output:

Code:
  88071c20:
mov.l
@r1
,
r1

  88071c22:
tst
r1
,
r1

By adding KERN_CONT where needed, the output becomes a lot more
useful:

Code:
  88071fc2:  bt        88071fc8
  88071fc4:  bra       88071e22
  88071fc6:  nop
->88071fc8:  trapa     #62
  88071fca:  mov.l     8807201c <smp_call_function_many+0x244/0x278>, r10  ! 88316208 <cpumask_next_and+0x0/0x74>
  88071fcc:  mov       r12, r5
  88071fce:  mov.l     88072018 <smp_call_function_many+0x240/0x278>, r6  ! 8844667c <__cpu_online_mask+0x0/0x4>
  88071fd0:  jsr       @r10
  88071fd2:  mov       #-1, r4

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 arch/sh/kernel/disassemble.c | 92 ++++++++++++++++++++++----------------------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/arch/sh/kernel/disassemble.c b/arch/sh/kernel/disassemble.c
index 015fee58014b..3db7957995f5 100644
--- a/arch/sh/kernel/disassemble.c
+++ b/arch/sh/kernel/disassemble.c
@@ -379,149 +379,149 @@ static void print_sh_insn(u32 memaddr, u16 insn)
 		}
 
 	ok:
-		printk("%-8s  ", op->name);
+		printk(KERN_CONT "%-8s  ", op->name);
 		lastsp = (op->arg[0] = A_END);
 		disp_pc = 0;
 		for (n = 0; n < 6 && op->arg[n] != A_END; n++) {
 			if (n && op->arg[1] != A_END)
-				printk(", ");
+				printk(KERN_CONT ", ");
 			switch (op->arg[n]) {
 			case A_IMM:
-				printk("#%d", (char)(imm));
+				printk(KERN_CONT "#%d", (char)(imm));
 				break;
 			case A_R0:
-				printk("r0");
+				printk(KERN_CONT "r0");
 				break;
 			case A_REG_N:
-				printk("r%d", rn);
+				printk(KERN_CONT "r%d", rn);
 				break;
 			case A_INC_N:
-				printk("@r%d+", rn);
+				printk(KERN_CONT "@r%d+", rn);
 				break;
 			case A_DEC_N:
-				printk("@-r%d", rn);
+				printk(KERN_CONT "@-r%d", rn);
 				break;
 			case A_IND_N:
-				printk("@r%d", rn);
+				printk(KERN_CONT "@r%d", rn);
 				break;
 			case A_DISP_REG_N:
-				printk("@(%d,r%d)", imm, rn);
+				printk(KERN_CONT "@(%d,r%d)", imm, rn);
 				break;
 			case A_REG_M:
-				printk("r%d", rm);
+				printk(KERN_CONT "r%d", rm);
 				break;
 			case A_INC_M:
-				printk("@r%d+", rm);
+				printk(KERN_CONT "@r%d+", rm);
 				break;
 			case A_DEC_M:
-				printk("@-r%d", rm);
+				printk(KERN_CONT "@-r%d", rm);
 				break;
 			case A_IND_M:
-				printk("@r%d", rm);
+				printk(KERN_CONT "@r%d", rm);
 				break;
 			case A_DISP_REG_M:
-				printk("@(%d,r%d)", imm, rm);
+				printk(KERN_CONT "@(%d,r%d)", imm, rm);
 				break;
 			case A_REG_B:
-				printk("r%d_bank", rb);
+				printk(KERN_CONT "r%d_bank", rb);
 				break;
 			case A_DISP_PC:
 				disp_pc = 1;
 				disp_pc_addr = imm + 4 + (memaddr & relmask);
-				printk("%08x <%pS>", disp_pc_addr,
+				printk(KERN_CONT "%08x <%pS>", disp_pc_addr,
 				       (void *)disp_pc_addr);
 				break;
 			case A_IND_R0_REG_N:
-				printk("@(r0,r%d)", rn);
+				printk(KERN_CONT "@(r0,r%d)", rn);
 				break;
 			case A_IND_R0_REG_M:
-				printk("@(r0,r%d)", rm);
+				printk(KERN_CONT "@(r0,r%d)", rm);
 				break;
 			case A_DISP_GBR:
-				printk("@(%d,gbr)",imm);
+				printk(KERN_CONT "@(%d,gbr)",imm);
 				break;
 			case A_R0_GBR:
-				printk("@(r0,gbr)");
+				printk(KERN_CONT "@(r0,gbr)");
 				break;
 			case A_BDISP12:
 			case A_BDISP8:
-				printk("%08x", imm + memaddr);
+				printk(KERN_CONT "%08x", imm + memaddr);
 				break;
 			case A_SR:
-				printk("sr");
+				printk(KERN_CONT "sr");
 				break;
 			case A_GBR:
-				printk("gbr");
+				printk(KERN_CONT "gbr");
 				break;
 			case A_VBR:
-				printk("vbr");
+				printk(KERN_CONT "vbr");
 				break;
 			case A_SSR:
-				printk("ssr");
+				printk(KERN_CONT "ssr");
 				break;
 			case A_SPC:
-				printk("spc");
+				printk(KERN_CONT "spc");
 				break;
 			case A_MACH:
-				printk("mach");
+				printk(KERN_CONT "mach");
 				break;
 			case A_MACL:
-				printk("macl");
+				printk(KERN_CONT "macl");
 				break;
 			case A_PR:
-				printk("pr");
+				printk(KERN_CONT "pr");
 				break;
 			case A_SGR:
-				printk("sgr");
+				printk(KERN_CONT "sgr");
 				break;
 			case A_DBR:
-				printk("dbr");
+				printk(KERN_CONT "dbr");
 				break;
 			case FD_REG_N:
 				if (0)
 					goto d_reg_n;
 			case F_REG_N:
-				printk("fr%d", rn);
+				printk(KERN_CONT "fr%d", rn);
 				break;
 			case F_REG_M:
-				printk("fr%d", rm);
+				printk(KERN_CONT "fr%d", rm);
 				break;
 			case DX_REG_N:
 				if (rn & 1) {
-					printk("xd%d", rn & ~1);
+					printk(KERN_CONT "xd%d", rn & ~1);
 					break;
 				}
 			d_reg_n:
 			case D_REG_N:
-				printk("dr%d", rn);
+				printk(KERN_CONT "dr%d", rn);
 				break;
 			case DX_REG_M:
 				if (rm & 1) {
-					printk("xd%d", rm & ~1);
+					printk(KERN_CONT "xd%d", rm & ~1);
 					break;
 				}
 			case D_REG_M:
-				printk("dr%d", rm);
+				printk(KERN_CONT "dr%d", rm);
 				break;
 			case FPSCR_M:
 			case FPSCR_N:
-				printk("fpscr");
+				printk(KERN_CONT "fpscr");
 				break;
 			case FPUL_M:
 			case FPUL_N:
-				printk("fpul");
+				printk(KERN_CONT "fpul");
 				break;
 			case F_FR0:
-				printk("fr0");
+				printk(KERN_CONT "fr0");
 				break;
 			case V_REG_N:
-				printk("fv%d", rn*4);
+				printk(KERN_CONT "fv%d", rn*4);
 				break;
 			case V_REG_M:
-				printk("fv%d", rm*4);
+				printk(KERN_CONT "fv%d", rm*4);
 				break;
 			case XMTRX_M4:
-				printk("xmtrx");
+				printk(KERN_CONT "xmtrx");
 				break;
 			default:
 				return;
@@ -536,7 +536,7 @@ static void print_sh_insn(u32 memaddr, u16 insn)
 			else
 				__get_user(val, (u32 *)disp_pc_addr);
 
-			printk("  ! %08x <%pS>", val, (void *)val);
+			printk(KERN_CONT "  ! %08x <%pS>", val, (void *)val);
 		}
 
 		return;
@@ -545,7 +545,7 @@ static void print_sh_insn(u32 memaddr, u16 insn)
 
 	}
 
-	printk(".word 0x%x%x%x%x", nibs[0], nibs[1], nibs[2], nibs[3]);
+	printk(KERN_CONT ".word 0x%x%x%x%x", nibs[0], nibs[1], nibs[2], nibs[3]);
 }
 
 void show_code(struct pt_regs *regs)
@@ -568,7 +568,7 @@ void show_code(struct pt_regs *regs)
 
 		printk("%s%08lx:  ", (i ? "  ": "->"), (unsigned long)(pc + i));
 		print_sh_insn((unsigned long)(pc + i), insn);
-		printk("\n");
+		printk(KERN_CONT "\n");
 	}
 
 	printk("\n");
-- 
2.14.4

