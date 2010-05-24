From: Roland McGrath <roland@redhat.com>
Date: Mon, 24 May 2010 23:42:50 +0000
Subject: Re: [PATCH -mm 1/1] ptrace: PTRACE_GETFDPIC: fix the unsafe usage
Message-Id: <20100524234250.F158849A56@magilla.sf.frob.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20100522165401.GB19573@redhat.com>
	<1266280229-18469-1-git-send-email-vapier@gentoo.org>
	<1274431345-22366-1-git-send-email-vapier@gentoo.org>
	<20100521162659.GA16193@redhat.com>
	<20100521183512.4477F40476@magilla.sf.frob.com>
	<20100522165320.GA19573@redhat.com>
	<25539.1274711817@redhat.com>
	<20100524151445.GA6393@redhat.com>
In-Reply-To: Oleg Nesterov's message of  Monday, 24 May 2010 17:14:45 +0200 <20100524151445.GA6393@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Oleg Nesterov <oleg@redhat.com>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Mike Frysinger <vapier@gentoo.org>, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, uclinux-dist-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org

> You mean, pass it to arch_ptrace() ?
> 
> grep, grep, grep. I guess I understand you. We have more unsafe code
> like this in arch/*/kernel/ptrace.c. Of course, it can be fixed without
> doing get_task_mm() in sys_ptrace(), but perhaps it would be more clean
> to do what you suggest.
> 
> Roland, what do you think?

The mm pointer is only used by these uncommon ptrace operations that exist
only in certain unusual arch's (and they're all ill-advised old arch ptrace
ABI additions, at that).  It doesn't seem wise to pay the overhead for
get_task_mm()/mmput() on every ptrace call, 99.44% of which don't use it
(and 100% on 90% of machines).

If you were to make any change to the signature of arch_ptrace() it should
be one big change to use a struct ptrace_params or suchlike, also passed
down to ptrace_request().  Then any future needs to pass around more
information won't require changing the code in all the arch code that
doesn't look at the new parameter.


Thanks,
Roland
