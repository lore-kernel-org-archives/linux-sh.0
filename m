From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 07 Feb 2008 11:04:12 +0000
Subject: [PATCH] sh: use opcode_t and enable unaligned code for sh2a
Message-Id: <20080207110412.9582.20137.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch converts the unaligned access handling code to use opcode_t
instead of u16. While at it, enable unaligned access handling for sh2a.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/traps_32.c |   59 +++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 34 deletions(-)

--- 0003/arch/sh/kernel/traps_32.c
+++ work/arch/sh/kernel/traps_32.c	2008-02-07 16:01:35.000000000 +0900
@@ -179,7 +179,7 @@ static inline void sign_extend(unsigned 
  *   (if that instruction is in a branch delay slot)
  * - return 0 if emulation okay, -EFAULT on existential error
  */
-static int handle_unaligned_ins(u16 instruction, struct pt_regs *regs)
+static int handle_unaligned_ins(opcode_t instruction, struct pt_regs *regs)
 {
 	int ret, index, count;
 	unsigned long *rm, *rn;
@@ -320,11 +320,13 @@ static int handle_unaligned_ins(u16 inst
  * emulate the instruction in the delay slot
  * - fetches the instruction from PC+2
  */
-static inline int handle_unaligned_delayslot(struct pt_regs *regs)
+static inline int handle_unaligned_delayslot(struct pt_regs *regs,
+					     opcode_t old_instruction)
 {
-	u16 instruction;
+	opcode_t instruction;
+	void *addr = (void *)(regs->pc + instruction_size(old_instruction));
 
-	if (copy_from_user(&instruction, (u16 *)(regs->pc+2), 2)) {
+	if (copy_from_user(&instruction, addr, sizeof(instruction))) {
 		/* the instruction-fetch faulted */
 		if (user_mode(regs))
 			return -EFAULT;
@@ -334,7 +336,7 @@ static inline int handle_unaligned_delay
 		    regs, 0);
 	}
 
-	return handle_unaligned_ins(instruction,regs);
+	return handle_unaligned_ins(instruction, regs);
 }
 
 /*
@@ -357,10 +359,10 @@ static inline int handle_unaligned_delay
  * XXX: SH-2A needs this too, but it needs an overhaul thanks to mixed 32-bit
  * opcodes..
  */
-#ifndef CONFIG_CPU_SH2A
+
 static int handle_unaligned_notify_count = 10;
 
-static int handle_unaligned_access(u16 instruction, struct pt_regs *regs)
+static int handle_unaligned_access(opcode_t instruction, struct pt_regs *regs)
 {
 	u_int rm;
 	int ret, index;
@@ -375,7 +377,7 @@ static int handle_unaligned_access(u16 i
 		printk(KERN_NOTICE "Fixing up unaligned userspace access "
 		       "in \"%s\" pid=%d pc=0x%p ins=0x%04hx\n",
 		       current->comm, task_pid_nr(current),
-		       (u16 *)regs->pc, instruction);
+		       (void *)regs->pc, instruction);
 	}
 
 	ret = -EFAULT;
@@ -383,19 +385,19 @@ static int handle_unaligned_access(u16 i
 	case 0x0000:
 		if (instruction=0x000B) {
 			/* rts */
-			ret = handle_unaligned_delayslot(regs);
+			ret = handle_unaligned_delayslot(regs, instruction);
 			if (ret=0)
 				regs->pc = regs->pr;
 		}
 		else if ((instruction&0x00FF)=0x0023) {
 			/* braf @Rm */
-			ret = handle_unaligned_delayslot(regs);
+			ret = handle_unaligned_delayslot(regs, instruction);
 			if (ret=0)
 				regs->pc += rm + 4;
 		}
 		else if ((instruction&0x00FF)=0x0003) {
 			/* bsrf @Rm */
-			ret = handle_unaligned_delayslot(regs);
+			ret = handle_unaligned_delayslot(regs, instruction);
 			if (ret=0) {
 				regs->pr = regs->pc + 4;
 				regs->pc += rm + 4;
@@ -416,13 +418,13 @@ static int handle_unaligned_access(u16 i
 	case 0x4000:
 		if ((instruction&0x00FF)=0x002B) {
 			/* jmp @Rm */
-			ret = handle_unaligned_delayslot(regs);
+			ret = handle_unaligned_delayslot(regs, instruction);
 			if (ret=0)
 				regs->pc = rm;
 		}
 		else if ((instruction&0x00FF)=0x000B) {
 			/* jsr @Rm */
-			ret = handle_unaligned_delayslot(regs);
+			ret = handle_unaligned_delayslot(regs, instruction);
 			if (ret=0) {
 				regs->pr = regs->pc + 4;
 				regs->pc = rm;
@@ -449,7 +451,7 @@ static int handle_unaligned_access(u16 i
 		case 0x0B00: /* bf   lab - no delayslot*/
 			break;
 		case 0x0F00: /* bf/s lab */
-			ret = handle_unaligned_delayslot(regs);
+			ret = handle_unaligned_delayslot(regs, instruction);
 			if (ret=0) {
 #if defined(CONFIG_CPU_SH4) || defined(CONFIG_SH7705_CACHE_32KB)
 				if ((regs->sr & 0x00000001) != 0)
@@ -462,7 +464,7 @@ static int handle_unaligned_access(u16 i
 		case 0x0900: /* bt   lab - no delayslot */
 			break;
 		case 0x0D00: /* bt/s lab */
-			ret = handle_unaligned_delayslot(regs);
+			ret = handle_unaligned_delayslot(regs, instruction);
 			if (ret=0) {
 #if defined(CONFIG_CPU_SH4) || defined(CONFIG_SH7705_CACHE_32KB)
 				if ((regs->sr & 0x00000001) = 0)
@@ -476,13 +478,13 @@ static int handle_unaligned_access(u16 i
 		break;
 
 	case 0xA000: /* bra label */
-		ret = handle_unaligned_delayslot(regs);
+		ret = handle_unaligned_delayslot(regs, instruction);
 		if (ret=0)
 			regs->pc += SH_PC_12BIT_OFFSET(instruction);
 		break;
 
 	case 0xB000: /* bsr label */
-		ret = handle_unaligned_delayslot(regs);
+		ret = handle_unaligned_delayslot(regs, instruction);
 		if (ret=0) {
 			regs->pr = regs->pc + 4;
 			regs->pc += SH_PC_12BIT_OFFSET(instruction);
@@ -493,12 +495,11 @@ static int handle_unaligned_access(u16 i
 
 	/* handle non-delay-slot instruction */
  simple:
-	ret = handle_unaligned_ins(instruction,regs);
+	ret = handle_unaligned_ins(instruction, regs);
 	if (ret=0)
 		regs->pc += instruction_size(instruction);
 	return ret;
 }
-#endif /* CONFIG_CPU_SH2A */
 
 #ifdef CONFIG_CPU_HAS_SR_RB
 #define lookup_exception_vector(x)	\
@@ -526,10 +527,8 @@ asmlinkage void do_address_error(struct 
 	unsigned long error_code = 0;
 	mm_segment_t oldfs;
 	siginfo_t info;
-#ifndef CONFIG_CPU_SH2A
-	u16 instruction;
+	opcode_t instruction;
 	int tmp;
-#endif
 
 	/* Intentional ifdef */
 #ifdef CONFIG_CPU_HAS_SR_RB
@@ -549,9 +548,9 @@ asmlinkage void do_address_error(struct 
 			goto uspace_segv;
 		}
 
-#ifndef CONFIG_CPU_SH2A
 		set_fs(USER_DS);
-		if (copy_from_user(&instruction, (u16 *)(regs->pc), 2)) {
+		if (copy_from_user(&instruction, (void *)(regs->pc),
+				   sizeof(instruction))) {
 			/* Argh. Fault on the instruction itself.
 			   This should never happen non-SMP
 			*/
@@ -564,8 +563,6 @@ asmlinkage void do_address_error(struct 
 
 		if (tmp=0)
 			return; /* sorted */
-#endif
-
 uspace_segv:
 		printk(KERN_NOTICE "Sending SIGBUS to \"%s\" due to unaligned "
 		       "access (PC %lx PR %lx)\n", current->comm, regs->pc,
@@ -580,9 +577,9 @@ uspace_segv:
 		if (regs->pc & 1)
 			die("unaligned program counter", regs, error_code);
 
-#ifndef CONFIG_CPU_SH2A
 		set_fs(KERNEL_DS);
-		if (copy_from_user(&instruction, (u16 *)(regs->pc), 2)) {
+		if (copy_from_user(&instruction, (void *)(regs->pc),
+				   sizeof(instruction))) {
 			/* Argh. Fault on the instruction itself.
 			   This should never happen non-SMP
 			*/
@@ -592,12 +589,6 @@ uspace_segv:
 
 		handle_unaligned_access(instruction, regs);
 		set_fs(oldfs);
-#else
-		printk(KERN_NOTICE "Killing process \"%s\" due to unaligned "
-		       "access\n", current->comm);
-
-		force_sig(SIGSEGV, current);
-#endif
 	}
 }
 
