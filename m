Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3288029BDBB
	for <linux-sh@vger.kernel.org>; Sun, 19 Apr 2026 16:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776616154; cv=none; b=pVyw9a62WZ+/c+GvVd+FwVGsUmLFqPrEja1NR74ePBJHVVmeXzBwhkP/HI8nBfc3XQ6nG5bU7koDAHK+g+7EqiaC6iDBEqQOyg87w8dhKEUH4x4UTjxuB4T+MwhlQduTZJIdnw0JLkRgu/2xtD1WXvTjZn8sZlAYet9dJOxP47c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776616154; c=relaxed/simple;
	bh=1sb7wN3eYGAQdamJ89DLNnKCT1xdePZdB8hf7+oTijM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QkGpp2PQKebpRhoUIcsdmqnW3PQBs0rPBci3gZDGPajZxcLgamZI9n6NFizfgbmBj12RT7gAClnupN2fPWppo4938B7NE+F2lvaiGh1F29s7uctb3jkxZ3HpoO9cBbvKSWwrFzFU5x1uJqiC7rPWQbIQPgq5CzzXrBo5V9hPXtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUuMBEh0; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUuMBEh0"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d73352cf2so1892702f8f.1
        for <linux-sh@vger.kernel.org>; Sun, 19 Apr 2026 09:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776616151; x=1777220951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IH1mNiSxJXGXo2HwZVp3mXz1xbpeH6Y5j/S+8PSgzoY=;
        b=PUuMBEh0uOTApYtibXKsWNAxsx9VcwUljpjB0Czb4K8GGC2mKdFKilTfu5qiSntaQi
         fPOO/G4AkTvOqmfcSIsa+L4VynoG1PgAZf4hCwAfrKY4PGomet8N0sJUpwB55NXl+3kp
         xU5/bk7yem8w3QGt26sAR+YnTiUBKHE2NsUzk4ke3b+rOU3sYT8kvfv4D03AgbyD4A0b
         s1Q3qNRQcQVZadGvsS7ETk+mZuRxeN9T6dem61L4rqv9UiQALWBD8i4MVHT+dbDxfTKD
         NQWJdrNSc99N0Cf4gjy4QyixEBuemg0znrag/rYxvWPg1RFb768byBmh7yN/2hzBbMc/
         YQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776616151; x=1777220951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IH1mNiSxJXGXo2HwZVp3mXz1xbpeH6Y5j/S+8PSgzoY=;
        b=cieNqMoGB+d22BYXPAKJU8vKamwoJDgv543JJ/n9nCNi873o4VpCb28HKxpgJEkPOf
         3Ue6w+U+RjxD/QF4eyCrv7aOGGeWDVV3SGu7Fn3enALAWu7IulRChIBINHu9xpPC1qBm
         SDc4vPoaKmpum/+f6mIAClL/LC/RwRNvJm1BlC7hFHPyQ+Li9h2V7eKvTxHQk/uLS0IF
         OI7673gTys/for6Ls1O5afpXoI2bBuzh1nI8hZjEEpiiAp0lWsruT7BinbeQDXJLIcbM
         gnL3nwLRIEI0QQs8qYYRG6FFwNuGQ3aSNzwmy4ixMGeKc7V0Gx61XK/b5lZipcTYU/bY
         okrQ==
X-Gm-Message-State: AOJu0YyX8812r8VSyWWlKe4Gcp9s/CzUUeYO2gsiTE+exYmnnuaj5Us4
	jOFmXHwoaA/o4an/fnlVJynbGd1CyUARqxrHaswtlgo+66bp48pOPDYKQpRh56o=
X-Gm-Gg: AeBDiesWY1YVujzRbuKWnY8LDUlRgzji5N7yHVhxH5idraoeTtHVLitpqvnfNvi23d+
	rWl1JaR1ZcbwJevyssVfpSYoUB2y6B+aP3UAFxATweqsUJnurAz+lxhP9q6GBj7eeaMg6JglO7k
	74oKJUGjd3OQ4EQy4D1rNjH30hsIFG7iNcjhOgwsg4C7ZwsCsU/N6N+8nJJNe6URkGU1+/lcLnl
	WCDPOBWtSfWrqbEj5ckc2/DVzHo5Kt1yafdBYv3YsE15UxvI/CUQvj7x9u0BYwKx2I9rBBVQZ6Y
	x8Ge172TIQDtkEN9B+AGueJ3nDF1NqdrqcIsZsxMkBqfDGcAlJbUqebEPOubm+00bECiWWFDlMw
	ndzuBo4C2v+IiJvN94gO6Tfm6aRKDKWoR37lezaiA4C8TLnpJkMppUdtXkqUDxMgZ2V5QWHlfQ3
	/oav94r+6SocazKFrTYiA16FlJDSK8xUadtYIkw3FSl7diCdXTNjtB15ycMRZ/N9x9kdo4p6gNj
	OwEkhSJrgdpl0ETKrs=
X-Received: by 2002:adf:fe8b:0:b0:43f:e414:1bed with SMTP id ffacd0b85a97d-43fe4141c7bmr10259511f8f.0.1776616150912;
        Sun, 19 Apr 2026 09:29:10 -0700 (PDT)
Received: from localhost ([2a02:810d:4a94:b300:e7d2:9a54:d18c:d3f3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43fe4e3a381sm23740919f8f.21.2026.04.19.09.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 09:29:10 -0700 (PDT)
From: Florian Fuchs <fuchsfl@gmail.com>
To: linux-sh@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Artur Rojek <contact@artur-rojek.eu>
Cc: Adrian McMenamin <adrianmcmenamin@gmail.com>,
	linux-kernel@vger.kernel.org,
	Florian Fuchs <fuchsfl@gmail.com>
Subject: [PATCH v2 1/2] cdrom: gdrom: replace port I/O with MMIO accessors
Date: Sun, 19 Apr 2026 18:28:22 +0200
Message-ID: <20260419162823.2829286-2-fuchsfl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260419162823.2829286-1-fuchsfl@gmail.com>
References: <20260419162823.2829286-1-fuchsfl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GDROM_DATA_REG is a memory-mapped data register, but the driver uses
outsw() and insw() only for this register. Replace this with MMIO
accessors readsw() / writesw().

Before, it oopsed accessing the data register, as the io_port_base
P2SEG gets added to the argument in outsw() / insw(), which leads to an
unusable drive:

        BUG: unable to handle kernel paging request at 405f7080
        PC: [<8c28d5b4>] gdrom_spicommand+0x6c/0xb0

Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
---
v1->v2: Don't use helper functions with io.*_rep(), but writesw() and
        readsw() local in the respective functions

v1: https://lore.kernel.org/linux-sh/20260405082330.4104672-2-fuchsfl@gmail.com/
---
 drivers/cdrom/gdrom.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index 4ba4dd06cbf4..89938d9b2825 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -198,7 +198,7 @@ static void gdrom_spicommand(void *spi_string, int buflen)
 		gdrom_getsense(NULL);
 		return;
 	}
-	outsw(GDROM_DATA_REG, cmd, 6);
+	writesw((void __iomem *)GDROM_DATA_REG, cmd, 6);
 }
 
 
@@ -282,7 +282,7 @@ static int gdrom_readtoc_cmd(struct gdromtoc *toc, int session)
 		err = -EINVAL;
 		goto cleanup_readtoc;
 	}
-	insw(GDROM_DATA_REG, toc, tocsize/2);
+	readsw((void __iomem *)GDROM_DATA_REG, toc, tocsize / 2);
 	if (gd.status & 0x01)
 		err = -EINVAL;
 
@@ -433,7 +433,7 @@ static int gdrom_getsense(short *bufstring)
 		GDROM_DEFAULT_TIMEOUT);
 	if (gd.pending)
 		goto cleanup_sense;
-	insw(GDROM_DATA_REG, &sense, sense_command->buflen/2);
+	readsw((void __iomem *)GDROM_DATA_REG, &sense, sense_command->buflen / 2);
 	if (sense[1] & 40) {
 		pr_info("Drive not ready - command aborted\n");
 		goto cleanup_sense;
@@ -612,7 +612,7 @@ static blk_status_t gdrom_readdisk_dma(struct request *req)
 		cpu_relax();
 	gd.pending = 1;
 	gd.transfer = 1;
-	outsw(GDROM_DATA_REG, &read_command->cmd, 6);
+	writesw((void __iomem *)GDROM_DATA_REG, read_command->cmd, 6);
 	timeout = jiffies + HZ / 2;
 	/* Wait for any pending DMA to finish */
 	while (__raw_readb(GDROM_DMA_STATUS_REG) &&
-- 
2.43.0

