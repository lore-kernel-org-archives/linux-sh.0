From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 08 Dec 2015 13:50:21 +0000
Subject: Re: [PATCH] pinctrl: sh-pfc: r8a7791: add EtherAVB pin groups
Message-Id: <CAMuHMdXcLa_t06sgkDFpZGR0qhBevsh3BJf_ceEKn9GBRxN_BA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <13219129.kD4pZSmcAP@wasted.cogentembedded.com>
	<1512650.VUqGxiAB2A@wasted.cogentembedded.com>
	<CAMuHMdX5d90NS0btT28yAUD3iNSDdV_GLPOwDMAt9PcTvU4dMA@mail.gmail.com>
	<5666CD4A.8030903@cogentembedded.com>
	<CAMuHMdV_-LYJMrZJG+zP4M2Y7TVHgtdoSqjP=Af-XENWcu7frw@mail.gmail.com>
	<5666DE21.7030909@cogentembedded.com>
In-Reply-To: <5666DE21.7030909@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Linux-sh list <linux-sh@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Tue, Dec 8, 2015 at 2:41 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>> So I guess the daughterboard uses both RX_ER and TX_ER?
>
>    Yes, for the one with Gigabit PHY and no, for the one with 100 Mbit (that
> one doesn't even seem to have RX_ER connected to anything).

Which means the pin could be used for something else, modulo the fact that
it's part of the avb_mii group, and thus configured for avb...

Thanks for checking!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
