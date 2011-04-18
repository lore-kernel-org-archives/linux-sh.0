From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 18 Apr 2011 09:48:23 +0000
Subject: Re: [PATCH 1/2] sh: fix SD / MMC configuration dependencies on ecovec
Message-Id: <20110418094823.GI32457@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1104152017400.18593@axis700.grange>
	<Pine.LNX.4.64.1104152015190.18593@axis700.grange>
	<Pine.LNX.4.64.1104152003190.18593@axis700.grange>
	<Pine.LNX.4.64.1104152000450.18593@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1104152017400.18593@axis700.grange>
	<Pine.LNX.4.64.1104152015190.18593@axis700.grange>
	<Pine.LNX.4.64.1104152003190.18593@axis700.grange>
	<Pine.LNX.4.64.1104152000450.18593@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, linux-i2c@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>

On Fri, Apr 15, 2011 at 08:03:17PM +0200, Guennadi Liakhovetski wrote:
> Update CONFIG_MMC_TMIO to the new CONFIG_MMC_SDHI symbol and fix
> MMCIF to also function in modular builds for ecovec.

On Fri, Apr 15, 2011 at 08:04:12PM +0200, Guennadi Liakhovetski wrote:
>  arch/sh/configs/ecovec24_defconfig  |    2 +-
>  arch/sh/configs/sh7757lcr_defconfig |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

On Fri, Apr 15, 2011 at 08:17:34PM +0200, Guennadi Liakhovetski wrote:
> This patch enables FSI driver autoloading on sh-mobile systems.

On Fri, Apr 15, 2011 at 08:18:57PM +0200, Guennadi Liakhovetski wrote:
> This patch enables I2C driver autoloading on sh-mobile systems.

All applied, thanks.
