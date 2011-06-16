From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 16 Jun 2011 20:21:53 +0000
Subject: Re: [PATCH 5/5] kgdbts: unify/generalize gdb breakpoint adjustment
Message-Id: <201106162221.53360.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1302760895-13459-1-git-send-email-vapier@gentoo.org> <BANLkTi=iKW+XsfSBoPJmZWZOvq4RKa_Yjg@mail.gmail.com> <BANLkTim5fBUmyH-Vo+6zSgoZdXxu-Mq6OA@mail.gmail.com>
In-Reply-To: <BANLkTim5fBUmyH-Vo+6zSgoZdXxu-Mq6OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Frysinger <vapier@gentoo.org>
Cc: Paul Mundt <lethal@linux-sh.org>, Roland McGrath <roland@redhat.com>, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, Jason Wessel <jason.wessel@windriver.com>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-sh@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Thursday 16 June 2011 22:07:55 Mike Frysinger wrote:
> On Thu, Jun 16, 2011 at 16:06, Mike Frysinger wrote:
> > On Thu, Jun 16, 2011 at 11:07, Arnd Bergmann wrote:
> >> This patch is causing build problems now, because the instruction_pointer_set()
> >> that is used now is only defined in asm-generic/ptrace.h, which is only
> >> used on x86, blackfin and sparc. Every other architecture now fails to
> >> build.
> >
> > a fix was already merged over two weeks ago.  so either your tree is
> > out of date,
> >
> > your tree is out of date.
> 
> blah, network died before i could finish editing this
> 
> your tree is out of date or you're seeing a different issue and need
> to post a full build log

Ok, sorry for the noise. I've only now completed going through the build
errors of ARM randconfig on -rc1 and obviously need to rebase my fixes.

	Arnd
