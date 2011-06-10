From: Mathias Krause <minipli@googlemail.com>
Date: Fri, 10 Jun 2011 13:10:48 +0000
Subject: [PATCH] sh, exec: remove redundant set_fs(USER_DS)
Message-Id: <1307711448-16289-1-git-send-email-minipli@googlemail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <BANLkTinv1teZEHMK0qymaVdcxPOErpqSyg@mail.gmail.com>
In-Reply-To: <BANLkTinv1teZEHMK0qymaVdcxPOErpqSyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Mathias Krause <minipli@googlemail.com>

The address limit is already set in flush_old_exec() so those calls to
set_fs(USER_DS) are redundant.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
---
 arch/sh/include/asm/processor_64.h |    1 -
 arch/sh/kernel/process_32.c        |    2 --
 2 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/sh/include/asm/processor_64.h b/arch/sh/include/asm/processor_64.h
index 2a541dd..e25c4c7 100644
--- a/arch/sh/include/asm/processor_64.h
+++ b/arch/sh/include/asm/processor_64.h
@@ -150,7 +150,6 @@ struct thread_struct {
 #define SR_USER (SR_MMU | SR_FD)
 
 #define start_thread(_regs, new_pc, new_sp)			\
-	set_fs(USER_DS);					\
 	_regs->sr = SR_USER;	/* User mode. */		\
 	_regs->pc = new_pc - 4;	/* Compensate syscall exit */	\
 	_regs->pc |= 1;		/* Set SHmedia ! */		\
diff --git a/arch/sh/kernel/process_32.c b/arch/sh/kernel/process_32.c
index b473f0c..aaf6d59 100644
--- a/arch/sh/kernel/process_32.c
+++ b/arch/sh/kernel/process_32.c
@@ -102,8 +102,6 @@ EXPORT_SYMBOL(kernel_thread);
 void start_thread(struct pt_regs *regs, unsigned long new_pc,
 		  unsigned long new_sp)
 {
-	set_fs(USER_DS);
-
 	regs->pr = 0;
 	regs->sr = SR_FD;
 	regs->pc = new_pc;
-- 
1.5.6.5

