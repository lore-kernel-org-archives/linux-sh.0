Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D77156F54;
	Tue, 23 Jul 2024 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721754017; cv=none; b=gcY2URCtpZNIMb0PwtAqNKwXfyrimhFVB2kvj/MeDbNvRWT7DItFxG6NBBJBfztn7OuQ9XVNb5lXM/4IP+mc3UytClDPLlsi732T9qITn+fRwSor8hRGLFJFAqzod/1+Xj0tlKJfOqwfqB1LklpUaECye6uKXBBWO49LLVdbinQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721754017; c=relaxed/simple;
	bh=4GrRylsdB0mp1TqIwIq6Dg6WHxP0uXAxjk5b6WquL4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HlCqq01aQWoz8bGuztx05U9sPqDvIDQONyKTLzGmI1h58CeUTXhZto/gxuvTB5XdygvYHMHThG2Sgu9QBq+6t+KS5DE0N264J9ubCXdGBXZyV6tbmDPYCJuvcWAXV6l7u+GeJUPyQbxA1KJVx/nPXUT1JJuT70JV7y4LsWVuy3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=H3wwsIMb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="H3wwsIMb"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46N9q4bj009144;
	Tue, 23 Jul 2024 16:59:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4GrRylsdB0mp1TqIwIq6Dg6WHxP0uXAxjk5b6WquL4w=; b=H3wwsIMbYsYqj0Qo
	rEtGlyRqE85r74yLqTF40pwk7fniFilkcyN5yJDfK4ExzJeEVMMywQpftKQSPQac
	dp84bixfeScjU/wiZ3b/lbuGpZCWcVH5Tb26DYn3PvG6eYB6t/luG5NJzQc/SCUw
	x5mY1ZhJxCREHaxmGhgt++sgI/IYuiHq9DB3GztawNydknkYgwvvXtdYIeMaNjX0
	2CI9P/531H2fxMY4IEykuCY0h0ozHt0B+LOqZZ1AgifeEQ0FmrIs0KsAGsbQJWYl
	/ydB+2mnlxbuxVhjyPX4B+1xsLCpgeJsFKdXIV9C6GGG7597alxWrMNVblHm1R0D
	++n0mw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g487fm8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 16:59:55 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46NGxreD027379
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 16:59:53 GMT
Received: from [10.110.73.223] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Jul
 2024 09:59:50 -0700
Message-ID: <5ea6b07e-7583-45f6-afd1-05f2856bea27@quicinc.com>
Date: Tue, 23 Jul 2024 09:59:44 -0700
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
 <636943c1-6e32-4dd1-abdd-5a110e9aa07c@quicinc.com>
 <d12de025cfb71bcf2a86aa54251aac20f16d32b7.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
In-Reply-To: <d12de025cfb71bcf2a86aa54251aac20f16d32b7.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: iMk1Q4DWqact0PwbnYfnVZng_N2Sbp4s
X-Proofpoint-GUID: iMk1Q4DWqact0PwbnYfnVZng_N2Sbp4s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_05,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 mlxlogscore=560
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407230117


On 7/23/2024 12:57 AM, John Paul Adrian Glaubitz wrote:
> Hi Oreluwa,
>
> On Wed, 2024-07-17 at 19:22 -0700, Oreoluwa Babatunde wrote:
>> Thanks for your feedback and for working with me on this.
>> I have uploaded a new version here:
>> https://lore.kernel.org/all/20240718021822.1545976-1-quic_obabatun@quicinc.com/
>>
>> Please let me know if this properly addresses your comments.
> Thanks. I'll have another look this week, including testing.
>
> But I have decided to send the pull request to Linus for v6.11 now,
> so I don't have to hurry with the review.
>
> Adrian
ack.

Thank you!
