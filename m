Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3F82DEA89;
	Fri, 29 May 2026 08:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043268; cv=none; b=jIxxzcjYnoc1bQJ2pdV1T1XY/BI2sBQe4E5fALz3V/6QoPf50tV0qdrNvSS7Jg8d5qA1Rwh4HaxVPinx0i15mi0TLBzQMJrvP+8JVsV5zn4sKcQK5oKozHblQThxcF4l+9F8U7+GXfHByXUnw0ChnMNw3/NBfPoQYdBMojncmFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043268; c=relaxed/simple;
	bh=vGqKwtowp8PNMRvBO7niOdxzr80Af+Ycpil33LSytq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jaUGM2gwtG1Dv19CxjSjHMpITtqBI+JjHCjK8BfY+QCOYcdbFGX83kpukRNo6Sy+xB07ybP476TS4ljSIhYOEDp3UIqaanVcGsGh//yAjy1Z5NLcZf2JJ5ZikbRdhTzLoGsfYVa7qoyj/x/hjkLA5WV/LLcL8ely/Z4jYgMekWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sZLc3D9c; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sZLc3D9c"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2265201B;
	Fri, 29 May 2026 01:27:41 -0700 (PDT)
Received: from [10.57.91.162] (unknown [10.57.91.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F36E3F632;
	Fri, 29 May 2026 01:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780043266; bh=vGqKwtowp8PNMRvBO7niOdxzr80Af+Ycpil33LSytq8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sZLc3D9chfT7SLPciBg3CzU4tEgQd2MgnitSwynPVzMJkASztCzaS8U6eG48NlXUj
	 NjlYJAnCst9GC7POcH6vB4eJQPJcLzWDvzqPHQrCfUmthlePWs5wgYHTV4sko2IV+Z
	 aIr2mh8cXNbx5h2aQZIulPua6F09KFpwA+oUzHNk=
Message-ID: <2a6f9f05-ac57-4ef8-9328-74cc8ccfea16@arm.com>
Date: Fri, 29 May 2026 10:27:37 +0200
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/15] arm64: Move fixmap and kasan page tables to end
 of kernel image
To: Ard Biesheuvel <ardb+git@google.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com,
 mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>,
 Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>,
 linux-mm@kvack.org, linux-hardening@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org
References: <20260526175846.2694125-17-ardb+git@google.com>
 <20260526175846.2694125-26-ardb+git@google.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260526175846.2694125-26-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/05/2026 19:58, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
>
> Move the fixmap and kasan page tables out of the BSS section, and place
> them at the end of the image, right before the init_pg_dir section where
> some of the other statically allocated page tables live.
>
> These page tables are currently the only data objects in vmlinux that
> are meant to be accessed via the kernel image's linear alias, and so
> placing them together allows the remainder of the data/bss section to be
> remapped read-only or unmapped entirely.
>
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/include/asm/mmu.h    | 2 ++
>  arch/arm64/kernel/vmlinux.lds.S | 8 +++++++-
>  arch/arm64/mm/fixmap.c          | 6 +++---
>  arch/arm64/mm/kasan_init.c      | 2 +-
>  4 files changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> index 5e1211c540ab..fb95754f2876 100644
> --- a/arch/arm64/include/asm/mmu.h
> +++ b/arch/arm64/include/asm/mmu.h
> @@ -13,6 +13,8 @@
>  
>  #ifndef __ASSEMBLER__
>  
> +#define __pgtbl_bss __section(".pgdir.bss") __aligned(PAGE_SIZE)
> +
>  #include <linux/refcount.h>
>  #include <asm/cpufeature.h>
>  
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index e1ac876200a3..2b0ebfb30c63 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -349,9 +349,15 @@ SECTIONS
>  	_edata = .;
>  
>  	/* start of zero-init region */
> -	BSS_SECTION(SBSS_ALIGN, 0, 0)
> +	BSS_SECTION(SBSS_ALIGN, 0, PAGE_SIZE)
>  	__pi___bss_start = __bss_start;
>  
> +	/* fixmap BSS starts here - preceding data/BSS is omitted from the linear map */
> +	.pgdir.bss (NOLOAD) : ALIGN(PAGE_SIZE) {

Do we actually need the NOLOAD type here?

Aside from that:

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

> +		*(.pgdir.bss)
> +	}
> +	ASSERT(ADDR(.pgdir.bss) == __bss_stop, ".pgdir.bss must follow BSS")
> +
>  	. = ALIGN(PAGE_SIZE);
>  	__pi_init_pg_dir = .;
>  	. += INIT_DIR_SIZE;
> diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
> index c5c5425791da..1a3bbd67dd76 100644
> --- a/arch/arm64/mm/fixmap.c
> +++ b/arch/arm64/mm/fixmap.c
> @@ -31,9 +31,9 @@ static_assert(NR_BM_PMD_TABLES == 1);
>  
>  #define BM_PTE_TABLE_IDX(addr)	__BM_TABLE_IDX(addr, PMD_SHIFT)
>  
> -static pte_t bm_pte[NR_BM_PTE_TABLES][PTRS_PER_PTE] __page_aligned_bss;
> -static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
> -static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
> +static pte_t bm_pte[NR_BM_PTE_TABLES][PTRS_PER_PTE] __pgtbl_bss;
> +static pmd_t bm_pmd[PTRS_PER_PMD] __pgtbl_bss __maybe_unused;
> +static pud_t bm_pud[PTRS_PER_PUD] __pgtbl_bss __maybe_unused;
>  
>  static inline pte_t *fixmap_pte(unsigned long addr)
>  {
> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> index abeb81bf6ebd..dbf22cae82ee 100644
> --- a/arch/arm64/mm/kasan_init.c
> +++ b/arch/arm64/mm/kasan_init.c
> @@ -214,7 +214,7 @@ asmlinkage void __init kasan_early_init(void)
>  		 * shadow pud_t[]/p4d_t[], which could end up getting corrupted
>  		 * when the linear region is mapped.
>  		 */
> -		static pte_t tbl[PTRS_PER_PTE] __page_aligned_bss;
> +		static pte_t tbl[PTRS_PER_PTE] __pgtbl_bss;
>  		pgd_t *pgdp = pgd_offset_k(KASAN_SHADOW_START);
>  
>  		set_pgd(pgdp, __pgd(__pa_symbol(tbl) | PGD_TYPE_TABLE));
