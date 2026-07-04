Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029993955D7
	for <linux-sh@vger.kernel.org>; Sat,  4 Jul 2026 05:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144694; cv=none; b=nbI+5mbybqTqC/DhQk69spK/e5ePAcx5iT01OxcQk4ZusWlhd0eyysreGitIQrv7M6coHNSf8+op05le1AkXBW99AS+Ijql21V6wa0lkLkQZGUX0uPOaVEYztOEaeXc81EWqqDH1j24eR6tkivBKhAi2kRHg/LHxNACNQDbyBfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144694; c=relaxed/simple;
	bh=bJdwpjh8bt5egacgW4GkSSVLDN/CuQe6AaNTKlGoUdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LfOxGWoI6DUSCHJSumpv0TG5WEw6c4jNnhGmqN//zkLSa3rLV718MqyYhvFUKcb/zKUxnrpZBfCUN6zsczZIOc2KMtsYSrA3agfW+ervvufg0v/m9IpnEN6KvmDt7U2sqsRe50uyBZJc1O2piMnaF+19ymBZwpVXpj5Cqn5ILEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfOpz4cy; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfOpz4cy"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c85b73ffb52so614812a12.3
        for <linux-sh@vger.kernel.org>; Fri, 03 Jul 2026 22:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144691; x=1783749491; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cWjg7UC3W2OY/ypUpA0NQNYwI2Wk9GMT1X28efRSy2Q=;
        b=QfOpz4cyGxJpis6I4NEzMWQRgKptixEMXgb4+beT7NmMIOhlcYkTr0F7sNdo3Fvmlb
         fzdPpd2KAGGNmHD7qzTQhjJxqvZvrc5RaVCZq7ScQVvSBZ419/UqthVizQRtYNfwFqzn
         3w9nNWEfW/ueU497XsRgSTD3MmGGaCYUl6nK5AczgAjzOj3Dc5y46XpO9W1Kv9//g8s4
         nYTfRJiW8FppIlvlSgnwe55yhCfYD7ZpszJmgpys7f+pf05kKvgQhTgdGgspz5ah5Pl0
         1WNsdIJHWlSFBq47gwhZvdBCP4K5LEkeWD7uTtiLNWjHNYglU0h5L28a7VedgXAY60y4
         18rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144691; x=1783749491;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cWjg7UC3W2OY/ypUpA0NQNYwI2Wk9GMT1X28efRSy2Q=;
        b=UfRs7X7/ydNuMjthH9nCtLPB0SnAFhcSUWujfmS7L1jfKJ+an/FwHrVS3dWPoUvDO1
         pijHp+NreXxRBQaO3y15bzirLwahC2u38rIB9WsMO73Ro7A+srnWuUyrrHTEtn/EFBe7
         crX0dfMOJpInYRI9fDN+iM7TWgcMTTAoh4TGbbi3OYztTfUdg1FHarrI+Gf41BUsJx0j
         892sc9kZrNJdZvdDviiK9ZwCknV3IgwMeARDU89M/5ymNxVIsP9TDDnVKE6H3lgbO24b
         +412rMVEs8SoyhYouG6vjjljl9kcnOOONdxZ8YrAPkucwFMUZ76mQz+Yq500mUSCx/xV
         waBQ==
X-Forwarded-Encrypted: i=1; AFNElJ/+yGQcbmHGxQfMKAELfrOst2SmhGfiWBAySjA3IKleNktfUBwIQ9QaGGeXpgL+VHhYuh2nIU8AdA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyR2F2htd98O04Wv1WX86saYbe7xFlOzhD3ffd9IAUk+OboFW4s
	7BH0wJzvtRMqyoNDuCTGzZI8sqE5frZ2WCMu8x0DHs/9bIanL7nRnACZ
X-Gm-Gg: AfdE7cmZ5/1Y+st55OHbn2HKLUpSGfTVcyzb/79GF7vmxqgJT4MXj3ARQsMcwez3M4k
	XcKRPisMgjiw3niEW8pCaKWR1ZzcVPKjyXs18/gUAadgwrCg6JbgCu49H8gEfnVqCC2+Sm6pvbU
	zuhINGHXPtNlsh1NVvATfXITEgvM+TU+ga30RLJMVy4zqlMd6QKLGk6I0E4TcsTc5r3GP/XOJxp
	WDLbS/t17t1wjDDgferW3qJa6zfCSYjN2lDGGUd6eYPJuDCd14izb7QnL5aBEdjjCA5UYEL1lde
	zBytrZ5IsffETURidzb5eXfx7TbnVpkg/RKX3fa7nQT7q7iKfMbu1/a4uYXPQ9fFqCV+NC59Aal
	y1/s8TOZn1xUGTzOwoO8Gsg0MPi9lPC24dJbAHxwGHyFqECp8bX/fhi9GWUai4u63CiVKzvN6m/
	5CFXFeL3OvB1r2IswYVjiJ8FZOP545GbiA6QrHMmJ/NEIng1xyYJq16o0RJDQdSj6BwfmF7QDWJ
	PA=
X-Received: by 2002:a05:6a20:3c90:b0:3bf:6c04:a817 with SMTP id adf61e73a8af0-3c03e4dee8fmr2742445637.56.1783144691289;
        Fri, 03 Jul 2026 22:58:11 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:58:10 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:46 -0700
Subject: [PATCH 23/26] Input: maple_keyb - fix style issues
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-23-41e424964da5@gmail.com>
References: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
In-Reply-To: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Florian Fuchs <fuchsfl@gmail.com>, 
 Adrian McMenamin <adrianmcmenamin@gmail.com>, linux-kernel@vger.kernel.org, 
 Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org, 
 linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org
X-Mailer: b4 0.16-dev-6911d

Fix coding style and formatting issues reported by checkpatch.pl.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/maple_keyb.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/input/keyboard/maple_keyb.c b/drivers/input/keyboard/maple_keyb.c
index bd4ce803a13e..1d99ed5bad1e 100644
--- a/drivers/input/keyboard/maple_keyb.c
+++ b/drivers/input/keyboard/maple_keyb.c
@@ -48,7 +48,7 @@ static const unsigned short dc_kbd_keycode[NR_SCANCODES] = {
 	KEY_F23, KEY_F24, KEY_OPEN, KEY_HELP, KEY_PROPS, KEY_FRONT, KEY_STOP,
 	KEY_AGAIN, KEY_UNDO, KEY_CUT, KEY_COPY, KEY_PASTE, KEY_FIND, KEY_MUTE,
 	KEY_VOLUMEUP, KEY_VOLUMEDOWN, KEY_RESERVED, KEY_RESERVED, KEY_RESERVED,
-	KEY_KPCOMMA, KEY_RESERVED, KEY_RO, KEY_KATAKANAHIRAGANA , KEY_YEN,
+	KEY_KPCOMMA, KEY_RESERVED, KEY_RO, KEY_KATAKANAHIRAGANA, KEY_YEN,
 	KEY_HENKAN, KEY_MUHENKAN, KEY_KPJPCOMMA, KEY_RESERVED, KEY_RESERVED,
 	KEY_RESERVED, KEY_HANGEUL, KEY_HANJA, KEY_KATAKANA, KEY_HIRAGANA,
 	KEY_ZENKAKUHANKAKU, KEY_RESERVED, KEY_RESERVED, KEY_RESERVED,
@@ -92,15 +92,16 @@ static void dc_scan_kbd(struct dc_kbd *kbd)
 	for (i = 2; i < 8; i++) {
 		ptr = memchr(kbd->new + 2, kbd->old[i], 6);
 		code = kbd->old[i];
-		if (code > 3 && ptr == NULL) {
+		if (code > 3 && !ptr) {
 			keycode = kbd->keycode[code];
 			if (keycode) {
 				input_event(dev, EV_MSC, MSC_SCAN, code);
 				input_report_key(dev, keycode, 0);
-			} else
+			} else {
 				dev_dbg(&dev->dev,
 					"Unknown key (scancode %#x) released.",
 					code);
+			}
 		}
 		ptr = memchr(kbd->old + 2, kbd->new[i], 6);
 		code = kbd->new[i];
@@ -109,10 +110,11 @@ static void dc_scan_kbd(struct dc_kbd *kbd)
 			if (keycode) {
 				input_event(dev, EV_MSC, MSC_SCAN, code);
 				input_report_key(dev, keycode, 1);
-			} else
+			} else {
 				dev_dbg(&dev->dev,
 					"Unknown key (scancode %#x) pressed.",
 					code);
+			}
 		}
 	}
 	input_sync(dev);
@@ -191,9 +193,6 @@ static int probe_maple_kbd(struct maple_device *mdev)
 	return 0;
 }
 
-
-
-
 static struct maple_driver dc_kbd_driver = {
 	.function = MAPLE_FUNC_KEYBOARD,
 	.probe =	probe_maple_kbd,

-- 
2.55.0.rc0.799.gd6f94ed593-goog

