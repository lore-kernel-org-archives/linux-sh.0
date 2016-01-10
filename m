From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 10 Jan 2016 20:05:57 +0000
Subject: Re: [PATCH 2/2] MAINTAINERS: remove linux-sh list from non-arch/sh sections
Message-Id: <CAMuHMdWe9=_ooKRA86+PwP62fRKEbMRgp+12ZfMw4sHaib=0mQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20160108043907.GA7005@brightrain.aerifal.cx>
	<20160108065642.GA1215@verge.net.au>
	<568FF369.9080006@landley.net>
	<7119737.DzNTr3WlaV@avalon>
	<56903D52.3000908@landley.net>
In-Reply-To: <56903D52.3000908@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Landley <rob@landley.net>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Simon Horman <horms@verge.net.au>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, "D. Jeff Dionne" <jeff@uclinux.org>

Hi Rob,

On Fri, Jan 8, 2016 at 11:50 PM, Rob Landley <rob@landley.net> wrote:
> On 01/08/2016 12:28 PM, Laurent Pinchart wrote:
>> On Friday 08 January 2016 11:35:37 Rob Landley wrote:
>>> On 01/08/2016 12:56 AM, Simon Horman wrote:
>>>> On Thu, Jan 07, 2016 at 11:40:54PM -0500, Rich Felker wrote:
>>>>> From: Rich Felker <dalias@libc.org>
>>>>>
>>>>> Recently the bulk of traffic on the linux-sh list has been unrelated
>>>>> to arch/sh but instead focused on Renesas hardware for their ARM-based
>>>>> SoCs. As part of resuming maintenance of arch/sh, remove the linux-sh
>>>>> list from the MAINTAINERS file sections for these other components so
>>>>> that new arch/sh development is not drowned out by unrelated
>>>>> cross-postings.
>>>>
>>>> The use of the linux-sh mailing list has evolved somewhat over time,
>>>> from SH related to ARM related. Its name (obviously) has not evolved.
>>>
>>> According to http://vger.kernel.org/vger-lists.html#linux-sh
>>>
>>>   This is the development discussion and bug reporting mailing list
>>>   for the Linux port to the SuperH architecture.
>>>
>>> By "evolved" you mean "acquired a bunch of off-topic traffic because the
>>> architecture's original owner abandoned it and moved on to other things
>>> that already _have_ lists, but treated this list as their own personal
>>> scratch pad".
>>>
>>> Those people let the architecture this list was created for become
>>> unmaintained for a year and a half.
>>
>> A year and a half since the architecture was officially marked as orphan, at
>> least one more year since the maintainer stopped handling patches.
>
> At and least 5 since Paul Mundt wasn't confused by the concept of people
> trying to use sh without being Renesas customers.
>
>>> DURING that year and a half they posted unrelated content to the list
>>> because they think it belongs to them personally rather than to Linux.
>>
>> I would hardly call upstream Linux R-Mobile and R-Car development "personal
>> stuff". The decision to keep using the linux-sh mailing list comes from the
>> overlap between the SH-based and ARM-based chips. It sure doesn't match the
>> mailing list description anymore, but jumping to the conclusion that the
>> description is the only authoritative source of information is a bit too
>> hasty.
>
> If this is _not_ a superh mailing list, there's still the option to move
> the superh traffic to a dedicated superh mailing list.
>
> I've been doing making the aboriginal linux superh stuff work on
> aboriginal's mailing list for several years. (Alas Dreamhost has a nasty
> habit of deleting mailing list archives. Last christmas they deleted
> about 3 weeks, this christmas they deleted the past 11 months, so that's
> not really my first choice of lists anymore.)
>
> There's been an internal engineering mailing list at se-instruments for
> a few years now. I made an earlier effort to move some of the traffic to
> a mailing list on nommu.org but it kept mostly happening in private
> email (even from people outside the company). I was hoping the kernel
> list would be the logical place for it, but apparently wanting linux-sh
> to be dedicated to linux superh is controversial.
>
> Finding a _different_ list for the traffic and letting this one being
> Renesas' personal scratch pad is, of course, an option. It seems kind of
> silly, but if that's what vger.kernel.org wants...
>
> If this list is the place to discuss things that have nothing to do with
> superh, and the maintainer of superh has no say in changing that, then
> this probably _isn't_ the superh discussion list.
>
>>> Now that the architecture is becoming maintained again (on the hardware
>>> side as well, because the patents have expired and other people are
>>> taking an interest), we would like to reclaim this list to develop the
>>> Linux arch/sh directory.
>>
>> How about asking nicely instead of claiming ? It usually helps.
>
> You're reading "we would like to do X" as "you can't stop us from doing X"?
>
>>> This is a kernel list, not a Renesas list.
>>
>> It has never become a Renesas list. We have private mailing lists for that.
>
> Geert's previous message:
>
>> Indeed, following the evolution of the SoC hardware, cfr. below.
>> It meaning has shifted more to the "Linux Renesas mailing list".

What I mean is that this is still a public mailing list for the Linux kernel
community, to discuss and develop for Renesas SoCs, which are evolutions from
the old SuperH SoCs.

> I personally think "in the absence of a maintainer, this place got
> filled with off-topic traffic" was the abberation, and that a new
> maintainer (who is NOT me) has the right to request it not be so filled.
> But I'm clearly a minority here.

Unfortunately it's not that black and white. The ARM "shmobile" SoCs did
evolve from SH SoCs, and are still related, hardware-wise (the only exception
is EMEV2).

I know it's not a perfect comparison (CPU cores vs. SoCs containing not only
CPU cores, but also support hardware called "IP cores"), but assume the
original x86 Linux mailing list was called "linux-i386". The mailing list
name's would stay unchanged, but Linux gains support for i486, i586, and so on.
Now imagine someone created a free i386 clone, and demanded "all off-topic
amd64 traffic" to be removed...

Also, IMHO the comparison to Apple moving from ppc to x86 doesn't fly well,
as the Apple machines with x86 CPUs are (almost?) PCs, and have, besides the
OS, little resemblance with their PPC ancestors.

> I'm sad that the presentation we gave at Linuxcon Japan (along with the
> original SuperH architect, Kawasaki-san) wasn't recorded, but apparently
> somebody stole all the Linux Foundation's cameras one year so they
> decided to stop recording anything ever. (Tim Bird still records the
> stuff he's involved in, so CELF posts videos, but the Linux Foundation
> doesn't for stuff like Linuxcon...)

At least the slides are available on the net.

> Also, Jeff gave a talk at ELC Europe, but he let himself get talked into
> having it upgraded from normal talk to "keynote", which meant it wasn't
> recorded because they dumped him in the "our sponsors are giving
> infomercials" section. So THAT apparently wasn't recorded either...
>
> https://lceeu2015.sched.org/event/3xSV/keynote-building-the-j-core-cpu-as-open-hardware-disruptive-open-source-principles-applied-to-hardware-and-software-jeff-dionne-smart-energy-instruments

That's a real pity (I've attended it).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
