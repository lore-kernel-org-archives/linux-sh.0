From: Anshuman Khandual <anshuman.khandual@arm.com>
Date: Mon, 14 Jan 2019 04:40:14 +0000
Subject: Re: [PATCH] mm: Introduce GFP_PGTABLE
Message-Id: <48f81a76-2b2d-5060-d9bc-c42d5b5975c3@arm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1547288798-10243-1-git-send-email-anshuman.khandual@arm.com>
 <20190112121230.GQ6310@bombadil.infradead.org>
 <ddd59fdc-3d8f-4015-e851-e7f099193a1b@c-s.fr>
 <20190112154944.GT6310@bombadil.infradead.org>
In-Reply-To: <20190112154944.GT6310@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Wilcox <willy@infradead.org>, Christophe Leroy <christophe.leroy@c-s.fr>
Cc: mhocko@suse.com, linux-sh@vger.kernel.org, peterz@infradead.org, catalin.marinas@arm.com, dave.hansen@linux.intel.com, will.deacon@arm.com, linux-mm@kvack.org, kvmarm@lists.cs.columbia.edu, aneesh.kumar@linux.ibm.com, linux@armlinux.org.uk, mingo@redhat.com, vbabka@suse.cz, rientjes@google.com, marc.zyngier@arm.com, rppt@linux.vnet.ibm.com, shakeelb@google.com, kirill@shutemov.name, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, ard.biesheuvel@linaro.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, robin.murphy@arm.com



On 01/12/2019 09:19 PM, Matthew Wilcox wrote:
> On Sat, Jan 12, 2019 at 02:49:29PM +0100, Christophe Leroy wrote:
>> As far as I can see,
>>
>> #define GFP_KERNEL_ACCOUNT (GFP_KERNEL | __GFP_ACCOUNT)
>>
>> So what's the difference between:
>>
>> (GFP_KERNEL_ACCOUNT | __GFP_ZERO) & ~__GFP_ACCOUNT
>>
>> and
>>
>> (GFP_KERNEL | __GFP_ZERO) & ~__GFP_ACCOUNT
> 
> Nothing.  But there's a huge difference in the other parts of that same
> file where GFP_ACCOUNT is _not_ used.
> 
> I think this unification is too small to bother with.  Something I've
> had on my todo list for some time and have not done anything about
> is to actually unify all of the architecture pte/pmd/... allocations.
> There are tricks some architectures use that others would benefit from.

Sure. Could you please elaborate on this ?

Invariably all kernel pgtable page allocations should use GFP_PGTABLE and
all user page table allocation should use (GFP_PGTABLE | __GFP_ACCOUNT).
Ideally there should be default generic functions user_pgtable_gfp() or
kernel_pgtable_gfp() returning these values. Overrides can be provided if
an arch still wants some more control.
