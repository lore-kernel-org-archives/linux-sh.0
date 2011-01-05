From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 05 Jan 2011 07:57:58 +0000
Subject: Re: [PATCH] mmc: sh_mmcif: make DMA support by the driver unconditional
Message-Id: <20110105075757.GC23889@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1012290852530.14233@axis700.grange> <AANLkTikh5yYj_kXM6fD+SNmurXqmB_ATaKnDfWM5Cwva@mail.gmail.com>
In-Reply-To: <AANLkTikh5yYj_kXM6fD+SNmurXqmB_ATaKnDfWM5Cwva@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Wed, Jan 05, 2011 at 10:45:49AM +0900, Magnus Damm wrote:
> On Wed, Dec 29, 2010 at 4:59 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > Simplify the driver by removing the possibility to build it without the DMA
> > support and remove the respective Kconfig parameter.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> Excellent, this helps against bitrot and makes kernel configuration
> easier for newbies.
> 
> Acked-by: Magnus Damm <damm@opensource.se>

Applied to rmobile/mmcif, thanks.
