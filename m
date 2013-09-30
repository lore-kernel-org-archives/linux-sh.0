From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 30 Sep 2013 15:25:42 +0000
Subject: Re: [PATCH v2 0/5] ARM: shmobile: CPUFreq support on Lager
Message-Id: <Pine.LNX.4.64.1309301719460.16868@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1380216060-14506-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1380216060-14506-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-kernel@vger.kernel.org

Hi Simon,

Just a quick check of the status of this patch series:

On Thu, 26 Sep 2013, Guennadi Liakhovetski wrote:

> On Lager a da9210 regulator is used to supply DVFS power to the SoC. This
> patch series adds I2C and Z-clock support on r8a7790 and CPUFreq support
> for the Lager board. Please note, that patch 4/4 is an RFC as explained
> inline.
> 
> Developed on top of today's
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git    devel
> 
> plus i2c-rcar patches from my earlier patch series
> 
> [PATCH v2 0/5] i2c: rcar: Device Tree support and clock improvements
> 
> and the "sh-pfc: r8a7790: Add I2C pin groups and functions" patch from
> Ulrich Hecht.
> 
> All changes since v1 are noted in respective patches. They all are trivial,
> still as soon as test hardware is available, it would be good to run-time
> test this version too.
> 
> Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> 
> Guennadi Liakhovetski (5):
>   pinctrl: sh-pfc: r8a7790: add pin definitions for the I2C3 interface

Laurent has taken this one.

>   ARM: shmobile: r8a7790: add I2C clocks and aliases for the DT mode
>   ARM: shmobile: r8a7790: add I2C DT nodes

You've applied the above two too, thanks.

>   ARM: shmobile: r8a7790: add CPUFreq clock support

Do I see it right, that you're waiting for a review for the above one?

>   ARM: shmobile: lager: (DEVEL) add CPUFreq support

Once a review of #4/5 is posted, I can split the above patch into two to 
separate shmobile and DT parts, as requested by Sergei. Is that about what 
you're expecting too?

Thanks
Guennadi

>  arch/arm/boot/dts/r8a7790-lager-reference.dts  |   33 +++++
>  arch/arm/boot/dts/r8a7790.dtsi                 |   40 ++++++
>  arch/arm/mach-shmobile/Kconfig                 |    2 +
>  arch/arm/mach-shmobile/board-lager-reference.c |    4 +-
>  arch/arm/mach-shmobile/clock-r8a7790.c         |  160 ++++++++++++++++++++++++
>  drivers/pinctrl/sh-pfc/pfc-r8a7790.c           |   28 ++++
>  6 files changed, 266 insertions(+), 1 deletions(-)
> 
> -- 
> 1.7.2.5

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
