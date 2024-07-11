Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DA519EEB5;
	Thu, 11 Jul 2024 21:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720734654; cv=none; b=kHHV312nNsm0huk/6EqED0mmlb7f6W2TdWAJ1Hyc+8V7yilHzpBreLZZmPSNuDVpC73oHHx2S/hRk2hCsbcu2Y5MzstCC5OzLR1iDmf4U491iSPTtfvKPCX/9uqXKJMdrePD8H4dU9qmtp525ATtqdoyjJ3Ty+D2u+3ICpYPvjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720734654; c=relaxed/simple;
	bh=aHPJQOrogz3kbFJvr1CRGRbLVk85aTsCDiiqA1RvceA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iX6f6GN12gl1oR/EZzM3VynHpxLXlAbpiBlt8XHbw9ZVWTPP6Wv/4VumII/HmzvjqnEcZbb4zG3MVCiLgeUHgzzcctRMrBCgOREt821J+1GPa9+xRe4wNzptgJJN0n3SNloWTE+s+jewrAXsNaiN/6jke1KSKJ/lj0Ytp0+O8lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IvYnR1G1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IvYnR1G1"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BCdaA2017998;
	Thu, 11 Jul 2024 21:50:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vIdYcJF0eNQWdR//iBxtiLTn8GHmcsPFnlzxI0peuWQ=; b=IvYnR1G14jyl+6v0
	RbfN8wX0gaN2762R/jc6GXE0KJGDp3r53uPh2381rGXNXIgNEPCF+w2XXHTAAd/X
	GwXzPSUVMKqkXFKpqFXTa+PNSOYpWFawE8I2eNFJFeIxvYGMuF/PYo7jWPS27tol
	RxHSG9KB1YqYCpNksdCJ/bke1jDAETRzMt5ZUNpy2TXvRsxfL8ZjXKbWJzp0VBhm
	hV1sSWb+bLxh5rtKfWZPpj7OvuzkZ+7XHPYX3bUfm/oHPVG4wRRxtes3MU4ftlmP
	Z6G9OAqYnB8XIOTnEYR1aDa4w3f84P0+h3cY5T9NET5dwdC0R1dzCrUAqOQqMf+d
	b/f8DQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40a8uhtaru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 21:50:32 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46BLoViV031608
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 21:50:31 GMT
Received: from [10.71.109.148] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 11 Jul
 2024 14:50:28 -0700
Message-ID: <fd55bf91-cc59-403f-bbba-88b63c8535df@quicinc.com>
Date: Thu, 11 Jul 2024 14:50:22 -0700
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sh: Restructure setup code to reserve memory regions
 earlier
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        <ysato@users.sourceforge.jp>, <dalias@libc.org>
CC: <linux-sh@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <kernel@quicinc.com>
References: <20240520175802.2002183-1-quic_obabatun@quicinc.com>
 <47f3716dd48ecdc35d823fbab087332fbf3a24d5.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
In-Reply-To: <47f3716dd48ecdc35d823fbab087332fbf3a24d5.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ljrfg-2MBx_vM9L9ngQz-bIrnOY0F2TU
X-Proofpoint-ORIG-GUID: ljrfg-2MBx_vM9L9ngQz-bIrnOY0F2TU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_16,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407110154


On 7/11/2024 4:07 AM, John Paul Adrian Glaubitz wrote:
> Hi Oreoluwa,
>
> On Mon, 2024-05-20 at 10:58 -0700, Oreoluwa Babatunde wrote:
>> The unflatten_device_tree() function contains a call to
>> memblock_alloc(). This is a problem because this allocation is done
>> before any of the reserved memory regions are set aside in
>> paging_init().
>> As a result, there is a possibility for memblock to unknowingly allocate
>> from any of the memory regions that are meant to be reserved.
>>
>> Hence, restructure the setup code to set aside reserved memory
>> regions before any allocations are done using memblock.
>>
>> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
>> ---
>> v3:
>> - Instead of moving all of paging_init(), move only the parts
>>   that are responsible for setting aside the reserved memory
>>   regions.
>>
>> v2:
>> https://lore.kernel.org/all/20240423233150.74302-1-quic_obabatun@quicinc.com/
>> - Added Rob Herrings Reviewed-by.
>> - cc Andrew Morton to assist with merging this for sh architecture.
>>   Similar change made for loongarch and openrisc in v1 have already
>>   been merged.
>>
>> v1:
>> https://lore.kernel.org/all/1707524971-146908-4-git-send-email-quic_obabatun@quicinc.com/
>>
>>  arch/sh/include/asm/setup.h |  1 -
>>  arch/sh/kernel/setup.c      | 43 +++++++++++++++++++++++++++++++++++-
>>  arch/sh/mm/init.c           | 44 -------------------------------------
>>  3 files changed, 42 insertions(+), 46 deletions(-)
>>
>> diff --git a/arch/sh/include/asm/setup.h b/arch/sh/include/asm/setup.h
>> index fc807011187f..5feed99b9b7a 100644
>> --- a/arch/sh/include/asm/setup.h
>> +++ b/arch/sh/include/asm/setup.h
>> @@ -19,7 +19,6 @@
>>  #define COMMAND_LINE ((char *) (PARAM+0x100))
>>  
>>  void sh_mv_setup(void);
>> -void check_for_initrd(void);
>>  void per_cpu_trap_init(void);
>>  
>>  #endif /* _SH_SETUP_H */
>> diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
>> index 620e5cf8ae1e..f5b6078173c9 100644
>> --- a/arch/sh/kernel/setup.c
>> +++ b/arch/sh/kernel/setup.c
>> @@ -114,7 +114,7 @@ static int __init early_parse_mem(char *p)
>>  }
>>  early_param("mem", early_parse_mem);
>>  
>> -void __init check_for_initrd(void)
>> +static void __init check_for_initrd(void)
>>  {
>>  #ifdef CONFIG_BLK_DEV_INITRD
>>  	unsigned long start, end;
>> @@ -172,6 +172,42 @@ void __init check_for_initrd(void)
>>  #endif
>>  }
>>  
>> +static void __init early_reserve_mem(void)
>> +{
>> +	unsigned long start_pfn;
>> +	u32 zero_base = (u32)__MEMORY_START + (u32)PHYSICAL_OFFSET;
>> +	u32 start = zero_base + (u32)CONFIG_ZERO_PAGE_OFFSET;
>> +
>> +	/*
>> +	 * Partially used pages are not usable - thus
>> +	 * we are rounding upwards:
>> +	 */
>> +	start_pfn = PFN_UP(__pa(_end));
>> +
>> +	/*
>> +	 * Reserve the kernel text and Reserve the bootmem bitmap. We do
>> +	 * this in two steps (first step was init_bootmem()), because
>> +	 * this catches the (definitely buggy) case of us accidentally
>> +	 * initializing the bootmem allocator with an invalid RAM area.
>> +	 */
>> +	memblock_reserve(start, (PFN_PHYS(start_pfn) + PAGE_SIZE - 1) - start);
>> +
>> +	/*
>> +	 * Reserve physical pages below CONFIG_ZERO_PAGE_OFFSET.
>> +	 */
>> +	if (CONFIG_ZERO_PAGE_OFFSET != 0)
>> +		memblock_reserve(zero_base, CONFIG_ZERO_PAGE_OFFSET);
>> +
>> +	/*
>> +	 * Handle additional early reservations
>> +	 */
>> +	check_for_initrd();
>> +	reserve_crashkernel();
>> +
>> +	if (sh_mv.mv_mem_reserve)
>> +		sh_mv.mv_mem_reserve();
>> +}
>> +
>>  #ifndef CONFIG_GENERIC_CALIBRATE_DELAY
>>  void calibrate_delay(void)
>>  {
>> @@ -319,9 +355,14 @@ void __init setup_arch(char **cmdline_p)
>>  
>>  	sh_mv_setup();
>>  
>> +	sh_mv.mv_mem_init();
>> +
>>  	/* Let earlyprintk output early console messages */
>>  	sh_early_platform_driver_probe("earlyprintk", 1, 1);
>>  
>> +	/* set aside reserved memory regions */
>> +	early_reserve_mem();
>> +
>>  #ifdef CONFIG_OF_EARLY_FLATTREE
>>  #ifdef CONFIG_USE_BUILTIN_DTB
>>  	unflatten_and_copy_device_tree();
>> diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
>> index bf1b54055316..4559f5bea782 100644
>> --- a/arch/sh/mm/init.c
>> +++ b/arch/sh/mm/init.c
>> @@ -242,55 +242,11 @@ static void __init do_init_bootmem(void)
>>  	sparse_init();
>>  }
>>  
>> -static void __init early_reserve_mem(void)
>> -{
>> -	unsigned long start_pfn;
>> -	u32 zero_base = (u32)__MEMORY_START + (u32)PHYSICAL_OFFSET;
>> -	u32 start = zero_base + (u32)CONFIG_ZERO_PAGE_OFFSET;
>> -
>> -	/*
>> -	 * Partially used pages are not usable - thus
>> -	 * we are rounding upwards:
>> -	 */
>> -	start_pfn = PFN_UP(__pa(_end));
>> -
>> -	/*
>> -	 * Reserve the kernel text and Reserve the bootmem bitmap. We do
>> -	 * this in two steps (first step was init_bootmem()), because
>> -	 * this catches the (definitely buggy) case of us accidentally
>> -	 * initializing the bootmem allocator with an invalid RAM area.
>> -	 */
>> -	memblock_reserve(start, (PFN_PHYS(start_pfn) + PAGE_SIZE - 1) - start);
>> -
>> -	/*
>> -	 * Reserve physical pages below CONFIG_ZERO_PAGE_OFFSET.
>> -	 */
>> -	if (CONFIG_ZERO_PAGE_OFFSET != 0)
>> -		memblock_reserve(zero_base, CONFIG_ZERO_PAGE_OFFSET);
>> -
>> -	/*
>> -	 * Handle additional early reservations
>> -	 */
>> -	check_for_initrd();
>> -	reserve_crashkernel();
>> -}
>> -
>>  void __init paging_init(void)
>>  {
>>  	unsigned long max_zone_pfns[MAX_NR_ZONES];
>>  	unsigned long vaddr, end;
>>  
>> -	sh_mv.mv_mem_init();
>> -
>> -	early_reserve_mem();
>> -
>> -	/*
>> -	 * Once the early reservations are out of the way, give the
>> -	 * platforms a chance to kick out some memory.
>> -	 */
>> -	if (sh_mv.mv_mem_reserve)
>> -		sh_mv.mv_mem_reserve();
>> -
>>  	memblock_enforce_memory_limit(memory_limit);
>>  	memblock_allow_resize();
>>  
> This is missing an include of <asm/kexec.h> in arch/sh/kernel/setup.c:
>
>   CC      io_uring/notif.o
>   CC      lib/zlib_inflate/inftrees.o
> arch/sh/kernel/setup.c: In function 'early_reserve_mem':
> arch/sh/kernel/setup.c:205:9: error: implicit declaration of function 'reserve_crashkernel'; did you mean 'parse_crashkernel'? [-Werror=implicit-function-declaration]
>   205 |         reserve_crashkernel();
>       |         ^~~~~~~~~~~~~~~~~~~
>       |         parse_crashkernel
>   CC      net/core/flow_dissector.o
>   AR      block/partitions/built-in.a
>   CC      block/elevator.o
>   CC      block/blk-core.o
> cc1: some warnings being treated as errors
>   CC      crypto/shash.o
> make[4]: *** [scripts/Makefile.build:244: arch/sh/kernel/setup.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
>   CC      crypto/crc32c_generic.o
>
> Can you fix that? And, while at it, also rebase the patch against v6.10-rc1
> so it applies cleanly against my SH Linux tree?
>
> Besides, I have tested the patch and I can confirm that my J2 board still
> boots fine with the patch applied.
>
> Sorry for being so super-late with the review. I hope you can still send
> an updated patch by tomorrow or Saturday.
>
> Adrian
Hi Adrian,

Thanks for taking a look and testing the patch!

I have made the changes you mentioned and
uploaded the new version of the patch here:
https://lore.kernel.org/all/20240711214438.3920702-1-quic_obabatun@quicinc.com/

Please let me know if you need me to do anything else.

Regards,
Oreoluwa
