From: Samuel Ortiz <sameo@linux.intel.com>
Date: Fri, 23 Nov 2012 11:15:15 +0000
Subject: Re: [PATCH v2 2/2] regulator: add a regulator driver for the AS3711 PMIC
Message-Id: <20121123111515.GD12685@sortiz-mobl>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1211221107520.28453@axis700.grange>
 <Pine.LNX.4.64.1211221110330.28453@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1211221110330.28453@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

Hi Guennadi, Mark,

On Thu, Nov 22, 2012 at 11:12:08AM +0100, Guennadi Liakhovetski wrote:
> This driver supports the 4 DCDC and 8 LDO regulators on the AS3711 PMIC.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> v2: make platform data optional
> 
>  drivers/regulator/Kconfig            |    7 +
>  drivers/regulator/Makefile           |    1 +
>  drivers/regulator/as3711-regulator.c |  379 ++++++++++++++++++++++++++++++++++
>  3 files changed, 387 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/regulator/as3711-regulator.c
Mark, does that look ok with you ? There's a build dependency with patch #1,
so it would make sense for me to take it.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
