From: Will Deacon <will.deacon@arm.com>
Date: Mon, 29 Oct 2018 17:53:04 +0000
Subject: Re: [PATCH v2 1/6] mm: Introduce common STRUCT_PAGE_MAX_SHIFT define
Message-Id: <20181029175303.GB16739@arm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20181015175702.9036-1-logang@deltatee.com>
 <20181015175702.9036-2-logang@deltatee.com>
In-Reply-To: <20181015175702.9036-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Logan,

On Mon, Oct 15, 2018 at 11:56:57AM -0600, Logan Gunthorpe wrote:
> This define is used by arm64 to calculate the size of the vmemmap
> region. It is defined as the log2 of the upper bound on the size
> of a struct page.
> 
> We move it into mm_types.h so it can be defined properly instead of
> set and checked with a build bug. This also allows us to use the same
> define for riscv.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm64/include/asm/memory.h | 9 ---------
>  arch/arm64/mm/init.c            | 8 --------
>  include/asm-generic/fixmap.h    | 1 +
>  include/linux/mm_types.h        | 5 +++++
>  4 files changed, 6 insertions(+), 17 deletions(-)

This looks like a really good cleanup to me, thanks:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
