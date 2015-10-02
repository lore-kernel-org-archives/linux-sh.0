From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 02 Oct 2015 08:13:02 +0000
Subject: Re: [PATCH v10 04/07] arm64: renesas: r8a7795 dtsi: Add all SCIF nodes
Message-Id: <CAMuHMdXcUZKMd3rC1nbcyjgxqYabmP3aU7Bb-p=OxskZ+a7ggw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20151002025551.28158.20307.sendpatchset@little-apple>
In-Reply-To: <20151002025551.28158.20307.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Fri, Oct 2, 2015 at 10:08 AM, Simon Horman <horms@verge.net.au> wrote:
> On Fri, Oct 02, 2015 at 09:11:50AM +0200, Geert Uytterhoeven wrote:
>> On Fri, Oct 2, 2015 at 4:55 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> > --- 0012/include/dt-bindings/clock/r8a7795-clock.h
>> > +++ work/include/dt-bindings/clock/r8a7795-clock.h      2015-10-01 19:24:51.200513000 +0900
>> > @@ -22,8 +22,14 @@
>> >  /* MSTP1 */
>> >
>> >  /* MSTP2 */
>> > +#define R8A7795_CLK_SCIF5              202
>> > +#define R8A7795_CLK_SCIF4              203
>> > +#define R8A7795_CLK_SCIF3              204
>> > +#define R8A7795_CLK_SCIF1              206
>> > +#define R8A7795_CLK_SCIF0              207
>> >
>> >  /* MSTP3 */
>> > +#define R8A7795_CLK_SCIF2              210
>>
>> 310
>
> Thanks, I will fix that.
>
> I plan to wait a little to accumulate more changes.
> But if for some reason you need this in a hurry I can
> push an updated topic branch ASAP.

Given how close we are to leaving for ELCE, I think we can live with it.

The correct clock will have been enabled by the boot loader anyway.
MSTP210 is MSIOF1, so no animals will be hurt by accidentally touching that
clock.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
