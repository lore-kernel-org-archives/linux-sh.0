From: Rich Felker <dalias@libc.org>
Date: Fri, 08 Jan 2016 18:51:37 +0000
Subject: Re: [PATCH 2/2] MAINTAINERS: remove linux-sh list from non-arch/sh sections
Message-Id: <20160108185137.GL238@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20160108043907.GA7005@brightrain.aerifal.cx>
 <20160108044054.GA7130@brightrain.aerifal.cx>
 <20160108065642.GA1215@verge.net.au>
 <568FF369.9080006@landley.net>
In-Reply-To: <568FF369.9080006@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Landley <rob@landley.net>
Cc: Simon Horman <horms@verge.net.au>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, "D. Jeff Dionne" <jeff@uClinux.org>

On Fri, Jan 08, 2016 at 11:35:37AM -0600, Rob Landley wrote:
> On 01/08/2016 12:56 AM, Simon Horman wrote:
> > On Thu, Jan 07, 2016 at 11:40:54PM -0500, Rich Felker wrote:
> >> From: Rich Felker <dalias@libc.org>
> >>
> >> Recently the bulk of traffic on the linux-sh list has been unrelated
> >> to arch/sh but instead focused on Renesas hardware for their ARM-based
> >> SoCs. As part of resuming maintenance of arch/sh, remove the linux-sh
> >> list from the MAINTAINERS file sections for these other components so
> >> that new arch/sh development is not drowned out by unrelated
> >> cross-postings.
> > 
> > The use of the linux-sh mailing list has evolved somewhat over time,
> > from SH related to ARM related. Its name (obviously) has not evolved.
> 
> According to http://vger.kernel.org/vger-lists.html#linux-sh
> 
>   This is the development discussion and bug reporting mailing list
>   for the Linux port to the SuperH architecture.
> 
> By "evolved" you mean "acquired a bunch of off-topic traffic because the
> architecture's original owner abandoned it and moved on to other things
> that already _have_ lists, but treated this list as their own personal
> scratch pad".
> 
> Those people let the architecture this list was created for become
> unmaintained for a year and a half. DURING that year and a half they
> posted unrelated content to the list because they think it belongs to
> them personally rather than to Linux.
> 
> Now that the architecture is becoming maintained again (on the hardware
> side as well, because the patents have expired and other people are
> taking an interest), we would like to reclaim this list to develop the
> Linux arch/sh directory.
> 
> This is a kernel list, not a Renesas list.
> 
> > Dropping linux-sh@vger.kernel.org from portions of the MAINTAINERS file as
> > you suggest would essentially leave the Renesas ARM work without a mailing
> > list or patchwork instance.
> 
> Here's a half-dozen arm lists already:
> 
>   http://www.arm.linux.org.uk/mailinglists/lists.php
> 
> And that's not even a complete list of them all:
> 
>   http://vger.kernel.org/vger-lists.html#linux-tegra
> 
> > Both of which are actively used for that work.
> 
> Off-topic traffic exists, therefore it should exist? Its volume is its
> justification? Why do we have spam filters then?
> 
> > Off-hand I can think of three solutions to this problem:
> > 
> > 1. Live with the noise
> > 2. Establish a new list (and possibly patchwork instance) for the SH work.
> 
> So... squatter's rights?
> 
> Renesas calling its new arm stuff "shmobile" is as relevant as Intel
> designating itanic "ia64" as the successor to "ia32". The superh
> architecture's only been officially unmaintained for a year and change
> (presumably because the patents were expiring so they saw no more profit
> in it for themselves).
> 
> Meanwhile there was active superh-compatible work off-list during that
> time (the j-core stuff) that's just now coming to fruition, building off
> 20 years of history and a decade and change of previous Linux development.

I'm not here to place blame or argue over who's "fault" it is that
this happened, but it is inappropriate for a kernel arch list to be
used as a development list for hardware that's no longer related to
the arch and just happens to be produced/used by the same company.
Another decent analogy might be if the linuxppc list had been deluged
with driver traffic for Apple-specific x86 hardware after Apple
dropped PPC and switched to x86. As far as I know, no such thing
happened, but I don't think it would have gone over well.

> [...]
> We aren't proposing to rename the arch/sh directory to "jcore", so
> "linux-sh@vger.kernel.org" remains the logical name for this list. The
> new stuff is intentionally backwards compatible with the old stuff, and
> we are happy to maintain compatibility with the old stuff, and have
> current plans to move it to device tree. (We just need a lot more legacy
> test hardware...)

Indeed. SH is a nice arch with a very long history on Linux, and I'm
happy to be carrying forward its legacy. I believe doing this within
the framework that's already there (and thereby preserving and
improving support for the legacy hardware), rather than starting over
as if it were a new arch, is the right way to go, having the list
overrun with mostly-unrelated traffic is an unfortunate situation to
be in, and one that I'd like to see corrected.

Rich
