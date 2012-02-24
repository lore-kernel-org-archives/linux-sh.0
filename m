From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 24 Feb 2012 05:36:47 +0000
Subject: Re: Single-stepping with UBC on SH7785
Message-Id: <20120224053646.GA23937@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87sjidcrrn.fsf@schwinge.name>
In-Reply-To: <87sjidcrrn.fsf@schwinge.name>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Feb 14, 2012 at 05:18:52PM +0100, Thomas Schwinge wrote:
> After learning from the SH7785 manual how to use and program the UBC, it
> seemed obvious to me that what it implemented nowadays in
> arch/sh/kernel/cpu/sh4a/ubc.c for programming the UBC does not match how
> it used to be
> 
That would be because we're using it differently. It was originally
reworked in order to permit use of multiple UBC channels, and geared at
the ksym tracer (subsequently superseded by generic perf hw_breakpoint
API utilization). The intent was the model the same single-step behaviour
as previously over top of the new API, but there are some caveats (ie,
perf can have all of the available channels locked down, making
set_single_step() fail).

> After several hours of grief, I came up with the additional
> 0001-Wire-the-clock-of-the-SH7785-s-UBC-as-expected-in-ub.patch -- and it
> worked!  (Meh, so simple...)
> 
Sorry about that, I prototyped on 7786 and should have more diligently
grepped for other UBC clock definitions!

> ... and today I figured out that my first patch isn't even needed -- but
> I don't understand how the current ubc.c implementation gets away with
> not using the asid stuff, for example?  And shouldn't it respect the
> reserved value UBC_CRR_RES as well as UBC_CRR_INIT and UBC_CBR_INIT that
> I re-introduced?  Also the manual suggests a different order for
> programming the registers.
> 
The reserved bit is functionally immaterial. It's always wired to 1, so
it makes no difference what is read/written to it. We can add a 1 write
to it to line up with the manual if you like, but in general the UBC
chapter has been cut-and-pasted from legacy parts for years, to the
extent that the manual should really only be considered a loose guideline
(for some CPUs the register map is nowhere near where the manual
suggests, for example). Your CRR_INIT value is just setting CRR_RES
anyways.

The CBR_INIT value relates to matching conditions for the given channel,
and their values need to be derived from the channel being used rather
than a fixed constant. You are correct that there is a bug here though,
in that the CBR write forces a CCMFR.MF0 match, while we need to set the
CBR.MFI relative to the channel index (you can tell this was only really
tested one channel at a time!). This probably would have been caught
earlier if we had set CBR.MFE, but we don't really need it for anything.

> As soon as someone starts working on adding user-space controlled
> hardware breakpoint and/or watchpoint support, this will need further
> untangling/cleanup.
> 
Now that the kernel uses the UBC alongside userspace it's quite possible
that we'll have to adjust some of the settings, and I'm certainly
interested in hearing about any troubles you encounter. I tested the
single-step stuff with the utrace testsuite if I recall correctly, and it
seemed to work alright (even with the ksym tracer tying down another
channel for watchpoint use at the time).

I left the ASID stuff out initially to keep things simple (SH-X3 cores
and later all have extended ASIDs, so we have an extra set of CBR
registers to program for extended ASID matching -- this applies to
anything with PTEAEX capabilities). We obviously don't require it on the
kernel side, but you're right that we should add it back in for the
userspace case. If you want to hack up some patches for that I'll
certainly use them, otherwise I'll see about hacking something up for you
to test.

It wasn't entirely obvious from your mail, but is the general conclusion
from all this that with the clock properly registered for SH7785 that
single-stepping works as you expected it to?
