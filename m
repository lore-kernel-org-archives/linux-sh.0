From: Michael Turquette <mturquette@baylibre.com>
Date: Tue, 22 Dec 2015 19:41:06 +0000
Subject: Re: [git pull] clk: shmobile: Updates for v4.5
Message-Id: <20151222194106.GA18143@quark.deferred.io>
List-Id: <linux-sh.vger.kernel.org>
References: <1449652390-10349-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1449652390-10349-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-clk@vger.kernel.org, linux-sh@vger.kernel.org

On 12/09, Geert Uytterhoeven wrote:
> 	Hi Mike, Stephen,
> 
> The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:
> 
>   Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git clk-shmobile-for-v4.5
> 
> for you to fetch changes up to c5dae0df298120e0a331d749d77fd472c253b5b3:
> 
>   clk: shmobile: r8a7795: Add new CPG/MSSR driver (2015-12-08 14:33:06 +0100)

Pulled.

Thanks,
Mike

> 
> Summary:
>   - Make clock-output-names optional for single-output clocks,
>   - New Renesas CPG/MSSR driver for r8a7795,
>   - Cleanups to prepare for the above.
> 
> Thanks for pulling!
> 
> ----------------------------------------------------------------
> Geert Uytterhoeven (4):
>       clk: shmobile: div6: Make clock-output-names optional
>       clk: shmobile: div6: Extract cpg_div6_register()
>       clk: shmobile: Add new CPG/MSSR driver core
>       clk: shmobile: r8a7795: Add new CPG/MSSR driver
> 
> Magnus Damm (1):
>       clk: shmobile: Rework CONFIG_ARCH_SHMOBILE_MULTI
> 
>  .../bindings/clock/renesas,cpg-div6-clocks.txt     |   4 +
>  drivers/clk/Makefile                               |   1 +
>  drivers/clk/shmobile/Makefile                      |  24 +-
>  drivers/clk/shmobile/clk-div6.c                    | 137 +++--
>  drivers/clk/shmobile/clk-div6.h                    |   7 +
>  drivers/clk/shmobile/r8a7795-cpg-mssr.c            | 382 +++++++++++++
>  drivers/clk/shmobile/renesas-cpg-mssr.c            | 596 +++++++++++++++++++++
>  drivers/clk/shmobile/renesas-cpg-mssr.h            | 132 +++++
>  8 files changed, 1220 insertions(+), 63 deletions(-)
>  create mode 100644 drivers/clk/shmobile/clk-div6.h
>  create mode 100644 drivers/clk/shmobile/r8a7795-cpg-mssr.c
>  create mode 100644 drivers/clk/shmobile/renesas-cpg-mssr.c
>  create mode 100644 drivers/clk/shmobile/renesas-cpg-mssr.h
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
