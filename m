From: Alex Ghiti <alex@ghiti.fr>
Date: Tue, 05 Mar 2019 06:57:23 +0000
Subject: Re: [PATCH v4 1/4] sh: Advertise gigantic page support
Message-Id: <334697c3-1f56-bf71-41fe-49c68980c991@ghiti.fr>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 2/28/19 1:36 AM, Alexandre Ghiti wrote:
> sh actually supports gigantic pages and selecting
> ARCH_HAS_GIGANTIC_PAGE allows it to allocate and free
> gigantic pages at runtime.
>
> At least sdk7786_defconfig exposes such a configuration with
> huge pages of 64MB, pages of 4KB and MAX_ORDER = 11:
> HPAGE_SHIFT (26) - PAGE_SHIFT (12) = 14 >= MAX_ORDER (11)
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>   arch/sh/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index a9c36f95744a..299a17bed67c 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -53,6 +53,7 @@ config SUPERH
>   	select HAVE_FUTEX_CMPXCHG if FUTEX
>   	select HAVE_NMI
>   	select NEED_SG_DMA_LENGTH
> +	select ARCH_HAS_GIGANTIC_PAGE if (MEMORY_ISOLATION && COMPACTION) || CMA
>   
>   	help
>   	  The SuperH is a RISC processor targeted for use in embedded systems

Hi Yoshinori, Rich,

Do you have any remark regarding this patch before I send a v5 ?

Thanks,

Alex
