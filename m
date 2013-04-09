From: Simon Horman <horms@verge.net.au>
Date: Tue, 09 Apr 2013 12:13:17 +0000
Subject: Re: [PATCH 00/10] r8a7790 PFC pinctrl and GPIO improvements
Message-Id: <20130409121317.GA15412@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1365413782-17036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1365413782-17036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Apr 08, 2013 at 11:36:12AM +0200, Laurent Pinchart wrote:
> Hello,
> 
> This patch series adds pinctrl support to the r8a7790 PFC driver. Only the
> ETH, INTC and SCIF pin groups are currently defined, more will be added later
> as needed.
> 
> The series also removes the r8a7790 PFC GPIO code and uses the separate RCar
> GPIO driver instead.
> 
> The patches are based on Simon's pinmux branch plus Magnus' r8a7790 PFC
> patches posted today ("[PATCH 00/02] sh-pfc: Initial r8a7790 PFC support"),
> except for the last patch that requires Lager board support as a prerequisite.
> 
> Simon, is it too late to get this series merged in v3.10 ? We can delay the
> last patch to v3.11 if that helps.

As mentioned elsewhere I'd prefer to delay the entire series for v3.11.
Actually, at this point I think I would like to delay all non-fixes for v3.11.


Magnus could you review this series?


> 
> Laurent Pinchart (10):
>   gpio-rcar: Add RCAR_GP_PIN macro
>   sh-pfc: r8a7790: Add ETH pin groups and functions
>   sh-pfc: r8a7790: Add INTC pin groups and functions
>   sh-pfc: r8a7790: Add SCIF, SCIFA and SCIFB pin groups and functions
>   ARM: shmobile: r8a7790: Register GPIO devices
>   sh-pfc: r8a7790: Remove GPIO data
>   sh-pfc: r8a7790: Remove function GPIOs
>   sh-pfc: r8a7790: Don't use GPIO enum entries
>   ARM: shmobile: r8a7790: Remove all GPIOs
>   ARM: shmobile: lager: Initialize pinmux
> 
>  arch/arm/mach-shmobile/board-lager.c          |   15 +
>  arch/arm/mach-shmobile/include/mach/r8a7790.h |  383 --------
>  arch/arm/mach-shmobile/setup-r8a7790.c        |   35 +-
>  drivers/pinctrl/sh-pfc/pfc-r8a7790.c          | 1280 +++++++++++++++----------
>  include/linux/platform_data/gpio-rcar.h       |    2 +
>  5 files changed, 823 insertions(+), 892 deletions(-)
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
