Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9099814F135
	for <linux-sh@vger.kernel.org>; Sat, 31 Aug 2024 09:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725096907; cv=none; b=XUZ17uOHp2KOTf8G7WmSlU4+hxb5A96wGjdDOYyYA/KoGy6+0EduXQDzRtbU+WJ7sagJmY2+3dpJSV+gs5b2h/WUwVz+RsE6hdrmwu2aZrSEkZCZQju//r4beRCq1iFCtiMpMAUgg5hsEzo04cEwtD+rMTY3G0c0lfiBCwqZiaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725096907; c=relaxed/simple;
	bh=ydfJi7anvWLZ/0wVgeHPWe2y2hltADXY6FWFt8wzBpI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iVvCZaC3+fNijJnzS1JPg0cmjI1eQ2ohHvkKrzVvgmSzZ8DdE90uF67FpGCOtmG8lt96ya9WaLBtoce+AH1+/13wHPBu05At30m65F9YsIRBpvZEK5O4dROuC7WUdymgS12wHl/PcKvXRRc5ED9457gbq2W/KSiLzOzAY0aE6MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WwqVm45ypzQrH8;
	Sat, 31 Aug 2024 17:30:08 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C5B81800CF;
	Sat, 31 Aug 2024 17:35:01 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 31 Aug
 2024 17:35:01 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <ysato@users.sourceforge.jp>, <dalias@libc.org>,
	<glaubitz@physik.fu-berlin.de>, <geert@linux-m68k.org>
CC: <lihongbo22@huawei.com>, <linux-sh@vger.kernel.org>
Subject: [PATCH -next v2] sh: intc: replace simple_strtoul to kstrtoul
Date: Sat, 31 Aug 2024 17:43:10 +0800
Message-ID: <20240831094310.4148930-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500022.china.huawei.com (7.185.36.66)

The function simple_strtoul performs no error checking
in scenarios where the input value overflows the intended
output variable.

We can replace the use of the simple_strtoul with the safer
alternatives kstrtoul. For fail case, we also print the extra
message.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

---
v2:
  - Pass the error code returned by kstrtoul() suggested by Geert.

v1: https://lore.kernel.org/all/98c7b473-0b2b-4e47-83f6-35d9f417bb01@huawei.com/T/
---
 drivers/sh/intc/userimask.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/sh/intc/userimask.c b/drivers/sh/intc/userimask.c
index abe9091827cd..5d7801b76715 100644
--- a/drivers/sh/intc/userimask.c
+++ b/drivers/sh/intc/userimask.c
@@ -32,8 +32,10 @@ store_intc_userimask(struct device *dev,
 		     const char *buf, size_t count)
 {
 	unsigned long level;
+	int ret = kstrtoul(buf, 10, &level);
 
-	level = simple_strtoul(buf, NULL, 10);
+	if (ret != 0)
+		return ret;
 
 	/*
 	 * Minimal acceptable IRQ levels are in the 2 - 16 range, but
-- 
2.34.1

