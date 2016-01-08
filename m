From: Rob Landley <rob@landley.net>
Date: Fri, 08 Jan 2016 22:50:58 +0000
Subject: Re: [PATCH 2/2] MAINTAINERS: remove linux-sh list from non-arch/sh sections
Message-Id: <56903D52.3000908@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20160108043907.GA7005@brightrain.aerifal.cx>
 <20160108065642.GA1215@verge.net.au> <568FF369.9080006@landley.net>
 <7119737.DzNTr3WlaV@avalon>
In-Reply-To: <7119737.DzNTr3WlaV@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Simon Horman <horms@verge.net.au>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, "D. Jeff Dionne" <jeff@uclinux.org>



On 01/08/2016 12:28 PM, Laurent Pinchart wrote:
> Hi Rob,
> 
> On Friday 08 January 2016 11:35:37 Rob Landley wrote:
>> On 01/08/2016 12:56 AM, Simon Horman wrote:
>>> On Thu, Jan 07, 2016 at 11:40:54PM -0500, Rich Felker wrote:
>>>> From: Rich Felker <dalias@libc.org>
>>>>
>>>> Recently the bulk of traffic on the linux-sh list has been unrelated
>>>> to arch/sh but instead focused on Renesas hardware for their ARM-based
>>>> SoCs. As part of resuming maintenance of arch/sh, remove the linux-sh
>>>> list from the MAINTAINERS file sections for these other components so
>>>> that new arch/sh development is not drowned out by unrelated
>>>> cross-postings.
>>>
>>> The use of the linux-sh mailing list has evolved somewhat over time,
>>> from SH related to ARM related. Its name (obviously) has not evolved.
>>
>> According to http://vger.kernel.org/vger-lists.html#linux-sh
>>
>>   This is the development discussion and bug reporting mailing list
>>   for the Linux port to the SuperH architecture.
>>
>> By "evolved" you mean "acquired a bunch of off-topic traffic because the
>> architecture's original owner abandoned it and moved on to other things
>> that already _have_ lists, but treated this list as their own personal
>> scratch pad".
>>
>> Those people let the architecture this list was created for become
>> unmaintained for a year and a half.
> 
> A year and a half since the architecture was officially marked as orphan, at 
> least one more year since the maintainer stopped handling patches.

At and least 5 since Paul Mundt wasn't confused by the concept of people
trying to use sh without being Renesas customers.

>> DURING that year and a half they posted unrelated content to the list
>> because they think it belongs to them personally rather than to Linux.
> 
> I would hardly call upstream Linux R-Mobile and R-Car development "personal 
> stuff". The decision to keep using the linux-sh mailing list comes from the 
> overlap between the SH-based and ARM-based chips. It sure doesn't match the 
> mailing list description anymore, but jumping to the conclusion that the 
> description is the only authoritative source of information is a bit too 
> hasty.

If this is _not_ a superh mailing list, there's still the option to move
the superh traffic to a dedicated superh mailing list.

I've been doing making the aboriginal linux superh stuff work on
aboriginal's mailing list for several years. (Alas Dreamhost has a nasty
habit of deleting mailing list archives. Last christmas they deleted
about 3 weeks, this christmas they deleted the past 11 months, so that's
not really my first choice of lists anymore.)

There's been an internal engineering mailing list at se-instruments for
a few years now. I made an earlier effort to move some of the traffic to
a mailing list on nommu.org but it kept mostly happening in private
email (even from people outside the company). I was hoping the kernel
list would be the logical place for it, but apparently wanting linux-sh
to be dedicated to linux superh is controversial.

Finding a _different_ list for the traffic and letting this one being
Renesas' personal scratch pad is, of course, an option. It seems kind of
silly, but if that's what vger.kernel.org wants...

If this list is the place to discuss things that have nothing to do with
superh, and the maintainer of superh has no say in changing that, then
this probably _isn't_ the superh discussion list.

>> Now that the architecture is becoming maintained again (on the hardware
>> side as well, because the patents have expired and other people are
>> taking an interest), we would like to reclaim this list to develop the
>> Linux arch/sh directory.
> 
> How about asking nicely instead of claiming ? It usually helps.

You're reading "we would like to do X" as "you can't stop us from doing X"?

>> This is a kernel list, not a Renesas list.
> 
> It has never become a Renesas list. We have private mailing lists for that.

Geert's previous message:

> Indeed, following the evolution of the SoC hardware, cfr. below.
> It meaning has shifted more to the "Linux Renesas mailing list".

I personally think "in the absence of a maintainer, this place got
filled with off-topic traffic" was the abberation, and that a new
maintainer (who is NOT me) has the right to request it not be so filled.
But I'm clearly a minority here.

>>> 3. Establish a new list and patchwork instance for the ARM work.
>>
>> Now that people are interested in superh again, the correct answer
>> seemed to be #3, which is what we were suggesting.
> 
> Now I like the suggesting better than the claiming :-)

You seem to consider this a change in tone. I don't understand why.

>> A similar situation occurred when buildroot didn't have its own mailing
>> list for several years and used the uClibc list: uClibc development
>> suffered greatly. I eventually got sick of it and created a new
>> buildroot list and politely kicked the traffic off, which is why the
>> first message in the buildroot mailing list archive is:
>>
>>   http://lists.busybox.net/pipermail/buildroot/2006-July/012219.html
>>
>> The corresponding "please move the buildroot traffic off the uClibc
>> list" thread started at:
>>
>>   http://lists.busybox.net/pipermail/uclibc/2006-July/036836.html
>>
>> The current list is not a Renesas list, it is a Linux list for the
>> SuperH architecture port. Says so on the tin, and that was its history
>> until pretty recently. Renesas moving away from the SuperH architecture
>> doesn't change that this is the Linux arch/sh list.
>>
>> We aren't proposing to rename the arch/sh directory to "jcore", so
>> "linux-sh@vger.kernel.org" remains the logical name for this list. The
>> new stuff is intentionally backwards compatible with the old stuff,
> 
> How about IP cores around the CPU, do you plan to develop cores compatible 
> with the Renesas implementations, or go for something else ?

Not that I know of, but the people to ask are either Jeff Dionne or
Geoff Salmon (or Martin, or Niishi-san, or... As I said, I'm trying to
migrate that discussion _off_ of various private email channels and get
it onto open lists where it's archived. I'm also bothering people to
WRITE DOWN the roadmap. Right now it's in Jeff's head...)

That said, it's an open source project, anybody can implement what they
want. The full VHDL history would already be on github if we weren't
understaffed. (There's a tarball of the VHDL up from something like
June, but converting the history from mercurial in several different
repos to one git repository with a sane unified history is not something
there's an existing tool for; I got very far along doing it by hand
before realizing that "hg export" without telling it "--git" doesn't
export any file it thinks of as "binary", such as the openoffice
spreadsheet containing the instruction definitions, which is a kinda
important input into the build process. Wound up having to start over
and my todo list runneth over. If you'd like a giant pile of "hg export"
patches that don't connect up with each other, feel free to email me...)

> If we end up 
> sharing the same peripherals between multiple architectures we will need to 
> decide on how to coordinate the work.

I'm pretty sure we can stick arbitrary stuff into it, but right now
they're redoing the design of some I/O engine as a prerequisite for
adding USB2 (the FPGA isn't clocked fast enough for USB3, I think?) and
that was never in the old renesas stuff that I know of...

Actually, I think Russell Lait is probably the guy you want to talk
about for roadmap stuff because he's the guy trying to put together the
series of kickstarter campaigns for various open hardware stuff.
(They're currently designing a raspberry-pi compatible LX45 board,
because the Numato LX9 boards don't have enough gates to do the SMP and
DSP stuff we want to release. And as long as they're doing raspberry pi
they want to do all the peripherals THAT has, which is where USB and
hdmi and so on come into it. Again, I'm a software guy, barely started
to learn VHDL yet...)

Anyway, getting all this traffic onto public list was kind of what I was
hoping to do. (Not necessarily all on this one, but at least getting
kernel stuff upstream is good...)

>> and we are happy to maintain compatibility with the old stuff, and have
>> current plans to move it to device tree. (We just need a lot more legacy
>> test hardware...)
> 
> I personally don't think that's worth it given that most of the legacy 
> hardware is buried under a thick layer of dust (when not used as coasters or 
> door stoppers).

I am regression testing sh4 in qemu, but people keep objecting that qemu
is not "real".

I'm all for ignoring sh3 since it only shipped for about a year before
being replaced by sh4, but it's not really my call. There's continuing
interest in nommu (thus sh2) going forward because A) hard realtime
constraints in products we're shipping so eliminating page fault latency
actually helps, B) Jeff Dionne founded uclinux before wandering back
into hardware (and moving to Japan) in 2003, and now that he's
resurfaced into the Linux world and noticed that uclinux died in his
absence, he wants to fix that. (Which means the new nommu.org website
needs to grow cortex-m support and we should dig up coldfire and h8300
shoudl go there...)

It would be nice if there was a nommu@vger.kernel.org list, but that
should not be THIS list.

(Then there's more current sh4a stuff that won't have its patents expire
for a while yet, so is uninteresting to jcore for the forseeable future...)

I'm sad that the presentation we gave at Linuxcon Japan (along with the
original SuperH architect, Kawasaki-san) wasn't recorded, but apparently
somebody stole all the Linux Foundation's cameras one year so they
decided to stop recording anything ever. (Tim Bird still records the
stuff he's involved in, so CELF posts videos, but the Linux Foundation
doesn't for stuff like Linuxcon...)

Rob

Also, Jeff gave a talk at ELC Europe, but he let himself get talked into
having it upgraded from normal talk to "keynote", which meant it wasn't
recorded because they dumped him in the "our sponsors are giving
infomercials" section. So THAT apparently wasn't recorded either...

https://lceeu2015.sched.org/event/3xSV/keynote-building-the-j-core-cpu-as-open-hardware-disruptive-open-source-principles-applied-to-hardware-and-software-jeff-dionne-smart-energy-instruments

Really, we keep answering the same questions, the results just don't get
collected in one place. Clearly, this isn't that place either...
