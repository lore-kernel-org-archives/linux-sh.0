Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CD815C3;
	Thu, 18 Jul 2024 02:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721269142; cv=none; b=GATP/+cRFCMIf4AVnc7+E38/LumtFwnqSKqqpivYVj1qV6jaS8aJxRaUIJWmA+K5lAtE27R0ZTaz7iw4q7atpmYIs4xsivgdKRtdDl59hOHwX6jQ3f3JgiDxQYIlZRk7rk+tUJ2WhVIpJV+eLN54S/cM21wokpBeQaLtIkHINpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721269142; c=relaxed/simple;
	bh=/KzmiqZ1DGwvGOZCrjg/tYdiQhsCdmhOg4/3Iz+Fiwg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N+KiOwGLlddXE/Fsnu9YefQp13Bl10cwielfppAvGeqEiNKkp54QXHCapVg6V/h5ec1V5uVSpYu4P3JhrST+Kjex3NVkfHFn8/7458ZVbWJVI8fote9pXXyFZMTZA2JLNgho/3vPYNb43QUrdRmlHaFRug/IL3cTyjr/ESHRLQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XL2pElcW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XL2pElcW"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HFt0Eh029141;
	Thu, 18 Jul 2024 02:18:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UOOKMMmT5K9ZRMdtHreWgAH9PIVNDRgvbwbIqD3C7Zo=; b=XL2pElcWyOEYzN6r
	y7EYbctCLmayXqGwQZekkYklW9Cax5wTrxLj731nRZtosvusOowEpMTq8hL/2ZE8
	szI2TZBgeYcbOo279tzl5YRMiwTb1ibvKrUz5qBgMAxI5bDuI7XzRXDDsQVH2d6r
	V2tdKyLiBLAvoInq/qywZjB6WHgF8l8FtQ0Sk43rfXp6CnM/k7nGeA5/9QevjvQo
	5Jmany51NNgIwDtYE0G8rbjLs2N6vcRRIa6pdQ4SqVkzhHT6v3XdpqFD+oiZU4Pe
	DGMj5uHdLYaHphWSng3DRelOFOSbnIRoESUceSHZapqzJNePHi7LkU0tDM69YxCz
	OcrJDg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfpm5fr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 02:18:40 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46I2Id1I030971
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
Subject: [PATCH v5 1/2] sh: Restructure call site for early_reserve_mem()
Date: Wed, 17 Jul 2024 19:18:21 -0700
Message-ID: <20240718021822.1545976-2-quic_obabatun@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 2PkGXoz85e_Eex27rSNozL6vu--Aad8z
X-Proofpoint-GUID: 2PkGXoz85e_Eex27rSNozL6vu--Aad8z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_19,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 clxscore=1015 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=680
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407180014

early_reserve_mem() reserves memory for important regions in the kernel
such as kernel text region and bootmem bitmap.
Reserving these memory regions should take precedence over any other
reserved memory allocations so that the system does not unknowingly
reserve them for some other use case.

Hence, move the call site of early_reserve_mem() out of the
paging_init() function and into an earlier point in setup_arch()

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 arch/sh/include/asm/mmu.h | 1 +
 arch/sh/kernel/setup.c    | 3 +++
 arch/sh/mm/init.c         | 5 ++---
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/sh/include/asm/mmu.h b/arch/sh/include/asm/mmu.h
index 172e329fd92d..696e303a2f19 100644
--- a/arch/sh/include/asm/mmu.h
+++ b/arch/sh/include/asm/mmu.h
@@ -96,6 +96,7 @@ static inline int pmb_unmap(void __iomem *addr)
 
 #endif /* CONFIG_PMB */
 
+void __init early_reserve_mem(void);
 static inline void __iomem *
 pmb_remap(phys_addr_t phys, unsigned long size, pgprot_t prot)
 {
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 620e5cf8ae1e..3b0bc191a2a2 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -40,6 +40,7 @@
 #include <asm/setup.h>
 #include <asm/clock.h>
 #include <asm/smp.h>
+#include <asm/mmu.h>
 #include <asm/mmu_context.h>
 #include <asm/mmzone.h>
 #include <asm/processor.h>
@@ -319,6 +320,8 @@ void __init setup_arch(char **cmdline_p)
 
 	sh_mv_setup();
 
+	early_reserve_mem();
+
 	/* Let earlyprintk output early console messages */
 	sh_early_platform_driver_probe("earlyprintk", 1, 1);
 
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index bf1b54055316..643e3617c6a6 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -19,6 +19,7 @@
 #include <linux/io.h>
 #include <linux/dma-mapping.h>
 #include <linux/export.h>
+#include <asm/mmu.h>
 #include <asm/mmu_context.h>
 #include <asm/mmzone.h>
 #include <asm/kexec.h>
@@ -242,7 +243,7 @@ static void __init do_init_bootmem(void)
 	sparse_init();
 }
 
-static void __init early_reserve_mem(void)
+void __init early_reserve_mem(void)
 {
 	unsigned long start_pfn;
 	u32 zero_base = (u32)__MEMORY_START + (u32)PHYSICAL_OFFSET;
@@ -282,8 +283,6 @@ void __init paging_init(void)
 
 	sh_mv.mv_mem_init();
 
-	early_reserve_mem();
-
 	/*
 	 * Once the early reservations are out of the way, give the
 	 * platforms a chance to kick out some memory.
-- 
2.34.1

