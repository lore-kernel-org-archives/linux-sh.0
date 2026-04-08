Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E57C3612FE
	for <linux-sh@vger.kernel.org>; Wed,  8 Apr 2026 21:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775684208; cv=none; b=jYjYMIPg/M/5OqKoFY3UQR4Ccp17qI0JnlLGWTPvXZUidZgWucmL+aGhPOWmB3PHNsUeY+64XBH2H1Cbj27tKTErEpf+OA7/sxlAK/Qs1lkir7yMLHhekV+aCGEVGqNPFPnqzc5ReY98seX5SFWthCto8qoMkfS6jyJnfC9wki8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775684208; c=relaxed/simple;
	bh=U1470YJaT80+YzZNhB2zoGUiu7r+zEWF0Wm7E1xjjEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iImQJMSsmVHEOfuS8vRXghT9IWS2sqVT8NnocZ+JO3FIgUKkzkaK04eqVQPR1Pmo1vsst6dMgemL7W7MBbYrUV4PYWcxISYy8XP3z3NyFNM2a7SbLrhCw/A15g2T68Za7A3ab1kvwMPrHU7QotPVxP9OFQJIR7CLN7cr37A68gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTS6zmqJ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTS6zmqJ"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43cf3ee0fc1so94046f8f.1
        for <linux-sh@vger.kernel.org>; Wed, 08 Apr 2026 14:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775684205; x=1776289005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rjVxWYOeFnQfJj1Uu8QEV+84w2reIr8oTpqTdhpQ/Ac=;
        b=YTS6zmqJoNDjiBA7YfDsKC3ssfF0WujQuyURO3G9JuUBwT9g7/y7aPMgB6Ca2EmCOr
         s9VZ9b7VUUQh1zbhrvm65gBMZbo7P9jZBboXXL+taVLAd51Db7Pqrl7BsTDhQbXM8Hf0
         EGbONrPRPDp08cv67hsxqrRAYIDIBbpDMKkgcGv+4jPIDcTSMnyAMVtYdPMabTUqTAW2
         Nsv4HhFTEQBRT95oUdRIeB+9wP5JM8TIM32X4eZDtb6ArOwhhHelyXPZK77XlSDGNBU7
         6OT0c6cKBxELcmM1wml8fBBlLDxmrVCW2rgDW1aSnrL4U8dhXI/0q5NkcRUk6tECaNa9
         AIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775684205; x=1776289005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjVxWYOeFnQfJj1Uu8QEV+84w2reIr8oTpqTdhpQ/Ac=;
        b=FVB7bj7+eU4R8vdzQmTgCLnUyFrSIeNZ5UfYD+Ucof6GHHmc5vGs+nOukCN2g1YFBY
         6Cp4n4ZfcP02EbRnDXe/yIck4Dyow3Cv9MmjYD14dCoCY0iLyN2w9rpXXZc1At2gFwci
         gU5IIVUy12dYeO3pIZJ9kMDhvmwuugIBhGzV+Z6ZP0/NU7yGr/pMl88VPErcR39vQOo6
         eIBFMxvLlj1qlGjd9qrdg+JhjTseYpub+Ivf9/GYy72RbOBFrRkHNMpR19dfrlyQRXS9
         FUMQyrnQFEhUX4yfZifsV0xS8/Ft019OuxGRgKMOsSHz9L2WDz7Q15w9wmbvPCi6J0tx
         XILw==
X-Forwarded-Encrypted: i=1; AJvYcCWQnFYFoWlhtpTOYXDkwK+CY+H1DtT7Lg2ALvAb+ZoSW/qBXd5yZmoFTHcvtcJInFoh+oE+B+a37g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhPAlRYcYNHsCZTxTL6KmjkxSAJ8y7nGpa6pXfW0SdAxHu40/N
	eYOn+c0FIoeVvMid8snotHNlCVKiDvucJfGlnfCEvDNCMZxUXoB2Wznm
X-Gm-Gg: AeBDiesXC1T9oikhLMuf4Bs4MYBqbXZu7nwa/pa50+TS9Trf6hIROGu2f0eXA7+5vBy
	tmGydrk0itLSDxE5iPcwMmGvbsVy1sXetOxkEtLy+ePBi9Zku7kl0ZZ0ygRrSWhanXN5+E3rpfT
	QHsJO2P0E5P/EGkV32iGxCXFcc/gaOvRiXocee6P52/d3nah1TvdFEnfqAPPyQZpemQOKkWG1Iw
	7g2PwPhU1KNr67mBZCuz8phPmIGrEZhSFwwWVBuCGN15sEOX9plLTOPbt3+j9wnadCRtFBnnJj9
	2vP7x6acwX0ltJ+7gZvijrUrSdW80DISoscSP37eBxUNCw7KsHzTzCnJmG0ctM35Xsgyij30ndJ
	5X7igpY6jCCF1MfXUICmxEqNaz4hujfFWPLkIo7pNVqDBP4azB9/KocS4A7Gcx0pMJkCHg6ARQQ
	L0wfSj8lu4/Vy1rgcc7rH7zhH8IhgdmZEVoCXc2Avr8inGgDHq2iLBvI4tpCkDnZIjQQG9ZjRyo
	THUMmGM65CtNZzZ31kB
X-Received: by 2002:a05:6000:1a8b:b0:43d:1df7:e3af with SMTP id ffacd0b85a97d-43d595bbe8emr1451289f8f.22.1775684205254;
        Wed, 08 Apr 2026 14:36:45 -0700 (PDT)
Received: from localhost.localdomain ([2a02:c7c:37d6:c100:cca3:7cee:f0b5:b56f])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-43d473b8c1esm21404661f8f.12.2026.04.08.14.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 14:36:44 -0700 (PDT)
From: Adrian McMenamin <adrianmcmenamin@gmail.com>
To: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-sh@vger.kernel.org,
	Adrian McMenamin <adrianmcmenamin@gmail.com>
Subject: [PATCH] mtd: maps: vmu: add include to ensure maple mtd code builds
Date: Wed,  8 Apr 2026 22:29:51 +0100
Message-ID: <20260408212950.275065-2-adrianmcmenamin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


maple.h included in vmu-flash.c references struct device and struct
device_driver, so we should explicitly include linux/device.h to ensure
the code builds without error.


Include header file required for build.

Signed-off-by: Adrian McMenamin <adrianmcmenamin@gmail.com>
---
 drivers/mtd/maps/vmu-flash.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/maps/vmu-flash.c b/drivers/mtd/maps/vmu-flash.c
index 75e06d249ce9..e2a574a4b438 100644
--- a/drivers/mtd/maps/vmu-flash.c
+++ b/drivers/mtd/maps/vmu-flash.c
@@ -9,6 +9,7 @@
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/maple.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
-- 
2.43.0

