From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 28 May 2014 08:26:38 +0000
Subject: Re: [PATCH 00/11] i2c: rcar: cleanup series
Message-Id: <CAMuHMdUq5YxL+JfSuAzPtd4bHkPJXACqMAG+Fc0AFv7TkUDHDg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1401263086-13720-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1401263086-13720-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>

Hi Wolfram,

On Wed, May 28, 2014 at 9:44 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> Wolfram Sang (11):
>   i2c: rcar: not everything needs to be a function
>   i2c: rcar: no need to store irq number
>   i2c: rcar: refactor bus state machine
>   i2c: rcar: refactor irq state machine
>   i2c: rcar: check bus free before first message
>   i2c: rcar: refactor setting up msg
>   i2c: rcar: refactor status bit handling
>   i2c: rcar: remove spinlock
>   i2c: rcar: reuse status bits as enable bits
>   i2c: rcar: janitorial cleanup after refactoring
>   i2c: rcar: update copyright and license information

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
