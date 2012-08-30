From: Simon Horman <horms@verge.net.au>
Date: Thu, 30 Aug 2012 04:45:06 +0000
Subject: Re: [PATCH 0/8] ARM: shmobile: r8a7779/marzen/kzm9g patches for v3.7
Message-Id: <20120830044505.GA30566@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87mx1fdbgl.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mx1fdbgl.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Mon, Aug 27, 2012 at 06:58:21PM -0700, kuninori.morimoto.gx@renesas.com wrote:
> 
> Hi Simon, Magnus, Paul, Rafael
> 
> These are r8a7779/marzen/kzm9g new feature patches for v3.7 (not v3.6-rcX).
> These patches need subsystem branch merge.
> 
> Kuninori Morimoto (8):
>       1) ARM: shmobile: r8a7779: PFC rename PENCx -> USB_PENCx
>       2) ARM: shmobile: r8a7779: add USB common phy initializer
>       3) ARM: shmobile: r8a7779: add USB EHCI clock support
>       4) ARM: shmobile: r8a7779: add USB OHCI clock support
>       5) ARM: shmobile: marzen: add USB EHCI driver support
>       6) ARM: shmobile: marzen: add USB OHCI driver support
>       7) ARM: shmobile: marzen: enable thermal sensor
>       8) ARM: shmobile: kzm9g: use gpio-keys instead of gpio-keys-polled
> 
>  arch/arm/configs/marzen_defconfig             |   13 ++-
>  arch/arm/mach-shmobile/Kconfig                |    2 +
>  arch/arm/mach-shmobile/board-marzen.c         |  161 +++++++++++++++++++++++++
>  arch/arm/mach-shmobile/clock-r8a7779.c        |    7 +
>  arch/arm/mach-shmobile/include/mach/common.h  |    1 +
>  arch/arm/mach-shmobile/include/mach/r8a7779.h |    2 +-
>  arch/arm/mach-shmobile/pfc-r8a7779.c          |   16 ++--
>  arch/arm/mach-shmobile/setup-r8a7779.c        |   93 ++++++++++++++
>  8 files changed, 284 insertions(+), 11 deletions(-)
> 
> 1) - 6) add EHCI/OHCI USB support to r8a7779/marzen board,
> but these depend on this branch
>    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git - usb-next

Thanks.

There seem to be build-time dependencies on usb-next,
so my current plan is to rebase the marzen branch
on top of usb-next and send a pull request to arm-soc.

> 7) adds thermal support for marzen,
> but it depends on this branch
>     git://git.linaro.org/people/amitdanielk/linux.git - exynos_v6_thermal_tree

It seems to be safe enough to apply this patch without exynos_v6_thermal_tree
present, the R-Car Thermal driver isn't built but both build and boot
of a defconfig kernel work. Accordingly, my plan is to include this
patch in the usb-net based pull request described above.

However, I did notice that when testing a tree with the following

* v3.6-rc3
* usb-next
* exynos_v6_thermal_tree
* My marzen branch
* Patches 1-7 of this series

And the R-Car Thermal driver selected in the kernel .config I see the following:

# make
  CC      drivers/thermal/rcar_thermal.o
drivers/thermal/rcar_thermal.c: In function 'rcar_thermal_probe':
drivers/thermal/rcar_thermal.c:214:10: warning: passing argument 3 of 'thermal_zone_device_register' makes integer from pointer without a cast include/linux/thermal.h:166:29: note: expected 'int' but argument is of type 'struct rcar_thermal_priv *'
drivers/thermal/rcar_thermal.c:214:10: error: too few arguments to function 'thermal_zone_device_register'
include/linux/thermal.h:166:29: note: declared here
make[2]: *** [drivers/thermal/rcar_thermal.o] Error 1
make[1]: *** [drivers/thermal] Error 2
make: *** [drivers] Error 2

> 8) switch to use gpio-keys instead of gpio-keys-polled,
> but it depends on this branch
>     git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git - for-next

This seems to be a build-time dependency.
My current plan is to create a kzm9g-gpio tree based
on linux-gpio/for-next and send a pull request to
arm-soc.

> These are based on linus/master + above each branch + "Simon's defconfig patch"

Thanks for the details, they are very helpful.
