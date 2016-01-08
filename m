From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 08 Jan 2016 09:01:25 +0000
Subject: Re: [PATCH 2/2] MAINTAINERS: remove linux-sh list from non-arch/sh sections
Message-Id: <CAMuHMdXkK68wM0D2-auNskSDv2ni6R4GabA90We8PbYXikO9Pw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20160108043907.GA7005@brightrain.aerifal.cx>
	<20160108044054.GA7130@brightrain.aerifal.cx>
	<20160108065642.GA1215@verge.net.au>
In-Reply-To: <20160108065642.GA1215@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Simon Horman <horms@verge.net.au>
Cc: Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, "D. Jeff Dionne" <jeff@uclinux.org>, Rob Landley <rob@landley.net>

First, I'd like to welcome the adoption of the arch/sh/ architecture.

On Fri, Jan 8, 2016 at 7:56 AM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Jan 07, 2016 at 11:40:54PM -0500, Rich Felker wrote:
>> From: Rich Felker <dalias@libc.org>
>>
>> Recently the bulk of traffic on the linux-sh list has been unrelated
>> to arch/sh but instead focused on Renesas hardware for their ARM-based
>> SoCs. As part of resuming maintenance of arch/sh, remove the linux-sh
>> list from the MAINTAINERS file sections for these other components so
>> that new arch/sh development is not drowned out by unrelated
>> cross-postings.
>
> The use of the linux-sh mailing list has evolved somewhat over time,
> from SH related to ARM related. Its name (obviously) has not evolved.

Indeed, following the evolution of the SoC hardware, cfr. below.
It meaning has shifted more to the "Linux Renesas mailing list".

> Dropping linux-sh@vger.kernel.org from portions of the MAINTAINERS file as
> you suggest would essentially leave the Renesas ARM work without a mailing
> list or patchwork instance. Both of which are actively used for that work.
>
> Off-hand I can think of three solutions to this problem:
>
> 1. Live with the noise
> 2. Establish a new list (and possibly patchwork instance) for the SH work.
> 3. Establish a new list and patchwork instance for the ARM work.

Personally, I'd go for option 1.
I would even like to propose H8/300 to join, as they share IP cores, too
(m32r doesn't, AFAIK).

Many old ARM/SH-Mobile SoCs look like SH SoCs with an ARM CPU core bolted o=
n.
Recent Renesas ARM SoCs still share many IP cores with older SH SoCs; most =
of
them even have a secondary SH4 CPU core. Using the SH4 CPU core could be us=
eful
for doing SH4 work, until J4 becomes mainstream (cfr. old prototype in
http://www.spinics.net/lists/linux-sh/msg07188.html).
Probably the Jx series won't share IP cores with SH/ARM, but as arch/sh/
maintainers you have to care about older Renesas SH platforms, too.

For patchwork, that would mean some more delegation needs to be put in plac=
e.

So far my 0.05=E2=82=AC...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
