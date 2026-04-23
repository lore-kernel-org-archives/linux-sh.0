Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482BD31E834
	for <linux-sh@vger.kernel.org>; Thu, 23 Apr 2026 20:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776975663; cv=none; b=k4TtAjdTwMDTXjoqUXQV9EVxjwx/UnSnVc72LFoLQDsny66Vy8Sqi2dz4WLj2WIQCcSJJIGJDDVEAZdueZijERfcpIy/ycHq9PbRZRMIV0mPUQChzVQrIMf5WzVIMhHz/BibYiGbMdOSQGmg0xU/zmh+S6w2EIFxaWxZRvE1tVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776975663; c=relaxed/simple;
	bh=MItMYgTPqjew35OjcNGzbayMaTYrkGdkOC9phsLKuPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYsspMQWbpWYnpZ1SdNrRHr5q3M1Zt6zfJC46rgkXBx4inEfyaXhziml2wZhmPT3RrBgClZ/nOUw3sscEINtg8IzegO3/xvZMS/9itxEc0gvUwdpkosgDQiJdj5z1v+X97+81RxG6wIY4lNnCbh80TMutL24M5LoWwBiOBjkkXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gG3qZaTn; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gG3qZaTn"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso31319535e9.3
        for <linux-sh@vger.kernel.org>; Thu, 23 Apr 2026 13:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776975660; x=1777580460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uZeS63roDC90AYjgGVCDBffRF1wcD1gyBrAlyIC0N8=;
        b=gG3qZaTnIhRpa0zcZkIyaaTPfACCihksJdfydohIGbwOFW8RnHoxEXF/CyniCDnQB/
         6LaO/HCnFj5ESZ4uIe16/ISxlvzojcRsxP/BAPGn1SMnkwX44A3XyA2yRX0hKks5pvfx
         mneD30y+duPPNE/jop65CDzf9JZFR++xIP9jq/YCVlJqchB122/GKcbTbYmalGfHDpS5
         NHQoqLZ2mwFj6DFxgQ1uie3Aubh9mZCfIxqc1nVIRcTc17LYs2X9XDq9OBzAyfTX1Hc3
         cKjud0bIdLXpQ2uEh2XuK5WZQcPY6wus1WvH/lUt1OlFosn9ltFOzFEW8vJTSOQcR/bG
         x4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776975660; x=1777580460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8uZeS63roDC90AYjgGVCDBffRF1wcD1gyBrAlyIC0N8=;
        b=dmY0LFfv8smA8JgqCUHNBQogtDFCXDTZ0LTwT/KRI/j2SVPQrUY+wC21dv4kUbWJz+
         9DlGgiUWgtAfZAXNDpYZsBFloGmomKt6vWEio8TOWoFVQUu28YG3QRRFANrNLxEUoFjp
         /hy/9eZMU4uSU9BkYqOW18Yv0TxitdqpRK5881N6xv36SKp2ALb/G1gFIgm738UKFEG6
         Nxb7j0PhyyuhcUT1y8Qv+Lz6IXpfBFzel05VSkYcMpSq16gK+UIovn0kJFEM2STla5f0
         emcVOSiz7FWT2Ztao5ED1qmWuRpzBRWUo0aUb74bamZNjYY0qgFluGn4f52/ns93Wt9m
         slzw==
X-Gm-Message-State: AOJu0YwUVjxq588JcOqIN/F+OI6DyUfZeH/ESwOtVeSI9hpV0Njq/pA6
	YBVqtpYtaiv9EIDXnH9PgirHxkyXOKe0V66dC0V8Ze01u59NokVFfRI3q4fQr6A=
X-Gm-Gg: AeBDietMCxiXjxayOZl0O32mhHKfO0OibQHNLXzp78xgGjPmI8b1YlIWtESO8INdQjR
	Tq6vKYOE8jyeWF7NC1ofFAnnw4owO3dNffWcx12LKFvy5CI4yLnvs9K1BG6xePDZJeL5d0uK0aG
	47D8FU7yHaSjoAs18O+IuD12auqLTsgP5/oZRI696H0IuxcsrJ8pBe91nD6zJHAgR5AmCQ4POhf
	783sL8/nyearEi7iDrlepPQO6aq8xU6kY7ppy7xElgdFPQHU9NbE18vN0wNw75zP5n/w+NJOOur
	TiUCELmr13xsGE0Emcoirr8ZVFZAzg+vPAUYfrno0xlXLFqodi59Wy0Icwhs9nQWSuGjCXDDKXy
	0eJOBmex88cLr52vxv1ktJl4jf/DsCXk/b6qpymtmarNlfqBcomemhXluEyOFRo6GSdCEU7l5Ws
	3pjHmIuuYM413RqX8vxrbQ1aOsfiz72szngN4kknuMnOvDzNBjG89Bp3HlGIE28dBQL/5j1flX9
	W0p3Z10b9RR2e6bl95bBm/kjNs=
X-Received: by 2002:a05:600c:3423:b0:488:fd7e:1063 with SMTP id 5b1f17b1804b1-488fd7e1253mr219912995e9.29.1776975660167;
        Thu, 23 Apr 2026 13:21:00 -0700 (PDT)
Received: from localhost ([2a02:810d:4a94:b300:fb97:cfb5:53a1:28])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488fb75a913sm165439815e9.12.2026.04.23.13.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 13:20:59 -0700 (PDT)
From: Florian Fuchs <fuchsfl@gmail.com>
To: linux-sh@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Artur Rojek <contact@artur-rojek.eu>
Cc: Adrian McMenamin <adrianmcmenamin@gmail.com>,
	linux-kernel@vger.kernel.org,
	Florian Fuchs <fuchsfl@gmail.com>
Subject: [PATCH v3 1/3] cdrom: gdrom: replace port I/O with MMIO accessors
Date: Thu, 23 Apr 2026 21:41:30 +0200
Message-ID: <20260423194132.693271-2-fuchsfl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423194132.693271-1-fuchsfl@gmail.com>
References: <20260423194132.693271-1-fuchsfl@gmail.com>
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
Acked-by: Artur Rojek <contact@artur-rojek.eu>
Reviewed-by: Adrian McMenamin <adrianmcmenamin@gmail.com>
---
v2->v3: no functional change. Added Acked-by from Artur Rojek.
        Added Reviewed-by tag from Adrian McMenamin.
v1->v2: Don't use helper functions with io.*_rep(), but writesw() and
        readsw() local in the respective functions

v2: https://lore.kernel.org/linux-sh/20260419162823.2829286-2-fuchsfl@gmail.com/
v1: https://lore.kernel.org/linux-sh/20260405082330.4104672-2-fuchsfl@gmail.com/

 drivers/cdrom/gdrom.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index 4ba4dd06cbf4..094d55b2d004 100644
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

