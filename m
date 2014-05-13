From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 13 May 2014 11:24:09 +0000
Subject: Re: [PATCH 00/03] pinctrl: sh-pfc: Extend Multiplatform Support
Message-Id: <1962660.3XoHXjmi59@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20140507231748.29661.46207.sendpatchset@w520>
In-Reply-To: <20140507231748.29661.46207.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

Thank you for the patches.

On Thursday 08 May 2014 08:17:48 Magnus Damm wrote:
> pinctrl: sh-pfc: Extend Multiplatform Support
> 
> [PATCH 01/03] pinctrl: sh-pfc: r8a7740: Allow Multiplatform Build
> [PATCH 02/03] pinctrl: sh-pfc: sh73a0: Allow Multiplatform Build
> [PATCH 03/03] pinctrl: sh-pfc: r8a73a4: Allow Multiplatform Build
> 
> These patches enable Multiplatform support for r8a7740, sh73a0 and r8a73a4.
> 
> The legacy case is still kept around, so the mach-header is still needed
> to allow static GPIO-IRQ assignment. In case of DT the GPIO IRQs are already
> provided via DT properties, so we can simply #ifdef out the static IRQ
> tables in case of Multiplatform build. Not pretty but it works.

Well, it builds, but does it really work ? If I'm not mistaken this patch set 
essentially disables gpio_to_irq support for the above three SoCs as the 
gpio_pin_to_irq() function (drivers/pinctrl/sh-pfc/gpio.c) will immediately 
return -ENOSYS due to pfc->info->gpio_irq_size being 0. Worse, the 
sh_pfc_register_gpiochip() function will fail with an error due to

        if (pfc->num_irqs && pfc->num_irqs != pfc->info->gpio_irq_size) {
                dev_err(pfc->dev, "invalid number of IRQ resources\n");
                return -EINVAL;
        }

with num_irqs being non-zero and gpio_irq_size being 0.

Am I missing something, or is this series completely untested ? :-)

I'll send another (also untested, as I have no Armadillo board anymore ;-)) 
patch set shortly with a proposed fix.

> sh7372 is intentionally excluded from this series since it will not be
> moved over to Multiplatform. Instead software support for sh7372 will be
> phased out in the a few kernel releases.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  Written against renesas-devel-v3.15-rc3-20140502
> 
>  drivers/pinctrl/sh-pfc/pfc-r8a73a4.c |    7 +++++++
>  drivers/pinctrl/sh-pfc/pfc-r8a7740.c |    7 ++++++-
>  drivers/pinctrl/sh-pfc/pfc-sh73a0.c  |    6 ++++++
>  3 files changed, 19 insertions(+), 1 deletion(-)

-- 
Regards,

Laurent Pinchart

