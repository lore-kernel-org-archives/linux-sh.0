From: Simon Horman <horms@verge.net.au>
Date: Sat, 07 Mar 2015 00:06:06 +0000
Subject: Re: [PATCH 00/11] r8a7793 SoC, Gose board support
Message-Id: <20150307000603.GC19866@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1425661798-10487-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1425661798-10487-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

On Fri, Mar 06, 2015 at 06:09:47PM +0100, Ulrich Hecht wrote:
> Hi!
> 
> This is a port from the R-Car2 BSP, including pin control, SMP, and power
> management.
> 
> I shuffled things around a bit to accomodate the current mainline
> infrastructure and dumped the platform devices and with them the Gose board
> file.
> 
> Known problems include missing bindings for PCIE, sound, and an I2C part.
> 
> It might we worth considering whether the r8a7791 and r8a7793 SMP
> implementations could be merged; the only functional difference between the
> two is that the r8a7791 implementation chickens out when hardware debug mode
> (MD21) is enabled, whereas the r8a7793 code does some magic that, I presume,
> is supposed to make it work properly.

Right, I noticed that too. I would like to see this code consolidated
and shared between the two SoCs unless it turns out to be more mess
than its worth.

I will provide some more specific comments to some of the patches
on a case by case basis, but I would like to make some higher
level observations here.

* Some of these patches are quite large and cover a lot of ground.
  In particular the sh-pfc and device tree patches. And to a lesser extent
  the power management patch. I do wonder if it would make more sense to
  take a more incremental approach to allow for easier review.

* As you mention above there seems to be some potential for sharing
  the SMP code between SoCs. I believe there is also scope for sharing
  some of the power management code for the SoCs. In particular I am
  referring to pm-r8a7790.c and pm-r8a7791.c and the recent patches
  by Inami-san to add pm-r8a7794.c.

* Several of the patches add trivial new bindings. They will need to
  be posted to the appropriate driver/subsystem maintainers to
  be either acked or merged. My preference is for the latter and
  I will provide acks to that end.

* sh-pfc changes also need to be posted to the appropriate subsystem
  maintainer (Linus Walleij) for him to merge. I believe Laurent should
  provide review. Though as I mentioned above I do wonder if the patch
  should be split up.

> CU
> Uli
> 
> 
> Hisashi Nakamura (1):
>   pinctrl: sh-pfc: Add r8a7793 PFC support
> 
> Ulrich Hecht (10):
>   ARM: shmobile: Basic r8a7793 SoC support
>   ARM: shmobile: add r8a7793 SoC device tree
>   ARM: shmobile: r8a7793: add Gose board device tree
>   ARM: shmobile: r8a7793: add power management support
>   ARM: shmobile: r8a7793: add SMP support
>   clk: shmobile: r8a7793: document DIV6 clock bindings
>   mmc: sh_mmcif: Document r8a7793 DT bindings
>   serial: sh-sci: Add device tree bindings for r8a7793
>   clk: shmobile: Add r8a7793 SoC to MSTP bindings
>   PCI: rcar: document r8a7793 DT bindings
> 
>  .../bindings/clock/renesas,cpg-div6-clocks.txt     |    1 +
>  .../bindings/clock/renesas,cpg-mstp-clocks.txt     |    1 +
>  .../devicetree/bindings/mmc/renesas,mmcif.txt      |    1 +
>  .../devicetree/bindings/pci/pci-rcar-gen2.txt      |    1 +
>  .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |    1 +
>  .../bindings/serial/renesas,sci-serial.txt         |    4 +
>  arch/arm/boot/dts/Makefile                         |    1 +
>  arch/arm/boot/dts/r8a7793-gose.dts                 |  555 ++
>  arch/arm/boot/dts/r8a7793.dtsi                     | 1402 +++++
>  arch/arm/mach-shmobile/Kconfig                     |    4 +
>  arch/arm/mach-shmobile/Makefile                    |    2 +
>  arch/arm/mach-shmobile/pm-r8a7793.c                |  273 +
>  arch/arm/mach-shmobile/r8a7793.h                   |    7 +
>  arch/arm/mach-shmobile/setup-r8a7793.c             |   35 +
>  arch/arm/mach-shmobile/smp-r8a7793.c               |   69 +
>  drivers/pinctrl/sh-pfc/Kconfig                     |    5 +
>  drivers/pinctrl/sh-pfc/Makefile                    |    1 +
>  drivers/pinctrl/sh-pfc/core.c                      |    9 +
>  drivers/pinctrl/sh-pfc/core.h                      |    1 +
>  drivers/pinctrl/sh-pfc/pfc-r8a7793.c               | 6033 ++++++++++++++++++++
>  include/dt-bindings/clock/r8a7793-clock.h          |  158 +
>  21 files changed, 8564 insertions(+)
>  create mode 100644 arch/arm/boot/dts/r8a7793-gose.dts
>  create mode 100644 arch/arm/boot/dts/r8a7793.dtsi
>  create mode 100644 arch/arm/mach-shmobile/pm-r8a7793.c
>  create mode 100644 arch/arm/mach-shmobile/r8a7793.h
>  create mode 100644 arch/arm/mach-shmobile/setup-r8a7793.c
>  create mode 100644 arch/arm/mach-shmobile/smp-r8a7793.c
>  create mode 100644 drivers/pinctrl/sh-pfc/pfc-r8a7793.c
>  create mode 100644 include/dt-bindings/clock/r8a7793-clock.h
> 
> -- 
> 2.2.2
> 
