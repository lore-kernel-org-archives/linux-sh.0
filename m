From: David Howells <dhowells@redhat.com>
Date: Mon, 24 May 2010 14:36:57 +0000
Subject: Re: [PATCH -mm 1/1] ptrace: PTRACE_GETFDPIC: fix the unsafe usage of child->mm
Message-Id: <25539.1274711817@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20100522165401.GB19573@redhat.com> <1266280229-18469-1-git-send-email-vapier@gentoo.org> <1274431345-22366-1-git-send-email-vapier@gentoo.org> <20100521162659.GA16193@redhat.com> <20100521183512.4477F40476@magilla.sf.frob.com> <20100522165320.GA19573@redhat.com>
In-Reply-To: <20100522165401.GB19573@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Oleg Nesterov <oleg@redhat.com>
Cc: dhowells@redhat.com, Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Mike Frysinger <vapier@gentoo.org>, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, uclinux-dist-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> wrote:

> Now that Mike Frysinger unified the FDPIC ptrace code, we can fix
> the unsafe usage of child->mm in ptrace_request(PTRACE_GETFDPIC).
> 
> We have the reference to task_struct, and ptrace_check_attach()
> verified the tracee is stopped. But nothing can protect from
> SIGKILL after that, we must not assume child->mm != NULL.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Acked-by: David Howells <dhowells@redhat.com>

Does it make sense to move the call to get_task_mm() up to sys_ptrace() since
several ptrace functions use it?  The mm pointer could then be handed down the
ptrace hierarchy.

David
