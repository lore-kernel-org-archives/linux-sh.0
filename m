Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9114C395AFA
	for <linux-sh@vger.kernel.org>; Sat,  4 Jul 2026 05:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144696; cv=none; b=RMDdu93TIa11l9qoGznJvJVLXacf7wvl+nHxPMeHbZ83weZfr5cBPUGaTRTsCQoZnoW1vNYorIQ6V0CWkJwrJV+fACKlo0+v9sTgLLFKn19IsFmByhV37EibXtgINSyrW2rFgmzLp8Sbz5jXoec65FLaN04ryTMxK3LHbbaXd0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144696; c=relaxed/simple;
	bh=bQtYsjtXaJYuyI8vpIX4gaXFUZwfy4lDJF5ogpSBWxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N2aNSWIBxkxWjaK73evE5d3nWEzxyNYL0U+cfNi5CA4amDIpzRBkgdZTxPkAJe6lRFV7dEd4NpUb56GFq3GZZ9urPAdGzBq4O4AcCCsD0VJCEjRSSXGHmGZSDDuQ2wb5wqt99eRB70kxrTNteM4qQsxKGb49SDqFcr5pL1630pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hB7JhYxw; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hB7JhYxw"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-37ff8e0ad0fso1190267a91.2
        for <linux-sh@vger.kernel.org>; Fri, 03 Jul 2026 22:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144694; x=1783749494; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/05hwWd8d+nbJ2K7TsHjukJa8IrGxWrR/Hgx1jL48II=;
        b=hB7JhYxwCHtpikzY9KCdpHdTubKwpV4jpbIL/ldK9W/jyT2bi2NDfjj3MZekpTZX0k
         3FX/pxC92b5TLUR5ZqY/pZqQHzEVC0WINyY4QYl157EdcNTUL05UOJyzr5jpsX96mqhE
         kQEJNi2TuK0RUQJJuIQ4gu5+P0AQg259eu8sQRX4rBtooUeUYtit0gRkEVgjDlnKeFAG
         Ei1s1z392nR9uHQoVjpPXUCkPv++4Eqi4MVSub1qdFQdQ2z0OZ4yIleAwea9iaG9C6xW
         Pi9uhVKUeavbiw0/lD9LY/1F76yHkASE/VZhSbJWGgq697mVgh05vujCmODVFb0HzLWA
         LCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144694; x=1783749494;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/05hwWd8d+nbJ2K7TsHjukJa8IrGxWrR/Hgx1jL48II=;
        b=dAe0qFylFSaV7VgiZsHOtiweGTThkSdr4XMqvZtPr4wAtVLf4KxFRDw89XhBpJuHjo
         nkNDry7U+oAKA/Zoyq7kC869qaiiQTQ3SgW1AcSQf0ar4YzBkvoIPnsKzXj1J7Vg3tqN
         CHIIZS/1h0MW7hp3R0a/YDKs/m5cNtgWAX3VFwj9Bau0ZYkgj70JAAsOmyzaJw4rOVQV
         eBh25Bvi6lGHP66VZ4C+ZC+gDNs8siNdV2apY2jbbj1f54KLxU0+pL/keLMFg2bXfw4N
         uewvnhdIy59oEcryA4aed6Oi9JNLcaJRQ2dsDcpF2gYama87t1OLIJhkzyQ4TJzfNMxh
         ctYw==
X-Forwarded-Encrypted: i=1; AHgh+Rrptii/Aq4NNhzizeyeB/J2IMSU/9qSTkJ70l4/GX0ZxIGS3qraH4me/m9qktCFMJaahA/a35OfVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzI9UkMfqF0LB0y4tiT613SNEAZq6EDdsaY5i1YCCCzVIm45+94
	vNNsQZanhPtPrNE6iraee/DaT8j4K1kZd1z7Irg9FnUCXZQkZeKyhYdJ
X-Gm-Gg: AfdE7ck0g763Jp3ReAH+ziYL9ouovTSoH1G03NT7Fwdj6Hqr3dMSb29nhXIt56fO5bT
	GckYORJ8EVrw4rRl77NT+2yOljIwFdOq6z7oX+jEmueCa2IsmwFeL7t0hKG+QsVec4y04kJNzgk
	F7tOcarOhihMU6HMXR2/44aRCe6+aZE85Rd1uTfHF+GNW/hCMgu1QMuepoFRC3zmVFpcbGfub+2
	PSSZu3wR4+Pg4KTH9ZaJ4vSLySxzRdyKJqsfNFNwFMC7LgaCLnSRv7DZeOX5yHErvFY+aX9lLr2
	mhmIYl3HdvmGIMFnPW8p+wlY1PEOaGNhwDKTxdDpuAwoKYQzvGfUGyREsVDP9zoHdFkcCtXivZK
	0WAtxR9Hdngx3RVTqJsbfx0proGep9oq7I2rGsGK+ddQoCobMrAaRZ8ijTExej74qePPyNyDSAy
	virfjwy7c+OkFUaYPwoeyr9HsUdxM6PXdXWKQgeOvPxcOvVrIZe681EDs+zvI30rJ7IHA7po91Z
	MA=
X-Received: by 2002:a17:90b:57c8:b0:382:1cf1:a0a6 with SMTP id 98e67ed59e1d1-3829f5eadf7mr2306393a91.24.1783144694449;
        Fri, 03 Jul 2026 22:58:14 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:58:13 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:48 -0700
Subject: [PATCH 25/26] Input: maplecontrol - fix style issues
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-25-41e424964da5@gmail.com>
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

Fix coding style and formatting issues reported by checkpatch.pl and
switch to using BIT(). When reporting D-PAD events avoid conditionals.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/maplecontrol.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/input/joystick/maplecontrol.c b/drivers/input/joystick/maplecontrol.c
index 3ef6652d40cb..457a73d91239 100644
--- a/drivers/input/joystick/maplecontrol.c
+++ b/drivers/input/joystick/maplecontrol.c
@@ -35,22 +35,22 @@ static void dc_pad_callback(struct mapleq *mq)
 	buttons = ~le16_to_cpup((__le16 *)(res + 8));
 
 	input_report_abs(dev, ABS_HAT0Y,
-		(buttons & 0x0010 ? -1 : 0) + (buttons & 0x0020 ? 1 : 0));
+			 !!(buttons & BIT(5)) - !!(buttons & BIT(4)));
 	input_report_abs(dev, ABS_HAT0X,
-		(buttons & 0x0040 ? -1 : 0) + (buttons & 0x0080 ? 1 : 0));
+			 !!(buttons & BIT(7)) - !!(buttons & BIT(6)));
 	input_report_abs(dev, ABS_HAT1Y,
-		(buttons & 0x1000 ? -1 : 0) + (buttons & 0x2000 ? 1 : 0));
+			 !!(buttons & BIT(13)) - !!(buttons & BIT(12)));
 	input_report_abs(dev, ABS_HAT1X,
-		(buttons & 0x4000 ? -1 : 0) + (buttons & 0x8000 ? 1 : 0));
+			 !!(buttons & BIT(15)) - !!(buttons & BIT(14)));
 
-	input_report_key(dev, BTN_C,      buttons & 0x0001);
-	input_report_key(dev, BTN_B,      buttons & 0x0002);
-	input_report_key(dev, BTN_A,      buttons & 0x0004);
-	input_report_key(dev, BTN_START,  buttons & 0x0008);
-	input_report_key(dev, BTN_Z,      buttons & 0x0100);
-	input_report_key(dev, BTN_Y,      buttons & 0x0200);
-	input_report_key(dev, BTN_X,      buttons & 0x0400);
-	input_report_key(dev, BTN_SELECT, buttons & 0x0800);
+	input_report_key(dev, BTN_C,      buttons & BIT(0));
+	input_report_key(dev, BTN_B,      buttons & BIT(1));
+	input_report_key(dev, BTN_A,      buttons & BIT(2));
+	input_report_key(dev, BTN_START,  buttons & BIT(3));
+	input_report_key(dev, BTN_Z,      buttons & BIT(8));
+	input_report_key(dev, BTN_Y,      buttons & BIT(9));
+	input_report_key(dev, BTN_X,      buttons & BIT(10));
+	input_report_key(dev, BTN_SELECT, buttons & BIT(11));
 
 	input_report_abs(dev, ABS_GAS,    res[10]);
 	input_report_abs(dev, ABS_BRAKE,  res[11]);
@@ -138,7 +138,6 @@ static int probe_maple_controller(struct maple_device *mdev)
 		return error;
 
 	return 0;
-
 }
 
 static struct maple_driver dc_pad_driver = {

-- 
2.55.0.rc0.799.gd6f94ed593-goog

