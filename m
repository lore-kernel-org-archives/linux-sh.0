From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 02 Sep 2015 09:29:43 +0000
Subject: Re: [PATCH 0/9] sh-pfc: modify PINMUX_IPSR_MSEL() and r8a7795 support
Message-Id: <CAMuHMdXMFp_MEK3ZJjxwyvDuFftqarCWiYkexc17V14x4KOoMA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87wpw9jn3i.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wpw9jn3i.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Wed, Sep 2, 2015 at 9:33 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> These are new version of r8a7795 PFC support.
> This time it includes PINMUX_IPSR_MSEL() modify patch too.
>
> r8a7795 needs 1) 8) 9)
> 2) - 7) are cleanup patches, but not related to r8a7795
>
> This time r8a7795 PFC driver is using many macros.
> I took precedence "readable code" more than "80 character".
> These macro are same as "datasheet" style. So, I believe review is easy.
>
> Kuninori Morimoto (9):
>       1) sh-pfc: modify PINMUX_IPSR_MSEL() macro order
>       2) sh-pfc: pfc-sh7734: use PINMUX_IPSR_MSEL()
>       3) sh-pfc: pfc-r8a7794: use PINMUX_IPSR_MSEL()
>       4) sh-pfc: pfc-r8a7791: use PINMUX_IPSR_MSEL()
>       5) sh-pfc: pfc-r8a7790: use PINMUX_IPSR_MSEL()
>       6) sh-pfc: pfc-r8a7779: use PINMUX_IPSR_MSEL()
>       7) sh-pfc: remove unused PINMUX_IPSR_MODSEL_DATA()
>       8) sh-pfc: Initial R8A7795 PFC support
>       9) sh-pfc: r8a7795: add SCIFx support

Thank you, imported into topic/r8a7795-pfc-v2.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
