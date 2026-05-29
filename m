Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47955348C61;
	Fri, 29 May 2026 08:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043334; cv=none; b=GoCLmNOpAP2vTr7dIm2nNowe5aZzrtvMR9LwjkAR84BXOUD8AU51CErgobuUCPlN4MlevCxnajPDzUeaJ3MvlzPQDjckY97YiO1f9gW8HwBKHvBuTh+rxOVnS917kS9Zj0YdbF+6dElhfeJiTj7nTHV4fNVq7Pg6Cnjyp51awGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043334; c=relaxed/simple;
	bh=Z2DB+SWpensbVmMniGSAriQUagND4+fkmRPKJtuCrJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jusYTHDGnhtGV1znbNB3lxms5DxQtVZSsoAOl6grvX6PVanWorcz20FgZryBG5RQGNVxw9s0fAA/tLEj7TFWPSkVbhZohSkkYBhKu9EucDvNWQX3o6gEc6MIDWk8rqu/yHlcTf2ARQBygg9Y4lEpQO3zDu2ZgOycW7AQy/SaOZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YZ2yU0au; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YZ2yU0au"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D07B032E5;
	Fri, 29 May 2026 01:28:47 -0700 (PDT)
Received: from [10.57.91.162] (unknown [10.57.91.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83FD73F632;
	Fri, 29 May 2026 01:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780043332; bh=Z2DB+SWpensbVmMniGSAriQUagND4+fkmRPKJtuCrJg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YZ2yU0auvFCW6viVlHGdHypyUVjfOW4ehecevzbX/zX9r4auet18CifsIvnfhrncg
	 Zh7kDsvXXHA1moz9xnVz2EB1X3ShgEYeP5pwX7OYBplU5hJ8Xiotq7kTPCe0AxPDhS
	 eLs2oxITo6qysD5YozkjUxNKKEiKfXYeDyGoA+bM=
Message-ID: <9566e664-3f54-4bcc-97c8-86e15dc927f2@arm.com>
Date: Fri, 29 May 2026 10:28:44 +0200
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/15] arm64: mm: Map the kernel data/bss read-only in
 the linear map
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
 <20260526175846.2694125-28-ardb+git@google.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260526175846.2694125-28-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/05/2026 19:58, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
>
> On systems where the bootloader adheres to the original arm64 boot
> protocol, the placement of the kernel in the physical address space is
> highly predictable, and this makes the placement of its linear alias in
> the kernel virtual address space equally predictable, given the lack of
> randomization of the linear map.
>
> The linear aliases of the kernel text and rodata regions are already
> mapped read-only, but the kernel data and bss are mapped read-write in
> this region. This is not needed, so map them read-only as well.
>
> Note that the statically allocated kernel page tables do need to be
> modifiable via the linear map, so leave these mapped read-write.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

> ---
>  arch/arm64/mm/mmu.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index b20c76b8381d..e7ca53d20b87 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1138,7 +1138,9 @@ static void __init map_mem(void)
>  {
>  	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
>  	phys_addr_t kernel_start = __pa_symbol(_text);
> -	phys_addr_t kernel_end = __pa_symbol(__init_begin);
> +	phys_addr_t init_begin = __pa_symbol(__init_begin);
> +	phys_addr_t init_end = __pa_symbol(__init_end);
> +	phys_addr_t kernel_end = __pa_symbol(__bss_stop);
>  	phys_addr_t start, end;
>  	int flags = NO_EXEC_MAPPINGS;
>  	u64 i;
> @@ -1171,7 +1173,11 @@ static void __init map_mem(void)
>  	 * of the region accessible to subsystems such as hibernate,
>  	 * but protects it from inadvertent modification or execution.
>  	 */
> -	__map_memblock(kernel_start, kernel_end, PAGE_KERNEL, flags);
> +	__map_memblock(kernel_start, init_begin, PAGE_KERNEL, flags);
> +
> +	/* Map the kernel data/bss so it can be remapped later */
> +	__map_memblock(init_end, kernel_end, pgprot_tagged(PAGE_KERNEL),
> +		       flags);
>  
>  	/* map all the memory banks */
>  	for_each_mem_range(i, &start, &end) {
> @@ -1183,6 +1189,11 @@ static void __init map_mem(void)
>  		__map_memblock(start, end, pgprot_tagged(PAGE_KERNEL),
>  			       flags);
>  	}
> +
> +	/* Map the kernel data/bss read-only in the linear map */
> +	__map_memblock(init_end, kernel_end, PAGE_KERNEL_RO, flags);
> +	flush_tlb_kernel_range((unsigned long)lm_alias(__init_end),
> +			       (unsigned long)lm_alias(__bss_stop));
>  }
>  
>  void mark_rodata_ro(void)
