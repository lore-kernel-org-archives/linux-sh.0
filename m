From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 27 Dec 2007 22:24:09 +0000
Subject: Re: Cache coherency problem in do_execve while passing arguments
Message-Id: <20071227222409.GB26382@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4773DD12.9000001@gmail.com>
In-Reply-To: <4773DD12.9000001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Dec 27, 2007 at 06:12:50PM +0100, Carmelo Amoroso wrote:
> The following patch into cacheflush.h solves the problem and the test ran 
> for 2 days without problem
> 
> I'm not sure if this fix should be applied to the common header 
> include/asm-sh/cacheflush.h (being valid for all
> sh subarch) or to the sh4 specific one include/asm-sh/cpu-sh4/cacheflush.h
> 
> +#define ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
> +static inline void flush_kernel_dcache_page(struct page *page)
> +{
> +   flush_dcache_page(page);
> +}
> +
> 
> Your comments are welcome
> 
This can be done generically, since the same problem is going to apply to
SH7705, and flush_dcache_page() is a nop for the platforms where we have
physical caches. I'll queue the patch up for 2.6.24, thanks.
