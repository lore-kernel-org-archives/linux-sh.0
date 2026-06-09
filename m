Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2363D0BE7
	for <linux-sh@vger.kernel.org>; Tue,  9 Jun 2026 06:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780986154; cv=none; b=JP5Qo0vD8WDuQB6EPyVA+0oYdj0qEjmltP65ZOYqxR35eE2iJ+rxZDxt9qlrmhIqm1+/I7AlRtT/q5Dkn/2901XE4rKAtQb4RhB+SbGZeOgOxHo/aK1MERrq6Q93Kaqx29bsRnT/4FG+7A9UPk3kqqUqQc277gYi53saw+pJjg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780986154; c=relaxed/simple;
	bh=wgla+/DQxAUvLuYqJp8l8A47wiL17TD53VIYJwrn7l4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=ZFstNB/atonEhGpul13dtZYzNBM5QmWDcTfkyyXegd7pr/k+x+ytP49+CuToF1KK/AkLJiyAW8sMao5BHNEpT7TfeEXW5iFW6lmuIZ37zNKKh7kt2HOj/TtA5eGpF5n2sA6I2XvbKbz5eYBj0AhwSy3gbWDC9QJPowBTGKh3wlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=kEkid4Lc; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kEkid4Lc"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260609062228euoutp025c18646a3832e72ee65fa098b39f733d~3VXde3NDQ1039710397euoutp02D
	for <linux-sh@vger.kernel.org>; Tue,  9 Jun 2026 06:22:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260609062228euoutp025c18646a3832e72ee65fa098b39f733d~3VXde3NDQ1039710397euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1780986148;
	bh=QNLMOTRHBXi4Z84O461LhX+rEh9cZpG943Cj00l7pcg=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=kEkid4Lc9CpRO/3yyOzVz5QUMceUdCkVZHKebqPeaNlT6tnzDo5I4F3ZPZBXOk8On
	 5gBBhxvU8QM/nU5ODXUfDdfNgxHBxvxHcEGaliaAtVjJolwf72MxHzOQWCQV2TKj7I
	 EB7BWOaYJ7qI4rHEe7WKsSSL3IF4YpJayVXGNTyo=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260609062228eucas1p211850bcf6ea79ef270bc6fbe29ffafdb~3VXdClAs70378003780eucas1p2G;
	Tue,  9 Jun 2026 06:22:28 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260609062227eusmtip2cece3df82958ee4950f41c056ec8da55~3VXb-fGd70969909699eusmtip2E;
	Tue,  9 Jun 2026 06:22:27 +0000 (GMT)
Message-ID: <a1b27e97-182c-485d-a448-56c19c5de2c2@samsung.com>
Date: Tue, 9 Jun 2026 08:22:26 +0200
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v7 15/15] arm64: mm: Unmap kernel data/bss entirely from
 the linear map
To: Ard Biesheuvel <ardb+git@google.com>,
	linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com,
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts
	<ryan.roberts@arm.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Kevin
	Brodsky <kevin.brodsky@arm.com>, Liz Prucka <lizprucka@google.com>, Seth
	Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, Mike Rapoport
	<rppt@kernel.org>, David Hildenbrand <david@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Jann Horn <jannh@google.com>,
	linux-mm@kvack.org, linux-hardening@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260529150150.1670604-32-ardb+git@google.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260609062228eucas1p211850bcf6ea79ef270bc6fbe29ffafdb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260609062228eucas1p211850bcf6ea79ef270bc6fbe29ffafdb
X-EPHeader: CA
X-CMS-RootMailID: 20260609062228eucas1p211850bcf6ea79ef270bc6fbe29ffafdb
References: <20260529150150.1670604-17-ardb+git@google.com>
	<20260529150150.1670604-32-ardb+git@google.com>
	<CGME20260609062228eucas1p211850bcf6ea79ef270bc6fbe29ffafdb@eucas1p2.samsung.com>

Dear All,

On 29.05.2026 17:02, Ard Biesheuvel wrote:
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
>
> Doing so is required because pages covering the kernel image are marked
> as PageReserved, and therefore disregarded for snapshotting by the
> hibernate logic unless they are mapped.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
This commit landed in yesterday's linux-next as commit 63e0b6a5b693
("arm64: mm: Unmap kernel data/bss entirely from the linear map").
In my tests I found that it breaks booting of RaspberryPi3 and
RaspberryPi4 boards with the following kernel panic:

kvm [1]: nv: 570 coarse grained trap handlers
kvm [1]: nv: 710 fine grained trap handlers
kvm [1]: IPA Size Limit: 40 bits
Unable to handle kernel paging request at virtual address ffff000003a23000
Mem abort info:
  ESR = 0x0000000096000147
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x07: level 3 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000147, ISS2 = 0x00000000
  CM = 1, WnR = 1, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000002609000
[ffff000003a23000] pgd=0000000000000000, p4d=180000003b3ff403, pud=180000003b3fe403, pmd=180000003b3e6403, pte=00e8000003a23f06
Internal error: Oops: 0000000096000147 [#1]  SMP
Modules linked in:
CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.1.0-rc1+ #16768 PREEMPT
Hardware name: Raspberry Pi 3 Model B (DT)
pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : dcache_clean_inval_poc+0x24/0x48
lr : kvm_arm_init+0xa8c/0x165c
sp : ffff8000844bbd00
...
Call trace:
 dcache_clean_inval_poc+0x24/0x48 (P)
 do_one_initcall+0x68/0x4f4
 kernel_init_freeable+0x24c/0x360
 kernel_init+0x24/0x1dc
 ret_from_fork+0x10/0x20
Code: 9ac32042 d1000443 8a230000 d503201f (d50b7e20)
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
SMP: stopping secondary CPUs
Kernel Offset: disabled
CPU features: 0x00000000,03000008,00040000,0400421b
Memory Limit: none
---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---



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

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

