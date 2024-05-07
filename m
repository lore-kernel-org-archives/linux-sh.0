Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC93745E4;
	Tue,  7 May 2024 21:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715118173; cv=none; b=RqLLNzdSnCEJyUDpQZsb3xI1zwQiv/KBpR4rwnNlASu8dtL+JaP99NBdg6+BMXm5Mxu6mHfDXfssz+aBTJdyWwbPTaV8c+W6g6yPRro4GsFHnSw3w5dDsv1ISYL37C7PCHBPSserrVssp4CyEVy4sf0Qf0Mqy/lPgKTPuoGvizg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715118173; c=relaxed/simple;
	bh=U7DObR7C46rOp9WAJ9Kp1t+6jdidsG351JAUz0jNDZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=deSI8DhSzMIMix4abJznsyZ0FnV0vMADCFpMCRbhWGjJGz6J/Hdx+3R6eMp+WFo9ROkh6TY2rhoiRU760wsQYDzo5S1lvGiPpb73Uo3CXGwR5S6Wa11uVZqj3lwAmrJrfcBMRxahWv2IZnyoMbjiIzPlr6rnSlD5bO6OT9gCyTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bPJ5vXwf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bPJ5vXwf"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 447KJshZ017981;
	Tue, 7 May 2024 21:42:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=gDELcenDVUTdOR/ZE4H7s3yaDipCvxPwDJjdsHdy2uk=; b=bP
	J5vXwfzUH5ib/0JhhS3oOojemgAFrRvcUUX1ZVH/iT+Z0iRMljIsxhlA24MLzlSc
	7Kg2kRAyELip9ydW/nF+G8fcC/IMBqWZ00m3eJ0tXhHq+lxCWH01pW8p+tsbQvaP
	ESjuaYp5lyNeRD7v6oFkV6WqkaHdYVAJI2XWptJHxDQ88xkPa1Xcj4LLZ4pIjv6f
	cbNfN1LgpxPDvbU0Fd+BtjG/pqjHhC0+qzNxJpSkLIj7pJVLv3gAXfivDgel8xFs
	NY5HxlQ4OkjzlvEY0DXsuDSdT+BWBSmpsn7yB9pRUz0DZEwnCKf/E0AOxLt2wJwV
	KBrcNnN1/PZMxZSrH1sA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xyspr0ayb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 21:42:19 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 447LgIj5010004
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 May 2024 21:42:18 GMT
Received: from [10.110.119.86] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 7 May 2024
 14:42:14 -0700
Message-ID: <ec5f3194-7e9e-4cc9-86b9-02a204649246@quicinc.com>
Date: Tue, 7 May 2024 14:42:05 -0700
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sh: Call paging_init() earlier in the init sequence
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        <ysato@users.sourceforge.jp>, <dalias@libc.org>
CC: <akpm@linux-foundation.org>, <linux-sh@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <kernel@quicinc.com>, Rob Herring <robh@kernel.org>,
        Rob Landley <rob@landley.net>
References: <20240423233150.74302-1-quic_obabatun@quicinc.com>
 <72ec7831604326e852eb228072b1d817bab829fb.camel@physik.fu-berlin.de>
 <b00e0adc72815e465cf32fc5505445cfceeeca84.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
In-Reply-To: <b00e0adc72815e465cf32fc5505445cfceeeca84.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FeRwHS4RWyL3Ea5FIRgdOCFmwjviY9ox
X-Proofpoint-GUID: FeRwHS4RWyL3Ea5FIRgdOCFmwjviY9ox
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_13,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 malwarescore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 impostorscore=0 mlxlogscore=772 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405070150


On 5/2/2024 3:29 AM, John Paul Adrian Glaubitz wrote:
> Hi Oreoluwa,
>
> On Wed, 2024-05-01 at 19:18 +0200, John Paul Adrian Glaubitz wrote:
>> Hi Oreoluwa,
>>
>> On Tue, 2024-04-23 at 16:31 -0700, Oreoluwa Babatunde wrote:
>>> The unflatten_device_tree() function contains a call to
>>> memblock_alloc(). This is a problem because this allocation is done
>>> before any of the reserved memory is set aside in paging_init().
>>> This means that there is a possibility for memblock to allocate from
>>> any of the memory regions that are supposed to be set aside as reserved.
>>>
>>> Hence, move the call to paging_init() to be earlier in the init
>>> sequence so that the reserved memory regions are set aside before any
>>> allocations are done using memblock.
>> I was just about to merge your patch when I ran a git blame on the code in
>> arch/sh/kernel/setup.c and noticed the following commit by Rich Felker:
>>
>> commit eb6b6930a70faefe04479a71088cc10366782d9a
>> Author: Rich Felker <dalias@libc.org>
>> Date:   Mon Jul 31 01:27:50 2017 -0400
>>
>>     sh: fix memory corruption of unflattened device tree
>>     
>>     unflatten_device_tree() makes use of memblock allocation, and
>>     therefore must be called before paging_init() migrates the memblock
>>     allocation data to the bootmem framework. Otherwise the record of the
>>     allocation for the expanded device tree will be lost, and will
>>     eventually be clobbered when allocated for another use.
>>     
>>     Signed-off-by: Rich Felker <dalias@libc.org>
>>
>> It looks like that the call to unflatten_device_tree() before paging_init()
>> is intentional and needed for the device tree to be preserved in memory
>> after running paging_init().
Hi John,

Thank you for pointing this out.

memblock_alloc() marks all its allocations as reserved by calling
memblock_reserve().
https://elixir.bootlin.com/linux/latest/source/mm/memblock.c#L1463

This should normally stop other users from allocating from within that
region of memory.

But in this case, since all the free memory regions have already been
transferred over to the bootmem framework by paging_init(), I am not
sure if that logic will still hold for the unflatten_deivcetree allocated memory.

The main goal of this patch is to make sure that the reserved memory
regions defined in the DT are set aside before any memblock allocations
are done (which includes the allocation done by unflatten_devicetree).

Hence, I can restructure the patch to only remove the portion of code that is
is responsible for setting aside the DT defined reserved memory regions from
within paging_init(), and move it above the unflatten_devicetree() call.
https://elixir.bootlin.com/linux/latest/source/arch/sh/mm/init.c#L292

I will explore further and possibly restructure this patch based on my findings.

Thank you!
Oreoluwa
>>
>> @Geert: Do you have any comments on this patch?
>> @Rob: Could you test this patch on your J2 board and report back?
