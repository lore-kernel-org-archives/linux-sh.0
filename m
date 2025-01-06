Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8561DFE3B
	for <linux-sh@vger.kernel.org>; Mon,  6 Jan 2025 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736174679; cv=none; b=e2w3T6I9sCxUFXxPx9mJyirwJSeV+UIA1zNbjoM8k1ZvEwLSSPK8n9F1UYK0siUm3mQwd+rMZHu+/8HeLpxugBYmQ/yOSGN64oOVLYfJxL2BZn2PBGJRLrFafqZbhf2AKya7YYSW+oAW9G2HzpFp1+bBvqa7xJ9nJ4G/o55FLHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736174679; c=relaxed/simple;
	bh=FT+GsbrHFNytgmVw9pS4MWUyG9GELMc2aWIALV4R5HM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BEiBkXYV2uEI6cgU0jizR6ov4Ax72Gt7D1xkzNVe/eJqCIiHMVmhMXUiWBFvcE1dG7TfZmq2r6YKOwzFSG9Vo3JWNRk/CTKlRaUR3Zm7gkNt1f0uTJw8DdFYRS6/7SpVGHqNdHRtqMoF0Hs7Qo+JjtJU5yczHIbHxJGFRxa/U7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AOENsm2R; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AOENsm2R"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-216426b0865so203631095ad.0
        for <linux-sh@vger.kernel.org>; Mon, 06 Jan 2025 06:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736174674; x=1736779474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NViglkR77PlL2AqsFJ9M2rA8vsy0VBtzEibmSHACi+I=;
        b=AOENsm2RWVESkj+tEE8NednRuNGe+HrlfMpqdMmB96TFPb1M05S6p2+RrKZ6kOJ2r6
         2m1ghhviUlJEv7uX2tL/vtDm1POjsFwB5CCUwKifHrGiN6wAdyKGQ9X2oL3piluKNYb0
         I3X+PpobzTtVz7/hTPrBW0pImZItQ99bJssa2FVL4Lrrjx7q1lNsJd7rELXfXFDMcswv
         aXqs85gh+NKJfwv3V9Dy+ZrYnXCasR3YIZbwRcM0jNsQdZ/dg9IB1W+XfduD1DKb5HNn
         zxq03RDCixKBfv9y4elRxUNAap32HNjC1W6uJzlwSMZFFa8MSUhCPMDJQ1aCRNa6iLgr
         188g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736174674; x=1736779474;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NViglkR77PlL2AqsFJ9M2rA8vsy0VBtzEibmSHACi+I=;
        b=wmKkgV4C3S39mV8+l9Eax08TYLEpqRd14FG5b2nSuBj8M9O1+Wix1YDZpDFZIbcBV7
         9wN9aey83lO2Ggl2nwm3oc94rV2VdQy99SQZdXxoYLiWoIeIuiJVxooZlPPabtRd7u0Q
         yRWcjitbrGfkdJkHR8JlkraLtKYQ06TCpABHPGnlul8V/0mbUVAkFbo/Mbp2RF+KIoTt
         c5iYNaLUVSR4aqnTKfPK8ntOGjnFlKFCYU8sORU3XgC2OkE5Tr1j0CBKxHzHRF+gAaEA
         pqxPK510Hu/I+Rfsq1PaoRyw3cRvNoj2fVyzDtqG+M//l7LHXYh39OP2U4q0OLCgq5WK
         DZgg==
X-Forwarded-Encrypted: i=1; AJvYcCUDG2D097vRsDJslGOxtB4B9TTG13Sg7yXaEMC/KLjSVwF0IFQsTEfN5AVCkovd0Kvtg1d6mahR/g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2+s48YqMTnyzliIOxqMA+rG+3VplATJN0XC0ep63rSEK/JRui
	oqOFjifA/d8Ns1qcrd8c0RIu/LsGGsz/YW9aCMZxv6UwcU/ih75FES01M+15iuk=
X-Gm-Gg: ASbGnct0My9DYyhJBmfdCV1ef9LeSpCrgNDCIEcdjWF/aU0uABb5aJgXMIBX+TJ+R6L
	s2EcHzwl2P95xsDlPIZTRiBic3cyjnP7E4zFML41P7e08ZOCTsnNHtpVixWLyGrcu3kBTp3Hbdm
	BtvSgGgtHt6sXIsfOk0vhGkaEdMEniZ1Sum+7puaCxj4RUNTkylRKR+6LL6rjCiMJ9AQj2l9zYS
	oVRORlDNise5ib4aVJ7qVzmkaO8TpeSGReDKg6eht7wFF5yESknbYDbVNoKAtje91yw2jJ7ih8b
	pFFNlTshuE+5CADURp+86s/poSVd8TcaPdsOOsESCyegHgGhQXSd
X-Google-Smtp-Source: AGHT+IHfRKlSBRBXUw7mHIW0SQFNESOEWbBrtQcBXd7/ffhetsdlBCZHRjeTrMJdIBfoDiMG7l+wRg==
X-Received: by 2002:a05:6a00:ac3:b0:726:f7c9:7b1e with SMTP id d2e1a72fcca58-72abddcadd6mr82367083b3a.13.1736174674262;
        Mon, 06 Jan 2025 06:44:34 -0800 (PST)
Received: from ?IPV6:2409:8a28:f44:d64:296c:a8f3:f81e:f88b? ([2409:8a28:f44:d64:296c:a8f3:f81e:f88b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad815804sm31532588b3a.32.2025.01.06.06.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 06:44:33 -0800 (PST)
Message-ID: <dbcbf4c3-f86a-4414-be52-8ac02dae5b6b@bytedance.com>
Date: Mon, 6 Jan 2025 22:44:21 +0800
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
 <2d16f0fe-9c7f-4229-b7b5-ffa3ab1b1143@bytedance.com>
 <Z3vQHplZqtHf6Td8@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <57ea8193-2fd9-41a9-85b4-7af924f900f4@bytedance.com>
 <Z3vqHXdwIMBVQ2GT@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Z3vqHXdwIMBVQ2GT@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/1/6 22:35, Alexander Gordeev wrote:
> On Mon, Jan 06, 2025 at 09:34:55PM +0800, Qi Zheng wrote:
>> OK, will change the subject and description to:
>>
>> s390: pgtable: also move pagetable_dtor() of PxD to pagetable_dtor_free()
>>
>> To unify the PxD and PTE TLB free path, also move the pagetable_dtor() of
>> PMD|PUD|P4D to pagetable_dtor_free().
>>
>> But pagetable_dtor_free() is newly introduced in this patch, should it
>> be changed to 'move ... to pagetable_pte_dtor_free()'? But this seems
>> strange. :(
> 
> s390: pgtable: consolidate PxD and PTE TLB free paths
> 
> Call pagetable_dtor() for PMD|PUD|P4D tables just before ptdesc is
> freed - same as it is done for PTE tables. That allows consolidating
> TLB free paths for all table types.
> 
> Makes sense?

Ah, make sense. Many thanks to you!

Will do it in v5.

> 
>> Thanks!
> 
> Thank you!
