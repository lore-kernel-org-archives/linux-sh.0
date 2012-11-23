From: Samuel Ortiz <sameo@linux.intel.com>
Date: Fri, 23 Nov 2012 11:12:21 +0000
Subject: Re: [PATCH v2 1/2] mfd: add an AS3711 PMIC MFD driver
Message-Id: <20121123111221.GC12685@sortiz-mobl>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1211221107520.28453@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1211221107520.28453@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

Hi Guennadi,

On Thu, Nov 22, 2012 at 11:12:04AM +0100, Guennadi Liakhovetski wrote:
> AS3711 is a PMIC with multiple DCDC and LDO power supplies, GPIOs, an RTC,
> a battery charger and a general purpose ADC. This patch adds support for
> the MFD with support for a regulator driver and a backlight driver.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> v2: (Thanks to Mark for review)
> 
>  - Only print chip IDs if they match expected values
>  - Check regmap_read() error
>  - Make platform data optional
> 
>  drivers/mfd/Kconfig        |    9 ++
>  drivers/mfd/Makefile       |    1 +
>  drivers/mfd/as3711.c       |  217 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/as3711.h |  126 +++++++++++++++++++++++++
>  4 files changed, 353 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/mfd/as3711.c
>  create mode 100644 include/linux/mfd/as3711.h
Patch applied to my for-next branch, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
