From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 15 Dec 2013 13:09:04 +0000
Subject: Re: [PATCH v5 06/17] ARM: shmobile: lager-reference: Enable multiplaform kernel support
Message-Id: <CAMuHMdUHciKptbXmMyTQ6gXaQs4kUKCRhb=4FXVa6Tg_htM+fQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387034741-3852-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1387034741-3852-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Dec 14, 2013 at 4:25 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> +config ARCH_R8A7790
> +       bool "R-Car H2 (R8A77900)"

Is the trailing "0" intentional?

> +       select RENESAS_IRQC
> +
>  config ARCH_R8A7791
>         bool "R-Car M2 (R8A77910)"

Same here.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
