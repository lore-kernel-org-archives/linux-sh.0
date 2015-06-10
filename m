From: Michael Turquette <mturquette@linaro.org>
Date: Wed, 10 Jun 2015 02:47:17 +0000
Subject: Re: [git pull] clk/shmobile updates for v4.2
Message-Id: <20150610024717.6017.50093@quantum>
List-Id: <linux-sh.vger.kernel.org>
References: <1433244779-5447-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1433244779-5447-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, linux-clk@vger.kernel.org, linux-sh@vger.kernel.org

Quoting Geert Uytterhoeven (2015-06-02 04:32:59)
>         Hi Mike, Stephen,
> 
> The following changes since commit c65b99f046843d2455aa231747b5a07a999a9f3d:
> 
>   Linux 4.1-rc6 (2015-05-31 19:01:07 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git clk-shmobile-for-4.2

Pulled!

FYI, I prefer to take PRs based on -rc1 if possible. This PR forced me
to update clk-next which was previously based on -rc1 (I merged clk-next
into -rc7 and then pulled your tag).

Of course some times this is unavoidable, due to a dependency on a fix
in a recent -rc.

Regards,
Mike

> 
> for you to fetch changes up to a431c1fa01ff020ecb146c04fbbea974e3eb910f:
> 
>   clk: shmobile: rz: Document mandatory compatible fallback (2015-06-01 12:25:28 +0200)
> 
> Summary:
> 
> Updates for existing shmobile DT clock bindings:
>   - Add support for new SoCs, following existing practices,
>   - Document compatible fallbacks that are mandatory, because the driver
>     matches against the generic fallback only.
> 
> Thanks for pulling!
> 
> ----------------------------------------------------------------
> Geert Uytterhoeven (5):
>       clk: shmobile: r8a7794: Document DIV6 clock bindings
>       clk: shmobile: div6: Document mandatory compatible fallback
>       clk: shmobile: mstp: Document mandatory compatible fallback
>       clk: shmobile: rcar-gen2: Document mandatory compatible fallback
>       clk: shmobile: rz: Document mandatory compatible fallback
> 
> Ulrich Hecht (3):
>       clk: shmobile: Add r8a7778 SoC to MSTP bindings
>       clk: shmobile: Add r8a7793 SoC to MSTP bindings
>       clk: shmobile: r8a7793: Document DIV6 clock bindings
> 
>  Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt | 6 ++++--
>  Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt | 6 ++++--
>  .../devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt      | 2 +-
>  Documentation/devicetree/bindings/clock/renesas,rz-cpg-clocks.txt   | 2 +-
>  4 files changed, 10 insertions(+), 6 deletions(-)
> 
> Gr{oetje,eeting}s,
> 
>                                                 Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                                             -- Linus Torvalds
