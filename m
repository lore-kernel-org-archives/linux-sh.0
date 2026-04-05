Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BBD36C9F2
	for <linux-sh@vger.kernel.org>; Sun,  5 Apr 2026 08:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775377421; cv=none; b=cFl7j841CCOaCiTDxBNJAvx7oj18r7/XuWWz8DvVTgFbWjP2Frz83spxRWyWghJ+GcwS8Y4uyLSRL7VWFrx599eBkI8LuD5SgUhl/KPcl0gSo4rucTuBOQSU3j9KjQKpR4YT+gP9TvXP9MC0FQ4nJ6jKE8kZ87s8BjV23HkI368=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775377421; c=relaxed/simple;
	bh=O818hNrmebuhm54PNjEMjBqHlwr2K30gFLLi0YLGmTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bFg54VQkJwG3ZAQPXkBOlM/3mJKOGrYZdvO6Yy6KnsNh6G7IGW/Tu5RvLGeV6vrlNIggYb9oHlpQvHwDJviv1peY0XYN98sk1qZJmzOXfUuqdZaiNxIKFW2mNP0XhqRoLrapMa4SV4lbm9p0IlNzJg2Ayhy8tcJM8hGZ3+jzX6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQQ+BGfq; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQQ+BGfq"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-486b96760easo36710405e9.2
        for <linux-sh@vger.kernel.org>; Sun, 05 Apr 2026 01:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775377418; x=1775982218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qyT7dMuTyeo4pWg6I7mWIhj7ve7iNx1quZYqE2iyEg=;
        b=GQQ+BGfqkjArTMRCkgJbjsOkz2DMt1wO1Yo0esvMEVACAw+KPJ3edb6kBJynE6qpw7
         wIZtBS5MvZ7spj+mdS5CJD1MLwFuX5RBp8aS4yx7m0WbeFjg53hpw6EEuAzi6r6zcEKr
         l1ESCrL1zSApDzX3DaW2fSYGZWqRa3fZZjNazZ/ps67ynELZjaLG+YyjljMpVEBf7z0L
         9gvAZLq/Tw4POJiLufGIuzdCdnB2kXtLcUB3yXYSf7kf+1MuXYM80c4n+mZHKzBHoAgs
         nEXHjww5ssUoncVMGupEBsHcGupl0ADQnSzKLBOZIgSoxOlTnWiAhWQHx3uiCaZJoetZ
         1VJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775377418; x=1775982218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7qyT7dMuTyeo4pWg6I7mWIhj7ve7iNx1quZYqE2iyEg=;
        b=dvhVvA6kuBK5LdQROfi2Pz9GufxXN45WCpqCtkUbN0qqi5nJq0tuR+okeI66vscgGo
         Z2zeptMZsTjUt07ziVjIzp7+drik0qhboywHDyRNCrP7bwCUS0zAy7lUCN1iH1r/SAXy
         gbn3sHdkqujj+eTemgV7L4R7jZcQSEE7Ok0hCmgZr0fSKIgqNXjirC167+JIjAAzVTPx
         mRIUXXFfN/Y3kSJgbaEHWlBL5wHkohjdCkhE6ARtuMK7NQFy1hWqraZDdRafy8mVXZlq
         ot6+lmxlOYIecvQ6DKCLBhOvUol5wKhIb3ULBsNJaSmNGxnsnHMowjhyMBIUJZVMJThq
         UXvQ==
X-Gm-Message-State: AOJu0Yz/N6M95H0zfqYQN2V3fIbSlB72+CzTs1UiMSvY0YIaIEpkZI2N
	JTHXZWRN/0UD3EOHRjhzQxaC7jBglqDTY/Ky33NanjeAoa3Vz5rtl4ubuigxy1o=
X-Gm-Gg: AeBDieuMQ3b4xNLRFinmPrx5KpWz/Z6glFRMu9+BUQwc0ueOhusYyCDWE1xuS6n3LtW
	EQRlmFQgzSclr/V1zzXu6M+7Ecen1rkaJ4h9AgccqAbqXU/wkv3y2rKmdg+4aRK+00/6eGFsjal
	6fy0VCoPcoXnTM2sGgc3UH1r3Bx7BxwIbyJy3P+bkeeyl/MhsMjQS5UsWkX5IzqJSqyaq4bB/xf
	awvITqQfkxBcag64A8D1BHykjl5qFsC7LUY9XVPmgoKYbQyhywmx/hfOYITMXKwr906iudMqNj8
	bbz5090JnE4AHpgwXjkceiHFt3j90TrLGxsNrWYueg9cdeyswZ4q++Olptez7KCl/bUyqO0YDjb
	xuZNqJvxmdtiOAj8On3x52aGClTvg0jJA0KMHEKXa1n8KEmzvzKPTr0Udi/PRNKJ/MIglSzi8+w
	4n0da9qPhEulkA9QFYDqBKVGmQE7iGhTwbDXULuMvcy6W+bVjiMN+YoE619bhaA8aQV4c7MNtM/
	XIeTtf7
X-Received: by 2002:a05:600c:820f:b0:485:3f1c:d887 with SMTP id 5b1f17b1804b1-488997d31f6mr136814905e9.26.1775377418195;
        Sun, 05 Apr 2026 01:23:38 -0700 (PDT)
Received: from localhost ([2a02:810d:4a94:b300:4382:4d9a:caac:a8d9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4887e80a616sm675861105e9.2.2026.04.05.01.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2026 01:23:37 -0700 (PDT)
From: Florian Fuchs <fuchsfl@gmail.com>
To: linux-sh@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Artur Rojek <contact@artur-rojek.eu>
Cc: Adrian McMenamin <adrianmcmenamin@gmail.com>,
	linux-kernel@vger.kernel.org,
	Florian Fuchs <fuchsfl@gmail.com>
Subject: [PATCH 1/2] cdrom: gdrom: replace port I/O with MMIO accessors
Date: Sun,  5 Apr 2026 10:23:29 +0200
Message-ID: <20260405082330.4104672-2-fuchsfl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260405082330.4104672-1-fuchsfl@gmail.com>
References: <20260405082330.4104672-1-fuchsfl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GDROM_DATA_REG is a memory-mapped data register, but the driver uses
outsw() and insw() only for this register. Replace this with local
helpers using MMIO accessors ioread16_rep() / iowrite16_rep().

Before, it oopsed accessing the data register, as the io_port_base
P2SEG gets added to the argument in outsw() / insw(), which leads to an
unusable drive:

        BUG: unable to handle kernel paging request at 405f7080
        PC: [<8c28d5b4>] gdrom_spicommand+0x6c/0xb0

Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
---
The original Oops can be reproduced just by mounting a disc, like:
mount -t iso9660 -o ro /dev/gdrom /mnt
---
 drivers/cdrom/gdrom.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index 4ba4dd06cbf4..dccf41fa5d0a 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -171,6 +171,16 @@ static void gdrom_identifydevice(void *buf)
 		data[c] = __raw_readw(GDROM_DATA_REG);
 }
 
+static void gdrom_fifo_readw(void *buf, unsigned int words)
+{
+	ioread16_rep((void __iomem *)GDROM_DATA_REG, buf, words);
+}
+
+static void gdrom_fifo_writew(const void *buf, unsigned int words)
+{
+	iowrite16_rep((void __iomem *)GDROM_DATA_REG, buf, words);
+}
+
 static void gdrom_spicommand(void *spi_string, int buflen)
 {
 	short *cmd = spi_string;
@@ -198,7 +208,7 @@ static void gdrom_spicommand(void *spi_string, int buflen)
 		gdrom_getsense(NULL);
 		return;
 	}
-	outsw(GDROM_DATA_REG, cmd, 6);
+	gdrom_fifo_writew(cmd, 6);
 }
 
 
@@ -282,7 +292,7 @@ static int gdrom_readtoc_cmd(struct gdromtoc *toc, int session)
 		err = -EINVAL;
 		goto cleanup_readtoc;
 	}
-	insw(GDROM_DATA_REG, toc, tocsize/2);
+	gdrom_fifo_readw(toc, tocsize / 2);
 	if (gd.status & 0x01)
 		err = -EINVAL;
 
@@ -433,7 +443,7 @@ static int gdrom_getsense(short *bufstring)
 		GDROM_DEFAULT_TIMEOUT);
 	if (gd.pending)
 		goto cleanup_sense;
-	insw(GDROM_DATA_REG, &sense, sense_command->buflen/2);
+	gdrom_fifo_readw(sense, sense_command->buflen / 2);
 	if (sense[1] & 40) {
 		pr_info("Drive not ready - command aborted\n");
 		goto cleanup_sense;
@@ -612,7 +622,7 @@ static blk_status_t gdrom_readdisk_dma(struct request *req)
 		cpu_relax();
 	gd.pending = 1;
 	gd.transfer = 1;
-	outsw(GDROM_DATA_REG, &read_command->cmd, 6);
+	gdrom_fifo_writew(read_command->cmd, 6);
 	timeout = jiffies + HZ / 2;
 	/* Wait for any pending DMA to finish */
 	while (__raw_readb(GDROM_DMA_STATUS_REG) &&
-- 
2.43.0

