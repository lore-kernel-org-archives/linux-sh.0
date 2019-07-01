From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 01 Jul 2019 17:43:37 +0000
Subject: Re: [PATCH 1/2] sh: stub out pud_page
Message-Id: <20190701174336.GA24848@roeck-us.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20190701151818.32227-1-hch@lst.de>
 <20190701151818.32227-2-hch@lst.de>
In-Reply-To: <20190701151818.32227-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 05:18:17PM +0200, Christoph Hellwig wrote:
> There wasn't any actual need to add a real pud_page, as pud_huge
> always returns false on sh.  Just stub it out to fix the sh3
> compile failure.
> 
> Fixes: 937b4e1d6471 ("sh: add the missing pud_page definition")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/sh/include/asm/pgtable-3level.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/sh/include/asm/pgtable-3level.h b/arch/sh/include/asm/pgtable-3level.h
> index 3c7ff20f3f94..779260b721ca 100644
> --- a/arch/sh/include/asm/pgtable-3level.h
> +++ b/arch/sh/include/asm/pgtable-3level.h
> @@ -37,7 +37,9 @@ static inline unsigned long pud_page_vaddr(pud_t pud)
>  {
>  	return pud_val(pud);
>  }
> -#define pud_page(pud)		pfn_to_page(pud_pfn(pud))
> +
> +/* only used by the stubbed out hugetlb gup code, should never be called */
> +#define pud_page(pud)		NULL
>  
>  #define pmd_index(address)	(((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1))
>  static inline pmd_t *pmd_offset(pud_t *pud, unsigned long address)
> -- 
> 2.20.1
> 
