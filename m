From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 May 2014 12:30:57 +0000
Subject: Re: [PATCH v5 00/15] Renesas CMT, MTU2 and TMU platform cleanups
Message-Id: <CAMuHMdX+SF0dqp6H1jPzV-NYRe4rfB8Pdu+EdpHca8iK_-b=AA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1398251722-31667-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1398251722-31667-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, May 12, 2014 at 2:11 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Genmai-legacy/reference:
>
> -sh_mtu2 sh_mtu2.0: no of_node; not parsing pinctrl DT
> -sh_mtu2 sh_mtu2.0: used for clock events
> -sh_mtu2 sh_mtu2.0: used for periodic clock events
> +sh_mtu2 sh-mtu2: no of_node; not parsing pinctrl DT
> +sh_mtu2 sh-mtu2: ch0: used for clock events
> +sh_mtu2 sh-mtu2: ch0: used for periodic clock events

Correction: this is only for -legacy, -reference behaves like
-multiplatform+CCF below:

> Genmai-multiplatform+CCF (note: needs addtional patches):
>
> -sh_mtu2 sh_mtu2.0: no of_node; not parsing pinctrl DT
> -sh_mtu2 sh_mtu2.0: used for clock events
> -sh_mtu2 sh_mtu2.0: used for periodic clock events
> +sh_mtu2 sh-mtu2: no of_node; not parsing pinctrl DT
> +sh_mtu2 sh-mtu2: using pinctrl dummy state (default)
> +sh_mtu2 sh-mtu2: using pinctrl dummy state (sleep)
> +sh_mtu2 sh-mtu2: using pinctrl dummy state (idle)
> +sh_mtu2 sh-mtu2: ch0: used for clock events
> +sh_mtu2 sh-mtu2: ch0: used for periodic clock events

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
