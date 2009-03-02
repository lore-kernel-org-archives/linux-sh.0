From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 02 Mar 2009 02:47:09 +0000
Subject: Re: [PATCH 04/04] sh: prefetch early exception data on sh3/sh4/sh4a
Message-Id: <20090302024709.GB15608@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090223071931.12300.72669.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090223071931.12300.72669.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Mar 02, 2009 at 11:48:15AM +0900, Magnus Damm wrote:
> On Mon, Mar 2, 2009 at 11:30 AM, Paul Mundt <lethal@linux-sh.org> wrote:
> > On Fri, Feb 27, 2009 at 04:53:00PM +0900, Magnus Damm wrote:
> >> On Fri, Feb 27, 2009 at 4:22 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> >> > This does show how often SH-3 gets tested though, as asm/processor_32.h
> >> > happily defines prefetch() for SH-3 when it shouldn't. I'll tidy this up
> >> > and drop in a PREF() macro.
> >>
> >> Right, I do recall building for hp6xx at some point. Thanks for fixing it up.
> >>
> > The fact that that didn't blow up on the opcode is likely because the
> > toolchain you were using had no idea about SH-3 ISA tuning, and so fell
> > back on an anything-goes tuning policy. If you are building for exotic
> > combinations, always do a single run with V=1 to make sure that the
> > CFLAGS are sticking and doing what you think they are doing.
> 
> Hm, what about extending the makefiles to check for SH-3 support?
> Or maybe that's impossible or takes too long time to implement.
> 
I don't think you fully appreciate the sheer amount of work we do in the
kernel Makefiles to work around GCC's stupidity. Give arch/sh/Makefile a
read first.
