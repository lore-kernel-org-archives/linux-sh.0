Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5143ACA68
	for <linux-sh@vger.kernel.org>; Mon, 23 Mar 2026 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274155; cv=none; b=c1o1JOrfQPIo8/rPe8Dbe/ZtLjUBOjhz4J+jmogh7ZEwIqebxRzRkbl80hcMPB3/O6UDr+h3LQjw2S5Xm3LfqqTVEAnEXWQbC4iV0S7k2SQS1S9wg3X+K3VyuvDJYHxDvBPdvAXqC6K+AZGL/UADoCrRWiLINoOsvyjKTQlDmVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274155; c=relaxed/simple;
	bh=ptUbi7coE8TiCTgvjCOJdhXmMm9zZV1RIxnNmpsvNUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jLuySRahDniJUe+ZXZjgjfyC479FGiQCUlk2dS9rBC0HdRvxgZOAqJJ254yS4pvgQU4MZaa0MvVhaZyvDTQX31WKh5glFEEV3gMPoLY5TM3Zoc9f8yobNxOKFWGwYJTGvqmhDfOW2HSUTwwCN5xPAUEvMJBbkiwrFpoFnUkKIAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFjIkSLb; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFjIkSLb"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ad21f437eeso37606645ad.0
        for <linux-sh@vger.kernel.org>; Mon, 23 Mar 2026 06:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774274153; x=1774878953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gX403DU43tnkaleCen3mlLyVekGcaUJRBonPOPbGQtY=;
        b=SFjIkSLb6hCeV6O6C0rMZn9Ic10VRNRaECLQK/c2sn6NWaZgQUEKdAr406SoSmeybA
         4ZrkRBXuiQ68yXXDuqeCt6gYZ3oDHRaZuTr8nWD7xfJxBhEs5cgfXXwvGWnbdUJpBZFi
         Uv3x7AxkMJPm1VB+SlWCjugJVtQNqXphz9NU34oCJ/jFtP4LD1f9a0jt3rfQQ0ryXLhR
         vKAHVsMEMtn6CVqM42/umHMRZQYtU+nKOjoWchw/3RFy5zIQJTkWPsRc0Ya0LKOxueGX
         JzBcQS9q5j5oNnEZbErXiOZulbOrdZ114gyYzpIe0TdEVxtKFOSaJBIYEE1GlnwMzPym
         jAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774274153; x=1774878953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gX403DU43tnkaleCen3mlLyVekGcaUJRBonPOPbGQtY=;
        b=k92Tnx4zCOlwZ7aF9swE3cBYyyHE4We5kHgB4f8eKfGqvVEn/gjqS2TkKNRuBWYwbA
         64Ec8PzKb525x/qDHE3C5xyuqfGp+OQHNONKhvdPbl11ZZ0HF6HDI3Kw78S3hRLYrd1l
         Kuh6ymKomgaVgm/DA4UEOwUY7CCtrp74uFa7/TwcnKFihpVhf6NsqfGyCPkwB/EWBeRI
         lzFKjW+GmbxcTWauePazzPzUeSdsn2y3frGG0IcaoE0qeOoIol8GdD3MJFXwPj56lq29
         6UAzktKm39SyGRiR+C2Ukw9AAbsLEK0TnN1VFftsCRs4z+Eo6UBhdzFkocYO9A16aA3Z
         4P3A==
X-Forwarded-Encrypted: i=1; AJvYcCXsw8igIBdSkJCzP6fZ8DtbHkKhqcgTmY2fjc93XyfXoV+wanHF2qLbsemaZ4h1jfo7MTOm0BcYxg==@vger.kernel.org
X-Gm-Message-State: AOJu0YydUyCnSPDrXS51HSt1r3Iih9++922pKXUnQENfoa6X7MWIu6B4
	ZFAvvyZSHnYZuzRdoAe3Mu5FubfaGKB9tDNE/1hQx8MUzBPmAwKvGPXl
X-Gm-Gg: ATEYQzztTR662haVI06IUhCm6JZ6GbRup1R6xct7RfkmxIKDHcPTaTbI8yrXUHqivEl
	kx5kRMwnV35YEWso1cEeL2MOpYSn5G7jl/1H3zZ0rHVN9vaTwoUqQVxubSJxnizp/1nNRa2Y81c
	TvSI/LCK3m2A5oKq2oFefaSH323xH0FFbjSf6VyJRwCw3h7M6Q+ZAyhgv/3L5ZLWqZK9phI5hA1
	8ZCPPF9V24iK4aA4tkXnUpa4kmjENFmc86X1dlzi6caycNpiPFa7G2KjM9qyMk2csRXX49Wvf23
	z0l2DBP+rDS9Zl6m1TEJOPOk6xpg0/33z7U6eyVcfet9iu9Ty+nqtIXBxZ7S9yNmhsLa3c5XDtW
	mpO5e/ITXs72uaMV11wnss0RUBW92Ka5aPCQ33DwNLZpczcFP8pWXm80tXVPAx960/obqds2TZL
	fg5o0DY63npeMIsTPS50Ze
X-Received: by 2002:a17:902:db12:b0:2ae:7f85:33d1 with SMTP id d9443c01a7336-2b082636715mr116185785ad.0.1774274153320;
        Mon, 23 Mar 2026 06:55:53 -0700 (PDT)
Received: from lgs.. ([223.80.110.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083527f90sm108967095ad.19.2026.03.23.06.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 06:55:53 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Adrian McMenamin <adrian@newgolddream.dyndns.info>,
	Paul Mundt <lethal@linux-sh.org>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] maple: Fix refcount leak in maple_attach_driver() error path
Date: Mon, 23 Mar 2026 21:55:40 +0800
Message-ID: <20260323135540.922928-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As device_register() calls device_initialize() before device_add(), the
failure path in maple_attach_driver() is reached after the embedded
struct device has already been initialized and its lifetime is expected
to be managed through the device core reference counting. However, that
path frees mdev and its associated resources directly via
maple_free_dev(), rather than releasing them through put_device() and
the normal release path. This may leave the reference count of the
embedded struct device unbalanced, resulting in a refcount leak and
potentially leading to a use-after-free.

A possible fix would be to use put_device() in the error path and let
maple_release_device() handle the final cleanup.

Fixes: b3c69e248176 ("maple: more robust device detection.")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/sh/maple/maple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
index 6dc0549f7900..20b7c2cd852b 100644
--- a/drivers/sh/maple/maple.c
+++ b/drivers/sh/maple/maple.c
@@ -393,7 +393,7 @@ static void maple_attach_driver(struct maple_device *mdev)
 		dev_warn(&mdev->dev, "could not register device at"
 			" (%d, %d), with error 0x%X\n", mdev->unit,
 			mdev->port, error);
-		maple_free_dev(mdev);
+		put_device(&mdev->dev);
 		mdev = NULL;
 		return;
 	}
-- 
2.43.0

