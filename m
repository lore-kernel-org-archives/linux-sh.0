Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D348E397B12
	for <linux-sh@vger.kernel.org>; Sat,  4 Jul 2026 05:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144699; cv=none; b=QtKnsIDY6j/JP5lDXB4P4cuPbltWCfqPh+c6HaJhDRVvM4txMcdnbKeJHUcd/DrrcAMPYhtyYVaSe67zKGORYjxR+dT3Pr5JeVxirKRMV3IxiS7Bn7ZXUDHRwKAukGTpTVX3Q1162ipX2Z0IqM0l84T6vGtQHhtpLsAWt8M98Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144699; c=relaxed/simple;
	bh=AxruopFb6RxNA8Yw2YyzbRC+TmLqrBdAl3Kg3xWhS44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ipAmtm63t21zfn0VbBGkSeu4eCe3RJUmqMniran3leV9y+G4evQtZY9ki2s48b5bqqgv6gTs2FCN3TiwfsSosTGTmLQMXDNJ2lr6xYwZx7y2l0HpiYPt0l67LcVLBgxN9OfNcqOmhhdjzirVTjFf4B6jxZ9NkV8zfK7RGcwTEio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlQr5+Rs; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlQr5+Rs"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-380cda7f00cso1032572a91.0
        for <linux-sh@vger.kernel.org>; Fri, 03 Jul 2026 22:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144696; x=1783749496; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tEG7tX5+i0yM5fGvf5APIP8u2V/3BZ/C2R2J5nBR/YM=;
        b=TlQr5+RssuuxnFg12iAtYTl1uvy1KaLgaNl8J34Lst3zifyTgI/1W+yvAAb73hEitM
         YXFMyjw7Hdsq6ONpuBc2hzth0M0RLWHmbD9hzHwVkcwBF3uIhyUTXPeFT3w1UB1DJ0Cg
         gX4DB2oMJUJ0k9wspJ90OClPg+T2PuTzKi9EUHBO5BN6vLz7MVthEL9GEMF7sJpvvO1r
         +leUG00eaVo5FDT/bFMO4x7Kf8Rb152vUXxnaaNhm5xYwxh+Q6ZfuP2iMSowU9FoxL+3
         LRSb3nwY0TTBSeLxaKsC1UlCWQmRQtqUvxVymSiM+aC+rl8tdw2IlZ2knnoAjkioDV4s
         MNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144696; x=1783749496;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tEG7tX5+i0yM5fGvf5APIP8u2V/3BZ/C2R2J5nBR/YM=;
        b=IGYPTyDqAZEKUTLC5t4M8/PhnhxWsLO3JEmMlMOUcuQ355j09lC6LhQBjlyZTLOH7M
         Q2z1P7Gg38iKVc79bZItuz/x+0Hs/4+HLwulX28YGXPbofwpZuwOE4R5wBfiGTB79O8M
         IiC4esnVDC39+gSppJsSmkhgK0U5BpGCY8WpMPQLNgJoU6onppPviwQjcvQ68by6MvNA
         VZdqT5xYqbmuZEW/rt7/TH3rorXkHnNuKAaM52lBAoWSYKAjrJDJZiDwkAjUWah4FZAN
         3Z3N1TLSQMCIX6/3URtrCbm6ExEz2p4bcrr3l1J5448oeDVpPGwkNEoZlkNiP6+bG2WX
         yjuQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp0EsJjBLp6rlTfvOVvJ4SjrFW88Y59K9XEiCAndSMwAp7yzSSFmgGwhB2+TqI09wxR1Ar1OBCxdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzeygJcPITAyqWXKLsqx0bXLVIjZtHs2glMKl4i1xhRsq2NCnt7
	CdmN+N1f4ZlVI57qdrcYQIYSV+Vs46ZSYA29fpuZuFvJIOc9zPHYyAOn
X-Gm-Gg: AfdE7ckYied+/oGC/Ej9ScqdgChl77g3EF51w5tKRMgms5p09rfmrJLP+k746XF68lp
	gJurbopXhTRFv6kKEySAyuZFnPjVJnbEcOq+tJo8m8zPbjYh3L6Bm4UO6mmos9oZnqonIKpo2AU
	qxmakLvtSIj38W6i8s79xWSXZnJi/K4q4AW0K9r3m09sMEi9vbMvXhB8JgtPgHtiIJYxnqNQw3f
	vNTP3/eorO9kuX8rCpk4noLVzLQnYpR3ACcQjqalImKxcE9nI4IvDq77rLDzMzMdLmUYmUXAfDf
	wyaXzNa6RBtvJlhePsjTIvtGn68ymj7fIYZF08UJhIoJ+deoUGUbozKjffn0ud1vMjEKP5QIqq9
	2VKeq5/e90/tSGF8uJBJXzxxyaDJmr3s32FzglypNcY/+r4HyP8pa65RG7mFsD21j1C0EXeFU3f
	uN1zkH9k8/KQIwMN43O5jT/Mae662gONvDhaFsZhL+3R6Yfo/yJ9y6bZpa9Ml23gIaQE68QCjcg
	YA=
X-Received: by 2002:a17:90a:d44f:b0:37c:8628:f79e with SMTP id 98e67ed59e1d1-382934ec0bemr2222411a91.16.1783144696090;
        Fri, 03 Jul 2026 22:58:16 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:58:15 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:49 -0700
Subject: [PATCH 26/26] Input: maple_keyb - remove redundant 'new' buffer
 from struct dc_kbd
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-26-41e424964da5@gmail.com>
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

The 'new' buffer in struct dc_kbd is only ever used as a temporary
staging area during dc_kbd_callback() to pass the received hardware
packet to dc_scan_kbd().

Remove 'new' from struct dc_kbd entirely and pass the received buffer
pointer directly to dc_scan_kbd(). This saves 8 bytes in struct dc_kbd
and avoids an unnecessary 8-byte memcpy on every keyboard poll cycle.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/maple_keyb.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/input/keyboard/maple_keyb.c b/drivers/input/keyboard/maple_keyb.c
index 1d99ed5bad1e..5b10c6ba7bd5 100644
--- a/drivers/input/keyboard/maple_keyb.c
+++ b/drivers/input/keyboard/maple_keyb.c
@@ -23,8 +23,7 @@ MODULE_LICENSE("GPL");
 struct dc_kbd {
 	struct input_dev *dev;
 	unsigned short keycode[NR_SCANCODES];
-	unsigned char new[8];
-	unsigned char old[8];
+	u8 old[8];
 };
 
 static const unsigned short dc_kbd_keycode[NR_SCANCODES] = {
@@ -75,7 +74,7 @@ static const unsigned short dc_kbd_keycode[NR_SCANCODES] = {
 	KEY_CALC, KEY_RESERVED, KEY_RESERVED, KEY_RESERVED, KEY_RESERVED
 };
 
-static void dc_scan_kbd(struct dc_kbd *kbd)
+static void dc_scan_kbd(struct dc_kbd *kbd, const u8 *new)
 {
 	struct input_dev *dev = kbd->dev;
 	void *ptr;
@@ -86,11 +85,11 @@ static void dc_scan_kbd(struct dc_kbd *kbd)
 		code = i + 224;
 		keycode = kbd->keycode[code];
 		input_event(dev, EV_MSC, MSC_SCAN, code);
-		input_report_key(dev, keycode, (kbd->new[0] >> i) & 1);
+		input_report_key(dev, keycode, (new[0] >> i) & 1);
 	}
 
 	for (i = 2; i < 8; i++) {
-		ptr = memchr(kbd->new + 2, kbd->old[i], 6);
+		ptr = memchr(new + 2, kbd->old[i], 6);
 		code = kbd->old[i];
 		if (code > 3 && !ptr) {
 			keycode = kbd->keycode[code];
@@ -103,8 +102,8 @@ static void dc_scan_kbd(struct dc_kbd *kbd)
 					code);
 			}
 		}
-		ptr = memchr(kbd->old + 2, kbd->new[i], 6);
-		code = kbd->new[i];
+		ptr = memchr(kbd->old + 2, new[i], 6);
+		code = new[i];
 		if (code > 3 && !ptr) {
 			keycode = kbd->keycode[code];
 			if (keycode) {
@@ -118,19 +117,17 @@ static void dc_scan_kbd(struct dc_kbd *kbd)
 		}
 	}
 	input_sync(dev);
-	memcpy(kbd->old, kbd->new, 8);
+	memcpy(kbd->old, new, 8);
 }
 
 static void dc_kbd_callback(struct mapleq *mq)
 {
 	struct maple_device *mapledev = mq->dev;
 	struct dc_kbd *kbd = maple_get_drvdata(mapledev);
-	unsigned long *buf = (unsigned long *)(mq->recvbuf->buf);
+	unsigned long *buf = mq->recvbuf->buf;
 
-	if (buf[1] == mapledev->function) {
-		memcpy(kbd->new, buf + 2, 8);
-		dc_scan_kbd(kbd);
-	}
+	if (buf[1] == mapledev->function)
+		dc_scan_kbd(kbd, mq->recvbuf->buf + 8);
 }
 
 static int dc_kbd_open(struct input_dev *dev)

-- 
2.55.0.rc0.799.gd6f94ed593-goog

