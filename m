From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 06 Jan 2017 10:53:37 +0000
Subject: Re: [PATCH 16/19] serial: sh-sci: Remove the platform data dma slave rx/tx channel IDs
Message-Id: <CAMuHMdVnLTSnEZ0_953Q-LYmXu5mcQ-qEz=O=wfO7+ifsB4w2w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com> <20170103230639.19660-17-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <20170103230639.19660-17-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>

On Wed, Jan 4, 2017 at 12:06 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> Only SH platforms still use platform data for the sh-sci, and none of
> them declare DMA channels connected to the SCI. Remove the corresponding
> platform data fields and simplify the driver accordingly.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
