From: Oleg Nesterov <oleg@redhat.com>
Date: Sat, 22 May 2010 14:55:20 +0000
Subject: [PATCH -mm 1/1] ptrace: PTRACE_GETFDPIC: fix the unsafe usage of
Message-Id: <20100522165401.GB19573@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1266280229-18469-1-git-send-email-vapier@gentoo.org> <1274431345-22366-1-git-send-email-vapier@gentoo.org> <20100521162659.GA16193@redhat.com> <20100521183512.4477F40476@magilla.sf.frob.com> <20100522165320.GA19573@redhat.com>
In-Reply-To: <20100522165320.GA19573@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Frysinger <vapier@gentoo.org>, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, uclinux-dist-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>

Now that Mike Frysinger unified the FDPIC ptrace code, we can fix
the unsafe usage of child->mm in ptrace_request(PTRACE_GETFDPIC).

We have the reference to task_struct, and ptrace_check_attach()
verified the tracee is stopped. But nothing can protect from
SIGKILL after that, we must not assume child->mm != NULL.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---

 kernel/ptrace.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- 34-rc1/kernel/ptrace.c~PTRACE_FDPIC	2010-05-22 18:04:47.000000000 +0200
+++ 34-rc1/kernel/ptrace.c	2010-05-22 18:35:35.000000000 +0200
@@ -598,18 +598,24 @@ int ptrace_request(struct task_struct *c
 
 #ifdef CONFIG_BINFMT_ELF_FDPIC
 	case PTRACE_GETFDPIC: {
+		struct mm_struct *mm = get_task_mm(child);
 		unsigned long tmp = 0;
 
+		ret = -ESRCH;
+		if (!mm)
+			break;
+
 		switch (addr) {
 		case PTRACE_GETFDPIC_EXEC:
-			tmp = child->mm->context.exec_fdpic_loadmap;
+			tmp = mm->context.exec_fdpic_loadmap;
 			break;
 		case PTRACE_GETFDPIC_INTERP:
-			tmp = child->mm->context.interp_fdpic_loadmap;
+			tmp = mm->context.interp_fdpic_loadmap;
 			break;
 		default:
 			break;
 		}
+		mmput(mm);
 
 		ret = put_user(tmp, (unsigned long __user *) data);
 		break;

