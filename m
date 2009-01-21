From: SUGIOKA Toshinobu <sugioka@itonet.co.jp>
Date: Wed, 21 Jan 2009 00:42:10 +0000
Subject: fix unaligned and nonexistent address handling
Message-Id: <4.2.0.58.J.20090121090500.00b5e5d0@router.itonet.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

unaligned and nonexistent address causes wrong exception
handling in traps_32.c(handle_unaligned_access).

'handle_unalinged_ins' should return -EFAULT if address error
is fixed up with kernel exception table, otherwise 
'handle_unaligned_access' increases already fixed program counter
and then crash.

for example
   ioctl(fd, TCGETA, (struct termio *)-1)
never return and stay in TASK_UNINTERRUPTIBLE state forever
in my kernel.

Signed-off-by: SUGIOKA Toshinobu <sugioka@itonet.co.jp>

diff --git a/arch/sh/kernel/traps_32.c b/arch/sh/kernel/traps_32.c
index c0aa3d8..60dcf87 100644
--- a/arch/sh/kernel/traps_32.c
+++ b/arch/sh/kernel/traps_32.c
@@ -125,20 +125,18 @@ static inline void die_if_kernel(const char *str, struct pt_regs *regs,
  * - userspace errors just cause EFAULT to be returned, resulting in SEGV
  * - kernel/userspace interfaces cause a jump to an appropriate handler
  * - other kernel errors are bad
- * - return 0 if fixed-up, -EFAULT if non-fatal (to the kernel) fault
  */
-static int die_if_no_fixup(const char * str, struct pt_regs * regs, long err)
+static void die_if_no_fixup(const char * str, struct pt_regs * regs, long err)
 {
 	if (!user_mode(regs)) {
 		const struct exception_table_entry *fixup;
 		fixup = search_exception_tables(regs->pc);
 		if (fixup) {
 			regs->pc = fixup->fixup;
-			return 0;
+			return;
 		}
 		die(str, regs, err);
 	}
-	return -EFAULT;
 }
 
 static inline void sign_extend(unsigned int count, unsigned char *dst)
@@ -314,7 +312,8 @@ static int handle_unaligned_ins(opcode_t instruction, struct pt_regs *regs,
 	/* Argh. Address not only misaligned but also non-existent.
 	 * Raise an EFAULT and see if it's trapped
 	 */
-	return die_if_no_fixup("Fault in unaligned fixup", regs, 0);
+	die_if_no_fixup("Fault in unaligned fixup", regs, 0);
+	return -EFAULT;
 }
 
 /*

SUGIOKA Toshinobu

