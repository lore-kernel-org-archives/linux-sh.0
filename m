Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CF430C172
	for <linux-sh@vger.kernel.org>; Wed,  3 Jun 2026 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509796; cv=none; b=YFKEXrm66kWynDhXBAfpZvg6D1abpz+fEFxLXcAkB+gvNlM2Y8S2pG0xcQ7zXELat2O7er+ioxL2mLjTwgGG3izZObxE0KFGz+YEItwBsvAZrCfyiAOyFMr+A18wq4DDaruLlAeCJGKIu/EfDoGeWi/PoVpGznLMHZFQRfdk5gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509796; c=relaxed/simple;
	bh=ySf7/WNEBUjqbEjsFjmTLnMeckZ/xsYDfJ4orOwY9/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKQAtWEW8svz58VklImWVflJaq6dxImMZqPlNIp3Njh5UpitWXZi2ozHxLOod/mNzZVSH4hTgUHRbxTlYvwQQOdb7qIXnb/wP0/4FiWfz/4wlCoVVNywOt5dbYL0rKQ90LFAyKjfqUS3jWxhWpLRVS9LiU0wTsfgFCauIqhYLtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Htci5tqQ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Htci5tqQ"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36d6bb38b44so2907039a91.0
        for <linux-sh@vger.kernel.org>; Wed, 03 Jun 2026 11:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780509794; x=1781114594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hrbiXUlsk45eySsbtONrBewq/djyZBhyYFXfnKgyx7M=;
        b=Htci5tqQrTB/Z8hUDrLhWB5b7/BqEiftHeOiy5uNda6fkwO2u8z8ZaamNC5Mm7+Vow
         NLBO92mwqGgfMpQuNgQqtMTbNXj81AjCOeJGWJ/tf6fXM0D/s6d0zyCQxLSIs8r5FKzN
         XsNh7Fq+58wiND8z7eec658vknoMLESs3/pTUIUTrKLn2f3TqyGs7JNYW5V5OhagIR5+
         0HNQxj32BJ8zqfH96GXVXiYSCQB6V1yFf4f5vbIxn+7v+0H9XzcSTTWLNheBryWIk0FE
         8oR4ebTLrMvrVUM+a5CvpgWdAxTgTuQ09Hmekb0ZkI/Qy3mRzcL7YKziU8BTZDVRaxvE
         /2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780509794; x=1781114594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrbiXUlsk45eySsbtONrBewq/djyZBhyYFXfnKgyx7M=;
        b=IvWUAeOJBvHVp7MKCbh0W7FFj65Rtc7QoVYKwJWD7kLRvB6NOKZi6Wln11DItB6xzo
         McJ80dkTLYLvjVNbaWvHMYtuT+TehqriLFO0+6BHNzctTH3T6sq2E4F/ZHQz7kgwZJrc
         s+nziO7rmPSmp1PHwnJvE/1CSVNezWaUZhb3a7G9IpkaSRSX7w2n7OcTHn5KdLBvAJT9
         3LoYaevruO3bcv+eNZUvjeWoO7OS4b8HEasuAacdOJVld7eLtDbQKwZw39ZZjbCjHu6z
         XH5cRe736cO8eWRZdaKUjyLf7h3JRqpRTLH5DSsdlAcjbkaCWmmFhGOPeziX2AS3dV9D
         Sp9A==
X-Forwarded-Encrypted: i=1; AFNElJ/lL7V/pVTToVbgZQOkdPy4aCFM1XTGIeudL/EZLg6kAiiP18KWB9cegTiPbNveZzNLo85JGfKL4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZhwhO1378Q6aE4u+htW5gyiRXJ3fL9hyXGNxymyViQeUBQ6PB
	jEK1Fz/WeBP3UkiQz+59wHquM6C6XowyGDyK8cBBQNYQNH+eP+aKeEae
X-Gm-Gg: Acq92OFxdp4T9+Pe796eUVGXaALGGDjB9WG5/S/ZXTK5kPqLd3giq0AZqMj9aViDCx/
	dwvKYd/cgK3bCE8dQa/X/EySL61PGClpLoHWbg8vwyM2+RvPeudX2/7iK4rAhTmGjIxK5fPdPoc
	pgXbv9CkFwFhMblv0oJ79qeqeLrpQc1MP1sED8U8sZzGVj0KPdgYb7E/bcyDZx3A718TS9NKH+Y
	LvxHoUC7fVrOXva29XbGhG3kmW4V4YC9hzqYzs4Fic72P2U09EUm0o7aRAwj+wRtiUhLzeuCK7Q
	N1IPS2YLLJTIYS0D77Stzfdsn0/uIF8rKEGyyG0eYKog7VRNpZXX3KtDY52D5TUktJpbjPqf+IQ
	6gewsYEEx0azoQ700bDdbHEMGi1ADgenH+UHgOfiskuWgXP5FpuDQ+gt4SqUEWrLrCyTQkbc+u4
	DhtKbi8msGGwzmN0KHuTr5EzDko1MaOI1AQp/46rGYp7IXAC8cM5oerfsnNdI8yTeYSt/kkRU8U
	auRmPqmjQ==
X-Received: by 2002:a17:90b:3f90:b0:367:db13:aca6 with SMTP id 98e67ed59e1d1-36e319bff94mr4221552a91.26.1780509794151;
        Wed, 03 Jun 2026 11:03:14 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6d1fec5asm331867a91.10.2026.06.03.11.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 11:03:13 -0700 (PDT)
Date: Wed, 3 Jun 2026 23:33:03 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com, 
	Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>, 
	Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Jann Horn <jannh@google.com>, linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: Re: [PATCH v7 11/15] powerpc/code-patching: Avoid r/w mapping of the
 zero page
Message-ID: <aiBsMg9WdDy-dRk_@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260529150150.1670604-17-ardb+git@google.com>
 <20260529150150.1670604-28-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529150150.1670604-28-ardb+git@google.com>

On Fri, May 29, 2026 at 05:02:02PM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The only remaining use of map_patch_area() is mapping the zero page, and
> immediately unmapping it again so that the intermediate page table
> levels are all guaranteed to be populated.
> 
> The use of the zero page here is completely arbitrary, and not harmful
> per se, but currently, it creates a writable mapping, and does so in a
> manner that requires that the empty_zero_page[] symbol is not
> const-qualified.
> 
> Given that this is about to change, and that map_patch_area() now never
> maps anything other than the zero page, let's simplify the code and
> - remove the helpers and call [un]map_kernel_page() directly
> - take the PA of empty_zero_page directly
> - create a read-only temporary mapping.
> 
> This allows empty_zero_page[] to be repainted as const u8[] in a
> subsequent patch, without making substantial changes to this code
> patching logic.
> 
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
> Link: https://lore.kernel.org/all/20260520085423.485402-1-ardb@kernel.org/
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/powerpc/lib/code-patching.c | 52 +-------------------
>  1 file changed, 2 insertions(+), 50 deletions(-)
> 
> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
> index f84e0337cc02..44ff9f684bef 100644
> --- a/arch/powerpc/lib/code-patching.c
> +++ b/arch/powerpc/lib/code-patching.c
> @@ -60,9 +60,6 @@ struct patch_context {
>  
>  static DEFINE_PER_CPU(struct patch_context, cpu_patching_context);
>  
> -static int map_patch_area(void *addr, unsigned long text_poke_addr);
> -static void unmap_patch_area(unsigned long addr);
> -
>  static bool mm_patch_enabled(void)
>  {
>  	return IS_ENABLED(CONFIG_SMP) && radix_enabled();
> @@ -117,11 +114,11 @@ static int text_area_cpu_up(unsigned int cpu)
>  
>  	// Map/unmap the area to ensure all page tables are pre-allocated
>  	addr = (unsigned long)area->addr;
> -	err = map_patch_area(empty_zero_page, addr);
> +	err = map_kernel_page(addr, __pa_symbol(empty_zero_page), PAGE_KERNEL_RO);
>  	if (err)
>  		return err;
>  
> -	unmap_patch_area(addr);
> +	unmap_kernel_page(addr);
>  
>  	this_cpu_write(cpu_patching_context.area, area);
>  	this_cpu_write(cpu_patching_context.addr, addr);
> @@ -233,51 +230,6 @@ static unsigned long get_patch_pfn(void *addr)
>  		return __pa_symbol(addr) >> PAGE_SHIFT;
>  }
>  
> -/*
> - * This can be called for kernel text or a module.
> - */
> -static int map_patch_area(void *addr, unsigned long text_poke_addr)
> -{
> -	unsigned long pfn = get_patch_pfn(addr);
> -
> -	return map_kernel_page(text_poke_addr, (pfn << PAGE_SHIFT), PAGE_KERNEL);
> -}
> -
> -static void unmap_patch_area(unsigned long addr)
> -{
> -	pte_t *ptep;
> -	pmd_t *pmdp;
> -	pud_t *pudp;
> -	p4d_t *p4dp;
> -	pgd_t *pgdp;
> -
> -	pgdp = pgd_offset_k(addr);
> -	if (WARN_ON(pgd_none(*pgdp)))
> -		return;
> -
> -	p4dp = p4d_offset(pgdp, addr);
> -	if (WARN_ON(p4d_none(*p4dp)))
> -		return;
> -
> -	pudp = pud_offset(p4dp, addr);
> -	if (WARN_ON(pud_none(*pudp)))
> -		return;
> -
> -	pmdp = pmd_offset(pudp, addr);
> -	if (WARN_ON(pmd_none(*pmdp)))
> -		return;
> -
> -	ptep = pte_offset_kernel(pmdp, addr);
> -	if (WARN_ON(pte_none(*ptep)))
> -		return;
> -
> -	/*
> -	 * In hash, pte_clear flushes the tlb, in radix, we have to
> -	 */
> -	pte_clear(&init_mm, addr, ptep);
> -	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> -}
> -
>  static int __do_patch_mem_mm(void *addr, unsigned long val, bool is_dword)
>  {
>  	int err;
> -- 
> 2.54.0.823.g6e5bcc1fc9-goog
> 
I don't see any functional change.

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
