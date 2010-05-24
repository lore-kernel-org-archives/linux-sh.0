From: Mike Frysinger <vapier.adi@gmail.com>
Date: Mon, 24 May 2010 04:33:38 +0000
Subject: Re: [Uclinux-dist-devel] [PATCH -mm 1/1] ptrace: PTRACE_GETFDPIC: fix
Message-Id: <AANLkTinCtKiXjz08FI6EDUKWgLRDd64UVgDawhonZr__@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1266280229-18469-1-git-send-email-vapier@gentoo.org> 
	<1274431345-22366-1-git-send-email-vapier@gentoo.org> <20100521162659.GA16193@redhat.com> 
	<20100521183512.4477F40476@magilla.sf.frob.com> <20100522165320.GA19573@redhat.com> 
	<20100522165401.GB19573@redhat.com>
In-Reply-To: <20100522165401.GB19573@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Oleg Nesterov <oleg@redhat.com>
Cc: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Mike Frysinger <vapier@gentoo.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, Paul Mundt <lethal@linux-sh.org>, uclinux-dist-devel@blackfin.uclinux.org

On Sat, May 22, 2010 at 12:54, Oleg Nesterov wrote:
> Now that Mike Frysinger unified the FDPIC ptrace code, we can fix
> the unsafe usage of child->mm in ptrace_request(PTRACE_GETFDPIC).
>
> We have the reference to task_struct, and ptrace_check_attach()
> verified the tracee is stopped. But nothing can protect from
> SIGKILL after that, we must not assume child->mm != NULL.

gdb still works with FDPIC apps after this, so presumably it works
fine :).  ive added it to the Blackfin tree to get more testing on our
side (not that i'll be pushing it out or anything).

thanks!
-mike
