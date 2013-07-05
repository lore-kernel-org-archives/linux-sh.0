From: Simon Horman <horms@verge.net.au>
Date: Fri, 05 Jul 2013 00:13:14 +0000
Subject: Re: [PATCH v7 00/19] SH Mobile pinctrl DT support
Message-Id: <20130705001314.GD25112@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1372961852-28490-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1372961852-28490-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jul 04, 2013 at 08:17:13PM +0200, Laurent Pinchart wrote:
> Hello,
> 
> Here's the seventh version of the SH Mobile pin controllers (PFC) DT support
> patch set.
> 
> The patches depend on the v3.11-rc pinctrl core. Linus Torvald has merged the
> pinctrl tree into his master branch, so I've based this series on a merge of
> Linus' master and tags/renesas-next-20130704v3 from Simon's tree
> (git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git). The result
> is available in my tree at
> 
>         git://linuxtv.org/pinchartl/fbdev.git pinmux/3.11/dt
> 
> The series is pretty self-explanatory. The patches gradually move SoC code
> and board code over to the device tree for the armadilla800eva-reference,
> kzm9g-reference and marzen-reference boards. The code has been tested on the
> three boards, but armadillo800eva has received less testing as it can't be
> booted all the way to userspace with network support due to missing DT
> bindings.
> 
> As the patches only touch the SH Mobile architecture they can all be merged
> through Simon's tree. Simon, will you rebase your tree on v3.11-rc1 when it
> will be tagged ?

In general I like to rebase once the renesas code that was accepted into
the arm-soc tree has been accepted into Linus's tree.

It appears that is already the case, except for some late fixes
(renesas-fixes2-for-v3.11), as of the current (pre v3.11-rc1) master branch
of Linus's tree. So yes, I plan to rebase once v3.11-rc1 is tagged.

> 
> Changes since v6:
> 
> - Dropped the sh-pfc driver patches that have been merged in mainline
> - Added kzm9g-reference patches back now that pinconf DT bindings are
>   available
> 
> Changes since v5:
> 
> - Dropped generic pinconf support
> - Dropped kzm9g-reference patches, as those require pinconf support
> 
> Changes since v4:
> 
> - Added generic pinconf bindings
> - Use symbolic names for GPIO flags
> 
> Changes since v3:
> 
> - Fixed the GPIO flags description in the DT bindings documentation
> - Mention the gpio-rcar driver in the DT bindings documentation for platforms
>   that use it
> - Removed unneeded #ifdef CONFIG_OF...#endif
> - Removed unused support for platform data
> - Simplified error path in sh_pfc_dt_node_to_map()
> - Added gpio-ranges for r8a7778, r8a7779 and r8a7790
> 
> Changes since v2:
> 
> - Added pin configuration properties
> - Rewrote all arch changes
> 
> Changes since v1:
> 
> - Fixed gpio cell number 2 documentation
> - Added missing gpio-controller and #gpio-cells properties to r8a7740 DT
> - Split kzm9g DT patch into SoC and board patches
> - Dropped pinctrl mappings move to DT
> 
> Laurent Pinchart (19):
>   ARM: shmobile: r8a73a4: Add pin control device to device tree
>   ARM: shmobile: r8a7740: Add pin control device to device tree
>   ARM: shmobile: r8a7778: Add pin control device to device tree
>   ARM: shmobile: r8a7778: Add GPIO controller devices to device tree
>   ARM: shmobile: r8a7779: Add pin control device to device tree
>   ARM: shmobile: r8a7779: Add GPIO controller devices to device tree
>   ARM: shmobile: r8a7790: Add pin control device to device tree
>   ARM: shmobile: r8a7790: Add GPIO controller devices to device tree
>   ARM: shmobile: sh7372: Add pin control device to device tree
>   ARM: shmobile: sh73a0: Add pin control device to device tree
>   ARM: shmobile: armadillo-reference: Move pinctrl mappings to device
>     tree
>   ARM: shmobile: armadillo-reference: Add st1232 pin mappings
>   ARM: shmobile: armadillo-reference: Move st1232 reset GPIO to DT
>   ARM: shmobile: armadillo-reference: Add LED1-LED4 to the device tree
>   ARM: shmobile: marzen-reference: Move pinctrl mappings to device tree
>   ARM: shmobile: marzen-reference: Add LED2-LED4 to the device tree
>   ARM: shmobile: kzm9g-reference: Move pinctrl mappings to device tree
>   ARM: shmobile: kzm9g-reference: Move SDHI regulators to DT
>   ARM: shmobile: kzm9g-reference: Add LED1-LED4 to the device tree
> 
>  arch/arm/boot/dts/r8a73a4.dtsi                     |  7 ++
>  .../boot/dts/r8a7740-armadillo800eva-reference.dts | 34 ++++++++
>  arch/arm/boot/dts/r8a7740.dtsi                     |  8 ++
>  arch/arm/boot/dts/r8a7778.dtsi                     | 66 ++++++++++++++++
>  arch/arm/boot/dts/r8a7779-marzen-reference.dts     | 49 ++++++++++++
>  arch/arm/boot/dts/r8a7779.dtsi                     | 90 ++++++++++++++++++++++
>  arch/arm/boot/dts/r8a7790.dtsi                     | 78 +++++++++++++++++++
>  arch/arm/boot/dts/sh7372.dtsi                      |  8 ++
>  arch/arm/boot/dts/sh73a0-kzm9g-reference.dts       | 90 +++++++++++++++++++++-
>  arch/arm/boot/dts/sh73a0.dtsi                      |  8 ++
>  .../board-armadillo800eva-reference.c              | 18 +----
>  arch/arm/mach-shmobile/board-kzm9g-reference.c     | 47 -----------
>  arch/arm/mach-shmobile/board-marzen-reference.c    | 28 -------
>  13 files changed, 437 insertions(+), 94 deletions(-)
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
