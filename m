From: Oleg Nesterov <oleg@redhat.com>
Date: Sat, 22 May 2010 14:54:43 +0000
Subject: [PATCH -mm 0/1] (Was: ptrace: unify FDPIC implementations)
Message-Id: <20100522165320.GA19573@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1266280229-18469-1-git-send-email-vapier@gentoo.org> <1274431345-22366-1-git-send-email-vapier@gentoo.org> <20100521162659.GA16193@redhat.com> <20100521183512.4477F40476@magilla.sf.frob.com>
In-Reply-To: <20100521183512.4477F40476@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Frysinger <vapier@gentoo.org>, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, uclinux-dist-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>

On 05/21, Roland McGrath wrote:
>
> > This looks unsafe. What protect child->mm if ptrace() races with SIGKILL ?
> >
> > Of course, I do not blame this patch, the code was copied from arch/, but
> > I think we need another patch which checks ->mm != NULL under task_lock()
> > on top of this one?
>
> Agreed, unless things are somehow different on nommu so there aren't such
> races.

I don't this !CONFG_MMU can make any difference, nothing can protect us
from exit_mm() afaics.

> But, as you mention, this is a long-standing issue that is entirely
> unrelated to the cleanup here and should not delay merging this patch.

Yes, yes, agreed.

Please see the patch on top of ptrace-unify-fdpic-implementations.patch
Untested, but hopefully trivial enough.

Oleg.

