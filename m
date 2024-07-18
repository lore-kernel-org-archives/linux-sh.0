Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660491878;
	Thu, 18 Jul 2024 02:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721269141; cv=none; b=Q3INLxww5bDqvLZe9kHDrT/K0ZEJAVJ9nr+rNMc7Y5B8DS+ABGl1rO/ojmz3W+3xm7x/+ueNokKx/8k+UCWjEaYhOx9G4SPLiBZqlpBfHbYfQj0LKYKW4NHC+W/SIq28QXC4DD62Ud/6CPk/KoZPOZzIjK0mGc+dwMh452s3Cis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721269141; c=relaxed/simple;
	bh=plpy38mmWamYATXqMVdmrtO/fFzE7ezmP08i+ZyxVFo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uS59ScBrCEcdWRh9XN0ODk54wQlJ2SfYQmAH7fuy95iWd9n1UsVNm1sDVA1ESa1rzAsDUvI7+pKVPNHzJ7PR2T4ustBmKrWzUHTTaxwNzlY+YMe7v99ZSXeVZelVduEeWW4OLbA4IT+Z2kz8nAdykE9jhHWi4YzgpSWwNy7aYGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MAyPFTtX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MAyPFTtX"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HFkDJV012695;
	Thu, 18 Jul 2024 02:18:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=whCRJMaCNaYbhIa4Tl3i8x
	VwOESYWRPPRp7mnXVWxmM=; b=MAyPFTtXiUUv4XHo674PxpADtzCWZsTDwaIjpy
	qxu7K3OHeKWSYoPPifKqcy28Y/Rtjaar2HVJGApk9XuFCyyz/9MRtcpU+9avGm9G
	72bKwyQM3DWrMcF4FRZdq5WzpfHgyzerltJf4/maQBG4forh9qzUHlkiGkvmvili
	uOQ5t39zQP/XGjmehPP357y10ioYt/nRJbShyjaxeg6sQjvLh6Qo+qEXKQPzLB1X
	r78am2pO2tcCsTulXVaq9qFYzWobjO3ZonqB9kiEwv0r4POj+iK6S1p1VfdLNW94
	T/p5o2VZzmuSP+u8Kl0u5puHEfRqxeRAiIMreIadAxLkjfwg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfwc3e8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 02:18:40 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46I2Id1H030971
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
Subject: [PATCH v5 0/2] sh: Restructure setup code to reserve memory regions earlier
Date: Wed, 17 Jul 2024 19:18:20 -0700
Message-ID: <20240718021822.1545976-1-quic_obabatun@quicinc.com>
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
X-Proofpoint-GUID: p0GFaALf-fa3CkYys2_USZ_1NhwG5zqL
X-Proofpoint-ORIG-GUID: p0GFaALf-fa3CkYys2_USZ_1NhwG5zqL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_19,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 mlxlogscore=410 impostorscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407180014

The unflatten_devicetree() function allocates memory from memblock
before the system gets a chance to set aside the regions of memory that
are meant to be reserved.
This means that there is a possibility for memblock to allocate from
these regions, thereby preventing them from being reserved.

This series makes changes to the arch specific setup code to call the
functions responsible for setting aside the reserved memory regions
earlier in the init sequence.

Hence, by the time memblock starts being used to allocate memory, the
memory regions that are meant to be carved out would already be set aside.

Oreoluwa Babatunde (2):
  sh: Restructure call site for early_reserve_mem()
  sh: Restructure setup code to reserve memory regions earlier

 arch/sh/include/asm/mmu.h |  1 +
 arch/sh/kernel/setup.c    |  3 +++
 arch/sh/mm/init.c         | 20 +++++++++-----------
 3 files changed, 13 insertions(+), 11 deletions(-)

-- 
2.34.1

v5:
- Keep the definition of early_reserve_mem() inside "arch/sh/mm/init.c"
  and make it available to be called from the setup code.
- Move the sh_mv reserved memory functions into early_reserve_mem().

v4:
- Rebase patch on top of v6.10-rc1 as requested by Maintainer.
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

