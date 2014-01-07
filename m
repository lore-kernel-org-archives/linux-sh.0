From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 07 Jan 2014 16:59:01 +0000
Subject: Re: [PATCH 0/2] clk: shmobile rcar-gen2 fixes
Message-Id: <CAMuHMdUVGAL_h8iezPHZsmfC+77xXE9+irNywk4LYcqAMk9JGg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1389113273-10364-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1389113273-10364-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Jan 7, 2014 at 5:47 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> Geert, could you please verify that the series fixes your QSPI clock issues
> with the Koelsch board ?
>
> Laurent Pinchart (2):
>   clk: shmobile: rcar-gen2: Fix clock parent all non-PLL clocks
>   clk: shmobile: rcar-gen2: Fix qspi divisor

Thanks, both:

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
