From: Rob Landley <rob@landley.net>
Date: Wed, 06 Jan 2016 15:42:35 +0000
Subject: Re: [PATCH v2 31/32] sh: support a 2-byte smp_store_mb
Message-Id: <568D35EB.7090108@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-32-git-send-email-mst@redhat.com>
 <20160105232735.GC238@brightrain.aerifal.cx>
 <20160106131321-mutt-send-email-mst@redhat.com>
 <20160106114023.GU6344@twins.programming.kicks-ass.net>
 <20160106134301-mutt-send-email-mst@redhat.com>
 <20160106143218.GV6344@twins.programming.kicks-ass.net>
In-Reply-To: <20160106143218.GV6344@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Rich Felker <dalias@libc.org>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Jeff Dionne <jeff@uclinux.org>, Yoshinori Sato <ysato@users.sourceforge.jp>



On 01/06/2016 08:32 AM, Peter Zijlstra wrote:
> On Wed, Jan 06, 2016 at 01:52:17PM +0200, Michael S. Tsirkin wrote:
> SH's cmpxchg() is equally incomplete and does not provide 1 and 2 byte
> versions.

We added a new cmpxchg() in j-core (smp on sh2 was not previously a
thing), but still need to support the old ones.

> In any case, I'm all for rm -rf arch/sh/, one less arch to worry about
> is always good, but ISTR some people wanting to resurrect SH:
> 
>   http://old.lwn.net/Articles/647636/

I note that old architectures in general become interesting again as
their patents expire and they're available for reimplementation as open
hardware. This tends to be about when the original manufacturer loses
interest, and thus people try to delete existing (working) project
support before the clones can get up to speed.

(I would have thought the presence of working QEMU support would tide us
over providing an easy basic regression testing environment, but people
keep insisting that's not real and doesn't count. But if we can keep it
99% working until the sh4 patents expire later this year, we can add mmu
and have full sh4 in hardware again with BSD VHDL.)

> Rob, Jeff, Sato-san, might I suggest you send a MAINTAINERS patch and
> take up an active interest in SH lest someone 'accidentally' nukes it?

We have an active interest, we just didn't think anybody would want a
MAINTAINERS patch until we had skin in the game, and as you saw from our
previous patch the kernel code wasn't remotely acceptable upstream yet.
(Rich has been redoing it as device tree.)

We've been talking about this offline. (The superh list is cc'd on a
bunch of Renesas arm drivers because Renesas, so it has a high noise to
signal ratio.)

Sato-san agreed to co-maintain but needs somebody else to take point. (I
similarly want to assist but don't have the expertise to be the main
guy.) That leaves Rich, who is ok with doing it but was trying to finish
the device tree port of the jcore board first.

That said, if you'd ack a submission, Rich already has my Acked-by line
on a maintainers patch (AND one to remove the extra cc's from the sh
kernel list, and I acked Chen Gang's syscall addition patch back in
https://lkml.org/lkml/2015/6/20/193 but nobody noticed...)

Rich? Maintain please.

Rob
