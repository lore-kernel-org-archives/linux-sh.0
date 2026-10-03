Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B943637F33F
	for <linux-sh@vger.kernel.org>; Sat,  3 Oct 2026 08:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791016131; cv=none; b=suDqU1oJfg3eEyysFhVCg/eS3nUVz/SKNqhltuggF4etX7MKz9JMsi9+kSDdAJP2sHkFVU4UbhYAIGdv/Hr2wr/qEWe4xvcJ31ZniTNW9ZIsU8rlzNA1vQBLlvwbsoYTaPSC62W8us90zbgxAnMnJtSpRJOMsHet9+XMDN5IZEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791016131; c=relaxed/simple;
	bh=HTPEmPCGYmkqZSgwlod58JbSJWkfi4nkOEYwzAfzU/M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n323JTSWSkF9tN/xs8huRS1a8CS9OC643tApNfY/7WZc6bqadt7AZvA488dfsg6u09dLOAcVw7Anrgh8Z/HLNkC3Ol0QMFBl419j5CzzRFlWB1XL4QXHoO1LOZ3kOnREJH7/BuVuzQjbDQyZm9MZxl2sx4KpydIUT9p6u0xPavg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2s2AwrX; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2s2AwrX"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so1596385e9.0
        for <linux-sh@vger.kernel.org>; Sat, 03 Oct 2026 01:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791016128; x=1791620928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CgkLt2eJLsFwOY1HeC2FpkdUeH6OhVDWA9sxCZx56OU=;
        b=V2s2AwrXE3qChXALPLP6LdN5Lkd7jnNw0Y1pchRFvuRGcgPAoiaqyI9uEIkjdqyc8k
         uyqKlWyo4kC7KloA7YuMs2vw541JmRdC9K3w3rfCcg+L30ZrnzKgri8I98yjirZutCWY
         TIVEsHPn4XFTi7C2ZEQA0Ud2pWNx2UJdVhERcTo3s3vY14DZFzEqfbH0ky34gw5rQYG4
         leIfoQ3yIvS6d0DQN62dmAzypbnpsnQAWsedhuNvh8W+/YaT+cI66PXuOJGf/rC/byDP
         UbwEQE+l9YE4i4yuMifS/ydDpnilP3Ubd2EoNnqweHij3xsUO+IE7XsGoQmmXoIG2w7m
         KGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791016128; x=1791620928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CgkLt2eJLsFwOY1HeC2FpkdUeH6OhVDWA9sxCZx56OU=;
        b=l7Bbzdm70fKSW2o876C+XaV2QzfbhbaNUT80b84/LJo8K0qZdRoSjK7pk47aNApH0V
         94KxM5ZEYuRC0rYAzeQ7k2P89Uxc6ssx2xbcnFrzIZohDI1ulRn/I3Z7aLN+TwfQRWul
         ew9I8Y27vbfYV3pK5Ep/rJ4NiMIWRoX7O3KXCx7nB1ir4JgOniOflk2Cg5bORTC9jxi/
         b1kJFemsfysjoYsNBFug6I6LQWa9sAwLm2uXFihbYjicg+81jPKbkVcrj6RZQFHqV/5G
         ih5w0pZTUYBb+YAhuZ7CRD8a40tVwmGs9cdeogtKgQfi3eZEYUwm7C7vMplyV17FcATp
         6b9Q==
X-Forwarded-Encrypted: i=1; AKwUvByM+ZJl7zhCgg92E/UOv//r/0e2p2jeW8i5bFm5wjb85sKcblchLMAZfmPWcfX1MiRfW7GpRtCReg==@vger.kernel.org
X-Gm-Message-State: AFuF++nwXin8BPym3UH95z1TIdNRfMPhAOYCwLLX56xLG82a3pSHYT1h
	bQl5YiflQ82Nj7WkVHA29W2O70t5vQ0x16chzOAMju1RXNgHuaPcOmj4yNekMdar
X-Gm-Gg: AYBFou23RqwJscCYbofg84TgPbCAxcDaVff0wAcjseMF8NsOsjDAm/8+KTgvuWuGPmr
	HR9dHD+jaefaaIBYODBAMZY9AXJKoEMXtVFLtoK8u5I75/4iwHB++D2YDqSEKo5/jbnbhyNGKEW
	FQdlhGXyglEFhYw0oHcH9t9MBJ5TUUTb/ugZMAcBObQ81y7Gni6xifa5NBGEXRP8R+FySBWZ6wm
	0AFeuOkBZr5Gd9OwSGHg47gCamn8LSANhXVhrDuohwvpw3HLYjpB4lixv/ZmZ/wL8Zt6XQjnBpP
	Y+ocViCDWLxdqIlsNBZoTBwEfaz7cE8ui58KOTRDJ0ykwfkXoDYxP31OLiQ68V6C23scVPUBxK+
	1kX2ERpdcMCxtcW0kb6Y57YbY5D32OsFVG9+J8PHz9rXodjDP+KCtzQdV1v6Fy0YnMGhShX7Mnw
	NGRIxweeW40lT1AvkHDGDvpsRVpAV680OeoVRfAHjL2MOdlZ+e4AaN/gIAyAKgLc3TVYdu8Lax5
	IGiY8EqxT9t8zEOa1oD80ytnjbaCaL6vFkUqN4BqxtYSUWPbSSFQjrgDsBgv0M6VYKx4psON0b0
	lQO+Cgp9EJzV57JqUuMCxrrHIx69W5DPrYntawFlqjE6o+zaw0397YaTLgfURZCwp+LgfIH5hLj
	TikI=
X-Received: by 2002:a05:600c:c091:b0:49f:cbf1:e77b with SMTP id 5b1f17b1804b1-4a1680dd2c0mr16619435e9.10.1791016127684;
        Sat, 03 Oct 2026 01:28:47 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b2e2-2001-c47f-5a89-3d9a-cd2d.310.pool.telefonica.de. [2a02:3100:b2e2:2001:c47f:5a89:3d9a:cd2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b380fab11sm10937712f8f.16.2026.10.03.01.28.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 03 Oct 2026 01:28:46 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Yoshinori Sato <yoshinori.sato@nifty.com>,
	Rich Felker <dalias@libc.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sh: sh7785lcr: register the PCA9564 as I2C bus 0
Date: Sat,  3 Oct 2026 10:28:33 +0200
Message-Id: <20261003082833.21511-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The R2025S/D board information is registered on I2C bus 0. Commit
44454baa7ca7 ("i2c: Dynamically assign adapter id if it wasn't explictly
specified") changed the PCA9564 platform driver to pass negative platform
device IDs to the I2C core. The SH7785LCR device uses ID -1, so the core
assigns it a dynamic bus number. Reserving bus 0 for the board information
makes i2c-1 the first dynamic bus, and the RTC is never instantiated.

Set the platform device ID to 0 so the adapter is registered as i2c-0 and
the RTC board information matches it.

Fixes: 44454baa7ca7 ("i2c: Dynamically assign adapter id if it wasn't explictly specified")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---

Tested with 29-bit and 32-bit kernels on a custom QEMU model of the
SH7785LCR. Both registered the controller as i2c-0 and the R2025S/D as
rtc0.
Testing on real hardware is welcome.

 arch/sh/boards/board-sh7785lcr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/boards/board-sh7785lcr.c b/arch/sh/boards/board-sh7785lcr.c
index 25c4968f0d8b..b93423df582f 100644
--- a/arch/sh/boards/board-sh7785lcr.c
+++ b/arch/sh/boards/board-sh7785lcr.c
@@ -256,7 +256,7 @@ static struct i2c_pca9564_pf_platform_data i2c_platform_data = {
 
 static struct platform_device i2c_device = {
 	.name		= "i2c-pca-platform",
-	.id		= -1,
+	.id		= 0,
 	.dev		= {
 		.platform_data	= &i2c_platform_data,
 	},
-- 
2.53.0
