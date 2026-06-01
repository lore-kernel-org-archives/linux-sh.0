Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAA43998BA;
	Mon,  1 Jun 2026 10:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780310606; cv=none; b=rFrap4Oj5Q30O/TJM3WzJtIr8QPKOdDfsWM2mZcvRRB7GVOeRPAKrAiHl+a01AZldZzL2X/2ex6w+YyWm2N0SUdsRr881DeUiAMSxM6xPfxia2KPWnTDlGfXqP5d3RTvgleZnDIc4yuh63Ow2ebVJI620cCob4NCGkrT3raPZEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780310606; c=relaxed/simple;
	bh=M9JAdG5DV/7YdqUDPO7phO8QpaY+0Cm/rOxjWCg5rg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n93qFIjtmjFukeiK1IJh/sIxKboiX4Jz75WefXYLBUoN8jLJQk+c35QddpbrJuJiVaJRffO/zCQQhS/lksEto2YKll8OezYqBq0fe8gP50+4XMy936vXxKwMDqFQqC0c1+TtZuVjJrwRDUwjv+Sndl3EzzbEGcBQppt9JjT3UB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=F8Byp1c2; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="F8Byp1c2"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FA3F2696;
	Mon,  1 Jun 2026 03:43:14 -0700 (PDT)
Received: from [10.57.94.8] (unknown [10.57.94.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5FEA3F905;
	Mon,  1 Jun 2026 03:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780310599; bh=M9JAdG5DV/7YdqUDPO7phO8QpaY+0Cm/rOxjWCg5rg4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F8Byp1c2fESYbQpuqvr4AlWD6wXTjIviMOELOHMH97zUW2cYZrKpsdEn1LfcD6kXz
	 UJIy+EgpBQi+xkE4miNGCmjzdHMfaUipsb7TkmxOblXjY1f60mslkBJ2kiKuhbuSA2
	 1yYR+XdZ5mwIByNNWcqVdJfgqcvs2DD6HSpBSnVM=
Message-ID: <c0eb50f2-b0da-4d5e-9a20-09c2391cd3f9@arm.com>
Date: Mon, 1 Jun 2026 12:43:12 +0200
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/15] arm64: mm: Don't abuse memblock NOMAP to check
 for overlaps
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
References: <20260529150150.1670604-17-ardb+git@google.com>
 <20260529150150.1670604-27-ardb+git@google.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260529150150.1670604-27-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/05/2026 17:02, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
>
> Now that the linear region mapping routines respect existing table
> mappings and contiguous block and page mappings, it is no longer needed
> to fiddle with the memblock tables to set and clear the NOMAP attribute
> in order to omit text and rodata when creating the linear map.
>
> Instead, map the kernel text and rodata alias first with the desired
> initial attributes and granularity, so that the loop iterating over the
> memblocks will not remap it in a manner that prevents it from being
> remapped with updated attributes later.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

> ---
>  arch/arm64/mm/mmu.c | 26 ++++++++------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 971996e46fd1..dcfca5667e5c 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1164,12 +1164,17 @@ static void __init map_mem(void)
>  		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>  
>  	/*
> -	 * Take care not to create a writable alias for the
> -	 * read-only text and rodata sections of the kernel image.
> -	 * So temporarily mark them as NOMAP to skip mappings in
> -	 * the following for-loop
> +	 * Map the linear alias of the [_text, __init_begin) interval first
> +	 * so that its write permissions can be removed later without the need
> +	 * to split any block mappings created by the loop below.
> +	 *
> +	 * Write permissions are needed for alternatives patching, and will be
> +	 * removed later by mark_linear_text_alias_ro() above. This makes the
> +	 * contents of the region accessible to subsystems such as hibernate,
> +	 * but protects it from inadvertent modification or execution.
>  	 */
> -	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
> +	__map_memblock(kernel_start, kernel_end, pgprot_tagged(PAGE_KERNEL),
> +		       flags);
>  
>  	/* map all the memory banks */
>  	for_each_mem_range(i, &start, &end) {
> @@ -1181,17 +1186,6 @@ static void __init map_mem(void)
>  		__map_memblock(start, end, pgprot_tagged(PAGE_KERNEL),
>  			       flags);
>  	}
> -
> -	/*
> -	 * Map the linear alias of the [_text, __init_begin) interval
> -	 * as non-executable now, and remove the write permission in
> -	 * mark_linear_text_alias_ro() below (which will be called after
> -	 * alternative patching has completed). This makes the contents
> -	 * of the region accessible to subsystems such as hibernate,
> -	 * but protects it from inadvertent modification or execution.
> -	 */
> -	__map_memblock(kernel_start, kernel_end, PAGE_KERNEL, 0);
> -	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
>  }
>  
>  void mark_rodata_ro(void)
