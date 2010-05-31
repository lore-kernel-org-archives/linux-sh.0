From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 31 May 2010 04:50:08 +0000
Subject: Re: [PATCH 9/9 v2] ARM: mach-shmobile: add DMA support to sh7372, enable DMA for SDHI
Message-Id: <20100531045008.GE20358@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1005041318200.4925@axis700.grange>
	<Pine.LNX.4.64.1005041424330.4925@axis700.grange>
	<Pine.LNX.4.64.1005231546310.3571@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1005231546310.3571@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sun, May 23, 2010 at 03:49:47PM +0200, Guennadi Liakhovetski wrote:
> This adds DMA support for the sh7372 sh-mobile ARM core, using the shdma
> dmaengine driver, and uses DMA for the SDHI SD-card controller on this SoC.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> v1 -> v2:
> 
> 1. updated to the current genesis tree HEAD
> 2. adjusted the topic line to match platform preferences
> 3. moved DMA platform devices to the top of the file, so that other 
> devices can reference them.
> 
> Paul, this should be ready for you to merge now.
> 
Applied, thanks.
