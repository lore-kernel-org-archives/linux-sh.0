From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 08 Jan 2016 20:35:11 +0000
Subject: Re: [PATCH 2/2] MAINTAINERS: remove linux-sh list from non-arch/sh sections
Message-Id: <CAMuHMdWkwXkFu6Uf-yYr7GiNc7OCvHXYPKGpOE7QhHY56F2rug@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20160108043907.GA7005@brightrain.aerifal.cx>
	<20160108044054.GA7130@brightrain.aerifal.cx>
	<20160108065642.GA1215@verge.net.au>
	<CAMuHMdXkK68wM0D2-auNskSDv2ni6R4GabA90We8PbYXikO9Pw@mail.gmail.com>
	<20160108182145.GA22240@brightrain.aerifal.cx>
In-Reply-To: <20160108182145.GA22240@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Rich Felker <dalias@libc.org>
Cc: Simon Horman <horms@verge.net.au>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, "D. Jeff Dionne" <jeff@uclinux.org>, Rob Landley <rob@landley.net>

Hi Rich,

On Fri, Jan 8, 2016 at 7:21 PM, Rich Felker <dalias@libc.org> wrote:
> On Fri, Jan 08, 2016 at 10:01:25AM +0100, Geert Uytterhoeven wrote:
>> Many old ARM/SH-Mobile SoCs look like SH SoCs with an ARM CPU core bolte=
d on.
>> Recent Renesas ARM SoCs still share many IP cores with older SH SoCs; mo=
st of
>> them even have a secondary SH4 CPU core. Using the SH4 CPU core could be=
 useful
>> for doing SH4 work, until J4 becomes mainstream (cfr. old prototype in
>> http://www.spinics.net/lists/linux-sh/msg07188.html).
>> Probably the Jx series won't share IP cores with SH/ARM, but as arch/sh/
>> maintainers you have to care about older Renesas SH platforms, too.
>>
>> For patchwork, that would mean some more delegation needs to be put in p=
lace.
>>
>> So far my 0.05=E2=82=AC...
>
> Is that actually the case? I can't find any current support in the
> kernel for running on these SH4 cores, and I was under the impression
> that they were being phased out, if not already gone. And the bulk of

There's no in-kernel support for these SH4 cores yet, just the prototype.

> the driver-related discussion I've seen on linux-sh over the past year
> does not seem to be related to hardware that's present/usable on
> boards where you can run Linux/SH. If this is incorrect, I'd like to
> hear some views on how/why such hardware is relevant to arch/sh.

At least the following drivers are shared between ARM and SH:

hspi
rspi
sh-cmt
sh_fsi
sh-mtu2
sh-sci (covering sci, scif, scifa, scifb, hscif)
sh-tmu
tpu

and of course the sh-pfc pinctrl subsystem.

Probably I'm forgetting a few that haven't been converted to DT on ARM yet,
and where the ARM side thus could benefit from a DT conversion on SH.

Note that you can find "shmobile" SoCs under both arch/sh/
(sh7723/sh7724/sh7343/sh7722/sh7366) and arch/arm/mach-shmobile/.
Some of these used to share even more code (e.g. drivers/sh/clk/), until the
ARM ones were converted to the Common Clock Framework.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
