From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 22 Feb 2015 22:39:05 +0000
Subject: Re: [PATCH v3] sh-pfc: add R8A7794 PFC support
Message-Id: <2862970.IP6dNCPzfj@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <2084538.pWCX8EzoLe@wasted.cogentembedded.com>
In-Reply-To: <2084538.pWCX8EzoLe@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linus.walleij@linaro.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org

Hi Sergei,

Thank you for the patch.

On Monday 23 February 2015 00:33:38 Sergei Shtylyov wrote:
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

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> Changes in version 3:
> - removed the platform device ID;
> - added PORT_GP_26() and PORT_GP_28() macros, used them for GPIO1/5/6 in the
> CPU_ALL_PORT() macto.
> 
> Changes in version 2:
> - rebased the patch.
> 
>  Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt |    1 
>  drivers/pinctrl/sh-pfc/Kconfig                                    |    5 
>  drivers/pinctrl/sh-pfc/Makefile                                   |    1 
>  drivers/pinctrl/sh-pfc/core.c                                     |    6 
>  drivers/pinctrl/sh-pfc/core.h                                     |    1 
>  drivers/pinctrl/sh-pfc/pfc-r8a7794.c                              | 4020 ++
>  6 files changed, 4034 insertions(+)

-- 
Regards,

Laurent Pinchart

