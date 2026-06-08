Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F483D5253
	for <linux-sh@vger.kernel.org>; Mon,  8 Jun 2026 14:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780928900; cv=none; b=BWhMjcK9PGCkV247LQ0mW8Q45dhY1pRo7lrqvSupPI5Yi0de1+N9DG0WiDGIEhBwQWkVvYHLz0wp9U1W+EvPkhSZY6jV8b9rYUgn+5qklPPoCoJNIKOVpPVSglg26bI55q1RgmFUuKYPnE9FwC/Vdo0zNpTk7ZQ8zlCVgRWtUNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780928900; c=relaxed/simple;
	bh=gzHc6gkZVQYvB/HNV+tpD+0yf/PTlunsXEIfWYwA01U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g0Pmnq5NXfc/wVXI0Tnljbe6QWvIGjKbM/5zgmfOTWEI/lzCniOD3nkGK27sftSDmu77BRGSvnwkrkgNBocHJHHdpVqS7Ad0SGOHTwQynliqfdO45scGVsBrNGW8FT3bGJNHwHtLamrFDtHlmHsPZXiElNaFALaQW5VjAqv7X7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pjfKWEW0; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pjfKWEW0"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490a76757e5so28681295e9.2
        for <linux-sh@vger.kernel.org>; Mon, 08 Jun 2026 07:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780928897; x=1781533697; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qohYqz4B4PBn5o3+UkMj6t+aWtH9uwOMAfqBpeAnghs=;
        b=pjfKWEW001D4YEjJQ1VE244wapauduv6wivj5ZIgUpExBrQaatIJrayTbrJ/UcLnI6
         iiSzJxmwDkxnbRbKZt7vpGC+MksPQhgA5UO9CrUa3PvY4Y6reeeMfhsc2rlu+wTiw8cA
         oB6O1x1ydNa2mFWaV9P+RTMkYiRe5oFzoLgyVmtq2mrlQhil0+ZLslLYoO75bbzUsvUy
         iqqMTXYWkFbyEGcKj5Ikln2LvJyqIv0mZGTVVXvpSlvH4sDVpumIThP350dQE6L92Rr9
         31mHyXFqiSIVV4LgJlqfbYWr5f+RhFbi1fh/vC3te5oO4xR4ZrxC3LMGhvSe7FJaEOzU
         dv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780928897; x=1781533697;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qohYqz4B4PBn5o3+UkMj6t+aWtH9uwOMAfqBpeAnghs=;
        b=cvz3bBdZLA0Fawsjru2sZVF5mPSrlAGYjFnCw1MITzNNnNcLHOkKNa5bwir/2iDM3l
         hfXC8ymfo9/4SiSB5dFRttuZD11U5LlY+AqzPrtJxbq6nADGK9/HCRx8JAV83ugC9sFV
         DDxeVBRJx2PJhILSe3rykp2gJjDdf7jH2o0yuLP6QU865rQkPdrpukwQUrM9MBzMqXT6
         Te9ZYB0q1ZHCbwv/yuB7mwaK//Q0M7PtFc2ZxoJmTKqzq/mhcWuX7/oUum+dYV4K6sRd
         orEsKxn0xz2NWy6m+FlT1zkVQ+ZyVxuAAK/wV2WuTmOHFel3z6BmHivJT6dcKuPw3HM1
         meFg==
X-Forwarded-Encrypted: i=1; AFNElJ8gVMNgNJNG8qmW/2B2T1VSPCzYXEKjLcWhyCqWewXIHk57mvD8Y6ElGNZEyouzRtW3DHxXOUJBSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YweF/3m1i1/odQUbbPxgOu5GuJ/jxW6+9E7qGF2EdyPmG/1C0Jc
	jva/x++YoU+duoLH3BwaAbR9CSBCaODu9FLYaqNmPHwaPV6NXxnFkUkq
X-Gm-Gg: Acq92OFz0sP0Aa5isqnQHgfVcfu7vnyr4l1EWGBOvyySv0UNRXQDnDk/wKxXWO0Y+JT
	YWv0oV44DHQciy3xD5VlzcGSLp9PMxprkPj32oLE8pUI7U+v0IZxtmr+5dggnfOu0zwO9YWFMNi
	wClL9WgZjragMCdtXKNFEVbX3NDrTIzgsHwgsZxfPhQeeJ4gtgXj3Eq6em+0tDOJFjKisHsqrbn
	v5gTQvIXgqOJ63Y1qLgOpifXBTbqLx9Y8E4aelzVhPd8otTdk4oPAYiwIu856HVH3jfE+puagK0
	pfJaoZnCyDvF8+QslFSVA95vY7W0P0aMMzdbeQbjJ2BWAE80mM2NbDP0OEyJaZ6BmjfbyrtfDEX
	LInpvjg/dQWGkhSRjcECSHCzG6MLa+Zp3HWE5b+mHhxvVcnkmh+dbjU4Z20j2u+S7AY1Z8Z5lFM
	oPnwsvyKFU8SGlkLR0UOe4cuCV8v4ZSfA1
X-Received: by 2002:a05:600c:1d29:b0:490:50eb:b777 with SMTP id 5b1f17b1804b1-490c2597822mr265428775e9.5.1780928896699;
        Mon, 08 Jun 2026 07:28:16 -0700 (PDT)
Received: from localhost ([94.53.77.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcad5sm58108978f8f.5.2026.06.08.07.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:28:16 -0700 (PDT)
From: Catalin Iacob <iacobcatalin@gmail.com>
Date: Mon, 08 Jun 2026 17:29:18 +0300
Subject: [PATCH v4 3/5] powerpc: Remove remaining defconfig references to
 the pktcdvd driver
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-remove-pktcdvd-references-v4-3-72f88b04cc87@gmail.com>
References: <20260608-remove-pktcdvd-references-v4-0-72f88b04cc87@gmail.com>
In-Reply-To: <20260608-remove-pktcdvd-references-v4-0-72f88b04cc87@gmail.com>
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
 Jens Axboe <axboe@kernel.dk>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
 sparclinux@vger.kernel.org, linux-scsi@vger.kernel.org, 
 Catalin Iacob <iacobcatalin@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1209;
 i=iacobcatalin@gmail.com; h=from:subject:message-id;
 bh=gzHc6gkZVQYvB/HNV+tpD+0yf/PTlunsXEIfWYwA01U=;
 b=owGbwMvMwCX261qtXAKXKjvjabUkhiy1iwfmTElx/xK55o6i86kC379LZn9k10kzaVc99Njd3
 jPQfnZYRykLgxgXg6yYIsuLc9fbNuw5E3Avya4FZg4rE8gQBi5OAZjIVFGG/1EhNZ1mKjOin/vU
 q7bP1LpQFJ4t+z+hMjdmjWGLWsGTowx/xW85dQpMajBlsOM6uceUz326+1uFPIOPe7lffQvjmFj
 PDwA=
X-Developer-Key: i=iacobcatalin@gmail.com; a=openpgp;
 fpr=F609BFABD84EB5C9DDDC37EDE89C6A3571CD0E33

Commit 1cea5180f2f8 ("block: remove pktcdvd driver") left behind some
CONFIG_CONFIG_CDROM_PKTCDVD references in defconfigs. Remove them.

Signed-off-by: Catalin Iacob <iacobcatalin@gmail.com>
---
 arch/powerpc/configs/g5_defconfig     | 1 -
 arch/powerpc/configs/ppc6xx_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_defconfig
index 5ca1676e6058..647775f6d174 100644
--- a/arch/powerpc/configs/g5_defconfig
+++ b/arch/powerpc/configs/g5_defconfig
@@ -57,7 +57,6 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=65536
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=y
 CONFIG_BLK_DEV_SR=y
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index eda1fec7ffd9..5c3e25fd8edd 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -306,7 +306,6 @@ CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=16384
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_VIRTIO_BLK=m
 CONFIG_ENCLOSURE_SERVICES=m
 CONFIG_SENSORS_TSL2550=m

-- 
2.54.0

