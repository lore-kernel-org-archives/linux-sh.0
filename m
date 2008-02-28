From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 28 Feb 2008 10:04:20 +0000
Subject: Re: TLB reset on SH7780
Message-Id: <20080228100420.GA27540@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080228.184540.68563408.saito@densan.co.jp>
In-Reply-To: <20080228.184540.68563408.saito@densan.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Feb 28, 2008 at 06:45:40PM +0900, Hideo Saito wrote:
> Hi Paul,
> 
> When /dev/mem is accessed as follows, it causes TLB reset on SH7780, because our physical memory is mapped from 0x08000000, the PMB entry does not map all of the P1 area.
> 
> # dd if=/dev/mem <return>
> 
> How about following changes though the code is in the machine independent part?
> 
> --- ./drivers/char/mem.c.org	2008-01-25 07:58:37.000000000 +0900
> +++ ./drivers/char/mem.c	2008-02-28 17:56:11.000000000 +0900
> @@ -91,17 +91,18 @@ static inline int uncached_access(struct
>  		return 1;
>  	return addr >= __pa(high_memory);
>  #endif
>  }
>  
>  #ifndef ARCH_HAS_VALID_PHYS_ADDR_RANGE
>  static inline int valid_phys_addr_range(unsigned long addr, size_t count)
>  {
> -	if (addr + count > __pa(high_memory))
> +	if (addr < __pa(high_memory - (num_physpages << PAGE_SHIFT)) ||
> +	    addr + count > __pa(high_memory))
>  		return 0;
>  
>  	return 1;
>  }
>  
Given that this is under an ARCH_HAS_VALID_PHYS_ADDR_RANGE check, how
about just defining this and providing a custom implementation?
