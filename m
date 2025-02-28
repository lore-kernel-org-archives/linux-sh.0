Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D67325757
	for <linux-sh@vger.kernel.org>; Fri, 28 Feb 2025 02:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740710675; cv=none; b=MOo9+p9UoBDxhrMFoX0igtZuBXrCRkMZ6u/ICu/UIPjy8tzOKX1oYnrtEnHWiRkgAxOjfQZwO1wVmKswoSZMo7jPZRLC2v69D+0851Jd7EHH0cm/EybHi1ioE5kOBgNS2u0YESI/n6VC0mb5UuYORmoggfL/UnEAyxBnIPJYTDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740710675; c=relaxed/simple;
	bh=0fz6H8dlUgf8ko9N18YypQHlBg79eNoT5rDDE25IBq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d2eK1gOFczSOb6fn/hqV4bs6BW1qH5O7DwlDk1ypbI7HxPGEneimOwoCHy3KP2xEweib0TvvraN+uANKgTIelmZa5tZ40FTd/ZXZU/dx6NBFKr0Er+S7Y9rbZE3ZDJDPHmDmdFrC87I47jmX9CWEqtbKbZGKq0GmKZhQumhE0RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cdGvg9LM; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cdGvg9LM"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fea795bafeso2248165a91.1
        for <linux-sh@vger.kernel.org>; Thu, 27 Feb 2025 18:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740710673; x=1741315473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrHEppDznEYNt+aFJHMFnsD9ySUlfKEU8kXo3t7+HP0=;
        b=cdGvg9LMCPgA86eF1veU8MttIzjFc4M9bOp1Q+ej90hvu2aZr7uyASxs7uRlr3D8kE
         YQQQANN+KG+nVURDCNJSv5gXBZoaa0W0i35WiZlp+mcBPmLoJfGx/iPTsUQgBx1Od+bK
         riOJ/vkAG14G2L8zko8aUF3QwPxJv+wmmzqITfAAwEEj6QVyvyt382VqOYTnBuj9KJAU
         HZNHwiMw671NsErHZxT6yRYWcQ8PvZzb/ikpwi5VOwlvOlu3HTNLh12KwEYvo2mJ8GYP
         PjXRKUtbafnl+V/PCk7t9Iw7EHZB8TYDo5psvQDupJbFjo70IVyq0wgSs20gO+qgyNoS
         eNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740710673; x=1741315473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KrHEppDznEYNt+aFJHMFnsD9ySUlfKEU8kXo3t7+HP0=;
        b=jBleBncG3KczRoM7wY+hcg/bHCUFeQ42RHyyyDbpNr/R05wyhKVsLaQBYlq3y8yta/
         Uwvh/dtBoJKVqz2pS+42lpq5kZMh6PuNR2rWo+PTBdvcHKVkMFJg5pvVpzIv1T/O3Ls1
         NiE0WRt5HsgQwEyx0sTWY62awSlFrjGOIx9LY3G5JwCPms3rgcbjvWxypE3lrsJ4Z3Vp
         NJ380Pc2uVoQ4rPKuLDjVfuFNkzVmD6Qc6OuZfkJ/V+PQKNMs0FEyemTIQa4WSMbytQY
         mkqvXdOCQbOF1oVORLWnP59TWVi4PN7lS955anw6s2p6w/TRaEIcXcN4ZvdLH9jtRWD/
         xseA==
X-Forwarded-Encrypted: i=1; AJvYcCUh0r2ugi7Xf4qFvecpD4NQ/lJKtKjHxaNitiGF8hTWHLzHKXqEBv1mlt2G+b3JLpTOMIIXBdV6Hw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcv/RA263uDefjvEymUAnM1wBfDpA1gzWf1h6mGSzYJ6krXHlm
	xckWh3td4PZHpvNupuM1APTEISDVA8VHZ8GsqbuxONTLDfWCIrUvUy1953oc/2Y=
X-Gm-Gg: ASbGncvEOVNy6E4XlPQvF7rN2tYJkP0/YphS0JQqot2lUCIOV7zGbCEVgrkQxDAj94/
	zE1qUSzubpgtFnJZjyI7PVz98ZI68QUi/h7ex1qVvGuCiNc50xpUIJv0Z8SD7Mga3IosvdriH5b
	ZmKMfErCty5QxOM4jIISNMiwgs1h/80UI5xRkVlB3OXL2uuOPPGqBMUXgMG758fMJ5TLgs6RBF3
	m6DJO7bBieu9oHRpI4ucpst8A2z9Xm/fraPGrXUPLh6yuyLoVzsxGwmhHHuyWKU95xAbUaNxYcS
	+52KC5W8SVr+w5Ije87EiJkcjc9VULt/N5flxBaruov3Cw51yg==
X-Google-Smtp-Source: AGHT+IF4hsdZRiz/aSbemK655CZrsY9ZUuvu4Xu2ENST8y9hxHTSO7PJo35OmCgDgimYWycuvOakGg==
X-Received: by 2002:a05:6a20:1591:b0:1ee:d19c:45f9 with SMTP id adf61e73a8af0-1f2f3e11f86mr2902815637.19.1740710672736;
        Thu, 27 Feb 2025 18:44:32 -0800 (PST)
Received: from [10.68.122.90] ([63.216.146.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe514besm2559832b3a.71.2025.02.27.18.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 18:44:32 -0800 (PST)
Message-ID: <e5f4e310-5bcd-4901-8ec3-757cf55dfa64@bytedance.com>
Date: Fri, 28 Feb 2025 10:44:21 +0800
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] mm: pgtable: convert some architectures to use
 tlb_remove_ptdesc()
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: peterz@infradead.org, kevin.brodsky@arm.com, riel@surriel.com,
 vishal.moola@gmail.com, david@redhat.com, jannh@google.com,
 hughd@google.com, willy@infradead.org, yuzhao@google.com,
 muchun.song@linux.dev, akpm@linux-foundation.org, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, arnd@arndb.de,
 dave.hansen@linux.intel.com, rppt@kernel.org, alexghiti@rivosinc.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org,
 linux-riscv@lists.infradead.org
References: <cover.1740454179.git.zhengqi.arch@bytedance.com>
 <19db3e8673b67bad2f1df1ab37f1c89d99eacfea.1740454179.git.zhengqi.arch@bytedance.com>
 <CAMuHMdU8ttibKCiUPxSNBpJyrtBbrt1CqLa++jq6CpJFbFCwAg@mail.gmail.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CAMuHMdU8ttibKCiUPxSNBpJyrtBbrt1CqLa++jq6CpJFbFCwAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/27/25 9:21 PM, Geert Uytterhoeven wrote:
> Hi Qi,
> 
> On Tue, 25 Feb 2025 at 04:46, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>> Now, the nine architectures of csky, hexagon, loongarch, m68k, mips,
>> nios2, openrisc, sh and um do not select CONFIG_MMU_GATHER_RCU_TABLE_FREE,
>> and just call pagetable_dtor() + tlb_remove_page_ptdesc() (the wrapper of
>> tlb_remove_page()). This is the same as the implementation of
>> tlb_remove_{ptdesc|table}() under !CONFIG_MMU_GATHER_TABLE_FREE, so
>> convert these architectures to use tlb_remove_ptdesc().
>>
>> The ultimate goal is to make the architecture only use tlb_remove_ptdesc()
>> or tlb_remove_table() for page table pages.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Thanks for your patch!
> 
>>   arch/m68k/include/asm/sun3_pgalloc.h | 3 +--
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Thanks for your review.

> 
>> --- a/arch/m68k/include/asm/sun3_pgalloc.h
>> +++ b/arch/m68k/include/asm/sun3_pgalloc.h
>> @@ -19,8 +19,7 @@ extern const char bad_pmd_string[];
>>
>>   #define __pte_free_tlb(tlb, pte, addr)                         \
>>   do {                                                           \
>> -       pagetable_dtor(page_ptdesc(pte));                       \
>> -       tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));        \
>> +       tlb_remove_ptdesc((tlb), page_ptdesc(pte));             \
>>   } while (0)
>>
> 
> With only a single statement remaining, you can remove the do { ... }
> while construct, too.

Ah, right. Will do in the next version.

Thanks!

> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 

