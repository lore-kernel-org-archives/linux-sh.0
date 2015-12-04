From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 04 Dec 2015 09:04:26 +0000
Subject: Re: [PATCH v6 0/5] clk: shmobile: Add new CPG/MSSR driver
Message-Id: <CAMuHMdUrsRqLMM70NG3JC-pwk5d1h=b5aBDNCKmUTK61KwGXWQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1447343686-2038-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1447343686-2038-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Magnus Damm <damm+renesas@opensource.se>, Simon Horman <horms+renesas@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-clk <linux-clk@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Nov 12, 2015 at 4:54 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> This series adds a new driver for the Renesas CPG (Clock Pulse
> Generator) and MSSR (Module Standby and Software Reset) blocks for R-Car
> H3 (r8a7795).  This is supposed to be more in-line with current CCF best
> practices, and allows expansion to cover the module reset functionality
> in the future. This drivers follows the DT bindings in
> Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt, which have
> been accepted in clk/clk-next.
> Support for other SoCs may be added later.

Ping?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
