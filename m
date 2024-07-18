Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9F11878;
	Thu, 18 Jul 2024 02:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721269388; cv=none; b=b4SSjqmJftHYFixSpMI/3WBVRBmYwoVQRui9WWT/z1bdW2B6jN/bqScCxdX4uBmc5GmSEWBWIGpdvIvXbkO80M2T/8YfcbUC9xqwnMVKb7LXtYf4mkk65/Eh8u6Fe+Iq2LyIsXnuAvjzmaryN9/WsXSn0QLsrhXmeHLohLiem5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721269388; c=relaxed/simple;
	bh=SWGlSnnCp6r/UeWUWzFYEzABelbvPJC5oq8qSW9a4iA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=euc4JWXpXIaeHuv9DbiF7fw+RCZjbMEc5srYk2ojng3LZ8253V1i6W9u+7CaEXTmEYj66ImNbGHqZJcSoPR3eO63yiFr5oPsQRd2DDhjlPLFDCAY9ObVEptiSJdfp0RLw8Z22zel3aF7foFndEyuotCmxXQV+5oVmUUXh2tslUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oIu5tacP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oIu5tacP"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HNvPgp002464;
	Thu, 18 Jul 2024 02:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7EDSnU0UhYtvOz3+3UQTMeKZTVuxzepauOLd3qpkA8A=; b=oIu5tacPoSAdSCZM
	OyhBaxLFK+6xab+RdbRLnbpjtFVGDLjQhtzx8VcNLZhQX8mTP0+z2i05P30XNOPJ
	NJ9vG3pwISEJjItSaEu5/wNXJ+61bteIlC1U43WzfI4jFTBPHEGESx9LsydcHwiR
	zI41wxHxw+Dwiym1WncNiyHEuXPP0Gaw4RRukCn0HkJYnTbXnXxavCQiAWn6wMhJ
	GveIf/TlqyOZZPwFzbGwP4NPWrhRE8SrTg1FERY9RQ1V+ItxyITLe6ur7yBMMi+/
	2t6Vw/TWn2QwfNS4uIQlD9DYwHzl8Qy0+pgjryAVWYkC/O2gA5oTnLn9lXtfdu/v
	PUVJuA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfpm5ps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 02:22:48 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46I2Mleu032257
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 02:22:47 GMT
Received: from [10.110.22.213] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 17 Jul
 2024 19:22:43 -0700
Message-ID: <636943c1-6e32-4dd1-abdd-5a110e9aa07c@quicinc.com>
Date: Wed, 17 Jul 2024 19:22:42 -0700
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
 <121b8077-bc6d-42a3-8ec2-c792e84bd947@quicinc.com>
 <831887db73d9eafc50940315ed44139107bd5f2a.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
In-Reply-To: <831887db73d9eafc50940315ed44139107bd5f2a.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rKCCS08Tmg8Sh-Ws8HqfR4j2Cltxv4iT
X-Proofpoint-GUID: rKCCS08Tmg8Sh-Ws8HqfR4j2Cltxv4iT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_19,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 clxscore=1015 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407180014


On 7/16/2024 3:42 AM, John Paul Adrian Glaubitz wrote:
> Hi Oreoluwa,
>
> On Mon, 2024-07-15 at 17:12 -0700, Oreoluwa Babatunde wrote:
>> On 7/13/2024 12:58 AM, John Paul Adrian Glaubitz wrote:
>>
>> Hi Adrian,
>>
>>>> diff --git a/arch/sh/include/asm/setup.h b/arch/sh/include/asm/setup.h
>>>> index 84bb23a771f3..f8b814fb1c7f 100644
>>>> --- a/arch/sh/include/asm/setup.h
>>>> +++ b/arch/sh/include/asm/setup.h
>>>> @@ -19,7 +19,6 @@
>>>>  #define COMMAND_LINE ((char *) (PARAM+0x100))
>>>>  
>>>>  void sh_mv_setup(void);
>>>> -void check_for_initrd(void);
>>>>  void per_cpu_trap_init(void);
>>>>  void sh_fdt_init(phys_addr_t dt_phys);
>>>>  
>>>> diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
>>>> index 620e5cf8ae1e..8477491f4ffd 100644
>>>> --- a/arch/sh/kernel/setup.c
>>>> +++ b/arch/sh/kernel/setup.c
>>>> @@ -35,6 +35,7 @@
>>>>  #include <asm/io.h>
>>>>  #include <asm/page.h>
>>>>  #include <asm/elf.h>
>>>> +#include <asm/kexec.h>
>>>>  #include <asm/sections.h>
>>>>  #include <asm/irq.h>
>>>>  #include <asm/setup.h>
>>>> @@ -114,7 +115,7 @@ static int __init early_parse_mem(char *p)
>>>>  }
>>>>  early_param("mem", early_parse_mem);
>>>>  
>>>> -void __init check_for_initrd(void)
>>>> +static void __init check_for_initrd(void)
>>>>  {
>>>>  #ifdef CONFIG_BLK_DEV_INITRD
>>>>  	unsigned long start, end;
>>>> @@ -172,6 +173,42 @@ void __init check_for_initrd(void)
>>>>  #endif
>>>>  }
>>> Making check_for_initrd() static seems like an unrelated change to me or am
>>> I missing something? If yes, it should go into a separate patch.
>> ack.
>>>> +static void __init early_reserve_mem(void)
>>>> +{
>>>> +	unsigned long start_pfn;
>>>> +	u32 zero_base = (u32)__MEMORY_START + (u32)PHYSICAL_OFFSET;
>>>> +	u32 start = zero_base + (u32)CONFIG_ZERO_PAGE_OFFSET;
>>>> +
>>>> +	/*
>>>> +	 * Partially used pages are not usable - thus
>>>> +	 * we are rounding upwards:
>>>> +	 */
>>>> +	start_pfn = PFN_UP(__pa(_end));
>>>> +
>>>> +	/*
>>>> +	 * Reserve the kernel text and Reserve the bootmem bitmap. We do
>>>> +	 * this in two steps (first step was init_bootmem()), because
>>>> +	 * this catches the (definitely buggy) case of us accidentally
>>>> +	 * initializing the bootmem allocator with an invalid RAM area.
>>>> +	 */
>>>> +	memblock_reserve(start, (PFN_PHYS(start_pfn) + PAGE_SIZE - 1) - start);
>>>> +
>>>> +	/*
>>>> +	 * Reserve physical pages below CONFIG_ZERO_PAGE_OFFSET.
>>>> +	 */
>>>> +	if (CONFIG_ZERO_PAGE_OFFSET != 0)
>>>> +		memblock_reserve(zero_base, CONFIG_ZERO_PAGE_OFFSET);
>>>> +
>>>> +	/*
>>>> +	 * Handle additional early reservations
>>>> +	 */
>>>> +	check_for_initrd();
>>>> +	reserve_crashkernel();
>>>> +
>>>> +	if (sh_mv.mv_mem_reserve)
>>>> +		sh_mv.mv_mem_reserve();
>>>> +}
>>>> +
>>>>  #ifndef CONFIG_GENERIC_CALIBRATE_DELAY
>>>>  void calibrate_delay(void)
>>>>  {
>>> I'm not really happy with moving early_reserve_mem() from mm/init.c to
>>> kernel/setup.c. Can't we just leave it where it is while still keeping
>>> the changes to paging_init()?
>> ack.
>>>> @@ -319,9 +356,14 @@ void __init setup_arch(char **cmdline_p)
>>>>  
>>>>  	sh_mv_setup();
>>>>  
>>>> +	sh_mv.mv_mem_init();
>>>> +
>>>>  	/* Let earlyprintk output early console messages */
>>>>  	sh_early_platform_driver_probe("earlyprintk", 1, 1);
>>>>  
>>>> +	/* set aside reserved memory regions */
>>>> +	early_reserve_mem();
>>>> +
>>>>  #ifdef CONFIG_OF_EARLY_FLATTREE
>>>>  #ifdef CONFIG_USE_BUILTIN_DTB
>>>>  	unflatten_and_copy_device_tree();
>> I'll make adjustments based on your comments and
>> resend another version.
> Okay, I will wait with my pull request to Linus a few more days then.
>
> Thanks so much for being super patient with me. It took me way too long
> to test and review your patch, but I hope in the end we'll get the best
> possible version merged.
>
> Adrian
Hi Adrian,

Thanks for your feedback and for working with me on this.
I have uploaded a new version here:
https://lore.kernel.org/all/20240718021822.1545976-1-quic_obabatun@quicinc.com/

Please let me know if this properly addresses your comments.

Regards,
Oreoluwa
