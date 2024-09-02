Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CAA179AA
	for <linux-sh@vger.kernel.org>; Mon,  2 Sep 2024 02:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725244636; cv=none; b=hoItBVUDp4u6be1iQrLzV5sVPsg3ozqyLP2ALomBmtEOWTY55LoSF4Dt2hmtZJ29DSUXZcLMvVA5VyZ1u17zpDUAQ12RqgWsVQriJxtObm5vbPUKC38UWI3WQD24BT9L5hXPET0AJY8LPzbjnR8IAKqGzkEUdThaG2odQUEMozU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725244636; c=relaxed/simple;
	bh=lfYpO9g8lBk8tYKifZLok/OdslQaCvjSE3US+/iXWN8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HJNARYcn0c98FEIBvCTAZSB/91qN1Cdr5YBug9YoIApBUMITw3sa9Uc5r6Zc89iOKIF57DlNrMUJl/pWK5SLDio9nCMUDIDZ1gnJ3uWsguFbkNrsV6zXkvy70lSSv7/+TiSYsXt3JTS/Y+iQZiUIAMQYY/mKCGSELCsOy3XL59s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WxtF118MVz1S9cG;
	Mon,  2 Sep 2024 10:36:53 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 16C24140203;
	Mon,  2 Sep 2024 10:37:11 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 2 Sep
 2024 10:37:10 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <ysato@users.sourceforge.jp>, <dalias@libc.org>,
	<glaubitz@physik.fu-berlin.de>, <linux-sh@vger.kernel.org>
CC: <lihongbo22@huawei.com>
Subject: [PATCH -next v3] sh: intc: replace simple_strtoul to kstrtoul
Date: Mon, 2 Sep 2024 10:45:34 +0800
Message-ID: <20240902024534.2288168-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)

The function simple_strtoul performs no error checking
in scenarios where the input value overflows the intended
output variable.

We can replace the use of the simple_strtoul with the safer
alternatives kstrtoul. For fail case, we also print the extra
message.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

---
v3:
  - Separate declaration and assignment to make it more consistent.

v2: https://lore.kernel.org/all/20240831094310.4148930-1-lihongbo22@huawei.com/T/
  - Pass the error code returned by kstrtoul() suggested by Geert.

v1: https://lore.kernel.org/all/98c7b473-0b2b-4e47-83f6-35d9f417bb01@huawei.com/T/
---
 drivers/sh/intc/userimask.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/sh/intc/userimask.c b/drivers/sh/intc/userimask.c
index abe9091827cd..a363f77881d1 100644
--- a/drivers/sh/intc/userimask.c
+++ b/drivers/sh/intc/userimask.c
@@ -32,8 +32,11 @@ store_intc_userimask(struct device *dev,
 		     const char *buf, size_t count)
 {
 	unsigned long level;
+	int ret;
 
-	level = simple_strtoul(buf, NULL, 10);
+	ret = kstrtoul(buf, 10, &level);
+	if (ret != 0)
+		return ret;
 
 	/*
 	 * Minimal acceptable IRQ levels are in the 2 - 16 range, but
-- 
2.34.1

