From: Olof Johansson <olof@lixom.net>
Date: Mon, 12 Jan 2015 22:29:32 +0000
Subject: Re: [GIT PULL] Renesas ARM Based SoC Lager Board Removal for v3.20
Message-Id: <20150112222932.GI22090@quad.lixom.net>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1419809774.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1419809774.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Dec 29, 2014 at 10:46:47AM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC lager board removal for v3.20.
> 
> The serial port rename changes are not strictly related to lager board
> removal from a feature point of view. But the lager portion of this change
> depends on board removal to avoid a regression of booting using that code,
> And thus it seems to make sense to put here. And it seems best to put the
> koelsch and lager serial port rename changes in the same branch.
> 
> Likewise the removal of bootargs from lager DT depends on removing lager
> board code to avoid a regression when using it and thus I have included
> it in the same branch.
> 
> 
> The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
> 
>   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-lager-board-removal-for-v3.20
> 
> for you to fetch changes up to 569dd56c9971c699472d3b270e988baf7f6de8c9:
> 
>   ARM: shmobile: lager dts: Drop console= bootargs parameter (2014-12-21 17:03:53 +0900)
> 
> ----------------------------------------------------------------
> Renesas ARM Based SoC Lager Board Removal for v3.20
> 
> * Remove legacy r8a7790 SoC and its Lager board code
> * Update serial port names on koelsch and lager boards
> * Remove console bootargs parameter from lager DT
> 
> ----------------------------------------------------------------
> Geert Uytterhoeven (1):
>       ARM: shmobile: lager dts: Drop console= bootargs parameter
> 
> Laurent Pinchart (3):
>       ARM: shmobile: r8a7790: Remove legacy code
>       ARM: shmobile: lager: Rename SCIFA[01] serial ports to ttySC[01]
>       ARM: shmobile: koelsch: Rename SCIF[01] serial ports to ttySC[01]
> 
> Magnus Damm (2):
>       ARM: shmobile: lager-reference: DTS-only board support
>       ARM: shmobile: lager: Remove legacy board support
> 
>  MAINTAINERS                                    |   1 -
>  arch/arm/boot/dts/Makefile                     |   1 -
>  arch/arm/boot/dts/r8a7790-lager.dts            |   6 +-
>  arch/arm/boot/dts/r8a7791-koelsch.dts          |   4 +-
>  arch/arm/configs/lager_defconfig               | 150 -----
>  arch/arm/configs/shmobile_defconfig            |   1 -
>  arch/arm/mach-shmobile/Kconfig                 |  20 -
>  arch/arm/mach-shmobile/Makefile                |   3 -
>  arch/arm/mach-shmobile/Makefile.boot           |   1 -
>  arch/arm/mach-shmobile/board-lager-reference.c |  39 --
>  arch/arm/mach-shmobile/board-lager.c           | 827 -------------------------
>  arch/arm/mach-shmobile/clock-r8a7790.c         | 459 --------------
>  arch/arm/mach-shmobile/r8a7790.h               |  28 -
>  arch/arm/mach-shmobile/setup-r8a7790.c         | 284 +--------
>  14 files changed, 6 insertions(+), 1818 deletions(-)

Nice!!

I've merged this into next/cleanup.


-Olof
