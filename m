From: Anshuman Khandual <anshuman.khandual@arm.com>
Date: Sat, 12 Jan 2019 12:56:15 +0000
Subject: Re: [PATCH] mm: Introduce GFP_PGTABLE
Message-Id: <9dd9a8ef-8db8-891c-79a9-270ab033037c@arm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1547288798-10243-1-git-send-email-anshuman.khandual@arm.com>
 <20190112121230.GQ6310@bombadil.infradead.org>
In-Reply-To: <20190112121230.GQ6310@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Wilcox <willy@infradead.org>
Cc: mark.rutland@arm.com, mhocko@suse.com, linux-sh@vger.kernel.org, peterz@infradead.org, catalin.marinas@arm.com, dave.hansen@linux.intel.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, kvmarm@lists.cs.columbia.edu, mpe@ellerman.id.au, linux@armlinux.org.uk, mingo@redhat.com, vbabka@suse.cz, rientjes@google.com, marc.zyngier@arm.com, rppt@linux.vnet.ibm.com, shakeelb@google.com, kirill@shutemov.name, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, ard.biesheuvel@linaro.org, robin.murphy@arm.com, steve.capper@arm.com, christoffer.dall@arm.com, james.morse@arm.com, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org



On 01/12/2019 05:42 PM, Matthew Wilcox wrote:
> On Sat, Jan 12, 2019 at 03:56:38PM +0530, Anshuman Khandual wrote:
>> All architectures have been defining their own PGALLOC_GFP as (GFP_KERNEL |
>> __GFP_ZERO) and using it for allocating page table pages.
> 
> Except that's not true.
> 
>> +++ b/arch/x86/mm/pgtable.c
>> @@ -13,19 +13,17 @@ phys_addr_t physical_mask __ro_after_init = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
>>  EXPORT_SYMBOL(physical_mask);
>>  #endif
>>  
>> -#define PGALLOC_GFP (GFP_KERNEL_ACCOUNT | __GFP_ZERO)
>> -
>>  #ifdef CONFIG_HIGHPTE
> 
> ...
> 
>>  pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>>  {
>> -	return (pte_t *)__get_free_page(PGALLOC_GFP & ~__GFP_ACCOUNT);
>> +	return (pte_t *)__get_free_page(GFP_PGTABLE & ~__GFP_ACCOUNT);
>>  }
> 
> I think x86 was the only odd one out here, but you'll need to try again ...

IIUC the user page table pages need __GFP_ACCOUNT not the kernel ones. Hence
in the above function it clears out __GFP_ACCOUNT for kernel page table page
allocations but where as by default it has got __GFP_ACCOUNT which would be
used for user page tables. Instead we can make X86 user allocations add
__GFP_ACCOUNT (like other archs) to generic GFP_PGTABLE when ever required.
