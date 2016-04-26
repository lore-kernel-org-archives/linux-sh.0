From: Rich Felker <dalias@libc.org>
Date: Tue, 26 Apr 2016 01:39:13 +0000
Subject: Re: [PATCH V2]sh: cmpxchg: fix a  bit shift bug in big_endian os
Message-Id: <20160426013913.GJ21636@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <5715D72D.7060501@linux.vnet.ibm.com>
 <5717247C.7080002@linux.vnet.ibm.com>
In-Reply-To: <5717247C.7080002@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, ysato@users.sourceforge.jp, mst@redhat.com, peterz@infradead.org, linux-sh@vger.kernel.org

On Wed, Apr 20, 2016 at 02:41:00PM +0800, Pan Xinhui wrote:
> From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
> 
> Correct bitoff in big endian OS.
> Current code works correctly for 1 byte but not for 2 bytes.
> 
> Fixes: 3226aad81aa6 ("sh: support 1 and 2 byte xchg")
> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> changes from V1:
> 	just add some patch comments. no code changes.

Looks good. Are you aware of any code affected by this bug that would
make it a regression in 4.6? If so I'll try to get this in now as a
bugfix; otherwise I'll include it in stuff for 4.7.

Rich


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
