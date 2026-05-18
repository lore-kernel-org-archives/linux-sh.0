Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F48325491
	for <linux-sh@vger.kernel.org>; Mon, 18 May 2026 11:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104833; cv=none; b=jN5MXR30rt/OJpSn82cYXb2yMqppfdCfBHCwiF1YWVKbMuhI9cF9EQB4HfogGbBbleJwIWljpVtegJ1UpOpcHfDprIrXoLchKew73M3Bs0ydY2lNAhYMs3sHsw4bGT6v4KtYlm+c+sGN3sTiO9X7QyHf7OIf/mm4IyzRzly13G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104833; c=relaxed/simple;
	bh=L0Rc+w8icLH5klehWd7GIFGwGQVz1yRZ6fpoEcrIfXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mm77xfo7JsEJCAQysx7eCb0v9HKDlPC1ge533pPTBiRvH9qmnD3ZqxFQQT+Kg7+p7qMI9Di9uoEjH+1WWq9DfannF8cR59IqxQqdi4a4KnytGGcn439ttvAYy6WDa2BKgftHO9di+/l4cYRnuuhOSdp4+RhGrpaUqh6ihawwRBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0AeCBIe; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0AeCBIe"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so1852883f8f.2
        for <linux-sh@vger.kernel.org>; Mon, 18 May 2026 04:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779104830; x=1779709630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLKMx0XG0KEj4EtOA3tO3neraMW/tRjRnfYn5YIq3Mw=;
        b=U0AeCBIeFSiq0lV3T+hW3aCbVa7kBoEjW6/EI7+PpiMFIjfHsQJfM/BU6WUSnO04Rv
         MsyTW9WsA3uK8ZhvRlcu2BCtoU1oXTOkcqDEeQZgNOXdY39hGl1hJKpMXpLP+orZXI0z
         K7GGycZZAD/9cki64RD8hsfoishHDJzkNVYE6l0aUFWWmCBDLQyOf3zWdJTHLbu6i1TG
         EXOVk2cxVBhmV5EuK0jxQowhRCFGo9GZjXlPb87UT1S6PPCdoZQSu221mWcWtgj41LmH
         /CL/q8heeOpC8HthLcgox4AYqkzwdmd2h64EVK8vTqOKai/rluCK01LpJq/36LM313C+
         TP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779104830; x=1779709630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OLKMx0XG0KEj4EtOA3tO3neraMW/tRjRnfYn5YIq3Mw=;
        b=hEt1ULGa2zA+Kq+UVJfyYFtOPQp6ft9Qt3XqhcoIechY+ELa9G/WJCfYjtMxoGisv5
         8plSfhnsPt7A3jhiXgAU7YagmkMq3mkqvsU7RgvrVBdpRhhY8vblM+Ujv35xDf3C7zcx
         dwG+HojOKlcaNcHa5Yts9ATRR7+JSgroSlbUbl5G10tNlXzwzZSkHB9GW43GJlSiE4En
         lDV/oVPHe7TyaC+Khu251OV4r4DjjZ7OMO7ac7Gx7sarqm0mcCy2LKl5GTe1tg5ZKi4t
         aAu2tmfJR3FbvqqFIUUbPLF1/AFi+muv9DV5anLM9fQeztzyDQRpRwweYoL878Tnvx52
         tX/w==
X-Gm-Message-State: AOJu0Yw/ywAKlt5VA0GxCCwGTKgHNQXysC/ht7q+R2+UENWjkHqpOH28
	oFFrem7tXw52f3Y/PLs4YfRwJkDi8XbzQlMU1gk02SNRHi7LGd0uxKo=
X-Gm-Gg: Acq92OEn0Nx7sy/yDReRZ3RRGIasXlgpMNSx0UPbHgG0+GfJFwViC68AAYYfbdp7MwS
	vTaz8onfETI6lmueVB9TOklagvYKnOFx9xYcaesiVp4u2fRJ2uWd9VxA/5N2CcZMxjGdojhCaUx
	o0XbzhgQF9Nvnl3BTuCPqW3fEkyehhfAcTF0W0onLN2inPnxRJA2j8HduQLBEO8+RQ7ztQKexYM
	tUpmivlT3XFp2qjHrDDEN/ULpbQMKVkNszdQqHa2MofB7kcu1F9AgJ5A35Rc7Qbo9Y8t4LOEIv8
	y/0WmZe27mM60JJwYSyVEOAEXiXqcLX9Cphg/Kqb6iQubGMg9KXk3MZXoXVt5uIFUEXjzP/05bX
	fr6al+QB7X5Sc6/nbCNGnuzKTUOzZ3HbzouAwX4eY45nlPS7ExjVU+tfF8rY3Tz7vw93JHN3brw
	6+avoLwacsyLY5246SpIt7XljdyLb94SHQMkyg+nWyGwymvgv8y+VkdMW9SXqhxZuhViGhuvyxu
	mir8pOX
X-Received: by 2002:a05:6000:2503:b0:43f:e43a:f4a6 with SMTP id ffacd0b85a97d-45e5c35e7bdmr22892189f8f.6.1779104830110;
        Mon, 18 May 2026 04:47:10 -0700 (PDT)
Received: from localhost ([2a02:810d:4a94:b300:f15c:fd38:3fe1:9653])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45da15a666fsm35365327f8f.36.2026.05.18.04.47.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 04:47:09 -0700 (PDT)
From: Florian Fuchs <fuchsfl@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Adrian McMenamin <adrian@newgolddream.dyndns.info>,
	Florian Fuchs <fuchsfl@gmail.com>,
	Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v3 1/3] maple: fix build error due to missing include of linux/device.h
Date: Mon, 18 May 2026 13:45:19 +0200
Message-ID: <20260518114521.81564-2-fuchsfl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518114521.81564-1-fuchsfl@gmail.com>
References: <20260518114521.81564-1-fuchsfl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 313162d0b838 ("device.h: audit and cleanup users in main
include dir") removed the include linux/device.h from linux/maple.h,
which led to build errors as linux/maple.h embeds struct device via
struct maple_device. So restore this, as it otherwise results in errors:

./include/linux/maple.h:81:16: error: field 'dev' has incomplete type
  struct device dev;

Fixes: 313162d0b838 ("device.h: audit and cleanup users in main include dir")
Cc: stable@vger.kernel.org
Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
---
v2->v3: no functional change, reword commit message, align subject to
	main includedir, add Cc tag
v1->v2: no functional change, just rebase patch

v2: https://lore.kernel.org/lkml/20260427114750.2480900-2-fuchsfl@gmail.com/
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

