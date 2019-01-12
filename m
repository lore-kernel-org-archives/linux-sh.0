From: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Sat, 12 Jan 2019 13:49:29 +0000
Subject: Re: [PATCH] mm: Introduce GFP_PGTABLE
Message-Id: <ddd59fdc-3d8f-4015-e851-e7f099193a1b@c-s.fr>
List-Id: <linux-sh.vger.kernel.org>
References: <1547288798-10243-1-git-send-email-anshuman.khandual@arm.com>
 <20190112121230.GQ6310@bombadil.infradead.org>
In-Reply-To: <20190112121230.GQ6310@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Matthew Wilcox <willy@infradead.org>, Anshuman Khandual <anshuman.khandual@arm.com>
Cc: mark.rutland@arm.com, mhocko@suse.com, linux-sh@vger.kernel.org, peterz@infradead.org, catalin.marinas@arm.com, dave.hansen@linux.intel.com, will.deacon@arm.com, christoffer.dall@arm.com, linux-mm@kvack.org, kvmarm@lists.cs.columbia.edu, aneesh.kumar@linux.ibm.com, linux@armlinux.org.uk, mingo@redhat.com, vbabka@suse.cz, rientjes@google.com, marc.zyngier@arm.com, rppt@linux.vnet.ibm.com, shakeelb@google.com, kirill@shutemov.name, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, ard.biesheuvel@linaro.org, linuxppc-dev@lists.ozlabs.org, steve.capper@arm.com, linux-kernel@vger.kernel.org, james.morse@arm.com, akpm@linux-foundation.org, robin.murphy@arm.com



Le 12/01/2019 à 13:12, Matthew Wilcox a écrit :
> On Sat, Jan 12, 2019 at 03:56:38PM +0530, Anshuman Khandual wrote:
>> All architectures have been defining their own PGALLOC_GFP as (GFP_KERNEL |
>> __GFP_ZERO) and using it for allocating page table pages.
> 
> Except that's not true.
> 
>> +++ b/arch/x86/mm/pgtable.c
>> @@ -13,19 +13,17 @@ phys_addr_t physical_mask __ro_after_init = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
>>   EXPORT_SYMBOL(physical_mask);
>>   #endif
>>   
>> -#define PGALLOC_GFP (GFP_KERNEL_ACCOUNT | __GFP_ZERO)
>> -
>>   #ifdef CONFIG_HIGHPTE
> 
> ...
> 
>>   pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>>   {
>> -	return (pte_t *)__get_free_page(PGALLOC_GFP & ~__GFP_ACCOUNT);
>> +	return (pte_t *)__get_free_page(GFP_PGTABLE & ~__GFP_ACCOUNT);
>>   }

As far as I can see,

#define GFP_KERNEL_ACCOUNT (GFP_KERNEL | __GFP_ACCOUNT)

So what's the difference between:

(GFP_KERNEL_ACCOUNT | __GFP_ZERO) & ~__GFP_ACCOUNT

and

(GFP_KERNEL | __GFP_ZERO) & ~__GFP_ACCOUNT

Christophe

> 
> I think x86 was the only odd one out here, but you'll need to try again ...
> 
