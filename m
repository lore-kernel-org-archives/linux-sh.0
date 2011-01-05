From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 05 Jan 2011 01:45:49 +0000
Subject: Re: [PATCH] mmc: sh_mmcif: make DMA support by the driver unconditional
Message-Id: <AANLkTikh5yYj_kXM6fD+SNmurXqmB_ATaKnDfWM5Cwva@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1012290852530.14233@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1012290852530.14233@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Wed, Dec 29, 2010 at 4:59 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Simplify the driver by removing the possibility to build it without the DMA
> support and remove the respective Kconfig parameter.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Excellent, this helps against bitrot and makes kernel configuration
easier for newbies.

Acked-by: Magnus Damm <damm@opensource.se>
