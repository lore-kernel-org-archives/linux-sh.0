Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C573133C52E
	for <linux-sh@vger.kernel.org>; Thu, 23 Apr 2026 20:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776975666; cv=none; b=FebaqC9vkBrSHpJj/orpQx2E1tTR4dG1pXJE7TFdTCLxnZLcNdwx0F2UnXpwiPL6ssiAoSzrJ3rOkU+UL0tpegcs6IS656H5fgZPdrSi/K7VIMpH34esJmionahm+vgY3iLX4q7OJ9zYg7znfpnXESZF3oLldUx2gkIsVo0Q8V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776975666; c=relaxed/simple;
	bh=qXIKkX4h7OUd60DQ2fKPN5FHdbGxmbN3u0xWQKFzdCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H6dZ4cVoazOen1raSRsGyWu/5rVuzDajBMt/M1e/YQCih7vipKS8aXA59N1Zk8FpYAjFnQvDldSkmH29K8lWiaCz+QGHgqya264ouVoLSqa41gkVN1tAkng2CMsIMwA40zPEkrte+AbkG0RsGaG4atkEYOode4NWO0X6K5+yNJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsW+ClON; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsW+ClON"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso43056425e9.0
        for <linux-sh@vger.kernel.org>; Thu, 23 Apr 2026 13:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776975663; x=1777580463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wL3tWq3fcfB8j/Jja0BNy+0Edqs7WrfstTJmG5tBxQw=;
        b=EsW+ClONHjmF60uY82w+6IkqP56ogNbo/gTCgnK1t4snsPUlgVsLH+uaY9xLWK9son
         2DZN0ikGZpyw503+HBtt5qsE4ghA9RIirNQaupCY2J/vbPkaYuxWVB3wGtpf9oe4WVGf
         OlLGiKYfkavJi24EvDJhK4o6mzYbMRUNgFpFkVKeXkt9B27UWdWmjgeXloSlLLFDv43P
         4SoROzxs1GBZleNAf7BpFPiOq0fVXaO2IM9vt9CK/ofkMka3jswO9d820S0yLE4KIuFj
         LIsft+qFJW1ysEytnsM1VbR3VYelozpPdZy9DtZES4qEedez12XlLIaUX11+MzSS36JL
         CuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776975663; x=1777580463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wL3tWq3fcfB8j/Jja0BNy+0Edqs7WrfstTJmG5tBxQw=;
        b=oXJnk/eLBVcMRpZOcfugHVL7A727T8k//yniZQ0F5V4drE/68bDL2Qe8WNseHf9i/d
         3v/FmUs0JMaTZbx7+4kXvhINnPlw0PwxLKKCITVEYCsidNdflCycRYSkiTs/0CPtJ2JS
         fndRLKgt2RCDq8GnFQvqN+Y+SlV7FYvPS2qQt+jZ5ikZh9GPrDTFBwfcsYPcKT0sGE5f
         GXoeYTSrT9nYxKAQz3eXNUCW1GTGonMODqcg05HQ052MgimFnG/FnIWzrOXbb49zLPyl
         g5BrmiCYc1crxCZ9iCRP9g9ZYVIqKWivcxG2PcWlM4pWwC1wVZODg4IwLG0PhU1cu1CW
         aKvQ==
X-Gm-Message-State: AOJu0YyG9kZG2MhBuqJHk6i967uq1XF142fLJ4J4fUn5ZqwK/oYnKw+p
	DNkurCoVpsEqO5vO7WCSd/qHvfDFA3SMQ34FKd9kSakLXoZYatd3MX2uXR0Pysc=
X-Gm-Gg: AeBDiesTZA3FrZH+BVfpBrX4lZCepzUqvFGASOhuI6FhTLkS+OD5HzxWtULfZhqyQQ0
	8NYwyR3F/29G28QWhISV3o5MV25cEmnpa64ftyjIDs+K70Y+4kR9HKWTPVf/26y3hiXxnBjVeDb
	oskv0MjFexfQ34e9qT8Kr10t+6Jrw7rXluT68Y3dlycOfZF3PQjIDcvNyXhotxLDdE/3lOuOtqu
	zMe5+JhM3n4eTibByovyTFOpTZoaBeU2xNl5PtWBjdR8Hf8Ze9iqltjq/9tIdYv3Kph4JheHXHS
	/9V1H1GSMQQmk3Aq5IS7NWHmwcWgY++RB/PYYg7yN/SGR4fqbPYTOdj/MCKb9UOK0y0mWfKBHc/
	EXBwjiyCdTC9/WPi3qUhehP4FwKaOH/b/AUlsd5Ij/gcsCUb8htA5DgHRytIM3HZfE9nXv2+0AJ
	6pNazG1V+UfPEhs7Gog1IW2mjlA8uwm2UKOZXJpy3BRXZXjtcNXxG+tr0KV19+WAz7c4tKpql+r
	fyZ8uYomjcn4PgJ6QgHgiM133w=
X-Received: by 2002:a05:600c:a106:b0:48a:58ae:9933 with SMTP id 5b1f17b1804b1-48a58ae9fbdmr108145875e9.18.1776975662557;
        Thu, 23 Apr 2026 13:21:02 -0700 (PDT)
Received: from localhost ([2a02:810d:4a94:b300:fb97:cfb5:53a1:28])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48a5aa3ae83sm271709905e9.12.2026.04.23.13.21.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 13:21:02 -0700 (PDT)
From: Florian Fuchs <fuchsfl@gmail.com>
To: linux-sh@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Artur Rojek <contact@artur-rojek.eu>
Cc: Adrian McMenamin <adrianmcmenamin@gmail.com>,
	linux-kernel@vger.kernel.org,
	Florian Fuchs <fuchsfl@gmail.com>
Subject: [PATCH v3 3/3] cdrom: gdrom: verify device access after disc swap
Date: Thu, 23 Apr 2026 21:41:32 +0200
Message-ID: <20260423194132.693271-4-fuchsfl@gmail.com>
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
v3: new patch added from Artur Rojek and also verified that it works.

 drivers/cdrom/gdrom.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index 1e73617b39ac..21ef4657dd2b 100644
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

