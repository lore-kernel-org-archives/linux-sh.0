From: Greg KH <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2015 16:19:02 +0000
Subject: Re: [PATCH/RFC] usb: gadget: udc: core: Fix argument of dma_map_single for IOMMU
Message-Id: <20150713161902.GA21884@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1436778605-5576-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1436778605-5576-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jul 13, 2015 at 06:10:05PM +0900, Yoshihiro Shimoda wrote:
> The dma_map_single and dma_unmap_single should set "gadget->dev.parent"
> instead of "&gadget->dev" in the first argument because the parent has
> a udc controller's device pointer.
> Otherwise, iommu functions are not called in ARM environment.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  This patch is based on the Felipe's usb.git / testing/next branch.
>  commit id = 298623983e74d935fc241d0eb1d0740cf4c32599

Why send something that has already been accepted into Felipe's tree?

