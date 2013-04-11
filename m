From: Simon Horman <horms@verge.net.au>
Date: Thu, 11 Apr 2013 08:05:40 +0000
Subject: Re: [PATCH 00/10] r8a7790 PFC pinctrl and GPIO improvements
Message-Id: <20130411080537.GA17390@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1365413782-17036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1365413782-17036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

On 月,  4月 08, 2013 at 11:36:12午前 +0200, Laurent Pinchart wrote:
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

Thanks,

I have queued up the following patches for v3.11 in the pinmux branch:

gpio-rcar: Add RCAR_GP_PIN macro
sh-pfc: r8a7790: Add ETH pin groups and functions
sh-pfc: r8a7790: Add INTC pin groups and functions
sh-pfc: r8a7790: Add SCIF, SCIFA and SCIFB pin groups and functions
sh-pfc: r8a7790: Remove GPIO data
sh-pfc: r8a7790: Remove function GPIOs
sh-pfc: r8a7790: Don't use GPIO enum entries

I have merged the pinmux branch into the soc-r8a7990 branch and
queued up the following patches for v3.11 in there.

ARM: shmobile: r8a7790: Register GPIO devices
ARM: shmobile: r8a7790: Remove all GPIOs

I have merged the soc-r8a7990 branch into the boards-lager branch and
queued up the following patches for v3.11 in there.

ARM: shmobile: lager: Initialize pinmux



