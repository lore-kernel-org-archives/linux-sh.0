Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86B41CB31A;
	Tue,  2 Jul 2024 19:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719948600; cv=none; b=c3AgPtXZAhClwQw8w2WhbyXwSGVqXvtO2CcIoR4FJylYPVdq0NzMkdJbGQVmN2UgzOTaikmtOySlaqosxS3Ulrs2/fntvyysz0quwNwRVj2H3BMUYdgQB8FcMNDbtBaDccwxtZfkp/Ytijj9LDe3nkEk5zTFe4qPmSmUUip7vSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719948600; c=relaxed/simple;
	bh=QBuD6Hut5dXpP5+pOc/zp3Scvh4JqCBY73zfdr7Da1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=HbzoTdACleDvsnECz2ZBz8mWDsFGPSbFaeCSVnwJjw5KuXXoeK2Cfpll+oDc4/RnDeonvrxIVyiZGA3O+jz+1NnJn2cTIVlpSnMzL2mRTtVzAxReUfBQiQQ7ywTqkinWYAJLDDjDHdruP9rO4FqxWsxD716r4AkJjSahlWWnofc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oXRnXDnA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oXRnXDnA"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 462IHocI022894;
	Tue, 2 Jul 2024 19:29:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=+RT/BSqL0fQX1VSaRxxCSz
	uhTf9PbyIl2ux1E/Yd+6M=; b=oXRnXDnAotJLpD1vCix+0Hswn4Z05CCqxbSJ2g
	/8hLsz73BteyTcT4C1A179HIhogievFRmnlifmV2+sPT+R8KdgsZRtZULCrCycyc
	oJNVHEpgCyFFGukpxNDqj8yxvkGU3zWcPeg78t1WJny4veCkSCBtj+9/pNh6yS6J
	AxAe5PfhY6U1crj8SEobD/2fwfjFpqFcUeKdoJEv+nY93Evytu3p+D3MVTLfmkRC
	dyN4o9xe/UwrVfgmWK9h1ZHjwwAUCk75s2zGmZVNlpuBSksLYlcDBBBpbkwH/FsC
	E8yQYkGeXfQbyMLpyvTIoACSjvD0qffm1vrRWWe5A6A6SX7w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40297rspkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jul 2024 19:29:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 462JTen1001294
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Jul 2024 19:29:40 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 2 Jul 2024
 12:29:40 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 2 Jul 2024 12:29:38 -0700
Subject: [PATCH] sh: push-switch: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240702-md-sh-arch-sh-drivers-v1-1-2c5d439a5479@quicinc.com>
X-B4-Tracking: v=1; b=H4sIACFVhGYC/x3MQQqDMBCF4avIrDsQoyj0KqWLSTI2AzUtM1UE8
 e7Grh7f4v07GKuwwb3ZQXkVk0+paG8NxEzlxSipGrzzvRudxzmhZSSN+dqksrIa9o6msWs5DEO
 E+v0qT7L9u49ndSBjDEol5qv2lrJsOJP9WOE4TsfTGl2GAAAA
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker
	<dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
CC: <linux-sh@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: F03KvV2Dd-KvJgc1F4CqwYgAcU6PP5Sk
X-Proofpoint-GUID: F03KvV2Dd-KvJgc1F4CqwYgAcU6PP5Sk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_14,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=941
 lowpriorityscore=0 clxscore=1011 mlxscore=0 suspectscore=0 spamscore=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407020142

With ARCH=sh, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in arch/sh/drivers/push-switch.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
MODULE_DESCRIPTION copied from file prologue:
/*
 * Generic push-switch framework
 *
 * Copyright (C) 2006  Paul Mundt
 */
---
 arch/sh/drivers/push-switch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/drivers/push-switch.c b/arch/sh/drivers/push-switch.c
index 362e4860bf52..1dea43381b5a 100644
--- a/arch/sh/drivers/push-switch.c
+++ b/arch/sh/drivers/push-switch.c
@@ -131,4 +131,5 @@ module_exit(switch_exit);
 
 MODULE_VERSION(DRV_VERSION);
 MODULE_AUTHOR("Paul Mundt");
+MODULE_DESCRIPTION("Generic push-switch framework");
 MODULE_LICENSE("GPL v2");

---
base-commit: 1dfe225e9af5bd3399a1dbc6a4df6a6041ff9c23
change-id: 20240702-md-sh-arch-sh-drivers-40af731eb66c

