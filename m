Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FFE1DB546
	for <linux-sh@vger.kernel.org>; Mon,  6 Jan 2025 11:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736161361; cv=none; b=Fh8apEWM/JekF2UPHUoY0Ak8kpsduOJtxOtNkg9XvFXpNgRTnqkIFC9loBy/Wfobgrw9bYUX+2kOPrDyHY7ERwW/VLpRZCWhm20XhXWs16KODsxGe4CSbM0AB3kM2ZYh5OkkU4nwSLooxgrkmbqocqNTrkuhHznIBx2KSvE5gho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736161361; c=relaxed/simple;
	bh=30+xZQfb9yDuTIOe+TrzSZCg5DGlryILzZEnHJoiL0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E0EbsuPcwK3xpFdhxAS3lAViIVaf/L0xZrBnixfof9Zntg5k/pD4malDnNPMwAlIB4g7t1JFFhjNGUYZvxx3N65VgpyBrfASfBjxS4zLTb6hBVT7y2BXmFIES78MbJn+QKscHdg4LZuxcg0aKWeWYAGLkTUdP+NFvJqf+q61LA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=e9BO8x11; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="e9BO8x11"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-216401de828so190698025ad.3
        for <linux-sh@vger.kernel.org>; Mon, 06 Jan 2025 03:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736161353; x=1736766153; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PtS7kKDFbbWBE6dlgb91yolih02/BD7li/VWMu2pf+Q=;
        b=e9BO8x11AH1QgI2kujJM472/6w1404H4PqWRzvoLs6Ix6ioP/bqjGrP8Z5j3y4WpXp
         P+oA+YYEpj2Hc1pKU2uZ2W5b49ym4KW7g5+BPwd9hw/NoDEQRiLgyFFaTBYmPtz/IqVm
         ACUrR3yo7UfwChTyck1sE6Mul1LfbGfDLU4l2cDJuHc08hZof/pXPnaWZ27o5ZTHJwZq
         CW5/tXH/s0eQNmiBJp9TunpWGl+11v2xKlWpJriisZ1p/weaU+bt1YkNllR+0Zlbb0Ng
         6hfA8PzCu+YbpoKwd7eyy+IlKqLTOCS+0Lnu+7obXPAgPYLbU6nq8WxJnpcdlHTKX5YE
         S33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736161353; x=1736766153;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PtS7kKDFbbWBE6dlgb91yolih02/BD7li/VWMu2pf+Q=;
        b=ZjHee12RRVSeziDM1UfxrCPFk1g91iD6kJY4y29EcEu/vlXeYsLeoH0/yOH90ngA1n
         rL8YPwLsP3AhKKrgjt0Mki4oeL6F/QBZ17xBPHPahFawUAXW/ERSnlAGdMC2fSGRO2xc
         BYT9Rbl9TTs4MLYhIDTeEUWTE4qG3dpfHKakKK/v8dYV7VNd1m9yvLE4d+qb4sPT2B93
         hEzN/f8hpwARmBwlZCkGbHeiQfGO0IbunadxqOH2GcEucp0HUW3daBKI+dDq6PrVA3X0
         XCcPo1fJdm0AqgYJT08OQryA3wD19H8GJ/kNgkJfv/y/IUcPOpRDM0/ExPEABTBpxqdL
         u4xg==
X-Forwarded-Encrypted: i=1; AJvYcCV7bZNhAN0ap+RUfHhULVks7tr3kYtqaMTke6dlyS2oZuShX9wCh1epkrUOdCClrXL2dNuzTcS/kg==@vger.kernel.org
X-Gm-Message-State: AOJu0YywMuQEN5vdzoCSRwwjNJAr9jup5cv4ibHhDWabZwFOn2++9VlR
	dLORAZPms6ovAvQB97Fer1HMPmUBJq6R7bRi2FVknYmZAkPwdytMrGvcgZfcTd0=
X-Gm-Gg: ASbGncvwOvyRlpBj4i4b0HvexfO+oKltvBkB9Lk09JCPDl+HktnT9QZJqodenDbj7Rc
	qmafIt157TLRin89nfhuLxZ+El9WN5sd77yDc1tFfhMg1WJFS8C6McumRUU5oXtCVu8pt6N3hGh
	NBmk4LDmAAIWXvxczXmPCjsiWih8MX9PrRWT0rcBn2MrfDewPentwINUYfl0jNI9Q8cMmvE7tBf
	0SgKNHY1vyDMT6eQ/qn8DD26x8v7PkfD3iva9eHEqAM6n/2gdsp0B9YYEerMoyDQwHouDgckhJ0
	yfleRw==
X-Google-Smtp-Source: AGHT+IFCeOw2arXEHpOUWAGun1CKXf9/XTpPQ1dFbIMLlKInW35U2LjXZ6DtTEzjdru/7w1/tbEHpw==
X-Received: by 2002:a05:6a00:4644:b0:725:b347:c3cc with SMTP id d2e1a72fcca58-72abdeb9c33mr83929136b3a.23.1736161353534;
        Mon, 06 Jan 2025 03:02:33 -0800 (PST)
Received: from [10.84.148.23] ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad816464sm31123318b3a.40.2025.01.06.03.02.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 03:02:33 -0800 (PST)
Message-ID: <2d16f0fe-9c7f-4229-b7b5-ffa3ab1b1143@bytedance.com>
Date: Mon, 6 Jan 2025 19:02:17 +0800
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/15] s390: pgtable: also move pagetable_dtor() of PxD
 to __tlb_remove_table()
Content-Language: en-US
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: peterz@infradead.org, kevin.brodsky@arm.com, palmer@dabbelt.com,
 tglx@linutronix.de, david@redhat.com, jannh@google.com, hughd@google.com,
 yuzhao@google.com, willy@infradead.org, muchun.song@linux.dev,
 vbabka@kernel.org, lorenzo.stoakes@oracle.com, akpm@linux-foundation.org,
 rientjes@google.com, vishal.moola@gmail.com, arnd@arndb.de, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, dave.hansen@linux.intel.com,
 rppt@kernel.org, ryan.roberts@arm.com, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
 <ad21b9392096336cf15aee46f68f9989a9cf877e.1735549103.git.zhengqi.arch@bytedance.com>
 <Z3uyJ2BjslzsjkZI@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Z3uyJ2BjslzsjkZI@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/1/6 18:36, Alexander Gordeev wrote:
> On Mon, Dec 30, 2024 at 05:07:47PM +0800, Qi Zheng wrote:
>> To unify the PxD and PTE TLB free path, also move the pagetable_dtor() of
>> PMD|PUD|P4D to __tlb_remove_table().
> 
> The above and Subject are still incorrect: pagetable_dtor() is
> called from pagetable_dtor_free(), not from __tlb_remove_table().

Hmm, __tlb_remove_table() calls pagetable_dtor_free(), so moving to
pagetable_dtor_free() means moving to __tlb_remove_table(). Right?
And the main purpose of this patch is also to move pagetable_dtor()
to __tlb_remove_table(). So I think this description makes sense?

> 
> ...
>> diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
>> index 569de24d33761..c73b89811a264 100644
>> --- a/arch/s390/mm/pgalloc.c
>> +++ b/arch/s390/mm/pgalloc.c
>> @@ -180,7 +180,7 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
>>   	return table;
>>   }
>>   
>> -static void pagetable_pte_dtor_free(struct ptdesc *ptdesc)
>> +static void pagetable_dtor_free(struct ptdesc *ptdesc)
>>   {
>>   	pagetable_dtor(ptdesc);
>>   	pagetable_free(ptdesc);
>> @@ -190,20 +190,14 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
>>   {
>>   	struct ptdesc *ptdesc = virt_to_ptdesc(table);
>>   
>> -	pagetable_pte_dtor_free(ptdesc);
>> +	pagetable_dtor_free(ptdesc);
>>   }
>>   
>>   void __tlb_remove_table(void *table)
>>   {
>>   	struct ptdesc *ptdesc = virt_to_ptdesc(table);
>> -	struct page *page = ptdesc_page(ptdesc);
>>   
>> -	if (compound_order(page) == CRST_ALLOC_ORDER) {
>> -		/* pmd, pud, or p4d */
>> -		pagetable_free(ptdesc);
>> -		return;
>> -	}
>> -	pagetable_pte_dtor_free(ptdesc);
>> +	pagetable_dtor_free(ptdesc);
>>   }
