From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 02 Jun 2011 05:47:39 +0000
Subject: Re: [PATCH] dmaengine: shdma: fix a regression: initialise DMA channels for memcpy
Message-Id: <20110602054739.GC6087@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, May 31, 2011 at 11:25:16AM +0200, Guennadi Liakhovetski wrote:
> A recent patch has introduced a regression, where repeating a memcpy
> DMA test with shdma module unloading between them skips the DMA channel
> configuration. Fix this regression by always configuring the channel
> during its allocation.

On Wed, Jun 01, 2011 at 09:32:07AM +0200, Guennadi Liakhovetski wrote:
> These definitions are needed to let the runtime PM subsystem turn off
> DMAC clocks, when it is suspended by the driver.

Both applied, thanks.
