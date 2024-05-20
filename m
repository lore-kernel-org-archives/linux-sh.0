Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5D528E7;
	Mon, 20 May 2024 18:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716230974; cv=none; b=SBEpoHnBdr+ryxJ/WbNWfJDbDZ82CXFNxP1gM6DIPFYaZVDigEKJw66XirFTm//4PA1Pdb4sCvn+khAwofKI1ROSEgb6R5IECamJd4K71ufaAxvi9BUmJJMQZ6tFXZWHu+l6FOKsqL4ABJ0mXfDnuF35B2JZI54oF+7H5kKaEK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716230974; c=relaxed/simple;
	bh=u2m9PqRi31nqcXPRdJ15h40h2RHdmsocERJ8ssKxvJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=snxOIREX4+9XGcYgP4Ea8xNxYI0tcJGWlGBT56Tq6CdOpKxwKMSHKNsSJ21P6YzELZzYbu+UrO4+Yq459mB4J+yuSPvX5UHQU/HnnDFBwnjnx1YUt4SgPWxoTsc32r4qOp/EupUEsVmhPZBQxgRixFAORETjw/j+vdI/g4AYIyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Uevmahz5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Uevmahz5"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44KBtNUd030957;
	Mon, 20 May 2024 18:49:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=u2m9PqRi31nqcXPRdJ15h40h2RHdmsocERJ8ssKxvJ4=; b=Ue
	vmahz5+xafE2pyUMfwhkAQyBLAdP6TGsq05Bd68KjWqnNVJHVeRfg8fGMpIyvkyH
	S+jq4V1OXWv0sSTyziFrr/ozy929LbwQBbvpR5hC5ytvmDOoP4Dpom2Gequ4EPar
	ZJXkCyHQDx33Hdd5GcNzk6kRSl5lvryKF6SITuuyZUSYnjCw/wiFadMy/E+HHSPZ
	QOv9VmEDiHUgybq/NZ5cJ0NHpcH3+bKbyqYg5d7Z2E+a5L3UwNd8Qpm6j8tzeYsL
	FiFtA8OtBzFuzDMLv2+/qD8UypUeVdj3g2rpTN8GTRDdc/AohdyVF8xgUoH7p+7O
	7Ra2aGTdL7kX1ovIHRjg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6pqc48a7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 18:49:10 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44KIn8pu008035
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 18:49:08 GMT
Received: from [10.110.126.173] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 20 May
 2024 11:49:04 -0700
Message-ID: <e3ee7a29-5b2e-4678-91e5-4fe3a0e618c6@quicinc.com>
Date: Mon, 20 May 2024 11:49:03 -0700
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sh: Call paging_init() earlier in the init sequence
Content-Language: en-US
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
 <e6436f2f-ac51-4f18-90f2-e39a2ff1c520@quicinc.com>
 <7130f36dcf6f2272fa61eb1477f881ccea0375f8.camel@physik.fu-berlin.de>
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
In-Reply-To: <7130f36dcf6f2272fa61eb1477f881ccea0375f8.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Gz3yrCDYxGlPnyFqqpBvlLeDU4Cy5cAd
X-Proofpoint-GUID: Gz3yrCDYxGlPnyFqqpBvlLeDU4Cy5cAd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_09,2024-05-17_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=637 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405200150


On 5/20/2024 11:24 AM, John Paul Adrian Glaubitz wrote:
> Hi Oreoluwa,
>
> On Mon, 2024-05-20 at 11:03 -0700, Oreoluwa Babatunde wrote:
>> I have uploaded v3 of this patch now.
>> https://lore.kernel.org/all/20240520175802.2002183-1-quic_obabatun@quicinc.com/
>>
>> In this new version, paging_init() is left in its original position and only the portion
>> of code that is responsible for setting aside the reserved memory regions is moved.
> Thanks a lot for the updated version.
>
> I will give it a try later this week as we had a public holiday in Germany
> today and therefore enjoyed an extended weekend.
>
> If it doesn't break anything and Geert is happy with the change as well,
> I'll pick it up for v6.11.
>
> Adrian

Hi Adrian,

That sounds good, thank you!
Enjoy the extended weekend!

Regards,
Oreoluwa

