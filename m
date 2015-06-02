From: Simon Horman <horms@verge.net.au>
Date: Tue, 02 Jun 2015 01:19:26 +0000
Subject: Re: [PATCH v5 0/4] r8a7793 SoC, Gose board support
Message-Id: <20150602011926.GA11844@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1433168577-7678-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1433168577-7678-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jun 01, 2015 at 04:22:53PM +0200, Ulrich Hecht wrote:
> Hi!
> 
> Here's the minimalized r8a7793 support series once more, with the missing
> regulator bits added and the "enable-method" removed.

Thanks, this looks good to me.

I plan to queue it up for v4.3 and as such it should
turn up in the next push of the renesas/devel branch.

> CU
> Uli
> 
> 
> Changes since v4:
> - added missing build system changes for regulator quirk
> - removed enable-method from SoC DT
> - fixed typo
> - added ack
> 
> Changes since v3:
> - minimalized device trees
> - split off DT bindings
> - added Geert's ack
> 
> Changes since v2:
> - dts: remove unused pins
> - dts: fix flash partition addresses
> - dts: add pmic
> - dtsi, dts: add CMTs
> - dts: add interrupt parent to regulator
> - smp, dtsi: use CPU_METHOD_OF_DECLARE, enable-method
> - smp: re-add rcar_gen2_pm_init() call
> - dtsi: add irqc0 clock
> - dtsi: add DMA controllers
> - dtsi: remove audmapp
> - dtsi: fix sdhi0 resource length
> - dtsi: add SDHI DMAs, remove unsupported properties
> - dtsi: add rcan, adsp clocks
> - dtsi: add missing MSTP4
> - dtsi: fix audmac clocks
> - dtsi: add MSIOF DMAs, remove unused register set
> - dtsi: copy sound description from r8a7791
> - enable rcar2 regulator quirk on Gose
> 
> Changes since v1:
> 
> - pfc: split patch in six
> - pfc: fixed typos
> - dts: named clock bits properly
> - dts: made more consistent with the very similar r8a7791 dts
> - dts: removed adv7511, don't know the address
> - pm: dropped for now, needs to be fixed up first
> - everywhere: renamed M2N -> M2-N (and M2 to M2-W, while at it)
> - everywhere: added Acks
> 
> 
> Ulrich Hecht (4):
>   ARM: shmobile: Basic r8a7793 SoC support
>   ARM: shmobile: add r8a7793 minimal SoC device tree
>   ARM: shmobile: r8a7793: add minimal Gose board device tree
>   ARM: shmobile: gose: enable R-Car Gen2 regulator quirk
> 
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/r8a7793-gose.dts                 |  63 ++++
>  arch/arm/boot/dts/r8a7793.dtsi                     | 367 +++++++++++++++++++++
>  arch/arm/mach-shmobile/Kconfig                     |   5 +
>  arch/arm/mach-shmobile/Makefile                    |   2 +
>  arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c |   3 +-
>  arch/arm/mach-shmobile/setup-r8a7793.c             |  33 ++
>  include/dt-bindings/clock/r8a7793-clock.h          | 164 +++++++++
>  8 files changed, 637 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/r8a7793-gose.dts
>  create mode 100644 arch/arm/boot/dts/r8a7793.dtsi
>  create mode 100644 arch/arm/mach-shmobile/setup-r8a7793.c
>  create mode 100644 include/dt-bindings/clock/r8a7793-clock.h
> 
> -- 
> 2.4.2
> 
