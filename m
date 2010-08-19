From: Greg KH <gregkh@suse.de>
Date: Thu, 19 Aug 2010 15:35:27 +0000
Subject: Re: [PATCH 3/5] DMA: reduce the number of memory allocations
Message-Id: <20100819153527.GE2985@suse.de>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1008191623580.26145@axis700.grange>
	<Pine.LNX.4.64.1008191634160.26145@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1008191634160.26145@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Aug 19, 2010 at 04:40:15PM +0200, Guennadi Liakhovetski wrote:
> Allocate the bitmap in dma_declare_coherent_memory() together with the struct
> dma_coherent_mem object.

You describe what you did, but _why_ are you doing it?

thanks,

greg k-h
