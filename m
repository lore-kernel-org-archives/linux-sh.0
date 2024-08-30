Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03CF158A23
	for <linux-sh@vger.kernel.org>; Fri, 30 Aug 2024 07:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725004553; cv=none; b=L7ghNA5/RE0dlygOrb6qPUMWN0YcsYz/oXjRf3WzzPb8qqsECwoZKqe91MzmqUSETdRUjqMzJjUsTIIjh4lTnvy1sC/g2OcJYFyXmCh44L5apNF3RT5YOJe7jpNcUcA+n/3MaF48RRaigTBZ4C0VHkHoNRIrlgkNOPIpQoQT2Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725004553; c=relaxed/simple;
	bh=GgKvsapMci/jtb6JGLWZy6KufWF5SR0RFJM+SJ+REV8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nakj4p9ulQmhYt2062St7a93dVaI+hl71tl64lvwn+mfJML2bOC0GJ9O5gaPoK5/cxhZP5pYpPth8LpTFiicl868E2k3cj8U9TERjsmjRdphTdHA64/Pqoc9HLYVRlOzA3kFWSZiKba81ZQZwQrjpTn8D33kFW06V5fG+QyKdQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Ww9RR1pM5z18MyF;
	Fri, 30 Aug 2024 15:54:59 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id E2B39140360;
	Fri, 30 Aug 2024 15:55:49 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 30 Aug
 2024 15:55:49 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <ysato@users.sourceforge.jp>, <dalias@libc.org>,
	<glaubitz@physik.fu-berlin.de>, <linux-sh@vger.kernel.org>
CC: <lihongbo22@huawei.com>
Subject: [PATCH -next] sh: intc: replace simple_strtoul to kstrtoul
Date: Fri, 30 Aug 2024 16:04:01 +0800
Message-ID: <20240830080401.3545399-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500022.china.huawei.com (7.185.36.66)

The function simple_strtoul performs no error checking
in scenarios where the input value overflows the intended
output variable.

We can replace the use of the simple_strtoul with the safer
alternatives kstrtoul. For fail case, we also print the extra
message.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 drivers/sh/intc/userimask.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/sh/intc/userimask.c b/drivers/sh/intc/userimask.c
index abe9091827cd..c9892338fc22 100644
--- a/drivers/sh/intc/userimask.c
+++ b/drivers/sh/intc/userimask.c
@@ -33,7 +33,8 @@ store_intc_userimask(struct device *dev,
 {
 	unsigned long level;
 
-	level = simple_strtoul(buf, NULL, 10);
+	if (kstrtoul(buf, 10, &level))
+		return -EINVAL;
 
 	/*
 	 * Minimal acceptable IRQ levels are in the 2 - 16 range, but
-- 
2.34.1

