From: Roland McGrath <roland@redhat.com>
Date: Fri, 21 May 2010 18:35:12 +0000
Subject: Re: [PATCH v2] ptrace: unify FDPIC implementations
Message-Id: <20100521183512.4477F40476@magilla.sf.frob.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1266280229-18469-1-git-send-email-vapier@gentoo.org>
	<1274431345-22366-1-git-send-email-vapier@gentoo.org>
	<20100521162659.GA16193@redhat.com>
In-Reply-To: Oleg Nesterov's message of  Friday, 21 May 2010 18:26:59 +0200 <20100521162659.GA16193@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Oleg Nesterov <oleg@redhat.com>
Cc: Mike Frysinger <vapier@gentoo.org>, Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, uclinux-dist-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>

> This looks unsafe. What protect child->mm if ptrace() races with SIGKILL ?
> 
> Of course, I do not blame this patch, the code was copied from arch/, but
> I think we need another patch which checks ->mm != NULL under task_lock()
> on top of this one?

Agreed, unless things are somehow different on nommu so there aren't such
races.  But, as you mention, this is a long-standing issue that is entirely 
unrelated to the cleanup here and should not delay merging this patch.


Thanks,
Roland
