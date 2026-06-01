Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49C939B4A3;
	Mon,  1 Jun 2026 10:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780310626; cv=none; b=V33/DQ5IvvfWFwqSkzOXns/HyaYqVNjhPlvSiuZvPGllqbTIrUfJHTiBO7v5DhQP01ubXGrXaNBKokrsiTfthK6p2qsoqY2nQ4h8HuLOcksnSI8GxnrmJ7Fg+NTKANhSlxKN7KSQE0pb/ow1bD8ePug8CCAG+n4ACJeVmEA+C0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780310626; c=relaxed/simple;
	bh=C3+Nupy9epvTU9YJN+UUOeTEoo2XErmrS9cELXLEaTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JbQrXa7OQvpM1vvKXzRRvSUWPWOH0x00Km/5/aH7WpU1E6GBju3PSW/x+yCngO4MMleVqj3aCnzjemTUy3Np9jYcVH2H5dxX9uebLe/mlJG4BHD8crQ3EcATSPPbRqUCYpHycx/gJxzU+MDh8bwU916kGJ/+1KPi6yG2rOC/oos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ATGD2KEF; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ATGD2KEF"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB1D41516;
	Mon,  1 Jun 2026 03:43:34 -0700 (PDT)
Received: from [10.57.94.8] (unknown [10.57.94.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38E4D3F905;
	Mon,  1 Jun 2026 03:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780310619; bh=C3+Nupy9epvTU9YJN+UUOeTEoo2XErmrS9cELXLEaTU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ATGD2KEFk9zH6A/3/wbmsLo8Bk16zruKAja2MWpstRHrcKrUHTc7cCqmaTsy1kze4
	 vG+kAYpgRYGrfxsVM+k07lFcID8aETdcpIWAaY6POEOlyHhT7SAbyCaNPXgf688bb2
	 NWAccF9tR54IJl/TxpZC5Vs/Yx5VmFz06QrmL7VQ=
Message-ID: <e9187fdb-b4dc-4b82-8783-fe1eb221d885@arm.com>
Date: Mon, 1 Jun 2026 12:43:29 +0200
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 15/15] arm64: mm: Unmap kernel data/bss entirely from
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
References: <20260529150150.1670604-17-ardb+git@google.com>
 <20260529150150.1670604-32-ardb+git@google.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260529150150.1670604-32-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/05/2026 17:02, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
>
> The linear aliases of the kernel text and rodata are also mapped
> read-only in the linear map. Given that the contents of these regions
> are mostly identical to the version in the loadable image, mapping them
> read-only and leaving their contents visible is a reasonable hardening
> measure.
>
> Data and bss, however, are now also mapped read-only but the contents of
> these regions are more likely to contain data that we'd rather not leak.
> So let's unmap these entirely in the linear map when the kernel is
> running normally.
>
> When going into hibernation or waking up from it, these regions need to
> be mapped, so map the region initially, and toggle the valid bit so
> map/unmap the region as needed.

s/so map/to map/? Also not sure what "initially" is referring to here.

Otherwise:

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

I don't know much about hibernation though, would be good for someone
knowledgeable to have a look.

- Kevin

> Doing so is required because pages covering the kernel image are marked
> as PageReserved, and therefore disregarded for snapshotting by the
> hibernate logic unless they are mapped.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/mm/mmu.c | 45 ++++++++++++++++++--
>  1 file changed, 41 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 7b18dc2f1721..07a6fa210171 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -24,6 +24,7 @@
>  #include <linux/mm.h>
>  #include <linux/vmalloc.h>
>  #include <linux/set_memory.h>
> +#include <linux/suspend.h>
>  #include <linux/kfence.h>
>  #include <linux/pkeys.h>
>  #include <linux/mm_inline.h>
> @@ -1056,6 +1057,29 @@ static void __init __map_memblock(phys_addr_t start, phys_addr_t end,
>  				 end - start, prot, early_pgtable_alloc, flags);
>  }
>  
> +static void mark_linear_data_alias_valid(bool valid)
> +{
> +	set_memory_valid((unsigned long)lm_alias(__init_end),
> +			 (unsigned long)(__bss_stop - __init_end) / PAGE_SIZE,
> +			 valid);
> +}
> +
> +static int arm64_hibernate_pm_notify(struct notifier_block *nb,
> +				     unsigned long mode, void *unused)
> +{
> +	switch (mode) {
> +	default:
> +		break;
> +	case PM_POST_HIBERNATION:
> +		mark_linear_data_alias_valid(false);
> +		break;
> +	case PM_HIBERNATION_PREPARE:
> +		mark_linear_data_alias_valid(true);
> +		break;
> +	}
> +	return 0;
> +}
> +
>  void __init mark_linear_text_alias_ro(void)
>  {
>  	/*
> @@ -1064,6 +1088,21 @@ void __init mark_linear_text_alias_ro(void)
>  	update_mapping_prot(__pa_symbol(_text), (unsigned long)lm_alias(_text),
>  			    (unsigned long)__init_begin - (unsigned long)_text,
>  			    PAGE_KERNEL_RO);
> +
> +	/*
> +	 * Register a PM notifier to remap the linear alias of data/bss as
> +	 * valid read-only before hibernation. This is needed because the
> +	 * snapshot logic disregards PageReserved pages (such as the ones
> +	 * covering the kernel image) unless they are mapped in the linear
> +	 * map.
> +	 */
> +	if (IS_ENABLED(CONFIG_HIBERNATION)) {
> +		static struct notifier_block nb = {
> +			.notifier_call = arm64_hibernate_pm_notify
> +		};
> +
> +		register_pm_notifier(&nb);
> +	}
>  }
>  
>  #ifdef CONFIG_KFENCE
> @@ -1193,10 +1232,8 @@ static void __init map_mem(void)
>  			       flags);
>  	}
>  
> -	/* Map the kernel data/bss read-only in the linear map */
> -	__map_memblock(init_end, kernel_end, PAGE_KERNEL_RO, flags);
> -	flush_tlb_kernel_range((unsigned long)lm_alias(__init_end),
> -			       (unsigned long)lm_alias(__bss_stop));
> +	/* Map the kernel data/bss as invalid in the linear map */
> +	mark_linear_data_alias_valid(false);
>  }
>  
>  void mark_rodata_ro(void)
