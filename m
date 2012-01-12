From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 12 Jan 2012 02:06:07 +0000
Subject: Re: [PATCH v4 4/6] dmaengine: shdma: modify the DMAC Address Error registration
Message-Id: <20120112020607.GD7281@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4F0D3A04.4030209@renesas.com>
In-Reply-To: <4F0D3A04.4030209@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jan 11, 2012 at 04:28:04PM +0900, Shimoda, Yoshihiro wrote:
> The USB-DMAC/SUDMAC don't have the interrupt of DMAC Address Error.
> So, only if the IRQ resource has a name of SH_DMA_IRQ_ERROR, the driver
> calls request_irq() for DMAC Address Error.
> 
> This patch is also useful for the generic DMAC which doesn't have
> DMAC Address Error. So, we can get rid of the "CPU_SH4 || ARCH_SHMOBILE"
> ifdefs.
> This patch also changes the IRQF_DISABLED to 0.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  about v4:
>   - use defination macros for IRQ resource
> 
>  drivers/dma/shdma.c |   73 +++++++++++++++++++++++++--------------------------
>  1 files changed, 36 insertions(+), 37 deletions(-)
> 
I do like the idea of the _byname() variants for the channel and error
resource at least, but they are separate patches. I don't particularly
like mixing the channel stuff in with the DMA address error changes,
since they are fundamentally different changes.

If we go with the v3 patches for fixing up the address error case then
you should be able to trivially layer on the channel resource cleanup on
top of that, which in turn will require another string patch for ARM/sh
naming the channel resources explicitly.
