From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 03 Mar 2015 00:31:11 +0000
Subject: Re: [PATCH v4] sh-pfc: add R8A7794 PFC support
Message-Id: <3121113.X7ESdRtU5F@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <3551465.HvFoQ45W0R@wasted.cogentembedded.com>
In-Reply-To: <3551465.HvFoQ45W0R@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linus.walleij@linaro.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org

Hi Sergei,

Thank you for the patch.

On Saturday 28 February 2015 02:40:42 Sergei Shtylyov wrote:
> From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> 
> Add PFC support for  the  R8A7794 SoC  including pin groups for some on-chip
> devices such as ETH, I2C, INTC, MSIOF, QSPI, [H]SCIF...
> 
> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> [Sergei: squashed together several patches, fixed the MLB_CLK typo, added
> IRQ4.. IRQ9 pin groups,  fixed IRQn comments, added ETH B pin group names,
> removed stray new line and fixed typos in the  comments in the
> pinmux_config_regs[] initializer, removed the platform device ID, took into
> account limited number of signals in the GPIO1/5/6 controllers, added
> reasonable and removed unreasonable copyrights, modified the bindings
> document, renamed, added changelog.] Signed-off-by: Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com>

Pending the merge of "[PATCH] sh-pfc: handle pin array holes in 
sh_pfc_map_pins()" which is still under discussion,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> The patch is against the 'devel' branch of Linus W.'s 'linux-pinctrl.git'
> repo.
> 
> Changes in version 4:
> - reused the PORT_GP_26() macro to #define PORT_GP_28().
> 
> Changes in version 3:
> - removed the platform device ID;
> - added PORT_GP_26() and PORT_GP_28() macros, used them for GPIO1/5/6 in the
> CPU_ALL_PORT() macro.
> 
> Changes in version 2:
> - rebased the patch.
> 
>  Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt |    1 
>  drivers/pinctrl/sh-pfc/Kconfig                                    |    5 
>  drivers/pinctrl/sh-pfc/Makefile                                   |    1 
>  drivers/pinctrl/sh-pfc/core.c                                     |    6 
>  drivers/pinctrl/sh-pfc/core.h                                     |    1 
>  drivers/pinctrl/sh-pfc/pfc-r8a7794.c                              | 4008 ++
>  6 files changed, 4022 insertions(+)

-- 
Regards,

Laurent Pinchart

