From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 08 Apr 2011 05:01:19 +0000
Subject: Re: [PATCH/RFC 4/6] ARM: move SH-mobile runtime PM to arm/common for sharing with other platforms
Message-Id: <20110408050117.GA13545@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1302134569-22825-1-git-send-email-khilman@ti.com>
	<20110407165654.GD8052@linux-sh.org> <8739lu9eg6.fsf@ti.com>
	<201104080035.26989.rjw@sisk.pl> <87vcyp37ch.fsf@ti.com>
In-Reply-To: <87vcyp37ch.fsf@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Apr 07, 2011 at 05:38:38PM -0700, Kevin Hilman wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> > On Thursday, April 07, 2011, Kevin Hilman wrote:
> >> Paul Mundt <lethal@linux-sh.org> writes:
> >> > This observation is wholly architecture agnostic, so it's not clear that
> >> > keeping it in arch/arm/common is any better. It seems that this would be
> >> > better suited for drivers/base/power/ with a generic Kconfig symbol.
> >> 
> >> Sounds fine to me.
> >
> > Well, what platforms is the clock framework available on?
> 
> Well, the majority of implementations of <linux/clk.h> are certainly in
> ARM, but I know it's also implemented for SH, and a quick grep shows
> implementations in powerpc, mips and m68k also.
> 
We also have CONFIG_HAVE_CLK that can be used as a dependency. In any
event, anything simply focusing on the clock bits can be completely
generic. On SH we still have these things lumped together with hwblk IDs,
but this is something we can likely transition off of with power domains.
