From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 07 Jul 2015 09:22:16 +0000
Subject: Re: [PATCH 2/5] i2c: emev2: add binding documentation
Message-Id: <CAMuHMdW5xKOk_pMBOegjzr5TFa-YGwwmKHTEVm5BsMwp_P0ZXw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1436219188-4325-1-git-send-email-wsa@the-dreams.de>
	<1436219188-4325-3-git-send-email-wsa@the-dreams.de>
	<CAMuHMdU1iEn+38FY2ncDL_L_k2ytJFWH+Ek=kF42pC4pdsuAzQ@mail.gmail.com>
	<20150707091758.GF1532@katana>
In-Reply-To: <20150707091758.GF1532@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Wolfram,

On Tue, Jul 7, 2015 at 11:17 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> > +               interrupts = <0 32 IRQ_TYPE_EDGE_RISING>;
>>
>> Are you sure about rising edge? All other emev2 interrupts are
>> IRQ_TYPE_LEVEL_HIGH.
>
> Yes. R19UH00356EJ0800_1chip.pdf, chapter 7.1.1
>
> 64
>  IIC0
>  IIC0_INT
>  IIC #0 interrupt
>  Edge
> 65
>  IIC1
>  IIC1_INT
>  IIC #1 interrupt
>  Edge

OK, verified using R19UH0036EJ1600_1chip.pdf (which is newer, Google is
your friend).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
