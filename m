Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D90F14BF90;
	Thu, 11 Jul 2024 21:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720734317; cv=none; b=o/UDlXRBXK5RPu+Aa2gRWklQl97UHO5vprJ1WGcXV/QIhPrArnKRZSmQuamwrAWzAh+3sqgkELfKLGiHCb/FMn7FyX1SlmHdoyZD572JpGKOXDgwQoadI0oWvxAt2FJJNVMXiIeCoD6nLrCweaoyBSLUsycLTorRN3oQsCQypuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720734317; c=relaxed/simple;
	bh=cwHESjd4NVht/H1+eJKWICsv4jM/PHuJfU0I8cuU7Go=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KaHE96YDsNkhe9UujHdWhLFUVe7firK5e0xyz8eS4SzPOQuGa8/d6HwNOpvlgwBvkqYrBpFBGEaTrKbfPrVlPlgaxYsjsE0K0uNIMkfDZesC9kK13kr8uR85VgZiRB52x0D/V0/zMhI8C/VDYA+vl8rACavSl6EzuESAD+iRNHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T9CFpLHU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T9CFpLHU"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BILd4C032378;
	Thu, 11 Jul 2024 21:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=oWSIWagKjg2eCW1Dq+4n8W
	GvZ6FVFhOoGpu8AKm5PwM=; b=T9CFpLHUkbYOpzg/UlBEihGlST0rPPjb15WiI2
	68MlIDEIPrz2qU9v2wn/5dasEDRDGLQKIAdQK5SIFCIGeXcC9DI2z5E4RXrYMTRC
	Eqh/o9bvAef61oxl+WpzUWr6LSQZeEJT1j7gdjmwsowDzN/rnsQuZYNGWdyBhipK
	Y3qRcVT5xgj11nDxUHpcHNn0cH5vY3elzp728v0XSVky6E+J+RTdV+6XaNnJ0cMC
	4cd2lWkMduEINbcIYuKB+KjnZClzdXB2FWF+Yqk7eOpzLVFKh/lD1YVtGe/NQLRD
	e18uUQQfLUbLBqOqZ4tifMGzOLPcfd8OxdwW3ZPt1im/V8Jw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40ac0ghtk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 21:44:54 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46BLir8b014827
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 21:44:53 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 11 Jul 2024 14:44:50 -0700
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
To: <glaubitz@physik.fu-berlin.de>, <ysato@users.sourceforge.jp>,
        <dalias@libc.org>
CC: <linux-sh@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <kernel@quicinc.com>,
        Oreoluwa Babatunde
	<quic_obabatun@quicinc.com>
Subject: [PATCH v4] sh: Restructure setup code to reserve memory regions earlier
Date: Thu, 11 Jul 2024 14:44:38 -0700
Message-ID: <20240711214438.3920702-1-quic_obabatun@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-ORIG-GUID: SjsFabd5WvJ8cJ1mmhNYeh6fn7Md0FX8
X-Proofpoint-GUID: SjsFabd5WvJ8cJ1mmhNYeh6fn7Md0FX8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_16,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 mlxscore=0 impostorscore=0 clxscore=1011 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407110152

The unflatten_device_tree() function contains a call to
memblock_alloc(). This is a problem because this allocation is done
before any of the reserved memory regions are set aside in
paging_init().
As a result, there is a possibility for memblock to unknowingly allocate
from any of the memory regions that are meant to be reserved.

Hence, restructure the setup code to set aside reserved memory
regions before any allocations are done using memblock.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
v4:
- Rebase patch ontop of v6.10-rc1 as requested by Maintainer.
- Add missing include in arch/sh/kernel/setup.c

v3:
https://lore.kernel.org/all/20240520175802.2002183-1-quic_obabatun@quicinc.com/
- Instead of moving all of paging_init(), move only the parts
  that are responsible for setting aside the reserved memory
  regions.

v2:
https://lore.kernel.org/all/20240423233150.74302-1-quic_obabatun@quicinc.com/
- Add Rob Herrings Reviewed-by.
- cc Andrew Morton to assist with merging this for sh architecture.
  Similar change made for loongarch and openrisc in v1 have already
  been merged.

v1:
https://lore.kernel.org/all/1707524971-146908-4-git-send-email-quic_obabatun@quicinc.com/
 arch/sh/include/asm/setup.h |  1 -
 arch/sh/kernel/setup.c      | 44 ++++++++++++++++++++++++++++++++++++-
 arch/sh/mm/init.c           | 44 -------------------------------------
 3 files changed, 43 insertions(+), 46 deletions(-)

diff --git a/arch/sh/include/asm/setup.h b/arch/sh/include/asm/setup.h
index 84bb23a771f3..f8b814fb1c7f 100644
--- a/arch/sh/include/asm/setup.h
+++ b/arch/sh/include/asm/setup.h
@@ -19,7 +19,6 @@
 #define COMMAND_LINE ((char *) (PARAM+0x100))
 
 void sh_mv_setup(void);
-void check_for_initrd(void);
 void per_cpu_trap_init(void);
 void sh_fdt_init(phys_addr_t dt_phys);
 
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 620e5cf8ae1e..8477491f4ffd 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -35,6 +35,7 @@
 #include <asm/io.h>
 #include <asm/page.h>
 #include <asm/elf.h>
+#include <asm/kexec.h>
 #include <asm/sections.h>
 #include <asm/irq.h>
 #include <asm/setup.h>
@@ -114,7 +115,7 @@ static int __init early_parse_mem(char *p)
 }
 early_param("mem", early_parse_mem);
 
-void __init check_for_initrd(void)
+static void __init check_for_initrd(void)
 {
 #ifdef CONFIG_BLK_DEV_INITRD
 	unsigned long start, end;
@@ -172,6 +173,42 @@ void __init check_for_initrd(void)
 #endif
 }
 
+static void __init early_reserve_mem(void)
+{
+	unsigned long start_pfn;
+	u32 zero_base = (u32)__MEMORY_START + (u32)PHYSICAL_OFFSET;
+	u32 start = zero_base + (u32)CONFIG_ZERO_PAGE_OFFSET;
+
+	/*
+	 * Partially used pages are not usable - thus
+	 * we are rounding upwards:
+	 */
+	start_pfn = PFN_UP(__pa(_end));
+
+	/*
+	 * Reserve the kernel text and Reserve the bootmem bitmap. We do
+	 * this in two steps (first step was init_bootmem()), because
+	 * this catches the (definitely buggy) case of us accidentally
+	 * initializing the bootmem allocator with an invalid RAM area.
+	 */
+	memblock_reserve(start, (PFN_PHYS(start_pfn) + PAGE_SIZE - 1) - start);
+
+	/*
+	 * Reserve physical pages below CONFIG_ZERO_PAGE_OFFSET.
+	 */
+	if (CONFIG_ZERO_PAGE_OFFSET != 0)
+		memblock_reserve(zero_base, CONFIG_ZERO_PAGE_OFFSET);
+
+	/*
+	 * Handle additional early reservations
+	 */
+	check_for_initrd();
+	reserve_crashkernel();
+
+	if (sh_mv.mv_mem_reserve)
+		sh_mv.mv_mem_reserve();
+}
+
 #ifndef CONFIG_GENERIC_CALIBRATE_DELAY
 void calibrate_delay(void)
 {
@@ -319,9 +356,14 @@ void __init setup_arch(char **cmdline_p)
 
 	sh_mv_setup();
 
+	sh_mv.mv_mem_init();
+
 	/* Let earlyprintk output early console messages */
 	sh_early_platform_driver_probe("earlyprintk", 1, 1);
 
+	/* set aside reserved memory regions */
+	early_reserve_mem();
+
 #ifdef CONFIG_OF_EARLY_FLATTREE
 #ifdef CONFIG_USE_BUILTIN_DTB
 	unflatten_and_copy_device_tree();
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index bf1b54055316..4559f5bea782 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -242,55 +242,11 @@ static void __init do_init_bootmem(void)
 	sparse_init();
 }
 
-static void __init early_reserve_mem(void)
-{
-	unsigned long start_pfn;
-	u32 zero_base = (u32)__MEMORY_START + (u32)PHYSICAL_OFFSET;
-	u32 start = zero_base + (u32)CONFIG_ZERO_PAGE_OFFSET;
-
-	/*
-	 * Partially used pages are not usable - thus
-	 * we are rounding upwards:
-	 */
-	start_pfn = PFN_UP(__pa(_end));
-
-	/*
-	 * Reserve the kernel text and Reserve the bootmem bitmap. We do
-	 * this in two steps (first step was init_bootmem()), because
-	 * this catches the (definitely buggy) case of us accidentally
-	 * initializing the bootmem allocator with an invalid RAM area.
-	 */
-	memblock_reserve(start, (PFN_PHYS(start_pfn) + PAGE_SIZE - 1) - start);
-
-	/*
-	 * Reserve physical pages below CONFIG_ZERO_PAGE_OFFSET.
-	 */
-	if (CONFIG_ZERO_PAGE_OFFSET != 0)
-		memblock_reserve(zero_base, CONFIG_ZERO_PAGE_OFFSET);
-
-	/*
-	 * Handle additional early reservations
-	 */
-	check_for_initrd();
-	reserve_crashkernel();
-}
-
 void __init paging_init(void)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES];
 	unsigned long vaddr, end;
 
-	sh_mv.mv_mem_init();
-
-	early_reserve_mem();
-
-	/*
-	 * Once the early reservations are out of the way, give the
-	 * platforms a chance to kick out some memory.
-	 */
-	if (sh_mv.mv_mem_reserve)
-		sh_mv.mv_mem_reserve();
-
 	memblock_enforce_memory_limit(memory_limit);
 	memblock_allow_resize();
 
-- 
2.34.1

