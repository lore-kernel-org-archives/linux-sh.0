Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5664430C150
	for <linux-sh@vger.kernel.org>; Fri, 15 May 2026 19:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778874741; cv=none; b=ffXnVIPMHv3ZWqZ+kwskr2E2zPQVXUZFbcq4cohAmcJ7WimDupid8X5mCOfMo+JUnMy4tTkwc+gUJ1BazcxrAFEmv1Eqp/i2tpifIIzkumeZZEBZ3nj7HzHHBdpaHVffg+j4BFeqIchId7oo/TOzeDM8C3SVGX608BgsOcnxi+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778874741; c=relaxed/simple;
	bh=6Ha/PEb51xP7chSZP65EQUMcHr107gh+nEamCTAJ2vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQMd//mIJ8qYaAJzPgw4y5CQNVgMTHJhZik5i8eoP/LPP2ese7IReCrut4u2nNmFskuMmWIfqmuhntc6Pl63P1R/3ZQI3sZ0jPq7BqCPoVfD+Bn6pfOC71Sm98kVrA3lHWnfglOssEMNM58Xv3ei6yy0qS7PfQxZsVdluNtwtIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOBMPq/H; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOBMPq/H"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48e82c23840so1287495e9.3
        for <linux-sh@vger.kernel.org>; Fri, 15 May 2026 12:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778874738; x=1779479538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPTAPHrOG00PlZmvn0SKpT8YOBlYRF/erWrb3+8AUB0=;
        b=LOBMPq/HMEYT8MzaR0H9FQWzyMZqVFaqDz1iaEI7Ssai0dDOXF21Lllmg4L2sQ9HRr
         Nw2jvqyAV8Ksh7XpfLMYSvXba/TYfqzZBy82WtFmuOHqLE6EJWVaYcmW9j1FC0V9OHgl
         xbfY0bAf/Noe2KUIhN4084Ym2DW/zr9Y5CLfXkjCSPWBcbcjlX8RbiZjCzteOHX6ZKe9
         1tpkTcQv1S6pts65YjyFW2mHHoDoXHnO1wkSLiM+5iPWCkSZsPtAkAdbFgnFgdlXPWkp
         CaVArR6xFtm/X2RjMMLUHFaOxn2YjR63uY76gWpsi0uxUoGKb9S57xzq4jtV/rroBVWJ
         iHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778874738; x=1779479538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SPTAPHrOG00PlZmvn0SKpT8YOBlYRF/erWrb3+8AUB0=;
        b=cKHq68/7VVtF6V2X2jLk9kaiVzAJzCl8lVMzl1xyljdVJAWIlDu4Zz9tR1Cnjwtb36
         ReG7U7mKzKjH8XSALQ4N3woK3VQZUgpBm4Uc0J/A/hVDxKqaF21+PKajYbwkTMHhO85u
         gLi5SFqpYy8dgIHlQERvjOHfMJ0T4nIDLp9ydHOEiA60pgx/cE3SEmKuG0G+ttt7Sq7z
         CgaFciKyEXK3HekDjYwKPOxdjWfLnANg/qBXvPOQ5l1ylmDAA+coAxeG5aEnzOnNYqTg
         YreFG+RyuSRC7msHxL4JgR086exnvmrRNF/4SgmhJHEcmaLqL0JOuaVX4Gzh4dy/xK3f
         Aimw==
X-Gm-Message-State: AOJu0YxU9c2akwAyuE7ht6PS3AFrwUPe8WDwkKoUKqV7t8IbXy4mhAvM
	irlzKoUmw+pv7VmEYJhvcoKecbTeFJhsag/QIhSbxDdbag+XBFnDJ+eec8XkrHc=
X-Gm-Gg: Acq92OF+ppe9KyuzXCKYHYnmN5zAsbTzaeb/10NXHcOSsj1mnmdpLNMJ4OhUxL6c4pD
	EbENLboNbw6VFRcGwcwoXxc2zMxnWZvw6YLjIosR/I9YnW96HHZ1m7zygJTIY3hNJNnFuvQQyIO
	9MOYhCs7oJOmqZSBEuMSpZbTiODCtQvl+nPNzKFe7cbfkcoLYx5uVZxGGLnVy2uJv6nOgQawLmr
	n7km4iNwOvJGbPyqoVsvQba7S68zutLHApNXktjmHOblrVcO5QIQ1vrzHIM+P21wbkZi7PI6HRc
	NHGC1esbI0ZI9CJnoOSBSjdMQqji2Wvk0mylU2iesn9SX1OrxyKWtGO8PGnYSVXvcSwDV49apWJ
	vva9hGlh08ZlFzQm8ML8ClZHraiCDbdT17Ii7dl9KtTOAibhqSBS/Zjf+Dk0oIFLpw1R0Vcppvb
	UDXpcEaVm7qbIpYmKaPDMXJBJTqTintFftRMXvx7Gm84NhIindsLYJdKlKd8/c+1GsZc9cG4Ouz
	QknzSI=
X-Received: by 2002:a05:600c:8189:b0:48e:89f9:9408 with SMTP id 5b1f17b1804b1-48fe632374fmr82858405e9.20.1778874737711;
        Fri, 15 May 2026 12:52:17 -0700 (PDT)
Received: from localhost ([2a02:810d:4a94:b300:fb24:41ce:1d7:fad9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48febe81b2dsm20062395e9.34.2026.05.15.12.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 12:52:17 -0700 (PDT)
From: Florian Fuchs <fuchsfl@gmail.com>
To: linux-sh@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Artur Rojek <contact@artur-rojek.eu>
Cc: linux-kernel@vger.kernel.org,
	Florian Fuchs <fuchsfl@gmail.com>,
	Adrian McMenamin <adrianmcmenamin@gmail.com>
Subject: [PATCH v4 3/3] cdrom: gdrom: verify device access after disc swap
Date: Fri, 15 May 2026 21:51:11 +0200
Message-ID: <20260515195111.3295031-4-fuchsfl@gmail.com>
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

From: Artur Rojek <contact@artur-rojek.eu>

To ready the drive for cdrom_open(), this driver sends a spin disc
command. However, if the cd lid has been opened and the disc de-spinned,
the very next SPI command will return UNIT_ATTENTION sense error,
resulting in a failure to mount the disc.

Fix this by sending a dummy TEST_UNIT command, which will catch the
above error, and allow subsequent commands to execute correctly.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
---
v3->v4: no change
v3: new patch added from Artur Rojek and also verified that it works.

v3: https://lore.kernel.org/linux-sh/20260423194132.693271-4-fuchsfl@gmail.com/

 drivers/cdrom/gdrom.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index 603429756a34..0827f4f0344d 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -219,6 +219,33 @@ static char gdrom_execute_diagnostic(void)
 	return __raw_readb(GDROM_ERROR_REG);
 }
 
+/*
+ * Test unit command
+ * byte 0 = 0x0
+ *
+ * This command verifies whether device can be accessed.
+ *
+ * -EIO indicates that device is not ready for operation.
+ */
+static int gdrom_test_unit_cmd(void)
+{
+	struct packet_command *test_command;
+
+	test_command = kzalloc_obj(struct packet_command);
+	if (!test_command)
+		return -ENOMEM;
+	test_command->cmd[0] = 0x0;
+	test_command->buflen = 0;
+	gd.pending = 1;
+	gdrom_packetcommand(gd.cd_info, test_command);
+	wait_event_interruptible_timeout(command_queue, gd.pending == 0,
+					 GDROM_DEFAULT_TIMEOUT);
+	gd.pending = 0;
+	kfree(test_command);
+
+	return gd.status & 0x1 ? -EIO : 0;
+}
+
 /*
  * Prepare disk command
  * byte 0 = 0x70
@@ -353,6 +380,9 @@ static int gdrom_get_last_session(struct cdrom_device_info *cd_info,
 
 static int gdrom_open(struct cdrom_device_info *cd_info, int purpose)
 {
+	/* Sink pending UNIT_ATTENTION sense error after a disc swap. */
+	(void)gdrom_test_unit_cmd();
+
 	/* spin up the disk */
 	return gdrom_preparedisk_cmd();
 }
-- 
2.43.0

