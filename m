From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 27 Oct 2014 11:17:11 +0000
Subject: Re: [PATCH] ARM: shmobile: marzen: Fix address and size cells in LVDS encoder node
Message-Id: <CAMuHMdVMb1wc93+FzZo3BJUkPkJG9R1GNhVWUh2x6K0Q27CACg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414402033-7311-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1414402033-7311-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Oct 27, 2014 at 10:27 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> The LVDS encoder DT node #address-cells and #size-cells properties are
> misplaced. Move them to within the ports node.
>
> Reported-by: Simon Horman <horms@verge.net.au>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
