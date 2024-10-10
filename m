Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279C21C8FBC;
	Thu, 10 Oct 2024 19:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728587103; cv=none; b=RDjxSf8hFAM9YG22zHTajn34nq5RSAtyv+RtbLCFzwgI9Cwb/prl7ui3+hXx2zaxuJjfty0ZNj0OXIfFSSCKLgyhbemml0e8GLYtPkpp2tjKi7uNs43whFuCPQXf0IzRSKT+mJBqfph/abLApjABcpLI29RQQKPXTiyYtC7KLNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728587103; c=relaxed/simple;
	bh=phoNZa9//6972a7VEYUPTIF2z9sXR02KuJ191yz9DBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nb40NE9PLvpWSgqPumthpFedExwT9vOato42CQ1AFSFRGkaa1DI9fGrXiNQYOyYgmPsUdh4gL5DvZ6hGNUTgHI6bN5MEI2gpSTaaBFZcocGqrFlIWUnL5g+sV0HRtc9l6oSfrY9TgoQ7lJ46pf9cZC4LKyJPzpPFZPLxh19PgSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eFx2z6uy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eFx2z6uy"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49ACSV1i022390;
	Thu, 10 Oct 2024 19:04:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	phoNZa9//6972a7VEYUPTIF2z9sXR02KuJ191yz9DBY=; b=eFx2z6uycYzWp2CK
	tW49HvuK4Bf19WTfXoQHcI0bc/bl6jmPca5DMV0/fWH0ruG8DQPu1OPfVumWCa5Y
	fE7QpXzO0xxAjn/D5MCClT0RKT+SCXR29DKtxty7wED5OJ+e0SzInq63PK7TTP2O
	uZOkJpVlSpP4Qnf9P58aX6IfOxgFulLAVTAgHBVYwTUVWOMXAsEdxCVK8xj2sNDD
	heAEL+FkajMbxZjsyvg4G0HhvjppZl9E7Rt2EyJ/xuVXWXg6KctFkAhJk2Mm9tl3
	cGszKB+qZ7F5avYcbG3WgI3q46IcdE5og5sjLUIB5XfEd5pTw+QI026K6A53co4m
	qlIZoQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 425xptugpe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 19:04:45 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49AJ4gER027564
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 19:04:42 GMT
Received: from [10.71.109.85] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 10 Oct
 2024 12:04:39 -0700
Message-ID: <94b7090d-583e-4008-acc3-1aa87d2fe6fa@quicinc.com>
Date: Thu, 10 Oct 2024 12:04:30 -0700
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] sh: Restructure setup code to reserve memory
 regions earlier
To: Artur Rojek <contact@artur-rojek.eu>
CC: <dalias@libc.org>, <glaubitz@physik.fu-berlin.de>,
        <ysato@users.sourceforge.jp>, <kernel@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <linux-sh@vger.kernel.org>,
        <robh+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>
References: <20240718021822.1545976-1-quic_obabatun@quicinc.com>
 <20240718021822.1545976-3-quic_obabatun@quicinc.com>
 <aba64912a7cf700fd281016d4a2ad82d@artur-rojek.eu>
Content-Language: en-US
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
In-Reply-To: <aba64912a7cf700fd281016d4a2ad82d@artur-rojek.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 83left3nMHHMzBaLqF--RnitoKgAqkGt
X-Proofpoint-GUID: 83left3nMHHMzBaLqF--RnitoKgAqkGt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 mlxlogscore=703 lowpriorityscore=0 clxscore=1011
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410100126


On 9/29/2024 2:15 PM, Artur Rojek wrote:
> On 2024-07-18 04:18, Oreoluwa Babatunde wrote:
>> The unflatten_device_tree() function contains a call to
>> memblock_alloc(). This is a problem because this allocation is done
>> before any of the reserved memory regions are set aside in
>> paging_init().
>> As a result, there is a possibility for memblock to unknowingly allocate
>> from any of the memory regions that are meant to be reserved.
>>
>> Hence, restructure the setup code to reserve the memory regions before
>> any allocation is done by the unflatten_devicetree*() using memblock.
>>
>> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
>
> Hi Oreoluwa,
>
>> ---
>>  arch/sh/mm/init.c | 15 +++++++--------
>>  1 file changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
>> index 643e3617c6a6..857ce8cc84bd 100644
>> --- a/arch/sh/mm/init.c
>> +++ b/arch/sh/mm/init.c
>> @@ -249,6 +249,7 @@ void __init early_reserve_mem(void)
>>      u32 zero_base = (u32)__MEMORY_START + (u32)PHYSICAL_OFFSET;
>>      u32 start = zero_base + (u32)CONFIG_ZERO_PAGE_OFFSET;
>>
>> +    sh_mv.mv_mem_init();
>
> One side effect of moving mv_mem_init here is that it makes cache
> operations available earlier. But I see no harm in doing that.
>
> Otherwise the patch is looking good. Verified on J2 Turtle Board.
>
> Reviewed-by: Artur Rojek <contact@artur-rojek.eu>
>
ack.

Thank you for the review Artur!

Regards,
Oreoluwa

