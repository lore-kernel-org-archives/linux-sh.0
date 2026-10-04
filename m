Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F9D3F9F2E
	for <linux-sh@vger.kernel.org>; Sun,  4 Oct 2026 18:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791139619; cv=none; b=lxc240ZoaMZUslKbm9IWeNXVMN6X6YYltUy7zGkjW+avc5vantLF3X/gJxFSTChPuQe8A/QZGKoySKQfR/edMs1vENmawW7tdgEdvaSHyxF/lU9ZCeBrr/hKywxZkCUQfr52yT32WpR/h2teq1f0MIZjuRYDWh3mnAPBSSQJBlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791139619; c=relaxed/simple;
	bh=BRr+vwdAsf32XFj/ye3s53koPgv7dr9UfIumPRKd20M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WR0pIkqWNNMl27U4mYdmX6hu7jiAAcRBUP9wEBNufz4pOgKSqhotJ4ywTbSL5YK43C/0OPRovDkfZn2pXcBItGcM+gGjYt2q66dD7zsrbvseV8prtjyhCsA2UKy9JkTV0O0aEsNe+7n4QIFXyVL+uPzjpSWgXxG/T6oOmGC73zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVD/AjqA; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVD/AjqA"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a1728d8dfcso1155615e9.1
        for <linux-sh@vger.kernel.org>; Sun, 04 Oct 2026 11:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791139616; x=1791744416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wGE1OXJENdmlXxvOEniQC7H7TDqRf95SbseW6xkxfxQ=;
        b=jVD/AjqA/fJkvIySOX5sctn3fZxeVMlXCjdloPPDJEqi/t0QBZsvUCqA/Yp5AS7hpd
         26r8G55r3bPLzRfwu+stY7QDEfVgea+if/kLUbeYl6h1ojp8jlfoGjPA5Bo3+mTbGoba
         C82DmepPwqHYM3fAIigz7cFzNO2llkAVGhKp9w0EkpldhdpIuK17DfY+pfuMyysJOKCL
         hyh41ZpMVgjouyIQc/yJL0ZWnyQYmv4ebmsG39HQSH2k5MUTv4eJPvpRx8qFt7f372p4
         9AJZzTzffssEp9C2QFOU7N8ByZJejDwFJI/2P1M4AAYEdFfYtmo0WXuSHumEB9YteM5P
         sszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791139616; x=1791744416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wGE1OXJENdmlXxvOEniQC7H7TDqRf95SbseW6xkxfxQ=;
        b=OjbYVitlYSpURtamGiebfr4/iQyZyZD/tAnpeDCWT/6Ky/aul18Om42MG6p5woxIeZ
         qxBt4dL10P9tWfS4ccckNk97j6WKnQuBcD0TBvDBLjdqPXRazMrfvnMv3bYrw6V0e9w5
         xKt9UfL9lrweJndRIjUTY9m4IZRGLmGYjdfdXbwn87Y1oKFBSDjCuIbZ+zpAlv7jrRKW
         rDwcs5ygldDK+YdjwP1X3a8zw9x3El9V+QbR44n5iuJkpfQjUrgrxSjrCp/QibQdE2yw
         nuxtA5jgNZ4Uhi298a/5EuN1NL2wUZ67x2UQedApjmnBZVYXg0twruQsp/dmCZmJcJc3
         zruQ==
X-Forwarded-Encrypted: i=1; AKwUvBxDK6qLmzP4RaEvOCcwckRy/1ooZeIHOg8pqlmhvi0n0ogq6AhvK1Uum8ecn2p93d/TXgcP0ym/XA==@vger.kernel.org
X-Gm-Message-State: AFuF++k+m/LfAdM+N6cpKyCgvPJMDbFOfdRF9aXCUwLIqRTudPtwBBP7
	fdnFwL1HVbTxUZ4+2uuxYFI0nJ94vKaqSlFWkNuNys9vDCWBuxGBco4I
X-Gm-Gg: AYBFou2eCqtwL76xNHv9RsgEy/8V7WJ0N8k6tkeFiHemE5Jj5JtmcGS/VJE4LN2WoHj
	/W3gVGKi22F0vzLz81/SSsqwMU25MZKdmix2tQc/SB+/E/Wvj5VKlY9dwvjBFkj/sVGgXfFPzs8
	MzDQfeHYJf4OKSevxPLd9brPkniaeSX1J8bI9NE68VpkawEL+3Q2INHMp+Ob+Y0kRLpzciysbw0
	r4pk7s38r+1CKCJ3Cexh9MLxlr2lBrjYRHsA7f1fOSoE94LTEiejwT2MgCIv+6bs/Ws2w/8p0Ji
	CtkgjyyvlXVEcs6gm4chcx9FW/HhsixADzpDcAlav/r3oCxiW1bK3t+Frrw/SragtJ+ETAsaEMm
	CfUWnIZGQgrem4GnNANV0IcmR3bci5dYvJ7Yjwomv33xYD1mF3C0r/qrbZVPQPQiuljT2NttIuk
	E/FoFHXtQMIP1PyO8EX3lWeeND74iPs4qYcRy2AdyR1mJZPwmBVAlMXD0Kqy7I2qaKBGZjojhqo
	vLMbZ7InQjOnl2AMZPC1eTZ7kqF2ba439FBvN2EnMSfmV+kTVLWqDPfKnPHPLXR4NbEKPOPHVVg
	WdiqYd4lUTc4d3FQGpYwqRlV8sdJJw5j3dJO/uqn1UsPzvmuApZIHSvSxpIV1RC6BAVQnkewWh4
	y+4GX9+g=
X-Received: by 2002:a05:600c:4e87:b0:4a0:2375:dc1a with SMTP id 5b1f17b1804b1-4a1680ece49mr82932205e9.21.1791139615573;
        Sun, 04 Oct 2026 11:46:55 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a190-7401-a90c-9d77-a1b8-e6a2.310.pool.telefonica.de. [2a02:3100:a190:7401:a90c:9d77:a1b8:e6a2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b382f8ab4sm18591274f8f.35.2026.10.04.11.46.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 04 Oct 2026 11:46:55 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Yoshinori Sato <yoshinori.sato@nifty.com>,
	Rich Felker <dalias@libc.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] sh: sh7785lcr: register the PCA9564 as I2C bus 0
Date: Sun,  4 Oct 2026 20:46:44 +0200
Message-Id: <20261004184644.90750-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before commit 44454baa7ca7 ("i2c: Dynamically assign adapter id if it
wasn't explictly specified"), a negative ID was replaced by zero, and
I2C bus zero was instantiated. Since that commit, a negative ID is passed
verbatim, instantiating an I2C bus with a dynamic number. As SH boards
still use i2c_register_board_info(0, ...) to register I2C devices, they
rely on the I2C bus being bus zero.

The SH7785LCR is the only SH board whose I2C adapter has a negative ID.
Its PCA9564 becomes i2c-1, causing registration of the R2025S/D RTC to
fail, and hwclock finds no /dev/rtc0.

Set the platform device ID to 0, so that the adapter is registered as
bus zero again.

Fixes: 44454baa7ca7 ("i2c: Dynamically assign adapter id if it wasn't explictly specified")
Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---

v2:
- Rewrite the commit message based on Geert's suggested wording.
- Add the tags from Adrian and Geert.
- No code change.

v1: https://lore.kernel.org/r/20261003082833.21511-1-kmehltretter@gmail.com/

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
