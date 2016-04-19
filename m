From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Tue, 19 Apr 2016 10:00:38 +0000
Subject: Re: [PATCH] sh: cmpxchg: fix a  bit shift bug in big_endian os
Message-Id: <20160419125927-mutt-send-email-mst@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5715D72D.7060501@linux.vnet.ibm.com>
In-Reply-To: <5715D72D.7060501@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, ysato@users.sourceforge.jp, dalias@libc.org, peterz@infradead.org, linux-sh@vger.kernel.org

On Tue, Apr 19, 2016 at 02:58:53PM +0800, Pan Xinhui wrote:
> From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
> 
> Correct bitoff in big endian OS.
> 
> Fixes: 3226aad81aa6 ("sh: support 1 and 2 byte xchg")
> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>

I would add: current code works correctly for 1 byte but not for 2 bytes.

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  arch/sh/include/asm/cmpxchg-xchg.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sh/include/asm/cmpxchg-xchg.h b/arch/sh/include/asm/cmpxchg-xchg.h
> index 7219719..1e881f5 100644
> --- a/arch/sh/include/asm/cmpxchg-xchg.h
> +++ b/arch/sh/include/asm/cmpxchg-xchg.h
> @@ -21,7 +21,7 @@ static inline u32 __xchg_cmpxchg(volatile void *ptr, u32 x, int size)
>  	int off = (unsigned long)ptr % sizeof(u32);
>  	volatile u32 *p = ptr - off;
>  #ifdef __BIG_ENDIAN
> -	int bitoff = (sizeof(u32) - 1 - off) * BITS_PER_BYTE;
> +	int bitoff = (sizeof(u32) - size - off) * BITS_PER_BYTE;
>  #else
>  	int bitoff = off * BITS_PER_BYTE;
>  #endif
> -- 
> 1.9.1
