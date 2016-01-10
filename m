From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 10 Jan 2016 19:41:47 +0000
Subject: Re: [PATCH 2/2] MAINTAINERS: remove linux-sh list from non-arch/sh sections
Message-Id: <CAMuHMdUxptqWHYfrp+kmfBn3h7eGgHY79gY_HNauJc2EzSMcVQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20160108043907.GA7005@brightrain.aerifal.cx>
	<20160108044054.GA7130@brightrain.aerifal.cx>
	<20160108065642.GA1215@verge.net.au>
	<CAMuHMdXkK68wM0D2-auNskSDv2ni6R4GabA90We8PbYXikO9Pw@mail.gmail.com>
	<20160108182145.GA22240@brightrain.aerifal.cx>
	<CAMuHMdWkwXkFu6Uf-yYr7GiNc7OCvHXYPKGpOE7QhHY56F2rug@mail.gmail.com>
	<20160108205221.GN238@brightrain.aerifal.cx>
In-Reply-To: <20160108205221.GN238@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Rich Felker <dalias@libc.org>
Cc: Simon Horman <horms@verge.net.au>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, "D. Jeff Dionne" <jeff@uclinux.org>, Rob Landley <rob@landley.net>

Hi Rich,

On Fri, Jan 8, 2016 at 9:52 PM, Rich Felker <dalias@libc.org> wrote:
> On Fri, Jan 08, 2016 at 09:35:11PM +0100, Geert Uytterhoeven wrote:
>> On Fri, Jan 8, 2016 at 7:21 PM, Rich Felker <dalias@libc.org> wrote:
>> > On Fri, Jan 08, 2016 at 10:01:25AM +0100, Geert Uytterhoeven wrote:
>> >> Many old ARM/SH-Mobile SoCs look like SH SoCs with an ARM CPU core bo=
lted on.
>> >> Recent Renesas ARM SoCs still share many IP cores with older SH SoCs;=
 most of
>> >> them even have a secondary SH4 CPU core. Using the SH4 CPU core could=
 be useful
>> >> for doing SH4 work, until J4 becomes mainstream (cfr. old prototype in
>> >> http://www.spinics.net/lists/linux-sh/msg07188.html).
>> >> Probably the Jx series won't share IP cores with SH/ARM, but as arch/=
sh/
>> >> maintainers you have to care about older Renesas SH platforms, too.
>> >>
>> >> For patchwork, that would mean some more delegation needs to be put i=
n place.
>> >>
>> >> So far my 0.05=E2=82=AC...
>> >
>> > Is that actually the case? I can't find any current support in the
>> > kernel for running on these SH4 cores, and I was under the impression
>> > that they were being phased out, if not already gone. And the bulk of
>>
>> There's no in-kernel support for these SH4 cores yet, just the prototype.
>
> OK. Are they presently just running (non-Linux) firmware provided with
> the boards? Or not being used at all? Also, is it correct that they're

I don't know whether they're used in products.

> all SH4, not SH5? I know on the gcc side there's interest in removing
> SH5 support, and I'd probably like to do the same in the kernel if
> it's not being used.

The ones on the boards I have are either SH-4A or SH4AL-DSP.

>> Note that you can find "shmobile" SoCs under both arch/sh/
>> (sh7723/sh7724/sh7343/sh7722/sh7366) and arch/arm/mach-shmobile/.
>> Some of these used to share even more code (e.g. drivers/sh/clk/), until=
 the
>> ARM ones were converted to the Common Clock Framework.
>
> Do you know how much is involved in converting the SH ones over to
> Common Clock Framework? That seems to be one obstacle for full DT
> conversion that supports the old boards.

The clock drivers for SH SoCs with module clocks ("MSTP") look very similar
to e.g. the old non-CCF clock driver for (ARM) SH-Mobile AG5 (sh73a0)
(cfr. arch/arm/mach-shmobile/clock-sh73a0.c in v4.2 and earlier).

With DT/CCF, sh73a0 is handled by clk-sh73a0.c, clk-mstp.c, clk-div6.c under
drivers/clk/shmobile/, and by generic "fixed-clock" and "fixed-factor-clock=
".
Only the first one is SoC-specific, the other two drivers should be reusable
for SH. This could be a good starting point to get something working.

However, a few years of experience with CCF has taught us that trying to
describe as many clocks as possible in DT has its disadvantages.
Hence for r8a7795 we started moving all clock definitions into the driver
again, cfr. renesas-cpg-mssr.c (core) and r8a7795-cpg-mssr.c in -next.
While I haven't converted sh73a0 yet, I believe a cpg-mssr based clock driv=
er
can easily be written for SH SoCs that are sufficiently similar to sh73a0,
based on the existing SH clock drivers.

Older SH SoCs have even simpler clock drivers.

Disclaimer: I don't have any "pure" SH boards, nor did any (significant)
development for them.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
