Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A5233345A;
	Fri, 29 May 2026 14:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065785; cv=none; b=badOvXiUsu9lFtExnMyFaUTFlb1hBxIB2x2xOdNdOGSjTlJI7ongLe2bheWo+VeJ5KVLArm5ibK1egHrftzbxrMY2/z2MnC90nvl9I8FKtOLdIEoM/L2bdMtCe+V+Tly4DJEVKQbPnwp0fovqPHLYlJ6QhKmB+DtM/TWAsWbfpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065785; c=relaxed/simple;
	bh=Jl9VQKojRAgBG12zDuJGeC336Uk4pqmCiAHAf+KoXfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AIFjZnJ707ymI+I0NFn7EoWY93PD8oqjxtCDGqlKH9vbNSrhBGnTfu7YvbiORzWHYuEl5wBXCm00/y2foqiW6n1IqIb/QfwxCR2YoDbPcFamM8F74NSdcHQxj01bhUpsRy1qxVVdhlDJl6WfLYBhABTgUrR002qLV2HmE550oWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=N9E9N33X; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="N9E9N33X"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A05B202C;
	Fri, 29 May 2026 07:42:58 -0700 (PDT)
Received: from [10.43.20.82] (e126510-lin.lund.arm.com [10.43.20.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5DC23F905;
	Fri, 29 May 2026 07:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780065783; bh=Jl9VQKojRAgBG12zDuJGeC336Uk4pqmCiAHAf+KoXfY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N9E9N33X8n15HQwC5psjF+tcjK3WjyYarbBnqu3nIcNYoMawZ7mbV1yjWd13q7IJv
	 QTsroWS/j20zBbVb7rfEQI+Aiu3SBMqEK641u2iZkJkWxvlTEL5KjcIxaj6t8ojsHY
	 iT1KU9ZTFJfOcdoib6fau3D3/hY79iVtzbs6xxPI=
Message-ID: <b76b327f-612e-494f-b8d3-44108aa73d2a@arm.com>
Date: Fri, 29 May 2026 16:42:55 +0200
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/15] arm64: Move fixmap and kasan page tables to end
 of kernel image
To: Ard Biesheuvel <ardb@kernel.org>, Ard Biesheuvel <ardb+git@google.com>,
 linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>,
 Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>,
 linux-mm@kvack.org, linux-hardening@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org
References: <20260526175846.2694125-17-ardb+git@google.com>
 <20260526175846.2694125-26-ardb+git@google.com>
 <2a6f9f05-ac57-4ef8-9328-74cc8ccfea16@arm.com>
 <96a8b6b9-71f2-4550-bbbb-fbfa146f4e6a@app.fastmail.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <96a8b6b9-71f2-4550-bbbb-fbfa146f4e6a@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/05/2026 13:19, Ard Biesheuvel wrote:
> On Fri, 29 May 2026, at 10:27, Kevin Brodsky wrote:
>> On 26/05/2026 19:58, Ard Biesheuvel wrote:
>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>
>>> Move the fixmap and kasan page tables out of the BSS section, and place
>>> them at the end of the image, right before the init_pg_dir section where
>>> some of the other statically allocated page tables live.
>>>
>>> These page tables are currently the only data objects in vmlinux that
>>> are meant to be accessed via the kernel image's linear alias, and so
>>> placing them together allows the remainder of the data/bss section to be
>>> remapped read-only or unmapped entirely.
>>>
>>> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>> ---
>>>  arch/arm64/include/asm/mmu.h    | 2 ++
>>>  arch/arm64/kernel/vmlinux.lds.S | 8 +++++++-
>>>  arch/arm64/mm/fixmap.c          | 6 +++---
>>>  arch/arm64/mm/kasan_init.c      | 2 +-
>>>  4 files changed, 13 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
>>> index 5e1211c540ab..fb95754f2876 100644
>>> --- a/arch/arm64/include/asm/mmu.h
>>> +++ b/arch/arm64/include/asm/mmu.h
>>> @@ -13,6 +13,8 @@
>>>  
>>>  #ifndef __ASSEMBLER__
>>>  
>>> +#define __pgtbl_bss __section(".pgdir.bss") __aligned(PAGE_SIZE)
>>> +
>>>  #include <linux/refcount.h>
>>>  #include <asm/cpufeature.h>
>>>  
>>> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
>>> index e1ac876200a3..2b0ebfb30c63 100644
>>> --- a/arch/arm64/kernel/vmlinux.lds.S
>>> +++ b/arch/arm64/kernel/vmlinux.lds.S
>>> @@ -349,9 +349,15 @@ SECTIONS
>>>  	_edata = .;
>>>  
>>>  	/* start of zero-init region */
>>> -	BSS_SECTION(SBSS_ALIGN, 0, 0)
>>> +	BSS_SECTION(SBSS_ALIGN, 0, PAGE_SIZE)
>>>  	__pi___bss_start = __bss_start;
>>>  
>>> +	/* fixmap BSS starts here - preceding data/BSS is omitted from the linear map */
>>> +	.pgdir.bss (NOLOAD) : ALIGN(PAGE_SIZE) {
>> Do we actually need the NOLOAD type here?
> Yes, otherwise it is emitted as PROGBITS, resulting in all of BSS to be
> emitted into Image.

That's rather strange, aren't the .pgdir.bss input sections already
NOBITS since __pgtbl_bss is only used on default-initialised globals?
Also AFAIU NOLOAD does not prevent the output section from being emitted
into the ELF file.

- Kevin
