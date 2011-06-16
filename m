From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 16 Jun 2011 15:07:32 +0000
Subject: Re: [PATCH 5/5] kgdbts: unify/generalize gdb breakpoint adjustment
Message-Id: <201106161707.32356.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1302760895-13459-1-git-send-email-vapier@gentoo.org> <1302760895-13459-6-git-send-email-vapier@gentoo.org> <20110418082900.GB32457@linux-sh.org>
In-Reply-To: <20110418082900.GB32457@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: Mike Frysinger <vapier@gentoo.org>, Roland McGrath <roland@redhat.com>, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, Jason Wessel <jason.wessel@windriver.com>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-sh@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Monday 18 April 2011, Paul Mundt wrote:
> On Thu, Apr 14, 2011 at 02:01:35AM -0400, Mike Frysinger wrote:
> > The Blackfin arch, like the x86 arch, needs to adjust the PC manually
> > after a breakpoint is hit as normally this is handled by the remote gdb.
> > However, rather than starting another arch ifdef mess, create a common
> > GDB_ADJUSTS_BREAK_OFFSET define for any arch to opt-in via their kgdb.h.
> > 
> > Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> 
> Acked-by: Paul Mundt <lethal@linux-sh.org>


This patch is causing build problems now, because the instruction_pointer_set()
that is used now is only defined in asm-generic/ptrace.h, which is only
used on x86, blackfin and sparc. Every other architecture now fails to
build.

	Arnd
