From: Shuah Khan <shuah.khan@hp.com>
Date: Thu, 15 Nov 2012 17:52:43 +0000
Subject: Re: [PATCH RFT linux-next] sh: dma-mapping: support debug_dma_mapping_error
Message-Id: <1353001963.2532.33.camel@lorien2>
List-Id: <linux-sh.vger.kernel.org>
References: <1351268403.4013.24.camel@lorien2>
In-Reply-To: <1351268403.4013.24.camel@lorien2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lethal@linux-sh.org, m.szyprowski@samsung.com
Cc: kyungmin.park@samsung.com, arnd@arndb.de, andrzej.p@samsung.com, linux-sh@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, shuahkhan@gmail.com

On Fri, 2012-10-26 at 10:20 -0600, Shuah Khan wrote:
> Add support for debug_dma_mapping_error() call to avoid warning from
> debug_dma_unmap() interface when it checks for mapping error checked
> status. Without this patch, device driver failed to check map error
> warning is generated.
> 
> Signed-off-by: Shuah Khan <shuah.khan@hp.com>
> ---
>  arch/sh/include/asm/dma-mapping.h |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/sh/include/asm/dma-mapping.h b/arch/sh/include/asm/dma-mapping.h
> index 8bd965e..b437f2c 100644
> --- a/arch/sh/include/asm/dma-mapping.h
> +++ b/arch/sh/include/asm/dma-mapping.h
> @@ -46,6 +46,7 @@ static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
>  {
>  	struct dma_map_ops *ops = get_dma_ops(dev);
>  
> +	debug_dma_mapping_error(dev, dma_addr);
>  	if (ops->mapping_error)
>  		return ops->mapping_error(dev, dma_addr);
>  

Marek,

This one is for sh to go through tree with the other arch
dma_debug_dma_mapping_error() change patches.

Thanks,
-- Shuah

