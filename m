Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC3747DD68
	for <linux-sh@vger.kernel.org>; Thu,  4 Jun 2026 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579206; cv=none; b=WBpwTgcKsU4KXqzxkiqoGdwVhBQ663CEeDYv3Nr5WfyKDegvUMeK4d3cyB+u/hmqaGS5Ipo4k9PfbgniAt2CRMrE1BcuOIMPsG2Z4jkDypWVGm1lYZSuahV7UcMfWxik3JukYkJa3qA6y+/IxSOznm2Am+hoWJkVEBrlztYm2eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579206; c=relaxed/simple;
	bh=qLq31BYjVwoita8p3VYbMVHsnGBFQquUbQzcOZAQW8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X9O3yoY1pVzPpWSEblLaROtP1OBsZB01q+k5nk48+2aE9mNCa+HX9pK3Qv+LxOj+VGXh4QekUnwgitdSAMJdcWN00OOcKmyjzPvyMCw6VzLFzKopxKz9BGw1HZdbH8ZvotoYntQvRvyr05pE9e+nVnJ/cY9bGwFfD7mcjAxpc7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2ujJrb1; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2ujJrb1"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45ee5cdbd28so1235980f8f.1
        for <linux-sh@vger.kernel.org>; Thu, 04 Jun 2026 06:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780579202; x=1781184002; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fx/LUhwU/PuBYtkBp+ygwfhlhplOE7zsRH3troT6KA8=;
        b=i2ujJrb1D9nO/hu9cDbPAjhHHqffMnDb38JHEUX+5GcLatPkLsKhFIfYlks2Wl22h4
         dcEUw1W0YE/3jthQ3eg3mZJQlyoC2bliAPxptg0oGLnn7Yy6idbBe1YqbDTerkMfZMpy
         vKCgmT8X2AgSOo7TTewzY/m8VQ/ld/fbrgBrUabZemG8Xa9zfEkrKqUNZENNGGn9EZSR
         C0iHhx/5A798ar2ZDEzvzG2P11xY9BEd1jFIzrBU1YV/inbVmxJIG5pdlAibDoVuuCI0
         k4ske8v9r+xL4MubZsrDnb1WErNVjmyButUPp1D2iV5gFEVreLaJBzDm9hDnwoj5218/
         xzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780579202; x=1781184002;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fx/LUhwU/PuBYtkBp+ygwfhlhplOE7zsRH3troT6KA8=;
        b=O0hWyN2MLFvPkYvChYGCL9+vBZNdYY0VlC9jZh1id3TVH5mWVDmvSyI3ZGa+3q98EF
         li64BIdgl7Fuzyv8PKLUpHWKmdDy+YjRhzt3Z5u0CqRT9s5o9LWMfHzwNzXEW6cn/ZVj
         1+Uwm/McLnOY6v9ruVsLXnp7T8Xvb/TlamU8UZtZ8PqRQRFYC0XD5L3x+xdwkm91kaU1
         sumTXWMpkb26iP+VPKaN7cZCYNoumBwBbP7Slni4q6/zWTRCWTZMeBNM/P6Nv96RZQP1
         VWKxMNJv6Lb/PmmWOqqurgBtmcNOp34h7Qnv4JNWylMf1kNHixXMltypjBNkLzwPLAN0
         TP+g==
X-Forwarded-Encrypted: i=1; AFNElJ8zf1iqnXYcD5oVaA4PbMb0WGar+xSXS7wdeslmmGzUKrpckGgAIqNW7aiiGuuBHPjqhgq66IIvEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgwtarDm9l320RP0R3933RHIYHJXRRxNfJxEJYgB3tv2gH3rds
	myTJAU6RQV9irnycMNkqlrt0Q6sN7yA1tXBzwwqgLCeuIxDcH/PsA9uO
X-Gm-Gg: Acq92OFeC0uMmayGvesaYAM7tDVK2eSdJ4S2oB9BBksto4YachkB7z4z9nrPMBqc0hC
	v/dLQPnGv2TVFE7EYX6JLFWxJTw4Q3UaofT+u8EaoOc0erB6M2q+kBY0WT7/v+vHKjZNcSqErm6
	CfClfTHtMFfVBmwK5Pf9HrTQL0hxoMvvpdZe4xvkldXGNFy6ywPHdJHI4RA4QRmJbOifsLUW04/
	KvhhG3EzRmdb8UEGrWi/Ir0VLLO5L5IKsnArh+gd7uphIqbksYN7gzP/FPrD1LOu92YJfna7nGE
	v4n04tA+hq3cjRr6sAg4MQrqZEAFCzV1uBxJJQPHAJ8S4KgJvAnIi2sAO7VkH8MoCDnq+67feMD
	kJkEUHTpUA7Hc9Tiaee4g41ruOo3SZ/taDhr8eZZreNYW7V+kvNFisCMKHaixypSUB13JgTiY3s
	GY5ffDpndAXjxB5NKFxVcrVwH31RMnq1Xz
X-Received: by 2002:adf:f9cb:0:b0:450:ad00:86aa with SMTP id ffacd0b85a97d-46027334f00mr4350905f8f.15.1780579201550;
        Thu, 04 Jun 2026 06:20:01 -0700 (PDT)
Received: from localhost ([94.53.77.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2f67c6sm16699144f8f.16.2026.06.04.06.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:20:01 -0700 (PDT)
From: Catalin Iacob <iacobcatalin@gmail.com>
Date: Thu, 04 Jun 2026 16:20:28 +0300
Subject: [PATCH v3 5/6] sh: Remove remaining defconfig reference to the
 pktcdvd driver
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-remove-pktcdvd-references-v3-5-e2f06fb4eef4@gmail.com>
References: <20260604-remove-pktcdvd-references-v3-0-e2f06fb4eef4@gmail.com>
In-Reply-To: <20260604-remove-pktcdvd-references-v3-0-e2f06fb4eef4@gmail.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Jens Axboe <axboe@kernel.dk>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
 sparclinux@vger.kernel.org, linux-scsi@vger.kernel.org, 
 Catalin Iacob <iacobcatalin@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=686; i=iacobcatalin@gmail.com;
 h=from:subject:message-id; bh=qLq31BYjVwoita8p3VYbMVHsnGBFQquUbQzcOZAQW8k=;
 b=owGbwMvMwCX261qtXAKXKjvjabUkhizF6vUbg4sCfwjVxDoesvyfcbp2wXwO5d1rzS5+q5cTn
 pozz+ZGRykLgxgXg6yYIsuLc9fbNuw5E3Avya4FZg4rE8gQBi5OAZiIMRcjw4LzeSe7T+xV9p50
 z5Yh/ZzHFna1hwXT1+ZHTSp83fXl60FGhj0iy0Jk/1atj4qxP3tw4bVFNxnFYrn//RW9kh8fLuX
 ymhMA
X-Developer-Key: i=iacobcatalin@gmail.com; a=openpgp;
 fpr=F609BFABD84EB5C9DDDC37EDE89C6A3571CD0E33

Commit 1cea5180f2f8 ("block: remove pktcdvd driver") left behind a
CONFIG_CONFIG_CDROM_PKTCDVD reference in defconfigs. Remove it.

Signed-off-by: Catalin Iacob <iacobcatalin@gmail.com>
---
 arch/sh/configs/sh2007_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/configs/sh2007_defconfig b/arch/sh/configs/sh2007_defconfig
index 5d9080499485..f287a41cd38c 100644
--- a/arch/sh/configs/sh2007_defconfig
+++ b/arch/sh/configs/sh2007_defconfig
@@ -45,7 +45,6 @@ CONFIG_NETWORK_SECMARK=y
 CONFIG_NET_PKTGEN=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
-CONFIG_CDROM_PKTCDVD=y
 CONFIG_RAID_ATTRS=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y

-- 
2.54.0

