From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 12 Feb 2019 07:50:46 +0000
Subject: Re: [PATCH 07/12] dma-mapping: move CONFIG_DMA_CMA to kernel/dma/Kconfig
Message-Id: <20190212075046.GD5924@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20190211133554.30055-1-hch@lst.de>
 <20190211133554.30055-8-hch@lst.de>
In-Reply-To: <20190211133554.30055-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: linux-xtensa@linux-xtensa.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org

On Mon, Feb 11, 2019 at 02:35:49PM +0100, Christoph Hellwig wrote:
> This is where all the related code already lives.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/base/Kconfig | 77 --------------------------------------------
>  kernel/dma/Kconfig   | 77 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 77 insertions(+), 77 deletions(-)

Much nicer, thanks!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
