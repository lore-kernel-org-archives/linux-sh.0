From: Rob Landley <rob@landley.net>
Date: Mon, 11 Jan 2016 02:02:24 +0000
Subject: Re: [PATCH 2/2] MAINTAINERS: remove linux-sh list from non-arch/sh sections
Message-Id: <56930D30.4040801@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20160108043907.GA7005@brightrain.aerifal.cx>
 <20160108065642.GA1215@verge.net.au> <568FF369.9080006@landley.net>
 <7119737.DzNTr3WlaV@avalon> <56903D52.3000908@landley.net>
 <CAMuHMdWe9=_ooKRA86+PwP62fRKEbMRgp+12ZfMw4sHaib=0mQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWe9=_ooKRA86+PwP62fRKEbMRgp+12ZfMw4sHaib=0mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Simon Horman <horms@verge.net.au>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, "D. Jeff Dionne" <jeff@uclinux.org>

On 01/10/2016 02:05 PM, Geert Uytterhoeven wrote:
>>>> This is a kernel list, not a Renesas list.
>>>
>>> It has never become a Renesas list. We have private mailing lists for that.
>>
>> Geert's previous message:
>>
>>> Indeed, following the evolution of the SoC hardware, cfr. below.
>>> It meaning has shifted more to the "Linux Renesas mailing list".
> 
> What I mean is that this is still a public mailing list for the Linux kernel
> community, to discuss and develop for Renesas SoCs, which are evolutions from
> the old SuperH SoCs.

There is a lot of unrelated traffic on here which is just noise for the
original purpose of maintaining arch/sh, yes. That's what I"m
complaining about.

The reason I recounted the earlier stuff about other lists is that there
is active traffic in this architecture. The fact Renesas itself isn't
doing doesn't mean that other people haven't been.

I wanted to direct that traffic here, but I'm not going to if there are
multiple dozens of unrelated messages in the amount of time we've been
having this conversation.

Clearly the kernel no longer has a dedicated arch/sh list. I see that as
a problem to be fixed.

>> I personally think "in the absence of a maintainer, this place got
>> filled with off-topic traffic" was the abberation, and that a new
>> maintainer (who is NOT me) has the right to request it not be so filled.
>> But I'm clearly a minority here.
> 
> Unfortunately it's not that black and white. The ARM "shmobile" SoCs did
> evolve from SH SoCs, and are still related, hardware-wise (the only exception
> is EMEV2).

And x86-64 plugged into the Alpha EV6 bus because AMD hired the Alpha
development team away from the corpse of DEC when Compaq bought them.
The only difference between the original x86-64 boards and an Alpha
board was the type of assembly flashed into the boot ROM.

Are you suggesting x86-64 should have done all its development on
linux-alpha? Or that if they did for a year and a half and then Alpha
guys came back and complained, the Alpha guys were the ones who should
move to a new list?

> I know it's not a perfect comparison (CPU cores vs. SoCs containing not only
> CPU cores, but also support hardware called "IP cores"), but assume the
> original x86 Linux mailing list was called "linux-i386".

It was called "comp.os.minix". They got kicked off it for being
off-topic, and founded linux-activists. (Then moved to
linux-kernel@vger.rutgers.edu, then moved to
linux-kernel@vger.kernel.org...)

> The mailing list
> name's would stay unchanged, but Linux gains support for i486, i586, and so on.
> Now imagine someone created a free i386 clone, and demanded "all off-topic
> amd64 traffic" to be removed...

Except amd64 is backwards compatible with x86, muddying the issue.
linux-alpha was the first incompatible port. It has its own list.

> Also, IMHO the comparison to Apple moving from ppc to x86 doesn't fly well,
> as the Apple machines with x86 CPUs are (almost?) PCs, and have, besides the
> OS, little resemblance with their PPC ancestors.

A) And therefore staying on the ppc list would have been appropriate?
(We're arguing _for_ a move. Could you give me an example of "We would
like to continue using this list for its intended and stated original
purpose, but it's being overwhelmed by off-topic traffic" was resolved
in _favor_ of the new topic?)

B) Was the m68k->powerpc switch from the same company similar enough
hardware for... whatever point you're making?

Rob
