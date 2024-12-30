Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B5316088F
	for <linux-sh@vger.kernel.org>; Mon, 30 Dec 2024 05:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735534906; cv=none; b=eQE6y5c2rfOLaXZAa5usUKIgeyf83c9aXkHdEBiX5nyZeKEH2+poxkvOljj0Qp1cNrTgnIY95OEZBLynchx6LfrTQsU4SiXTAPCjFKI8kikf2h/1tHRLOnrv38Uy9YfNqrgy0Clt7TOReVJTsRRwhViFL2EBIR02Fz0WgVHGx84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735534906; c=relaxed/simple;
	bh=piyHCVVAMwS1wQEyd4KrwKqNTu7KlhnDsmo79+H7v/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WwKC6nfXJolcHp2kGw8BnoNkCeOMOmmAj4/L1Arb8gwzg9MSxYQ/jAgW4JP1fQ+OYY/rlhm7dqgJIG5NV8/AvF7k+WED1OuEVPCsYa27CbkLckbo+EcHk8HFvp6XrEkac8z8kSgW+StUeqp1i//RH3bjJ5kOH2jqp2wGcmgmI+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AVwYCuks; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AVwYCuks"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21644aca3a0so14771025ad.3
        for <linux-sh@vger.kernel.org>; Sun, 29 Dec 2024 21:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1735534904; x=1736139704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z71RF7AQSzzvF96cC/aV2tD8Znb4DG916rBbscUdZ1I=;
        b=AVwYCuksyL4MWKNaOrcPqCsZHjP15dUO7Ft7whW/+MGucPq2CCF41ayT8HETt/nEMO
         INyXiKOGq8dtgD/nwAjk5Uvbn/UNo6jLG8qZLyqXrnJTAdRzC7Kamk4u5TtkyRp8o3/A
         +1Rvh7mPtO96ubOzkKZmD+51Gvtwp7vYJNHB3SEvUmi7l+9dL+Z3crf/xHOccAuBwsfd
         k1c3oolBT037qU5KPaOm4MllAPqW3k8jlJDhTFXsAr7VPyZz5sI+gBdqLOmCO810bvI/
         2VnuL99Nd7JF3vQY+V7vuf4tXweQBDZ0VLv7S4ip/DrVWjK5G//bmm3zSbnYRAqLIFvz
         XWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735534904; x=1736139704;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z71RF7AQSzzvF96cC/aV2tD8Znb4DG916rBbscUdZ1I=;
        b=txY7Xc4+pen+b5B8+SSYmzmYRv1XsHo+KoEJbgO+9JEkcQDqhPJxl2nuZWdC+UO+DO
         n7Q+rzKboxskfs30JMPwnovG8ikqHnzTiFshXLaEhs9Tmt/yNHeN4Y+3dXMoPdyQT2/J
         DDm6jVxckQza6A+Xaw1orKuP18NiBWa8NbUyeIOHPUwtwqlJ9g9YFvUnQz8fTnhAMqmL
         uVpXl+2OFNYyvzTjdBBaaPHCtWg7MjnBYTgK2RNyThHUmGNxIE3pcAxNQXjiux75LZJz
         +0HQHu7Mnil8i0PZ7JpvbzXk6V/+ggje+q2Eootem7/0nGB7TKTdYWcsMaYpJAmUnUHG
         4jMA==
X-Forwarded-Encrypted: i=1; AJvYcCU/lteWRcONvjyqGUFGI5GVj3B0grjfIXLAfy9LeDDteL3pF2NenUKUs6GouKt0GdW5raasFS2pmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyipvxU38VAIdX7ksUISAjjaqkz5SdNOJfK7Id3sWmG9yodEq4q
	32yhYyWAZPP+6IY15UGJCs4imBmtN80WCDMKIG24ROjXRE/AgwNCEhPRVAES8Bc=
X-Gm-Gg: ASbGnctQfnChgkLoRVDEWFQ37ce9VJeGi3ViHWasgU8TMGMTJTRszdFdmGfS+GpWN3D
	t6HVb0kUS6jWcAdHv0gklzEMV8cjdhihG11IU+9a5RGQ9SShtzKa5k5rG6Oi1zgr+FMm+FyVbSO
	mIRicJ1gP3siF/pIU/gNGXWBGuzzy46mEColzrcypHxdI2GGgMeCgyvi431pUdegeIgbyYUXiwi
	SnaevkjHfAhK3bx4txNRCTz5TT2EVrkB0XGJ70IK612VLibk6K5KWR1xCTvTSx8G+LSxLQMATH2
	6aq31g==
X-Google-Smtp-Source: AGHT+IGNJA4bVLowcqsTNcTKWXSt9C1oo/1EXH42Qr0z5K3kcPv3AzGfuER3K4niOaxH4y3G0nd6hA==
X-Received: by 2002:a17:902:ce86:b0:215:a57e:88e7 with SMTP id d9443c01a7336-219e6e89215mr362710865ad.3.1735534904325;
        Sun, 29 Dec 2024 21:01:44 -0800 (PST)
Received: from [10.84.148.23] ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba7325csm16914771a12.7.2024.12.29.21.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Dec 2024 21:01:43 -0800 (PST)
Message-ID: <efd81018-f637-4925-9104-c9586fef688c@bytedance.com>
Date: Mon, 30 Dec 2024 13:01:29 +0800
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/17] mm: pgtable: remove tlb_remove_page_ptdesc()
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>, kevin.brodsky@arm.com,
 peterz@infradead.org, agordeev@linux.ibm.com, tglx@linutronix.de,
 david@redhat.com, jannh@google.com, hughd@google.com, yuzhao@google.com,
 willy@infradead.org, muchun.song@linux.dev, vbabka@kernel.org,
 lorenzo.stoakes@oracle.com, rientjes@google.com, vishal.moola@gmail.com,
 arnd@arndb.de, will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 dave.hansen@linux.intel.com, ryan.roberts@arm.com, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org
References: <cover.1734945104.git.zhengqi.arch@bytedance.com>
 <b37435768345e0fcf7ea358f69b4a71767f0f530.1734945104.git.zhengqi.arch@bytedance.com>
 <Z2_EPmOTUHhcBegW@kernel.org>
 <9cac5690-c570-4d43-a6bc-2b59b85497ae@bytedance.com>
 <20241229205545.e4fa797886f30cb20c38ad06@linux-foundation.org>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20241229205545.e4fa797886f30cb20c38ad06@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 2024/12/30 12:55, Andrew Morton wrote:
> On Mon, 30 Dec 2024 11:12:00 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
>>> For now struct ptdesc overlaps struct page, but the goal is to have them
>>> separate and always operate on struct ptdesc when working with page tables.
>>
>> OK, so tlb_remove_page_ptdesc() and tlb_remove_ptdesc() are somewhat
>> intermediate products of the project.
>>
>> Hi Andrew, can you help remove [PATCH v3 15/17], [PATCH v3 16/17] and
>> [PATCH v3 17/17] from the mm-unstable branch?
>>
>> For [PATCH v3 17/17], I can send it separately later, or Kevin Brodsky
>> can help do this in his patch series. ;)
> 
> I think it would be best if you were to send a v4 series.  Please
> ensure that the changelogs are appropriately updated to reflect these
> (and any other) changes.

Got it. Will send a v4 ASAP (remove [PATCH v3 15/17] and
[PATCH v3 16/17], keep [PATCH v3 17/17]).

Thanks!

> 
