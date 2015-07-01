From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 01 Jul 2015 07:10:23 +0000
Subject: Re: [RFC 3/3] ARM: shmobile: r8a7790: rework dts to use i2c demuxer
Message-Id: <CAMuHMdXTnY_gg+VWcSxUZWnD6yrL9xxCSoJYQVCh4Dj7Lxr8Qg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1435700651-3543-1-git-send-email-wsa@the-dreams.de>
 <1435700651-3543-4-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1435700651-3543-4-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Jun 30, 2015 at 11:44 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> --- a/arch/arm/boot/dts/r8a7790-lager.dts
> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> @@ -49,6 +49,8 @@
>         aliases {
>                 serial0 = &scifa0;
>                 serial1 = &scifa1;
> +               i2c8 = &i2chdmi;
> +               i2c9 = &gpioi2c;

"i2c<suffix>" or "<prefix>i2c"?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
