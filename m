From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 10 Jan 2012 07:18:06 +0000
Subject: Re: [PATCH v3 1/3] dmaengine: shdma: modify the DMAC Address Error registration
Message-Id: <20120110071805.GA24305@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4F0BDCD5.9020603@renesas.com>
In-Reply-To: <4F0BDCD5.9020603@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jan 10, 2012 at 03:38:13PM +0900, Shimoda, Yoshihiro wrote:
> The USB-DMAC/SUDMAC don't have the interrupt of DMAC Address Error.
> So, only when the resource has a name and it is "error_irq", the driver
> calls request_irq() for DMAC Address Error.
> 
> This patch is also useful for the generic DMAC which doesn't have
> DMAC Address Error. So, we can get rid of the "CPU_SH4 || ARCH_SHMOBILE"
> ifdefs.
> This patch also changes the IRQF_DISABLED to 0.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  about v3:
>   - changes the IRQF_DISABLED to 0.
> 
>  drivers/dma/shdma.c |   78 ++++++++++++++++++++++++++-------------------------
>  1 files changed, 40 insertions(+), 38 deletions(-)
> 
The updated patches look fine to me, thanks for fixing them up. I'll let
Vinod pick them up.

Acked-by: Paul Mundt <lethal@linux-sh.org>
