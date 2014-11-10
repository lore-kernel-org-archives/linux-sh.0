From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Nov 2014 09:16:32 +0000
Subject: Re: [PATCH v7 0/2] clk: shmobile: DIV6 clock variable parent support
Message-Id: <CAMuHMdW=TGAySfRgXtVigcO-HuEudEDhnc2BhWuy8b0KJvE4oA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415375468-15378-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1415375468-15378-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, Mike Turquette <mturquette@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>

On Fri, Nov 7, 2014 at 4:51 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
>  .../bindings/clock/renesas,cpg-div6-clocks.txt     |  18 ++--
>  drivers/clk/shmobile/clk-div6.c                    | 113 ++++++++++++++++++---
>  2 files changed, 113 insertions(+), 18 deletions(-)

For the series:
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
