Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D694317167
	for <linux-sh@vger.kernel.org>; Mon, 27 Apr 2026 11:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777290680; cv=none; b=YTv9alox3JgsnHFvskS3alZesuEJ+S8pyNp56eK1jJEdgmCErblvB2PIXOwZco4XoWVR1lmG2+E8TfQRH+P5eod4uyebDoRD0hv5+/Tienvr+bm9KJxeQ7i5CYr4fYlozyRzZSWVFe5FQBIroXTjbJGNHPiWAA6S6DudquIl4W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777290680; c=relaxed/simple;
	bh=ZvC94RUtXjhCoDy3NT/pPP0G0XgJ0oCcr5awCU+I+MU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slZBB+vFB36bUTLIgBCfdA/x5gfH7NpyNf9Tgk+RvJSaZ22rCiz9/PSdYeIqPJ1qK84bILnOATinEPFWQEn83BnQMFd1g1Jyw1IS7bmrjP5bGiIaG2A6s6YVIiEiG7dU1AeWEESVbaEZP/eUv/WRl2WygFF2WOx1zs7Pa2SxtJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YI+cI4ea; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YI+cI4ea"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-441209fb77eso4428995f8f.1
        for <linux-sh@vger.kernel.org>; Mon, 27 Apr 2026 04:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777290676; x=1777895476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfSdD+/3LCf1oPMPi4U/rRQ7I8X6OVvY9lwSQny+X6I=;
        b=YI+cI4eayMXyNL0xE2SBr63jLIU/ntbAeDvtxnSNsP6vWnqlJwjvf8VXwvGTjFssq7
         115L25wLMjMkz/kq+NWoe8EZy6fT1DOMQgJtR4C67YdForQHvlD5S0qUl6ba0C6DItFr
         DtA50rJAAWBNtsDTegEGUb7PWhS9In1+fApOWocDZAwZfvQ9mb6zJF49JpAH/14r1fer
         Xp0KuVBIH+HkZGpqZEM6rEp4mhQRAvxcAEfxWm2gv2kCDaGn+zuGhE6krG7cYx9J7XhM
         D7Uz347f7rS8rti1iM/8Gvb4PsbMzgEIQLcXV6nWLjkLNW+M64qdBgEQeHGHGEYG1wbY
         9NBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777290676; x=1777895476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YfSdD+/3LCf1oPMPi4U/rRQ7I8X6OVvY9lwSQny+X6I=;
        b=mDxzPHMqP60xaZO9ET1BQtJBXmJ4Crj2kqGkTCVZTdMmt5d+GjYD07OxTWT4yUigUh
         BlnUKfuy9i/47u8b2LP7w2OlzAC3fuBvh7ZR4IF2piUtbDKUjIWjJpjIT/nMyeSoBubW
         hPDorLbaGEErBUriMT1SYg7Vg2W+xqbEAZLsAGPdw/t/sOdKZgn4lAynYS93yNOQyyzI
         pUzmxkYz6rSg3CueOip7vbt/KZ9ZL2F+vuJYq0NOK3PO/L9s4vg+sHlWTEb/4K9Tgvl2
         RDVqZuxJvIVs8XzN1Iujtyojr1pMMDQdv7UY8uQ0rGs9nHebOeJGKEUlxjDRoK6LAr2P
         VLWQ==
X-Gm-Message-State: AOJu0YwkxGdGn5nqN9w35n4INqdtjI63UACQ6/s6I5jXkJAhoFALuY0/
	m8ca30w0OsCH6lT1sLliB6yKkerR5MdBJ+f1WMNTKzBYr49llDwvMGo=
X-Gm-Gg: AeBDiev69Nu9gHyrUqLub5r6c0LHGn9LS+C44JgkUr7x7TLAZmAYHsxwBxFI+J/ydCe
	DQLyFvKStEk3gR6+3iLOhAENvtdwZRSNKMOTMH3VQMvJYFmm8LS19Fd0KLl7thdjL+RY+Rg/KTH
	EhxOBc8Ghv+5mR6RxOTkJnN4wKU1hUUAd8IdHjYA/mIaSfWzvvYrJfBoxeenE2aC0Kk+SFWafmJ
	HrwKRSYwMmqjqi+K3UK4VNmn1BiJ/g/IpL/uFP1g2PZNO6f5PiputvGomL4dtSNiH90ieGjPjJf
	l1cz/qGJv1/p7uhVyNA8AyRwM7z8F7qr/zCZRaFXMWTJhHshim1U89+u/jBIQtmzodvcongwDP7
	/mN+cKg4Z1ddaZGCwNJrqTLnSR56sPfVRmhtkIyCLGwJCVPfptIe7Q6sThyuYbtBZxc+cgp8NuH
	a4CVRZ6cZZYE1fOoxP82HHDtgxt0nIL/RPgGfpWoiKBm8+knFA+QGbYYY5GTDYJbfKhso5Jzrp0
	1O3+EQBlA911FWzFls=
X-Received: by 2002:a05:6000:41e4:b0:43d:7dc7:12b2 with SMTP id ffacd0b85a97d-43fe408b8abmr62962656f8f.21.1777290676373;
        Mon, 27 Apr 2026 04:51:16 -0700 (PDT)
Received: from localhost ([2a02:810d:4a94:b300:3c87:b0bc:8c35:1ba0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-444eebec868sm5255150f8f.31.2026.04.27.04.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 04:51:15 -0700 (PDT)
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
Subject: [PATCH v2 1/3] mtd: maps: vmu-flash: fix build error due to missing include of linux/device.h
Date: Mon, 27 Apr 2026 13:47:48 +0200
Message-ID: <20260427114750.2480900-2-fuchsfl@gmail.com>
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

Fix build error by adding the missing include of linux/device.h
linux/maple.h embeds struct device via struct maple_device, which
requires the definition. Otherwise results in build error:

./include/linux/maple.h:81:16: error: field 'dev' has incomplete type
  struct device dev;
                ^~~
./include/linux/maple.h:86:23: error: field 'drv' has incomplete type
  struct device_driver drv;
                       ^~~

Fixes: 313162d0b838 ("device.h: audit and cleanup users in main include dir")
Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
---
v1->v2: no functional change, just rebase patch

v1: https://lore.kernel.org/lkml/20251117224408.498449-2-fuchsfl@gmail.com/

 include/linux/maple.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/maple.h b/include/linux/maple.h
index 3be4e567473c..22f2930251ed 100644
--- a/include/linux/maple.h
+++ b/include/linux/maple.h
@@ -2,10 +2,9 @@
 #ifndef __LINUX_MAPLE_H
 #define __LINUX_MAPLE_H
 
+#include <linux/device.h>
 #include <mach/maple.h>
 
-struct device;
-
 /* Maple Bus command and response codes */
 enum maple_code {
 	MAPLE_RESPONSE_FILEERR =	-5,
-- 
2.43.0

