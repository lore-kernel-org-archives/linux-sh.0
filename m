From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Fri, 20 Apr 2018 01:03:54 +0000
Subject: [REVIEW][PATCH 03/17] signal/sh: Use force_sig_fault in hw_breakpoint_handler
Message-Id: <20180420010408.24438-3-ebiederm@xmission.com>
List-Id: <linux-sh.vger.kernel.org>
References: <878t9ilmhv.fsf@xmission.com>
In-Reply-To: <878t9ilmhv.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org

The call chain is:
breakpoint
  notify_die
    hw_breakpoint_exceptions_notify
      hw_breakpoint_handler

So the signal number can only be SIGTRAP.

In hw_breakpoint_handler rc is either NOTIFY_STOP or NOTIF_DONE
both of which notifier_to_errno converts to 0.  So si_errno is 0.

Historically si_addr was left unitialized in struct siginfo which is a
bug.  There appears to be no consensus among the various architectures
which value should be in si_addr.  So since no usable value has
been returned up to this point return NULL in si_addr.

Fixes: 4352fc1b12fa ("sh: Abstracted SH-4A UBC support on hw-breakpoint core.")
Fixes: 34d0b5af50a0 ("sh: Convert ptrace to hw_breakpoint API.")
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/sh/kernel/hw_breakpoint.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/sh/kernel/hw_breakpoint.c b/arch/sh/kernel/hw_breakpoint.c
index afe965712a69..8648ed05ccf0 100644
--- a/arch/sh/kernel/hw_breakpoint.c
+++ b/arch/sh/kernel/hw_breakpoint.c
@@ -347,13 +347,8 @@ static int __kprobes hw_breakpoint_handler(struct die_args *args)
 
 		/* Deliver the signal to userspace */
 		if (!arch_check_bp_in_kernelspace(bp)) {
-			siginfo_t info;
-
-			info.si_signo = args->signr;
-			info.si_errno = notifier_to_errno(rc);
-			info.si_code = TRAP_HWBKPT;
-
-			force_sig_info(args->signr, &info, current);
+			force_sig_fault(SIGTRAP, TRAP_HWBKPT,
+					(void __user *)NULL, current);
 		}
 
 		rcu_read_unlock();
-- 
2.14.1

