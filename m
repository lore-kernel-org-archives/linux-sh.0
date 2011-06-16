From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 16 Jun 2011 20:06:09 +0000
Subject: Re: [PATCH 5/5] kgdbts: unify/generalize gdb breakpoint adjustment
Message-Id: <BANLkTi=iKW+XsfSBoPJmZWZOvq4RKa_Yjg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1302760895-13459-1-git-send-email-vapier@gentoo.org>
 <1302760895-13459-6-git-send-email-vapier@gentoo.org> <20110418082900.GB32457@linux-sh.org>
 <201106161707.32356.arnd@arndb.de>
In-Reply-To: <201106161707.32356.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Mundt <lethal@linux-sh.org>, Roland McGrath <roland@redhat.com>, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, Jason Wessel <jason.wessel@windriver.com>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-sh@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Thu, Jun 16, 2011 at 11:07, Arnd Bergmann wrote:
> This patch is causing build problems now, because the instruction_pointer_set()
> that is used now is only defined in asm-generic/ptrace.h, which is only
> used on x86, blackfin and sparc. Every other architecture now fails to
> build.

a fix was already merged over two weeks ago.  so either your tree is
out of date,

your tree is out of date.

you also need a little qualification there ... every arch *which
supports kgdb and enables it* now fails to build.
-mike
