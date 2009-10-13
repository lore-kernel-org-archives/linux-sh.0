From: Valentin R Sitsikov <valentin.sitdikov@siemens.com>
Date: Tue, 13 Oct 2009 08:13:52 +0000
Subject: Re: Possibly icahe/dcache synchronization problem on sh7785lcr
Message-Id: <4AD436C0.3050409@siemens.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4ACF32C2.9010501@siemens.com>
In-Reply-To: <4ACF32C2.9010501@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Paul.
Thanks a lot i will try it.
I am a little bit confused about 4096.  Page size  is not always  equal 
to 4096.
In my particular case page size is equal to 8192.
How do you think if it might be a problem ?

Best regards,
Valentin.

Paul Mundt wrote:
> On Fri, Oct 09, 2009 at 04:55:30PM +0400, Valentin R Sitsikov wrote:
>   
>> During execution of user space application form time to time
>> invalid instruction or bus error occured or even init dies during sturtup.
>> The situation became more stable if i use the following code:
>> static void sh4_flush_icache_page(void *arg)
>> {
>>         flush_dcache_all();
>>         flush_icache_all();
>> }
>> ...
>> local_flush_icache_page         = sh4_flush_icache_page;
>> This is done because previous experience  with 2.6.20 on sdk7785.
>> There was the similar problems (at least it looks like).
>>
>>     
> flush_icache_page() is a legacy interface, all of which can be handled in
> flush_dcache_page()/update_mmu_cache() (well, __update_cache() now) these
> days. I think you've hit a case where we need to throw in an I-cache
> invalidation in. Can you give the following patch a try and see how that
> behaves (while leaving local_flush_icache_page unset)?
>
> ---
>
> diff --git a/arch/sh/mm/cache-sh4.c b/arch/sh/mm/cache-sh4.c
> index a98c7d8..74b44ab 100644
> --- a/arch/sh/mm/cache-sh4.c
> +++ b/arch/sh/mm/cache-sh4.c
> @@ -115,9 +115,9 @@ static inline void flush_cache_4096(unsigned long start,
>  static void sh4_flush_dcache_page(void *arg)
>  {
>  	struct page *page = arg;
> -#ifndef CONFIG_SMP
>  	struct address_space *mapping = page_mapping(page);
>  
> +#ifndef CONFIG_SMP
>  	if (mapping && !mapping_mapped(mapping))
>  		set_bit(PG_dcache_dirty, &page->flags);
>  	else
> @@ -131,6 +131,8 @@ static void sh4_flush_dcache_page(void *arg)
>  		n = boot_cpu_data.dcache.n_aliases;
>  		for (i = 0; i < n; i++, addr += 4096)
>  			flush_cache_4096(addr, phys);
> +
> +		flush_icache_all();
>  	}
>  
>  	wmb();
>   

