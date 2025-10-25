Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815242D4B52
	for <linux-sh@vger.kernel.org>; Sat, 25 Oct 2025 22:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761432137; cv=none; b=PtRqdPWvJr93zGW4mTnLZHS1jnUA47xirb9s+KLlXXdv3lGuzyNcEI/GojL6A7K4Ia5WqiT7LOTxKeb1v7W4+WjjvQat8VlNIrg9i+Z0aOyP1EDrAut4r8HAJ/z10SSpRBrCpD6PKuzWodIb53FyxrQUjxzrPrkgI06m37hBsbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761432137; c=relaxed/simple;
	bh=4TeSUUQyzmjI+AmEM5j9GI7xFhPjauS254ia4GjX/nc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PBRfO3pkynqzXspBEFrQH/V+bdMWuP0d+ncwBraI/2CNtJrpHxGK1nqJrUf6S+PJLN736+NiRmlpB0RijyIuWJU+9PSYWD4OvcvlR7UQ+BX4ioRw4rPs/OjEizdZoLpXdKGfDqGxHNGC3bqUsS9akDnp8FJfpGtDJoEvocvgLxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtGPljA5; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtGPljA5"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4298bada5bdso2900801f8f.2
        for <linux-sh@vger.kernel.org>; Sat, 25 Oct 2025 15:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761432134; x=1762036934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXq2mQ4sAJmwho7etnf6FLZOIO7gybFmwHnhQ+k6dI8=;
        b=YtGPljA532L3+1QTNRK8ucyMfbMjuy1X4EvYe7fZ9cn/Sf/vdvXVFXJ3eVPRmRCf79
         wsD++hhvwDxz8P0UrlzVVZs+0eJSfSZAFPd7uskAKPrZZBlIPrfM63qU12Rc/lbgHQYz
         ccj4DqwGnTj7lMuUbUoe1lfRT+jYLyvl2NdBABK5h14/NEklRqPk2p8NYEbdvuseB6rd
         /4SCEemylkOzoyMOO+pQNcaxRrxq3DoZB1XSSpI+zn0XQGkPl9VSegx76bUCtwyrU1Yw
         Mo9xL+BNqgDkq3lIGGQrVw8b0yUOoxqo4MNFHnH1SQsaGuUaa/jWeTkpY+ivKSyp34jW
         hiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761432134; x=1762036934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZXq2mQ4sAJmwho7etnf6FLZOIO7gybFmwHnhQ+k6dI8=;
        b=OGY4YWMZhmOl4k4yhcKyLPMoAhNr1LEZnxrC++0SnM+6JfGqUqprf3sxWHVBZsBC+6
         IAsASdJ4524i8P6IQdk0jJvMO2PR9OOGm6vCfDy+bWra65RLW+eLRhg5Kfq8Oe7YxwQh
         ETeDexLYsywS8A7oYKAweV1enQseWjciBuLlZbdFuaOd+sLHTuHkI13JtNmwXQUSojq7
         XZAQbc4Nmxm3CB3KhQM/5vnIKaVCFM1yQ2Ho+CqtaWMxEP6lH3ApThQjbYxpa7Uy9NU+
         o6CwVG8Ilmwv2MXi7MlhDwb1UODR+07z2gnqQqANYkuKQTuWdG2EJVBNLfd4HYnL37pr
         mmhw==
X-Forwarded-Encrypted: i=1; AJvYcCUAuAY+X3skfRG5rARHtfiujmgVyRWYQmI/sItC88fT5FuEFxw5JLqly2GBAcmyPXRnccZTj1EeMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YytebxSxc/SRm7eeVg/j/mr4hCTkx5xcV3KYKCBurPBqRcAzAq2
	aotOLAqFIZ7FJvetO9dX1PjZNJvIlsfWCaRXGtg5WOmcLO7CNyo1diw=
X-Gm-Gg: ASbGncuIoYDM5BaAYHwzEk8dhToRdpQsJbAhBwD0QeEswrfQa5O8zdooGSPd0ghHkaz
	3V3gXArrk/1PggIbw8liWxQgvzI/78QtHwPiAB0E0UnVsEeqFYH0KL6cC8Sb5rLjposOIB0q/vc
	JMG16xF7iQ29fjxxnyWCwvMD65iK80vHF9r1i8C55wMJCsnlvaq2gsvi5LH5byGoDDI9jn+3NjT
	lJ/hcceFZ7bFU2RFCpiTnJseW8l+SBINW8ddyrmdc+PK41hWpd2kNjMkDRVgFuUqhbAwpeoIRMM
	2P4hw/EOWTfkRGY/D+8swcerqq2TlP3k7pLPyveXEdWvZjGFGoEaGAab9g6whUb1Q4JuWPM1ax/
	+Ko0ylSkQ19Gfp2BJRIrMcbpeDaPr0iuoIUQzgWD/fX0V1eHJO2Z4Za5s3kNk29v8KXYmfpRhlq
	34pQRSTc6EtHszJRHUDZr6DRVfvj56TrLfx2Vo3rHremBFgV4/qNzia1Eu5UJRefp27WlHOBaju
	5i+JuY=
X-Google-Smtp-Source: AGHT+IH5qEmI200tfknZM3nb5ovcfV9MSsErH9Gyktcj7nN/CQ7b7jCUO5zA24B4gpxH66kEW1MyEA==
X-Received: by 2002:a05:6000:41d5:b0:427:666:f9d6 with SMTP id ffacd0b85a97d-4270666fa57mr22253037f8f.39.1761432133628;
        Sat, 25 Oct 2025 15:42:13 -0700 (PDT)
Received: from localhost ([2a02:810d:4a94:b300:bad8:a439:d5f7:21de])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429952cb55asm5742091f8f.17.2025.10.25.15.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Oct 2025 15:42:13 -0700 (PDT)
From: Florian Fuchs <fuchsfl@gmail.com>
To: Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-sh@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	fuchsfl@gmail.com
Subject: [PATCH] fbdev/pvr2fb: Fix leftover reference to ONCHIP_NR_DMA_CHANNELS
Date: Sun, 26 Oct 2025 00:38:50 +0200
Message-ID: <20251025223850.1056175-1-fuchsfl@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e24cca19babe ("sh: Kill off MAX_DMA_ADDRESS leftovers.") removed
the define ONCHIP_NR_DMA_CHANNELS. So that the leftover reference needs
to be replaced by CONFIG_NR_ONCHIP_DMA_CHANNELS to compile successfully
with CONFIG_PVR2_DMA enabled.

Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
---
Note: The fix has been compiled, and tested on real Dreamcast hardware,
with CONFIG_PVR2_DMA=y.

 drivers/video/fbdev/pvr2fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/pvr2fb.c b/drivers/video/fbdev/pvr2fb.c
index cbdb1caf61bd..0b8d23c12b77 100644
--- a/drivers/video/fbdev/pvr2fb.c
+++ b/drivers/video/fbdev/pvr2fb.c
@@ -192,7 +192,7 @@ static unsigned long pvr2fb_map;
 
 #ifdef CONFIG_PVR2_DMA
 static unsigned int shdma = PVR2_CASCADE_CHAN;
-static unsigned int pvr2dma = ONCHIP_NR_DMA_CHANNELS;
+static unsigned int pvr2dma = CONFIG_NR_ONCHIP_DMA_CHANNELS;
 #endif
 
 static struct fb_videomode pvr2_modedb[] = {

base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.43.0

