Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA76369970
	for <linux-sh@vger.kernel.org>; Mon, 27 Apr 2026 11:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777290682; cv=none; b=Pq44p8U4JDd1cmAxtRhanAa8hkNoR0ie1+WyWE4DoKtTVJ5ced7YJLWWwGV8psAw0r8oH4BMJEV76/I3x0LrWmSF7dOT5XkWPnL4buPNE1JtzIJ/D7WMGjlvs9yEses5jOCySeK8YTeOrntBHdT2AKe6lcLwWiB2VHS90j8CWGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777290682; c=relaxed/simple;
	bh=D6vKvkYjCfzwT3A2q/5obMGZQaiVMfe+7VuVdQT19po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AaXKKJgbKDg7rWeSOQJCCNp4EcvspYyAMYY2cQ/7mGfKMFqxunEA8kviZ3RSw1nOE2zORtC+oEc26GweVzctUrQlN+sruzy8jvdZWLQxeFlANtqL8RjLsE7KETyHaCcReeoByT5sDwDntz0tXfWIbXynv8w9yFpphpreKu7GDmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZLmD5r5; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZLmD5r5"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso110426065e9.1
        for <linux-sh@vger.kernel.org>; Mon, 27 Apr 2026 04:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777290679; x=1777895479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sK29FoURh791KB3pSonK6KWtGokZs28tGn9ydulth7M=;
        b=nZLmD5r5M5guFAWD2vxV5KACxiIno0Mum5fc6WpO5bEcF1e8tDNaWkmZ/hNLWN3BRQ
         5KDadE+9rGvmHm31Tmpm5M4o7QfYTHUBiJ5AR8VdTrto9rfkLf0ET+I9auAr6H7oNdgT
         On3vnZf3bNdl+ayzxuyvwjhTLnKEB5nArSTIv6k3Fq9juEcjj0C+teda9JMlO6ZCmyYZ
         oyfLCxFYnsuJVCxa1Ik3wMbXR85hjQ7gsseV+Mdy87M9t0NwkGvYjXKVupzz37Ee5YLx
         SpC9JrV5PCXXnrU8bGk+hqCOxh6KY5GpAxM51STdGeOHVd9RQELwNaGvslxpPxJL7lGf
         UzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777290679; x=1777895479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sK29FoURh791KB3pSonK6KWtGokZs28tGn9ydulth7M=;
        b=Gj1NRfOjt8CqAJkaKbyLJg0deDZA9GHkSL8IsPsdzZ3I5Qrdg/+P3JJWtXgc6xjNFf
         LYU3M4zwpr4JDBJCLXiByWxrtZehZ+bLBzPKle3O941rEHbLBQ9yq61RrZ3KSvNfmOa4
         NXXqmOPUicH9EIUxpbErbm9d8hIV/pnmFAgx/QdxDZ+57OKseRi1ngETaZjYe3wjzXOC
         jXg+DhX113Fceruc6l6qJat4Hyid/Sh7azQEwuvtEVB8zwZkqpXvuhB6P56rrWntV/fx
         AZ2nJO8w2BKVeSlMo3hLAjgbDMU+DoJ97B+AEnDiFphRfQJNuzP8yZl+zTP7Fp+7G3ig
         /gzA==
X-Gm-Message-State: AOJu0Yz2EnP8zufy/EWzY6YrLOY4nUoCDkdWKBVqh92AU5MGc6Tt35ma
	YWKm8ufDJM/AV3U01NXaQ3opgjm6U3fPjV4HDgrHPSJqlIOwDNRgkKc=
X-Gm-Gg: AeBDievP/LD2aJqctg6DDKBF3YXYRrXE3qUZlJXYZ9d6NIdAE89Juj8MaXk2gjPNcmq
	kst3ddeRvsgCTBqY9jpeBZDVCsliA5t+5bSCSiiaG3t1e/XSs0ZUymeUlvT3foTqnSMKp9iGt7x
	Hsv3DpnI8ODYeTbq+Rn3MfuL6f4a8EDyu3/nVLXhqJjWpDzab6ZtyrxZYX7DejopEPcqrgQlfsa
	xZavIW7tiqUEejcBdd24egN2MkTmcqX7Qh5abMmrj2Nasq3H+KzFiN570tnGbXcwgJDEh3EZzE0
	bQD+dT9zYtG8iNswe5Vt4a4KeIaofzojoj+6k88dfjL8agiOlYqvIapx/Gnjp4Nb3pTsazaMOk5
	s7jMff3iZ6wLmvzxrbYEWU8D6QlBrlwvb7IsE2ISZls+dqsUov84Yhgw44BDYPezhnY6Biw2oog
	SGnEdCgBbvC4Z64SUUElOmVD6s4mEx5Nz3smX1SoXMXWt77Mnp2lyCJd21AvaJiIA8sKw8T+S2V
	9nlGr3uU6kBfnHksjQ=
X-Received: by 2002:a05:6000:2303:b0:43e:b020:f8a2 with SMTP id ffacd0b85a97d-43fe3dd5208mr63553484f8f.19.1777290678780;
        Mon, 27 Apr 2026 04:51:18 -0700 (PDT)
Received: from localhost ([2a02:810d:4a94:b300:3c87:b0bc:8c35:1ba0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43fe4e59f97sm87393680f8f.37.2026.04.27.04.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 04:51:18 -0700 (PDT)
From: Florian Fuchs <fuchsfl@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Florian Fuchs <fuchsfl@gmail.com>,
	Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v2 3/3] mtd: maps: vmu-flash: Fix NULL pointer dereference in initialization
Date: Mon, 27 Apr 2026 13:47:50 +0200
Message-ID: <20260427114750.2480900-4-fuchsfl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427114750.2480900-1-fuchsfl@gmail.com>
References: <20260427114750.2480900-1-fuchsfl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mtd_info contains a struct device, which must be linked to its
parent. Without this, the initialization of the MTD fails with a NULL
pointer dereference.

Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
---
v1->v2: no functional change

v1: https://lore.kernel.org/lkml/20251117224408.498449-4-fuchsfl@gmail.com/

 drivers/mtd/maps/vmu-flash.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/maps/vmu-flash.c b/drivers/mtd/maps/vmu-flash.c
index b76d0609d1b7..10244e6731d0 100644
--- a/drivers/mtd/maps/vmu-flash.c
+++ b/drivers/mtd/maps/vmu-flash.c
@@ -547,6 +547,7 @@ static void vmu_queryblocks(struct mapleq *mq)
 	mpart->partition = card->partition;
 	mtd_cur->priv = mpart;
 	mtd_cur->owner = THIS_MODULE;
+	mtd_cur->dev.parent = &mdev->dev;
 
 	pcache = kzalloc_obj(struct vmu_cache);
 	if (!pcache)
-- 
2.43.0

