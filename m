Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F6329BDAE
	for <linux-sh@vger.kernel.org>; Thu, 12 Feb 2026 19:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770924538; cv=none; b=fh/WBVawQsg29UOk1g2y4Vqy6JsGmRWMqI4d+tUhwceGpLVOAx+3DMqCWZeoelfsIYxHI1zHEV518lfbG3JRyePvyA4Co1EYlEqEVoaso0UdRU2hbXJ/0mPrPnnlUKi9soN4zb8xQScA5DiwG8CfjjOkJSaJzIkrWT0WtDMYsf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770924538; c=relaxed/simple;
	bh=G5XZ6L0QvIVqsEnJspc7BCU8BL94sIUKCV45h1qLzUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s3cpSTeK3S3/rEK2ph4H/slxYsqpt7c73/vNROWLSLSCeyRVtFh3RbOQCTmempRuSBzgWY5Hqi7WnCLASt8Ow/u4cjwgsLrrI3ABz1Me8AyBLCvMA4K+b8WwU6vK6d/tHktBHeIOQFMAHXp0Z/9wXjUBXrdo3IW6FqHlAUfqNDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sony.com; spf=fail smtp.mailfrom=sony.com; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sony.com
Received: from eig-obgw-5001b.ext.cloudfilter.net ([10.0.29.181])
	by cmsmtp with ESMTPS
	id qVMbvAjBfCxrGqcMwv1HtN; Thu, 12 Feb 2026 19:28:54 +0000
Received: from host2044.hostmonster.com ([67.20.76.238])
	by cmsmtp with ESMTPS
	id qcMvvbgyySqlVqcMwvXJ8x; Thu, 12 Feb 2026 19:28:54 +0000
X-Authority-Analysis: v=2.4 cv=I7FlRMgg c=1 sm=1 tr=0 ts=698e29f6
 a=O1AQXT3IpLm5MaED65xONQ==:117 a=uc9KWs4yn0V/JYYSH7YHpg==:17
 a=HzLeVaNsDn8A:10 a=z6gsHLkEAAAA:8 a=GHiBHDn7-R_ywJEBXVEA:9
 a=iekntanDnrheIxGr1pkv:22
Received: from [66.118.46.62] (port=53394 helo=timdesk..)
	by host2044.hostmonster.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <tim.bird@sony.com>)
	id 1vqcMt-00000003X5q-2shZ;
	Thu, 12 Feb 2026 12:28:51 -0700
From: Tim Bird <tim.bird@sony.com>
To: brgl@kernel.org,
	ysato@users.sourceforge.jp,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de
Cc: linux-spdx@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tim Bird <tim.bird@sony.com>
Subject: [PATCH] sh: fix typo in SPDX license id lines
Date: Thu, 12 Feb 2026 12:28:45 -0700
Message-ID: <20260212192845.3724287-1-tim.bird@sony.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host2044.hostmonster.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - sony.com
X-BWhitelist: no
X-Source-IP: 66.118.46.62
X-Source-L: No
X-Exim-ID: 1vqcMt-00000003X5q-2shZ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (timdesk..) [66.118.46.62]:53394
X-Source-Auth: tim@bird.org
X-Email-Count: 12
X-Org: HG=bhshared_hm;ORG=bluehost;
X-Source-Cap: YmlyZG9yZztiaXJkb3JnO2hvc3QyMDQ0Lmhvc3Rtb25zdGVyLmNvbQ==
X-Local-Domain: no
X-CMAE-Envelope: MS4xfFshi4TstM/7v5/ijZxIO+4BptfNgH6D7Rt70HQhN+0kEgLOYiM3e3ObacK5YB2g09wCB5JTy+ecaI8gk59Cxm4jGenG4xQf61GBf4a255hSEuGItJXx
 QOz0J3NweYBI5paCcWSy9/arECp/cpNsIYbAGKPQRMWaWzIm2yWkv13z5Xzaj1rPIgap0OSx6kWwvPoFeVTxow/Fs+UyCYDw4ZY=

platform_early.[ch] have an extra - in their SPDX-License-Identifier
lines.  Use the correct (single-dash) syntax for these lines.

Signed-off-by: Tim Bird <tim.bird@sony.com>
---
 arch/sh/drivers/platform_early.c     | 2 +-
 arch/sh/include/asm/platform_early.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/drivers/platform_early.c b/arch/sh/drivers/platform_early.c
index 143747c45206..1c2a571a8ab8 100644
--- a/arch/sh/drivers/platform_early.c
+++ b/arch/sh/drivers/platform_early.c
@@ -1,4 +1,4 @@
-// SPDX--License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0
 
 #include <asm/platform_early.h>
 #include <linux/mod_devicetable.h>
diff --git a/arch/sh/include/asm/platform_early.h b/arch/sh/include/asm/platform_early.h
index fc802137c37d..00b6e6dc4ac4 100644
--- a/arch/sh/include/asm/platform_early.h
+++ b/arch/sh/include/asm/platform_early.h
@@ -1,4 +1,4 @@
-/* SPDX--License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0 */
 
 #ifndef __PLATFORM_EARLY__
 #define __PLATFORM_EARLY__
-- 
2.43.0

