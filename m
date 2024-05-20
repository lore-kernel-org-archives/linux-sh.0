Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D636034CDE;
	Mon, 20 May 2024 18:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716228304; cv=none; b=XhXirj86UXBDMRKKpJhxZWlVQhMj42As2Pxlt1/gqqPTKKvaPuGaBdslrMEjP4SGK/FJVZR8p8dn9lhkm0+4voZKJeGfpE62VnzZzFCsLTF64iA+n1JHxTxHmWqlLF5n4UuTJGh8Rlt40zSpVQUdv81lLhh+QPla6yUUrQpvnMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716228304; c=relaxed/simple;
	bh=kPBtia4xzyfEHTggusZtDrxjOdowelLRyYrYWeNkILQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f5R/miFMCeYDdl/+mmPjQ39TF3WBS/DI4riYJyz9NMJf5pi2Q5GX29OhdnUtb6qB0AWC+n9MhFgC1tF3j0hfqrbDDb/SRPc/3tuV3erS8/EAe3Ll5WxWLKNk4Cnqmg6XDvccZ3cw1BCCR2ntk+gxRIkfrPzGd9LkRmShbpO+b24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oPqJRmaL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oPqJRmaL"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44KBrKQx019730;
	Mon, 20 May 2024 18:04:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=kPBtia4xzyfEHTggusZtDrxjOdowelLRyYrYWeNkILQ=; b=oP
	qJRmaLWnD1kxfGyLqrhRLraaRQxTiPHZ34Yr70W5m31c5hQrsi/w2EVEc/1h5MNP
	/xwaCAuJhuwn/6d3SwZkPYfELmhCh4lphZrtWnGfr229fq+AYsW+REjL8QwZxohl
	gUp6hSA2yPN31s/W1ET0d3ZeTfZFsm4//GqeoUCtblCMhssvIkYPulXrHXFGWDpg
	W8njs4W/zWi3LoGQU6hAcW3lDn9aXg9M32CqYOELDkvuD96fHLxUkUI96apyj/Hf
	gHHaP0piTndidCTZHdYiaZQQ0a4x9jeL/IyH3k+2zjnktVo544JpoosyowWNl0Hf
	LlY5PY7O1VYJJf1xI6PQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6n4p4d8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 18:04:40 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44KI4JEw007304
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 18:04:19 GMT
Received: from [10.110.126.173] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 20 May
 2024 11:04:15 -0700
Message-ID: <e6436f2f-ac51-4f18-90f2-e39a2ff1c520@quicinc.com>
Date: Mon, 20 May 2024 11:03:50 -0700
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
 <ec5f3194-7e9e-4cc9-86b9-02a204649246@quicinc.com>
 <0e813c8498bf3d9ed5d8fd5b171ac9980dc2999c.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
In-Reply-To: <0e813c8498bf3d9ed5d8fd5b171ac9980dc2999c.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fnn3RhToGM7W8LpYoAZBiwrfbmQxHCc6
X-Proofpoint-GUID: fnn3RhToGM7W8LpYoAZBiwrfbmQxHCc6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_09,2024-05-17_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0 spamscore=0
 impostorscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 mlxlogscore=624 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405200145


On 5/7/2024 3:41 PM, John Paul Adrian Glaubitz wrote:
> Hello Oreoluwa,
>
> On Tue, 2024-05-07 at 14:42 -0700, Oreoluwa Babatunde wrote:
>> memblock_alloc() marks all its allocations as reserved by calling
>> memblock_reserve().
>> https://elixir.bootlin.com/linux/latest/source/mm/memblock.c#L1463
>>
>> This should normally stop other users from allocating from within that
>> region of memory.
>>
>> But in this case, since all the free memory regions have already been
>> transferred over to the bootmem framework by paging_init(), I am not
>> sure if that logic will still hold for the unflatten_deivcetree allocated memory.
>>
>> The main goal of this patch is to make sure that the reserved memory
>> regions defined in the DT are set aside before any memblock allocations
>> are done (which includes the allocation done by unflatten_devicetree).
>>
>> Hence, I can restructure the patch to only remove the portion of code that is
>> is responsible for setting aside the DT defined reserved memory regions from
>> within paging_init(), and move it above the unflatten_devicetree() call.
>> https://elixir.bootlin.com/linux/latest/source/arch/sh/mm/init.c#L292
>>
>> I will explore further and possibly restructure this patch based on my findings.
> OK, sounds like a plan. In the meantime, I have set up my J2 Turtle Board and
> I am actually now able to test patches for this target, so that I would be
> able to verify that your patch didn't break anything.
>
> However, I think for v6.10 I think the ship has sailed.
>
> Adrian
Hi Adrian,

I have uploaded v3 of this patch now.
https://lore.kernel.org/all/20240520175802.2002183-1-quic_obabatun@quicinc.com/

In this new version, paging_init() is left in its original position and only the portion
of code that is responsible for setting aside the reserved memory regions is moved.

Thank you!
Oreoluwa
