From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 23 Jul 2018 08:17:36 +0000
Subject: Re: [PATCH v2] serial: sh-sci: byte allocated register support
Message-Id: <CAMuHMdWEcRWga=Xp8zXt_GQwypreZh0rAthpX9=EuAm+0OeFLg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20180721143436.43675-1-ysato@users.sourceforge.jp>
In-Reply-To: <20180721143436.43675-1-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

CC gregkh, linux-serial

On Sun, Jul 22, 2018 at 3:02 PM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
>
> H8/300 SCI registers allocated byte address.
> It must support to the case where shift count is 0.
>
> Changes v2.
> more simply code.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -2863,10 +2863,12 @@ static int sci_init_single(struct platform_device *dev,
>         port->fifosize          = sci_port->params->fifosize;
>
>         if (port->type = PORT_SCI) {
> -               if (sci_port->reg_size >= 0x20)
> -                       port->regshift = 2;
> -               else
> -                       port->regshift = 1;
> +               /*
> +                * reg_size < 0x10: BYTE aligned (scale factor=1).
> +                * reg_size >= 0x10 and < 0x20: WORD aligned (scale factor=2).
> +                * reg_size >= 0x20: DWORD aligned (scale factor=4).
> +                */
> +               port->regshift = sci_port->reg_size >> 4;
>         }
>
>         /*

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
