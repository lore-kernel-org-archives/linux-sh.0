From: Matt Fleming <matt@console-pimps.org>
Date: Fri, 28 Aug 2009 21:37:20 +0000
Subject: [PATCH] sh: Only shout about fixing up unexpected unaligned accesses
Message-Id: <1251495440-29906-1-git-send-email-matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Some unaligned accesses are completely expected. For example, the
trapped_io code uses the unaligned access fixup code path so there's no
need to warn about having to fixup the unaligned access.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/include/asm/system_32.h |    2 +-
 arch/sh/kernel/io_trapped.c     |    3 ++-
 arch/sh/kernel/traps_32.c       |    9 +++++----
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/sh/include/asm/system_32.h b/arch/sh/include/asm/system_32.h
index 81e0d66..d3ab269 100644
--- a/arch/sh/include/asm/system_32.h
+++ b/arch/sh/include/asm/system_32.h
@@ -199,7 +199,7 @@ do {							\
 #endif
 
 int handle_unaligned_access(insn_size_t instruction, struct pt_regs *regs,
-			    struct mem_access *ma);
+			    struct mem_access *ma, int);
 
 asmlinkage void do_address_error(struct pt_regs *regs,
 				 unsigned long writeaccess,
diff --git a/arch/sh/kernel/io_trapped.c b/arch/sh/kernel/io_trapped.c
index e27a19e..69be603 100644
--- a/arch/sh/kernel/io_trapped.c
+++ b/arch/sh/kernel/io_trapped.c
@@ -284,7 +284,8 @@ int handle_trapped_io(struct pt_regs *regs, unsigned long address)
 		return 0;
 	}
 
-	tmp = handle_unaligned_access(instruction, regs, &trapped_io_access);
+	tmp = handle_unaligned_access(instruction, regs,
+				      &trapped_io_access, 1);
 	set_fs(oldfs);
 	return tmp = 0;
 }
diff --git a/arch/sh/kernel/traps_32.c b/arch/sh/kernel/traps_32.c
index c581dc3..583ace5 100644
--- a/arch/sh/kernel/traps_32.c
+++ b/arch/sh/kernel/traps_32.c
@@ -449,7 +449,7 @@ static inline int handle_delayslot(struct pt_regs *regs,
 #define SH_PC_12BIT_OFFSET(instr) ((((signed short)(instr<<4))>>3) + 4)
 
 int handle_unaligned_access(insn_size_t instruction, struct pt_regs *regs,
-			    struct mem_access *ma)
+			    struct mem_access *ma, int expected)
 {
 	u_int rm;
 	int ret, index;
@@ -458,7 +458,7 @@ int handle_unaligned_access(insn_size_t instruction, struct pt_regs *regs,
 	rm = regs->regs[index];
 
 	/* shout about fixups */
-	if (printk_ratelimit())
+	if (!expected && printk_ratelimit())
 		printk(KERN_NOTICE "Fixing up unaligned %s access "
 		       "in \"%s\" pid=%d pc=0x%p ins=0x%04hx\n",
 		       user_mode(regs) ? "userspace" : "kernel",
@@ -657,7 +657,7 @@ fixup:
 
 		set_fs(USER_DS);
 		tmp = handle_unaligned_access(instruction, regs,
-					      &user_mem_access);
+					      &user_mem_access, 0);
 		set_fs(oldfs);
 
 		if (tmp=0)
@@ -694,7 +694,8 @@ uspace_segv:
 			die("insn faulting in do_address_error", regs, 0);
 		}
 
-		handle_unaligned_access(instruction, regs, &user_mem_access);
+		handle_unaligned_access(instruction, regs,
+					&user_mem_access, 0);
 		set_fs(oldfs);
 	}
 }
-- 
1.6.4.rc0

