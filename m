Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C60115C9;
	Thu, 18 Jul 2024 02:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721269141; cv=none; b=gx84tnOLG3HYy6zShflV01y8DPK6vxs9tBLb4wclgDdn6vvoLXBzpKr3NGSSqIATr7OM+E+Xx8LIM2Paj+axdiIPrrsiModKkwXaESY/E29/rIkEzkfZZI3KiO/XuGbOPmSl9rbeSDCPs8mP90mUu0NSsgO+kwd5s+HbD0qHxeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721269141; c=relaxed/simple;
	bh=w/e2NqSnrmE1tRqCIsezqabfPYxwJY6lN0kCEP46PDc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AAg+MZfLpWwIcQBGPsvHaBiqT23gqApRI2tHEzjJ3cmvZ69Ei29MGb+zr0Q7TFFqbn5CtSHIul5i62Dh4PX+yqm/+5uG/Tz8a6kUR0pHGqAcZO8qskuP+uiP1Ay+wuauRQ7w8uHjs8gBS2XE7x/MBEVmC37dXlBeErquSOtxKtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=d2w/Zf9O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d2w/Zf9O"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HEtlhA007015;
	Thu, 18 Jul 2024 02:18:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4PdV6SI7MaqpNg7kLZI8izQWRBN+brJg0Qqo5GBUYYw=; b=d2w/Zf9Om5G41pjU
	+nQrQZgpt8/jPKsa4kf2OGIVW0+6lpwc8WoGLJjZhwE1fHwVIzW0ZkS6vhGc5T9i
	ivtaLEC6sBz78smVDvX6gf7twYkF/jzIUpyG4ru03rLk63+4nMfyXMKznUyVtmUD
	2gTAVfROnIiGiHfnoKH1w2SKcdWYShO8cUSpNZ/5WciJUnMtKt1gj7xTI3O30efa
	eeg/bF9XKesqRl7TX9jyZ6YLSoMWGJGsd9W34iSfFhh9VYd7Ww3OBrOg66V+hx22
	ZJt+ey0IlJIxx8EK4GdHvM+nVIecTOtBsgYTKDd5VacPr62CIMu5DAX0MkIUw/h/
	u1QSsQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfxc3sj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 02:18:40 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46I2IdWT015487
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 02:18:39 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Jul 2024 19:18:36 -0700
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
To: <dalias@libc.org>, <glaubitz@physik.fu-berlin.de>,
        <ysato@users.sourceforge.jp>
CC: <kernel@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <linux-sh@vger.kernel.org>, <robh+dt@kernel.org>,
        Oreoluwa Babatunde
	<quic_obabatun@quicinc.com>
Subject: [PATCH v5 2/2] sh: Restructure setup code to reserve memory regions earlier
Date: Wed, 17 Jul 2024 19:18:22 -0700
Message-ID: <20240718021822.1545976-3-quic_obabatun@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718021822.1545976-1-quic_obabatun@quicinc.com>
References: <20240718021822.1545976-1-quic_obabatun@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Gix7L43Y5yrVdhRK9DlDY_5x3dMtjbVs
X-Proofpoint-GUID: Gix7L43Y5yrVdhRK9DlDY_5x3dMtjbVs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_19,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=694 bulkscore=0 adultscore=0
 spamscore=0 clxscore=1015 mlxscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407180014

The unflatten_device_tree() function contains a call to
memblock_alloc(). This is a problem because this allocation is done
before any of the reserved memory regions are set aside in
paging_init().
As a result, there is a possibility for memblock to unknowingly allocate
from any of the memory regions that are meant to be reserved.

Hence, restructure the setup code to reserve the memory regions before
any allocation is done by the unflatten_devicetree*() using memblock.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 arch/sh/mm/init.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 643e3617c6a6..857ce8cc84bd 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -249,6 +249,7 @@ void __init early_reserve_mem(void)
 	u32 zero_base = (u32)__MEMORY_START + (u32)PHYSICAL_OFFSET;
 	u32 start = zero_base + (u32)CONFIG_ZERO_PAGE_OFFSET;
 
+	sh_mv.mv_mem_init();
 	/*
 	 * Partially used pages are not usable - thus
 	 * we are rounding upwards:
@@ -274,14 +275,6 @@ void __init early_reserve_mem(void)
 	 */
 	check_for_initrd();
 	reserve_crashkernel();
-}
-
-void __init paging_init(void)
-{
-	unsigned long max_zone_pfns[MAX_NR_ZONES];
-	unsigned long vaddr, end;
-
-	sh_mv.mv_mem_init();
 
 	/*
 	 * Once the early reservations are out of the way, give the
@@ -289,6 +282,12 @@ void __init paging_init(void)
 	 */
 	if (sh_mv.mv_mem_reserve)
 		sh_mv.mv_mem_reserve();
+}
+
+void __init paging_init(void)
+{
+	unsigned long max_zone_pfns[MAX_NR_ZONES];
+	unsigned long vaddr, end;
 
 	memblock_enforce_memory_limit(memory_limit);
 	memblock_allow_resize();
-- 
2.34.1

