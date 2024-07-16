Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691263FD4;
	Tue, 16 Jul 2024 00:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721088793; cv=none; b=WdpBZibHOuIUMxM/ofYx6j2ea7+LZvusALlLoFwVGV2jvFrx0mfdYLoGfMDiCZX7qXauR3I/ekbw8Ex1/OrtThWUNmesENHv49bKly3EQEZ3sZv+jR5V+YxwJrdTRK9ECFxwxsOeuFqF6wKjvog2IUsNkomwIL5N8/C1RrSGcTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721088793; c=relaxed/simple;
	bh=IECHwpDw7bZCOxZMSCqmkTZjycT1fyvO94gBHPARIfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SQYXgiKNT9+IG3bEtn0wOUa1Uj1oRF7PaGOm6GbAnu0crzZnqoPAkPWKMPi2T/6+vkz+CLnePu2hmbx010q5SXa0XsA92C5/O/RJYyVi+ZpvP3VLts51GdwJVrQoMWZ7yiXTbfpfRnUaB4c8znUDEZS+fp9NjrNnQf8uWVzcjjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iEzX+fRU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iEzX+fRU"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FH8xl9031993;
	Tue, 16 Jul 2024 00:12:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DEOdlO8zDMSoDPDlRdvvxulGld1btP9q++cglxsjV6I=; b=iEzX+fRUnxKxlrkI
	gVArJB2ZYBNr/T587f66f8BJgpzjGufvjPjSpLaf+qo7md7cjGZL5x831ItvpXcY
	U7Bq33zuJ2LAoy4/pe6O5nOeZmj65mG4oT0YyjqpmZCzZxWK0HMlZJm4lfAzeovw
	bxH5o4sku2SS30iG0yddxdUi9GmbdL70corsZxQwbls/HQ6rZaLwylalJdr4M2fY
	69nM+xWiTWxjtj4VFOaE4hW0qorC/o5GPLu2Mj5TRkezz/l5PTaDXFu68RG4+E81
	kOOaQt2CLHDIjmon9N6+m/Pb7VBZne7iaGuPbM1pdKqbY/dayOaA1Ocfu6tq3MOH
	1jtVFQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40bjrjdghy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 00:12:52 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46G0Cqtc025805
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 00:12:52 GMT
Received: from [10.71.109.148] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 15 Jul
 2024 17:12:49 -0700
Message-ID: <121b8077-bc6d-42a3-8ec2-c792e84bd947@quicinc.com>
Date: Mon, 15 Jul 2024 17:12:42 -0700
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] sh: Restructure setup code to reserve memory regions
 earlier
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        <ysato@users.sourceforge.jp>, <dalias@libc.org>
CC: <linux-sh@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <kernel@quicinc.com>
References: <20240711214438.3920702-1-quic_obabatun@quicinc.com>
 <a68b7cd0e3b143f023414feca279deb768d43575.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
In-Reply-To: <a68b7cd0e3b143f023414feca279deb768d43575.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fnGclF2WBtyivyEoc-JZlGKenfGPRtt9
X-Proofpoint-ORIG-GUID: fnGclF2WBtyivyEoc-JZlGKenfGPRtt9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_17,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407160000


On 7/13/2024 12:58 AM, John Paul Adrian Glaubitz wrote:

Hi Adrian,

>> diff --git a/arch/sh/include/asm/setup.h b/arch/sh/include/asm/setup.h
>> index 84bb23a771f3..f8b814fb1c7f 100644
>> --- a/arch/sh/include/asm/setup.h
>> +++ b/arch/sh/include/asm/setup.h
>> @@ -19,7 +19,6 @@
>>  #define COMMAND_LINE ((char *) (PARAM+0x100))
>>  
>>  void sh_mv_setup(void);
>> -void check_for_initrd(void);
>>  void per_cpu_trap_init(void);
>>  void sh_fdt_init(phys_addr_t dt_phys);
>>  
>> diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
>> index 620e5cf8ae1e..8477491f4ffd 100644
>> --- a/arch/sh/kernel/setup.c
>> +++ b/arch/sh/kernel/setup.c
>> @@ -35,6 +35,7 @@
>>  #include <asm/io.h>
>>  #include <asm/page.h>
>>  #include <asm/elf.h>
>> +#include <asm/kexec.h>
>>  #include <asm/sections.h>
>>  #include <asm/irq.h>
>>  #include <asm/setup.h>
>> @@ -114,7 +115,7 @@ static int __init early_parse_mem(char *p)
>>  }
>>  early_param("mem", early_parse_mem);
>>  
>> -void __init check_for_initrd(void)
>> +static void __init check_for_initrd(void)
>>  {
>>  #ifdef CONFIG_BLK_DEV_INITRD
>>  	unsigned long start, end;
>> @@ -172,6 +173,42 @@ void __init check_for_initrd(void)
>>  #endif
>>  }
> Making check_for_initrd() static seems like an unrelated change to me or am
> I missing something? If yes, it should go into a separate patch.
ack.
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
> I'm not really happy with moving early_reserve_mem() from mm/init.c to
> kernel/setup.c. Can't we just leave it where it is while still keeping
> the changes to paging_init()?
ack.
>
>> @@ -319,9 +356,14 @@ void __init setup_arch(char **cmdline_p)
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

I'll make adjustments based on your comments and
resend another version.

Thanks,
Oreoluwa
