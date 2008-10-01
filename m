From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 01 Oct 2008 10:45:56 +0000
Subject: Re: HOTPLUG_CPU is not defined
Message-Id: <20081001104556.GA23048@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <6iabdp61h3.fsf@mars.wyplay.int>
In-Reply-To: <6iabdp61h3.fsf@mars.wyplay.int>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Oct 01, 2008 at 10:27:14AM +0200, Francis Moreau wrote:
> On Tue, Sep 30, 2008 at 8:55 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> > On Tue, Sep 30, 2008 at 08:51:08PM +0200, Francis Moreau wrote:
> >> On Tue, Sep 30, 2008 at 8:24 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> >> > On Tue, Sep 30, 2008 at 06:30:00PM +0200, Francis Moreau wrote:
> >> >> Any reasons why this macro is not defined for SH ?
> >> >>
> >> > Yes, it's not implemented.
> >> >
> >>
> >> Well, it doesn't really matter and it avoids some warnings emitted
> >> by Kconfig because of this in kernel/power/Kconfig:
> >>
> >>
> >> config PM_SLEEP_SMP
> >>         bool
> >>         ....
> >>         select HOTPLUG_CPU
> >>         default y
> >>
> > We don't provide symbols for stuff we don't support. The fact people
> > screw up select usage is nothing new, which is part of the reason it
> > should generally be avoided.
> >
> 
> Still we could define it with a default value to 'n', in that case the symbol
> is not provided for the code and kconfig doesn't generate the warning
> anymore.
> 
Except that 'select' negates that entirely if the symbol is defined,
regardless of whether we give it a value or not.  Presently we don't
define any of the symbols that PM_SLEEP_SMP depends on:

	config PM_SLEEP_SMP
		bool
		depends on SMP
		depends on ARCH_SUSPEND_POSSIBLE || ARCH_HIBERNATION_POSSIBLE
		depends on PM_SLEEP
		select HOTPLUG_CPU

If any of those dependencies change, the select will automatically enable
HOTPLUG_CPU for us if we provide the symbol, regardless of whether it's
just a bool or default n or whatever else.

If you want this warning to go away, either have the select dropped or get the
Kconfig people to fix the dependency tracking. Again, we will not be papering
around this in the architecture code. We do not make a habit of "fixing" things
to make warnings go away when the warnings themselves are bogus. While the
kernel janitors are fond of this sort of mindless work, it is actively harmful
and doesn't help anything in the least.
