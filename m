From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 01 Sep 2015 11:36:28 +0000
Subject: Re: [PATCH v5 02/05] clk: shmobile: Add Renesas R-Car Gen3 CPG support
Message-Id: <CAMuHMdWkBPhPJP5WUkDv+1psiZ9iFQv65t9QB5+qq=+Kn7L0mA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150831124842.31057.54534.sendpatchset@little-apple>
	<20150831124904.31057.19757.sendpatchset@little-apple>
	<1692617.kRMz5BT8ct@avalon>
	<CANqRtoSw92UoVBvTJfzGvxmYwefNndqqnj2_8iqi5O=FUeLMGA@mail.gmail.com>
In-Reply-To: <CANqRtoSw92UoVBvTJfzGvxmYwefNndqqnj2_8iqi5O=FUeLMGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-clk <linux-clk@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Gaku Inami <gaku.inami.xw@bp.renesas.com>, Michael Turquette <mturquette@baylibre.com>, SH-Linux <linux-sh@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, "Simon Horman [Horms]" <horms@verge.net.au>

Hi Magnus,

On Tue, Sep 1, 2015 at 12:59 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>> +/*
>>> + *   MD              EXTAL           PLL0    PLL1    PLL2    PLL3    PLL4
>>> + * 14 13 19 17       (MHz)           *1      *1      *1
>>> + *-------------------------------------------------------------------
>>> + * 0  0  0  0        16.66 x 1       x180/2  x192/2  x144/2  x192    x144
>>> + * 0  0  0  1        16.66 x 1       x180/2  x192/2  x144/2  x128    x144
>>> + * 0  0  1  0        Prohibited setting
>>> + * 0  0  1  1        16.66 x 1       x180/2  x192/2  x144/2  x192    x144
>>> + * 0  1  0  0        20    x 1       x150/2  x156/2  x120/2  x156    x120
>>> + * 0  1  0  1        20    x 1       x150/2  x156/2  x120/2  x106    x120
>>> + * 0  1  1  0        Prohibited setting
>>> + * 0  1  1  1        20    x 1       x150/2  x156/2  x120/2  x156    x120
>>> + * 1  0  0  0        25    x 1       x120/2  x128/2  x96/2   x128    x96
>>> + * 1  0  0  1        25    x 1       x120/2  x128/2  x96/2   x84     x96
>>> + * 1  0  1  0        Prohibited setting
>>> + * 1  0  1  1        25    x 1       x120/2  x128/2  x96/2   x128    x96
>>> + * 1  1  0  0        33.33 / 2       x180/2  x192/2  x144/2  x192    x144
>>> + * 1  1  0  1        33.33 / 2       x180/2  x192/2  x144/2  x128    x144
>>> + * 1  1  1  0        Prohibited setting
>>> + * 1  1  1  1        33.33 / 2       x180/2  x192/2  x144/2  x192    x144
>>> + *
>>> + * *1 : datasheet indicates VCO output (PLLx = VCO/2)
>>
>> As explained in a separate e-mail there's a few clocks on R8A7795 that derive
>> directly from PLL1 VCO. I thus wonder whether we shouldn't expose the PLL1
>> clock as the VCO output and create VCO/2 using a fixed factor clock in DT.
>
> Do you think that would reduce complexity or simplify the code? If so
> I think we should do it. Otherwise I think it makes sense to simply
> follow the data sheet.

It would avoid having to apply a multiplier of two to the RPC clock.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
