From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 30 Sep 2008 18:55:50 +0000
Subject: Re: HOTPLUG_CPU is not defined
Message-Id: <20080930185550.GA15229@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <6iabdp61h3.fsf@mars.wyplay.int>
In-Reply-To: <6iabdp61h3.fsf@mars.wyplay.int>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Sep 30, 2008 at 08:51:08PM +0200, Francis Moreau wrote:
> On Tue, Sep 30, 2008 at 8:24 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> > On Tue, Sep 30, 2008 at 06:30:00PM +0200, Francis Moreau wrote:
> >> Any reasons why this macro is not defined for SH ?
> >>
> > Yes, it's not implemented.
> >
> 
> Well, it doesn't really matter and it avoids some warnings emitted
> by Kconfig because of this in kernel/power/Kconfig:
> 
> 
> config PM_SLEEP_SMP
>         bool
>         ....
>         select HOTPLUG_CPU
>         default y
> 
We don't provide symbols for stuff we don't support. The fact people
screw up select usage is nothing new, which is part of the reason it
should generally be avoided.

Your options are either to fix the PM_SLEEP_SMP Kconfig behaviour, or
ignore the warning. We're not going to paper around it in the
architecture side at least.
