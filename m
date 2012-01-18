From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 18 Jan 2012 11:54:21 +0000
Subject: Re: [PATCH] sh: sh7757lcr: update to the new MMCIF DMA configuration
Message-Id: <20120118115421.GF8182@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1201181016330.28782@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1201181016330.28782@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jan 18, 2012 at 10:24:17AM +0100, Guennadi Liakhovetski wrote:
> Specifying MMCIF DMA slave IDs via a struct sh_mmcif_dma instance is
> deprecated. Update sh7757lcr to specify slave IDs embedded in
> struct sh_mmcif_plat_data.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> Would be good to get this upstream asap, then we could remove struct 
> sh_mmcif_dma for 3.4, which is also a part of the following patch series.
> 
I've applied it and will make sure it gets in to the next -rc along with
the identical rmobile changes, thanks.
