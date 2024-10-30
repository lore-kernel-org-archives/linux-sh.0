Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC691D14F6
	for <linux-sh@vger.kernel.org>; Wed, 30 Oct 2024 06:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730269029; cv=none; b=Ll6yd0l4YLhPNCDOezg8eLsZ+CZSfB1Jz2u9aerWcHdsgPyBU/PfeQPSoYaHjdqyYtRx0csRrIxCJdupUyYBX3ATHC2m5zwfx96BoQfgk6PkDBDPdWFqo1lD3+gaeDla9zScw2m7aW2KROhXj9nuRIpVwzFftyl9uKSSp/K2uGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730269029; c=relaxed/simple;
	bh=l4C4vaPMjvPxLmwfPBMqb+0lhVcdF74wdK565k8Brd4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g8iikPrYKPOnnRShvyMbuPjVXu/XJX96wSAtpyuE7tycZ9FuK/4Z8wqBfy+RVC64JJaC2RRNrHewJc+ukjBBE4KutC3dgmDPGcRYWjFnHjwd8lNT4gVwufPX9SjlLU4mD5ddegquSu2LS4XYqLP2R0N9n3VokkFEx/uqjk3hFHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XdcMt3Tm5z4f3lCm
	for <linux-sh@vger.kernel.org>; Wed, 30 Oct 2024 14:16:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 05AAA1A0196
	for <linux-sh@vger.kernel.org>; Wed, 30 Oct 2024 14:17:01 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP3 (Coremail) with SMTP id _Ch0CgDnecZRzyFnUwBWAQ--.44530S2;
	Wed, 30 Oct 2024 14:17:00 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: ysato@users.sourceforge.jp,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	gregkh@linuxfoundation.org,
	ricardo@marliere.net,
	damm@opensource.se,
	lethal@linux-sh.org
Cc: linux-sh@vger.kernel.org,
	chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: [PATCH] sh: intc: Fix possible UAF in register_intc_controller
Date: Wed, 30 Oct 2024 06:08:13 +0000
Message-Id: <20241030060813.1307698-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDnecZRzyFnUwBWAQ--.44530S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKF4xGr18Kry8Xw1UAr17Awb_yoW3Jwc_Ca
	yrXryxAr1rWFn3Ga4Y9a48uFyF9FyUurs3tFna9r15XrW3ZrZavr42qryrZr18KFZxXF9r
	Ar1FqF1v9w47JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUF1v3UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

When it goes to error, the 'd' is freed, but 'd->list' was not deleted
from 'intc_list', which may lead to a UAF.

Fixes: 01e9651a21bc ("sh: add INTC out of memory error handling")
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 drivers/sh/intc/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
index 74350b5871dc..a30d205e7a43 100644
--- a/drivers/sh/intc/core.c
+++ b/drivers/sh/intc/core.c
@@ -387,6 +387,7 @@ int __init register_intc_controller(struct intc_desc *desc)
 
 	kfree(d->window);
 err1:
+	list_del(&d->list);
 	kfree(d);
 err0:
 	pr_err("unable to allocate INTC memory\n");
-- 
2.34.1

