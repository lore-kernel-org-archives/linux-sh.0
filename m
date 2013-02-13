From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 13 Feb 2013 09:45:13 +0000
Subject: Re: [PATCH 00/08] clocksource: sh_cmt: CMT driver update
Message-Id: <Pine.LNX.4.64.1302130927280.18535@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <20121214055323.10081.12056.sendpatchset@w520>
In-Reply-To: <20121214055323.10081.12056.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, johnstul@us.ibm.com, horms@verge.net.au, shinya.kuribayashi.px@renesas.com, tglx@linutronix.de

Hi Magnus

On Fri, 14 Dec 2012, Magnus Damm wrote:

> clocksource: sh_cmt: CMT driver update
> 
> [PATCH 01/08] clocksource: sh_cmt: Take care of clk_put() when setup_irq() fails
> [PATCH 02/08] clocksource: sh_cmt: Initialize 'max_match_value' and 'lock' in sh_cmt_setup()
> [PATCH 03/08] clocksource: sh_cmt: Consolidate platform_set_drvdata() call
> [PATCH 04/08] clocksource: sh_cmt: Introduce per-register functions
> [PATCH 05/08] clocksource: sh_cmt: CMSTR and CMCSR register access update
> [PATCH 06/08] clocksource: sh_cmt: CMCNT and CMCOR register access update
> [PATCH 07/08] clocksource: sh_cmt: Add control register callbacks
> [PATCH 08/08] clocksource: sh_cmt: Add CMT register layout comment

On a kzm9g board with -reference DT configuration and on armadillo800eva:

Tested-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks
Guennadi

> This patch series contains a couple of driver updates from Kuribayashi-san
> together with some register access changes from me. The register access
> changes work towards adding support for 32-bit only CMT hardware, but
> the final bits are not yet included in this series due to lack of hardware.
> 
> Patches 1-3:
> Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
> Signed-off-by: Magnus Damm <damm@opensource.se>
> 
> Patches 4-8:
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  drivers/clocksource/sh_cmt.c |  257 ++++++++++++++++++++++++------------------
>  1 file changed, 152 insertions(+), 105 deletions(-)
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
