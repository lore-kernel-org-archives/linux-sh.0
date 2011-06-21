From: Simon Horman <horms@verge.net.au>
Date: Tue, 21 Jun 2011 05:46:08 +0000
Subject: Re: Crash dumping on sh7372 Mackerel
Message-Id: <20110621054602.GA14369@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <BANLkTi=DgEtZwiigMvm4XptoB3uKqpXvLA@mail.gmail.com>
In-Reply-To: <BANLkTi=DgEtZwiigMvm4XptoB3uKqpXvLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jun 20, 2011 at 10:07:40PM +0900, Magnus Damm wrote:

[snip]

> Linux-3.0-rc or more exactly linux-2.6 git
> 95d17b7168eacf1f97f2d1d087ebe7a648c30051 is known to be working, but
> the attached prototype patch
> "linux-3.0-arm-crash-copy-oldmem-page-ioremap-fix-20110618.patch" is
> needed to properly access the /proc/vmcore file. Build the kernel as a
> regular uImage. This image is referred to as uImage-crash.

[snip]

Hi Magnus,

do you have any plans to submit this patch for inclusion upstream?

> From: Magnus Damm <damm@opensource.se>
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  arch/arm/kernel/crash_dump.c |   14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> --- 0001/arch/arm/kernel/crash_dump.c
> +++ work/arch/arm/kernel/crash_dump.c	2011-06-18 20:59:49.000000000 +0900
> @@ -39,9 +39,13 @@ ssize_t copy_oldmem_page(unsigned long p
>  	if (!csize)
>  		return 0;
>  
> -	vaddr = ioremap(pfn << PAGE_SHIFT, PAGE_SIZE);
> -	if (!vaddr)
> -		return -ENOMEM;
> +	if (pfn_valid(pfn)) {
> +		vaddr = phys_to_virt(pfn << PAGE_SHIFT);
> +	} else {
> +		vaddr = ioremap(pfn << PAGE_SHIFT, PAGE_SIZE);
> +		if (!vaddr)
> +			return -ENOMEM;
> +	}
>  
>  	if (userbuf) {
>  		if (copy_to_user(buf, vaddr + offset, csize)) {
> @@ -52,6 +56,8 @@ ssize_t copy_oldmem_page(unsigned long p
>  		memcpy(buf, vaddr + offset, csize);
>  	}
>  
> -	iounmap(vaddr);
> +	if (!pfn_valid(pfn))
> +		iounmap(vaddr);
> +
>  	return csize;
>  }

