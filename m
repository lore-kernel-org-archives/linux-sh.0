Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F89934D4EB
	for <linux-sh@vger.kernel.org>; Mon, 17 Nov 2025 22:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763419623; cv=none; b=Ypbe6gKbTxaKwqklYMTQzx7YnwFOicPeN6MZmog+MNxfj4gBO81oY5ujaR5CQ2b9z28HON6NfBEWbUV9Tk3OhbzOR5otZGphSttMtHN4Bz4DXQ5+H4bummewBeRs5HFWEjb6JznwzA6wOqd9uHLwcvMf1eHkM94K64AnFSMlqgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763419623; c=relaxed/simple;
	bh=Vo1e5ZJD9+i5l9smL/5/CWY0zd/SOXTtrKOJeMgZx5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=guuKkIYsDwKv/HY3kkBDie7ylOjpuQoyUZsWa1gw1PXedzxkBoLNs45TOWmDQyBMHEGxht1Ak9lVAFMTQo3+pA8vjZnfSkup8uYo17gBYjCrBNOyhkVK2zKHzVddb8Arz3mGOHwg+yNGDpsaw58aoMgMT4hH253Sj7+sleX0Tgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OR6EVG4+; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OR6EVG4+"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640860f97b5so7834361a12.2
        for <linux-sh@vger.kernel.org>; Mon, 17 Nov 2025 14:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763419619; x=1764024419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZBEUgm+GfP83woXXSnlop5bPmXXmwitxEZB0Co3Scs=;
        b=OR6EVG4+5TcL25nE178MeQ6chZ+qIkYQf+J9zXURe15P3gC+h2igMAdvnGDc10WlHV
         bf8Q4p0jBcFjmQ+ZLBeoDCkaQg95nI4A7yZnQ6rZU+INfNKKPBdxLZQdCPzl6nPmg+Vj
         nqlLRTOUC90KIqSuixwVD+YBRhPWQjOpcVjRWqe0lLsgBCnLVdjrnnV2JpX7gusd9Uxs
         wXxnIZjjmM3fgT0lIIcPteOAhHrKrDS/nvjiKSJysmpbkpK1orNt3qM5RJ4ByvVkga6M
         d+Ta5KgAZNrYkZEqiNC/y9UaSgVFjB8IA08bq1WQG0pbd7I11QNX1qIEtf9givbBveMb
         ldFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763419619; x=1764024419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OZBEUgm+GfP83woXXSnlop5bPmXXmwitxEZB0Co3Scs=;
        b=QW0at/Ji2xGazRhPFaJ7Y0nj3Cf/WkzfOPdB8NBUdtSq27rRjok0GXGayi+JmSsda2
         ENSSZcTzhivTLNrlireT49ySkfn7EBzUq8/7Ysf52/upc9LMjXhm+VY8OlkUgzw3pS21
         u36QgtZlAUKrcKbqWqd6exI7nn2s9qILIi0yBYtuIt9qrFDmANNrLtY/coXsZdVnXb8a
         sgbnlM+f7M+BuiWJfPyfOX3mNNPz2cNBKD5ZtYt85RImM1/j+LZzBAVCmfubLS2tdugA
         IaIixi+XpOKn9b1gf9VlSkuD1QPWlFaUf+48rNbXDgQsT6CKdqX/zuus50CmYMU/k34i
         BeeA==
X-Gm-Message-State: AOJu0YweAz0PGprvezD0GDfnmfW1/950CIYRuL/HuJ+0JcPN5Rln5Umx
	F36W1lISgr7cT4Qm22G1GNzynBPAFSYf3u9PkcJFoqAxGUVHRUWz6YA=
X-Gm-Gg: ASbGncvoQETasghFCkgxCOVO+udpI9fwX40eY7/Qo0JvzyKOh/VsMgPj7ZerpCv7o4p
	1CTa89KZSmYp8jIDkX6HcqpUBen2mCYKSsCRmPK1AM+4IJzJqLonNSaxlY/Ltx9ZlCaMfHpIzGa
	6U9szXfnPM9uPk0nSqU6l1wCJmpVbmGWPVaZGJkzo1+Me/H1Dj74tSlqmYNoCbMdB9wINtc7g4+
	6iEk6qKHQLoTMk6V+dhFe2HlWV1aw4GuKWu4QHx/AonHPi5xqVlYMjSoUDnSLh/HMhNrqdjgmCP
	KzgSycFH7jsLogKiwuPQXQk9gAcPixLtV54AbiCuODaXnEu0jZ53ysMauIy5H4Yk0nKO4P3Gmkl
	bTpMeyQlQErN9b3E5dQKjgc6+ORPuBaqSlMtgVmUoTPo9uqrfuQWl7YrbxNEO4wVwiRAQKbm1tk
	06/+xmZnW2VPMVY8tvVzk/czG7DPzPhtDxG/76kcQKwGSzN89byMYJasG13vrPVmSkdIjL
X-Google-Smtp-Source: AGHT+IH+cYgqyvs7Qy6c3BSCmA/lPzyceCw0kIG0eoKMVO8g31/I9hU7/tJT0mouZCkwTjjQu1aLWw==
X-Received: by 2002:a05:6402:1eca:b0:640:c394:5c7 with SMTP id 4fb4d7f45d1cf-64350e2042dmr13039417a12.11.1763419618871;
        Mon, 17 Nov 2025 14:46:58 -0800 (PST)
Received: from localhost ([2a02:810d:4a94:b300:232f:6d66:f093:4e68])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-6433a4cbd18sm11061900a12.35.2025.11.17.14.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 14:46:58 -0800 (PST)
From: Florian Fuchs <fuchsfl@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Florian Fuchs <fuchsfl@gmail.com>
Subject: [PATCH 3/3] mtd: maps: vmu-flash: Fix NULL pointer dereference in initialization
Date: Mon, 17 Nov 2025 23:44:08 +0100
Message-ID: <20251117224408.498449-4-fuchsfl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251117224408.498449-1-fuchsfl@gmail.com>
References: <20251117224408.498449-1-fuchsfl@gmail.com>
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
 drivers/mtd/maps/vmu-flash.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/maps/vmu-flash.c b/drivers/mtd/maps/vmu-flash.c
index d0793f1b0fac..153ba6f8f769 100644
--- a/drivers/mtd/maps/vmu-flash.c
+++ b/drivers/mtd/maps/vmu-flash.c
@@ -547,6 +547,7 @@ static void vmu_queryblocks(struct mapleq *mq)
 	mpart->partition = card->partition;
 	mtd_cur->priv = mpart;
 	mtd_cur->owner = THIS_MODULE;
+	mtd_cur->dev.parent = &mdev->dev;
 
 	pcache = kzalloc(sizeof(struct vmu_cache), GFP_KERNEL);
 	if (!pcache)
-- 
2.43.0

