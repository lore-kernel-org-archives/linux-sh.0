From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 01 Mar 2016 11:28:53 +0000
Subject: Re: [RFC PATCH 0/3] Add PCIe to r8a7795 & Salvator-X
Message-Id: <CAMuHMdXPGEBovCssGEw=77gSWuB74Yg4QJWrH5cMvy0w9VsWFg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1446484121-26682-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1446484121-26682-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Phil,

On Mon, Nov 2, 2015 at 6:08 PM, Phil Edworthy <phil.edworthy@renesas.com> wrote:
> These patches are needed to get PCIe working on the Salvator-X board, see
> https://lkml.org/lkml/2015/11/2/445.
>
> They depend on the cpg-mssr driver and other patches so are on top of
> git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git
> renesas-drivers-2015-10-27-v4.3-rc7
>
> Phil Edworthy (3):
>   clk: shmobile: r8a7795: Add PCIe clocks
>   arm64: renesas: r8a7795: Add PCIe nodes
>   arm64: dts: r8a7795: enable PCIe on Salvator-X
>
>  arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 12 +++++
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 60 +++++++++++++++++++++-
>  drivers/clk/shmobile/clk-r8a7795-cpg-mssr.c        |  2 +
>  3 files changed, 73 insertions(+), 1 deletion(-)

Do you plan to update and repost this series?

Simon still has it in topic/r8a7795-pcie, and I still include it in
renesas-drivers, but it became a bit rusty.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
