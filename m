Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF4A7346D
	for <linux-sh@vger.kernel.org>; Tue,  4 Mar 2025 02:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741055481; cv=none; b=kb0f6SJPU2kTEJRrKoxxMrCWsCpiG5maI2wllZPvDGUK3aM9rir0ZLms07qIYztEPnll8Z1Tm+NoEQPu5TLG7MfirE31m0u34I+sfAYXgwB3QeCBIXDsMixlCTpcb7NQOQG6oHy1451xK+HDniVFVqB8dUYpv6mhXWkGoh4oz7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741055481; c=relaxed/simple;
	bh=+LwpYhqMa0YBvdBDiDqcdY8NesTszK/ILIT1IDZ1qek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SbXy7Cw5pOQHn4aPVUqwZek2PkypoQjpoa0OU3Lqs8t+491fTElww0p2e7UbifQRZaEiqfKgJBEHa9Wi0VRUBsbOP6dsOYbxJ+p2qUif7eEJEOdqS/ELgW2CZe1eaC9BO2+yFJg3/uc0o4L7G9GSS21no3UDb4rrYp+te8+Wrpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UtwdYPdf; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UtwdYPdf"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22185cddbffso102622435ad.1
        for <linux-sh@vger.kernel.org>; Mon, 03 Mar 2025 18:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741055478; x=1741660278; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6T+mpuirUlxFXXDmZQp4DlzJljahRMUsKAZ4wXM54o=;
        b=UtwdYPdfRGrEFdCavYzZI3HyLPrnLnP1t9sLzv6NaaYk9ONdWAkOEhwOwWl1Kk/5fx
         2qKZUo498LJvoDacCw05YZlDhQNtwgyqpXvBw16HpL4kXr9Itknn3vw9x2GM4usnsRVT
         +GYKnIiGVdGQZ2GZEh8WSqHNTuyaCX4XB2mQUUBE7/IN/aMWutRcFyFC4iN3raLkFp1s
         N5d6EGHaAT3ebqpDYkKfMmdtaXwVm7d3zVHzuJQxdbj5B4yKA6NzQzH42R1WtRRs0nit
         iJ7CIxsP2mBHiD8uUs8ey2gPyYp3443CWAam4TRIParGmSH0RCJXxHkaAaFxsS1EX85v
         346Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741055478; x=1741660278;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A6T+mpuirUlxFXXDmZQp4DlzJljahRMUsKAZ4wXM54o=;
        b=QrmPT//53D9Q30NpeelTCLchhLm1mTOt0u72TYt/fWhzlAfru/Xi8qNem1cIkIHuk4
         SxUhmXVa+VLQ1IVQpC5C+aWB3jylYi5flyZKEIfxtGELqb7yjivmWtc82rem9Q3c0k/Q
         ewK5ZPHef4zHqXrT3mHVYIk4I9GRplGCUykLc5dG2EqG8Apjf3G0UHUBeoTg+WbWM6aR
         cMXbltFRPeB87nLJj/Kq2bOmbea2Kq7JvoF+9HRoBeNYnB0/IKnUAeGTWx8dGZ6CwEcK
         eNXynS2pb8tJ9uTvdmVx7vv3Is0igzKpFhBx6K/O/126zOrw/okGZVrj4cunkSt7C+ve
         MP0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUh337o1q8IbmUXdj+VrKLdb3tB/2IEuJgkxTOB3hTkz+1tnCBnL+Ng4dPDfA3BsO/+A4ejbjamiA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbk4dQFieKwJspvOE5XwpK7tEKLVWCQJ1TRpCZE/dXI7NxsY7R
	UEUhcn/tU+aMGbkt//mXJYWgdB2SWZCwbWon3HsnudCw4l4YXxxedGJ5zQ08B6c=
X-Gm-Gg: ASbGncthwIfITrqj+jwmKNisl3uM24ajx2YRFYG7gW6WAqRFE6xUJb0CgAX6AG0OIQM
	RwygXLbOPyDyPIIV3iTYKuD1VCZ5qaC2Lh5fd0useEAp7Z2X0gXZhN0n5ZEvrDnd+eMC2STX0Qi
	ARC+Y5Ghz6FOeHaiUjxjD8MCXKN1x1f0o/BbTvNZbInGgS3+Gh3kg+LlYFgVSYDWybXEWg8CJRC
	OfrWf5J2gtrHZrWW+gL0cmBvWH1C7BaLMJHYu1j5/EQdFt1rTipSYxsRyrnGtuO1W59/Zjp/YbR
	x3VZ/9lbgRRpwuN2QrO5EueVe8sDu0RGIdDJwqy86Gd/a93/Zqox7qD3M32keXNfh6AZ
X-Google-Smtp-Source: AGHT+IGfyVS9QzXp3fDXv9OSff0zyYBlNLrDj9vPIT6lOO0LqcIFLuDQltej9EU6VX3nefPaL9P2pQ==
X-Received: by 2002:a05:6a21:6b18:b0:1f3:383e:7739 with SMTP id adf61e73a8af0-1f3391176eamr2284458637.7.1741055478523;
        Mon, 03 Mar 2025 18:31:18 -0800 (PST)
Received: from [10.68.122.90] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7ddf242bsm8911768a12.13.2025.03.03.18.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 18:31:18 -0800 (PST)
Message-ID: <c48715aa-8c1f-41bf-92a0-bacf401c2f7c@bytedance.com>
Date: Tue, 4 Mar 2025 10:31:07 +0800
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6 update] mm: pgtable: convert some architectures to
 use tlb_remove_ptdesc()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: peterz@infradead.org, kevin.brodsky@arm.com, riel@surriel.com,
 vishal.moola@gmail.com, david@redhat.com, jannh@google.com,
 hughd@google.com, willy@infradead.org, yuzhao@google.com,
 muchun.song@linux.dev, will@kernel.org, aneesh.kumar@kernel.org,
 npiggin@gmail.com, arnd@arndb.de, dave.hansen@linux.intel.com,
 rppt@kernel.org, alexghiti@rivosinc.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org, Geert Uytterhoeven <geert@linux-m68k.org>
References: <19db3e8673b67bad2f1df1ab37f1c89d99eacfea.1740454179.git.zhengqi.arch@bytedance.com>
 <20250303072603.45423-1-zhengqi.arch@bytedance.com>
 <20250303155331.de9b2fff9b04984a255a7bc2@linux-foundation.org>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20250303155331.de9b2fff9b04984a255a7bc2@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/4/25 7:53 AM, Andrew Morton wrote:
> On Mon,  3 Mar 2025 15:26:03 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
>> Now, the nine architectures of csky, hexagon, loongarch, m68k, mips,
>> nios2, openrisc, sh and um do not select CONFIG_MMU_GATHER_RCU_TABLE_FREE,
>> and just call pagetable_dtor() + tlb_remove_page_ptdesc() (the wrapper of
>> tlb_remove_page()). This is the same as the implementation of
>> tlb_remove_{ptdesc|table}() under !CONFIG_MMU_GATHER_TABLE_FREE, so
>> convert these architectures to use tlb_remove_ptdesc().
>>
> 
> checkpatch warns.
> 
> Do these things have to be macros?  Switching to static inline fixes
> the unused-arg warning in a nice fashion.

This can be switched to static inline. In addition, I found that alpha,
arc, microblaze, parisc, sparc32 and xtensa also have the unused-arg
issue. Do I need to add a new patch to fix all of them, or just fix the
newly added 11 warnings?

> 
> I'll fix the trailing-semicolon issue locally.

Thanks!

> 
> WARNING: Argument 'address' is not used in function-like macro
> #51: FILE: arch/csky/include/asm/pgalloc.h:64:
> +#define __pte_free_tlb(tlb, pte, address)	\
> +	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
> 
> WARNING: Argument 'addr' is not used in function-like macro
> #66: FILE: arch/hexagon/include/asm/pgalloc.h:90:
> +#define __pte_free_tlb(tlb, pte, addr)	\
> +	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
> 
> WARNING: Argument 'address' is not used in function-like macro
> #80: FILE: arch/loongarch/include/asm/pgalloc.h:58:
> +#define __pte_free_tlb(tlb, pte, address)	\
> +	tlb_remove_ptdesc((tlb), page_ptdesc(pte));
> 
> WARNING: macros should not use a trailing semicolon
> #80: FILE: arch/loongarch/include/asm/pgalloc.h:58:
> +#define __pte_free_tlb(tlb, pte, address)	\
> +	tlb_remove_ptdesc((tlb), page_ptdesc(pte));
> 
> WARNING: Argument 'addr' is not used in function-like macro
> #95: FILE: arch/m68k/include/asm/sun3_pgalloc.h:20:
> +#define __pte_free_tlb(tlb, pte, addr)	\
> +	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
> 
> WARNING: Argument 'address' is not used in function-like macro
> #110: FILE: arch/mips/include/asm/pgalloc.h:51:
> +#define __pte_free_tlb(tlb, pte, address)	\
> +	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
> 
> WARNING: Argument 'addr' is not used in function-like macro
> #125: FILE: arch/nios2/include/asm/pgalloc.h:31:
> +#define __pte_free_tlb(tlb, pte, addr)	\
> +	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
> 
> WARNING: Argument 'addr' is not used in function-like macro
> #139: FILE: arch/openrisc/include/asm/pgalloc.h:67:
> +#define __pte_free_tlb(tlb, pte, addr)	\
> +	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
> 
> WARNING: Argument 'addr' is not used in function-like macro
> #153: FILE: arch/sh/include/asm/pgalloc.h:35:
> +#define __pte_free_tlb(tlb, pte, addr)	\
> +	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
> 
> WARNING: Argument 'address' is not used in function-like macro
> #167: FILE: arch/um/include/asm/pgalloc.h:28:
> +#define __pte_free_tlb(tlb, pte, address)	\
> +	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
> 
> WARNING: Argument 'address' is not used in function-like macro
> #176: FILE: arch/um/include/asm/pgalloc.h:33:
> +#define __pmd_free_tlb(tlb, pmd, address)	\
> +	tlb_remove_ptdesc((tlb), virt_to_ptdesc(pmd))
> 
> WARNING: Argument 'address' is not used in function-like macro
> #185: FILE: arch/um/include/asm/pgalloc.h:38:
> +#define __pud_free_tlb(tlb, pud, address)	\
> +	tlb_remove_ptdesc((tlb), virt_to_ptdesc(pud))
> 
> total: 0 errors, 12 warnings, 122 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>        mechanically convert to the typical style using --fix or --fix-inplace.
> 
> ./patches/mm-pgtable-convert-some-architectures-to-use-tlb_remove_ptdesc-v2.patch has style problems, please review.
> 
> NOTE: If any of the errors are false positives, please report
>        them to the maintainer, see CHECKPATCH in MAINTAINERS.
> 

