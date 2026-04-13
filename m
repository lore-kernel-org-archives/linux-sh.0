Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9565E391518
	for <linux-sh@vger.kernel.org>; Mon, 13 Apr 2026 11:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776081272; cv=none; b=P75hLA89It6mHXoXgACFTtumHFniKZlGF4TrIVn4OB9h3Xz6INP1WPaPdYka1LUv5ejsH6fDWbkmKPpBFL8trwbRkN2o1LV9vmTRUiW576KTcQxNS4exv1BIkJlKn+Z6byJtkEa4pTfx9AesKJFa5ps5pnUPC8le+0fgjmeDykg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776081272; c=relaxed/simple;
	bh=DpIntkKN3iEhgCt9UIkBGF4XZ4jGPxiV3R2ublbIpVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sP/EsvIPa4J3x96DYdmR7y1y2itpnm6bQPYzsYe3Vk3bVcoPY/e7N3JdMdrEbdfA9j8hSC/FB9AEW8V83XEaulj8EI2/z37hovNhKcYq4dkg5d4ur7TYA4PpigGziBebgDdJvs1JTgNc4v/TteaONdgVPIixQ/q9/NUOsp8ic2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzlIKv1J; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzlIKv1J"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c76864f4e58so1263675a12.1
        for <linux-sh@vger.kernel.org>; Mon, 13 Apr 2026 04:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776081269; x=1776686069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kbf6f/mBggx7CBkqLB4oD03Dp2SeRdAQ/IF7C0fyt8o=;
        b=HzlIKv1JoAOpWUuWPf+XLcFzylORAsmEMu/fnvpQ641CWo3f7NM7UK9cY9i/xe/V1T
         VbGcCq5tvok6A1AeiES6Z6KI2lcJBxEOuB6fdObr3ZA8vKB16Gh7Nxl1Q2qxbIRloISL
         qx1eM3aVRbIzgPgAL9To/D8SoqLl6ULpwGELV4LUh2MeNtLKRcTVhXKqIcLNUSck8g8V
         Z4XDT3nxVNeW7hJkYjttCldKvtn7wPn09N8qPslJCWtr4Dv30ZmXU+kvYcv6BuWyeMwy
         pfkXDojDCy/J+CHN8ndnDBqc4Dk/qUwq5nQKoLGcmzTDcJv9NiikwPUU2BV1XMiDf7Nc
         NKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776081269; x=1776686069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kbf6f/mBggx7CBkqLB4oD03Dp2SeRdAQ/IF7C0fyt8o=;
        b=BswCw0+WCXodiq8kapugyOSbELxJxvy0Rn9EldkN05z+UyslMYKz6NIZntaPc4+keQ
         yIzmVWFevkTnnVxZMUoIq433n7S1yoYHD+gppVHagGr5d15ivQU3YDDNL0ecqvQGcV+d
         QzzIm9BE3EGuCbHWVNaVTmjRuO+nQkrn3NtJBytn7ogcrSDuapdYXYLV8QhQaTY0BIXD
         IVkNaRpL+f/8XRseUrhv4BSTC9t3pcYkfW9b7MmcqJnNnz762LOO96OdpXNR8cgwdHod
         tQsBNfCyUedkzpBVxXU9YoDLSxQ/gNRNxEo14gPHNkyPe1RTtEYSQNbP8O8YRrLDYYZG
         fCOA==
X-Forwarded-Encrypted: i=1; AFNElJ/fmIgDqJRFEN4oo5boxtsVxs1QMLPx5aYmKL2tJPr7CDQ3eUd2qHXwob+2pMiObBVOe5CKMvNyrA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb0slHkaKb5DISFR2kuRGdSdH8fqZCGDZyTJBI5pauBOGB+oY0
	3qmyF6gw+6AQoPenOR+bGvD+aqvn0hZkX6mvUWZkNPcKEKt9AZbPEgzk
X-Gm-Gg: AeBDievqSwG0WFBrRyzaslw9xFe4DBw1uGf/PRQm1GWzaNn+OIkLIkz9+me1k8V1Un1
	VOQe9jJfvt8MnPfeDwHIw24lu9v7/SJWZqBcmfbTasZJFpdehuVy/n7dVeaRSs17c2SySySyqyK
	IOTZxEuQYhXsntwlKlAHkz/U96bv40Ko1fUVQkCOUXT6opJ0tV59hbQL9BL0kN51eEDZsXLxvzW
	Nz6V4+epE0JsAJziEkICV9Nd1Blhx7DEucVx4adYDbkewPqw9FBbHV+PincBoW5wr91Zf+zre+S
	+0a+UD5keIO4lKis+mmXPcKaipwprb0FREohZ8N9p6lwDBTSFr6YeFpk3mbcLUaPX5GBu+Eelf6
	9dMMXrbYqSv8HtjqjHwjRVjWR7Ct2ODDGvYmdXrQcTmloYZ9xM6t6DWFFzE4TIuc4Gjd4s4zM3a
	TbyecpDPj/OW+0dsMalMpj4jxHhL92fpEJNfCt7CNTUA==
X-Received: by 2002:a17:90b:1a8f:b0:359:83d3:27d3 with SMTP id 98e67ed59e1d1-35e4274e363mr10973143a91.2.1776081268925;
        Mon, 13 Apr 2026 04:54:28 -0700 (PDT)
Received: from lgs.. ([2409:893d:1188:142d:db27:7a46:955d:48f7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e34fdc4bcsm15474300a91.7.2026.04.13.04.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 04:54:28 -0700 (PDT)
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
Subject: [PATCH v2] maple: Fix refcount leak in maple_attach_driver() error path
Date: Mon, 13 Apr 2026 19:54:18 +0800
Message-ID: <20260413115418.2780881-1-lgs201920130244@gmail.com>
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

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

A possible fix would be to use put_device() in the error path and let
maple_release_device() handle the final cleanup.

Fixes: b3c69e248176 ("maple: more robust device detection.")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - note that the issue was identified by my static analysis tool
  - and confirmed by manual review

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

