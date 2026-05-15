Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570BB29D264
	for <linux-sh@vger.kernel.org>; Fri, 15 May 2026 19:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778874738; cv=none; b=Sgyw7jWtPl6TsJRU3joH4LGWnCsFkKCij43PG+D5lGJ5vcLDX//ISDugJOn5UadH/Z1jIvuBJIoUjI3hO1OQN9YOzAvC5DCxZ9EqayNzn8HSwIxoBWbV8hu537Kxtz6uY0PNsN/OrszI7yfPeCq8o02RbAAlDUz4qlcqYVtXCdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778874738; c=relaxed/simple;
	bh=rJ2E+SYstgHNYg9HfJKlddTJtm3NiuZdSrdaEV/cX7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oD8ox3CCsUsYvzkkfw1SzGzbcD2duI3uXJIPy7Lof/+KQ8eDLpVxX5KYh//GFbsbsJ5tR984FSTLf4NSgvhzO2C+QAtRyhBcpCsYZkIKwUSYi0XQZwbQi4JgBNrUgUNNBm1toSQ72iHWw++LN6JIkjwh/dcOZDQzsnx1ImDbrcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLcYjjIz; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLcYjjIz"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so609095e9.1
        for <linux-sh@vger.kernel.org>; Fri, 15 May 2026 12:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778874735; x=1779479535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYGTmQCcIfU+DrKSQlrVJ+uS7PIB4cLCZstWsw7lcqY=;
        b=RLcYjjIzmr03yuEPcvfmPkF0kIwtRTkWIQKOdYNokKaf1l4nnceJsrZhR5u2w+dicO
         n1kJBJtYvc0gXq5d3Hz6oZ3GA43+IzYNemJEPLXT3BmwuSefWrbRuEsQnTPEKiZ5Z5Pp
         MNJ1CBAfb/XXDiCn7MUGayDF7o/6AOGya09XIREZknTgEqoeWwUZ65vYsHrNc+Fhz+b2
         ndZyfNKT2PMb3h1lZdNjNNeN9EramZetm4rGAsq+PHKRtq1vQOgtfPim5FWQje67AlVD
         IsMf8Os4jObhH+StvW8prSYjGV+T+0/u1OLwJ5n0QM01APxI27sotUs0mUWGAFdO67Cr
         WgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778874735; x=1779479535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WYGTmQCcIfU+DrKSQlrVJ+uS7PIB4cLCZstWsw7lcqY=;
        b=gfgkYR+NKsFionW3M6q55eoOE5kqIHdXQ3nKx1Lh6C8BSLMdnfdEorR9ZjjEixCIwW
         LOMSow1uOjWWJkYZvuVHQt00rTr3Kdzvu7pT4Bblri9SnJq1/HIS73sIrbUzsMRvfrXO
         zoVe+POuWsKKfhZwgRIH5SJKsUgx8W1OrUHJ81RgSruhdHvd+7Zt2nldyQ+AJNQY+KZe
         SwlR1pbk7ZNqKhF0mSz72eUgH/mdGQ4OizgeaSszrpxcJjyEodZFcPypihl5ataXxqak
         XgV9f2eY+lw64BMiChta9FOmNsDDJ3hWPm0Ik/6wC66ZGKihNl5D1FmnPBMel9qksFZn
         gGDw==
X-Gm-Message-State: AOJu0YzU+wK4XIcyF4509JshFCsoYYthP0myF4woFVvs9mNoodhQ4gql
	gL8KQ1yvLhZ242YnYwzOLchc5uAP6v8TRh4bq3bKhlFIVlebs4O0pdzNPYOd4a0=
X-Gm-Gg: Acq92OFNmtFUPS7gLLOcWZ5iTAZggzSyLnR1Ly8cItRbaHMHLZo0Z9hyHR1/6rRJUTf
	j8F5lJMhl6/OTHBF4Zpom/5a785FoPz/OyfomTEuvCwlH7IGxtT0NHlYh+qwA3wWTnnxus7z0sH
	BurwAN3ZgDk78j00QRMeBE+hFpDOIh7bue3LAVokTswQSbRDdZSL+n7I/zPbbLteM3ubnAj1MPi
	b7iORs17oowrMU3sNMlYYz9hEr8rMNEwP0TNgVcUkGJ1ZP1bfcUUmJlMa2bnaZMC1rPagPTmVIE
	4KEmWD8OF6zTczs6fp7z/2943LUUw1226gGYswDky3Bc6JT6lTt/OlaLEkaYACarMgf+SU3ErCJ
	lxB2dqO0I6InhkS1FbnPi2mnVDOzFMjy2Qsx8kTDWvoW/lGErGdRXMqP4MnkKHpaN7LBaEPupfr
	5A+lPwoVbt1hOsCaKBuWdRS5bO4PB4fFux9c0GluAamIxYGwq9OGO7d0DXOOF23xdXg+xgpZCVC
	IcoWlG2Wm0jQfL2rQ==
X-Received: by 2002:a05:600c:8906:b0:488:aa33:dc8f with SMTP id 5b1f17b1804b1-48fe486cca4mr71178485e9.0.1778874735415;
        Fri, 15 May 2026 12:52:15 -0700 (PDT)
Received: from localhost ([2a02:810d:4a94:b300:fb24:41ce:1d7:fad9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48fe57943b2sm82007505e9.8.2026.05.15.12.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 12:52:15 -0700 (PDT)
From: Florian Fuchs <fuchsfl@gmail.com>
To: linux-sh@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Artur Rojek <contact@artur-rojek.eu>
Cc: linux-kernel@vger.kernel.org,
	Florian Fuchs <fuchsfl@gmail.com>,
	Adrian McMenamin <adrianmcmenamin@gmail.com>
Subject: [PATCH v4 1/3] cdrom: gdrom: replace port I/O with MMIO accessors
Date: Fri, 15 May 2026 21:51:09 +0200
Message-ID: <20260515195111.3295031-2-fuchsfl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515195111.3295031-1-fuchsfl@gmail.com>
References: <20260515195111.3295031-1-fuchsfl@gmail.com>
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

Acked-by: Artur Rojek <contact@artur-rojek.eu>
Reviewed-by: Adrian McMenamin <adrianmcmenamin@gmail.com>
Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
---
v3->v4: no functional change. Sort trailers.
v2->v3: no functional change. Added Acked-by from Artur Rojek.
        Added Reviewed-by tag from Adrian McMenamin.
v1->v2: Don't use helper functions with io.*_rep(), but writesw() and
        readsw() local in the respective functions

v3: https://lore.kernel.org/linux-sh/20260423194132.693271-2-fuchsfl@gmail.com/
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

base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
-- 
2.43.0

