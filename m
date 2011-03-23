From: David Engraf <david.engraf@sysgo.com>
Date: Wed, 23 Mar 2011 11:35:42 +0000
Subject: [PATCH] sh: Fix ptrace hw_breakpoint handling
Message-Id: <4D89DB0E.5030508@sysgo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040709040205080206060907"
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.
--------------040709040205080206060907
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

sh: Fix ptrace hw_breakpoint handling.

Since commit 34d0b5af50a063cded842716633501b38ff815fb it is no longer 
possible to debug an application using singlestep. The old commit 
converted singlestep handling via ptrace to hw_breakpoints. The 
hw_breakpoint is disabled when an event is triggered and not re-enabled 
again. This patch re-enables the existing hw_breakpoint before the 
existing breakpoint is reused.

Signed-off-by: David Engraf <david.engraf@sysgo.com>


--------------040709040205080206060907
Content-Type: text/x-diff;
 name="sh-fix-hw-breakpoint-usage.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sh-fix-hw-breakpoint-usage.patch"

diff --git a/arch/sh/kernel/ptrace_32.c b/arch/sh/kernel/ptrace_32.c
index 90a15d2..e3bd670 100644
--- a/arch/sh/kernel/ptrace_32.c
+++ b/arch/sh/kernel/ptrace_32.c
@@ -101,6 +101,8 @@ static int set_single_step(struct task_struct *tsk, unsigned long addr)
 
 		attr = bp->attr;
 		attr.bp_addr = addr;
+		/* reenable breakpoint */
+		attr.disabled = false;
 		err = modify_user_hw_breakpoint(bp, &attr);
 		if (unlikely(err))
 			return err;

--------------040709040205080206060907--
