Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8482638D3F7
	for <linux-sh@vger.kernel.org>; Sat,  4 Jul 2026 05:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144662; cv=none; b=qzR8flmIrsWgJ289KgpdE/84SecFr5wND2CcC89H0gMBjio3y0r/TRLFuBIhW+zXDOiE1k1ij3SVamMRXZfvXmF8JAhnFCkCPPibqF3u2hww/rcnmZmfDuPlJFRAqfXgwFu8esj5JhI/m4Q68DJeY7eIR2xVSMIr+5WLV5gephk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144662; c=relaxed/simple;
	bh=xQLsjtj+AicyFGmBbr6l87mq31LJli209Cl3g2Ekxyk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KpPtshlvp1QoRbeH5GFMDodqHKbRCuXt/gqBjjbEPnfXhlaOmLsKPpqhib3HiWCuiF+HXEwtUm5msaDHYmfNKQU++3hG9OcmQi1QWgwp27MJ1rfGNAyGrpnVg/RazD3pfPThZQHpcUMJBBFvrS2abtNGiUKNRG6jHSCg8MH/rtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBblsMlR; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBblsMlR"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-381065a7a03so913148a91.0
        for <linux-sh@vger.kernel.org>; Fri, 03 Jul 2026 22:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144658; x=1783749458; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dWA/4m/UVmnMmxggqt7YCrXYgmO39jWI35he5TtM3O0=;
        b=DBblsMlRK/TR4mwpkfQYe0ZFSwuJdFHavfj4OoVUcke8DyfNEaxz2JNlszZYex7uH2
         CHKhKmqKLZc1/xNyBfZBjjp4vrYefgfiFhy3w5paCC4RbIOJhmuRkRq9n9U6vLWWa2Vm
         nr4YcbNJq0QuS0aFNBLkVlwbmpUipvqUgfoGONqytH3qu5bxiZPUki8pCrYLWvpCjJIb
         dkzD7uz0PRzEfmaU4PM/9gFHPLyQ/KAI0ODW5yCBl75wRHQ3XpW9Ue0ljsIm5jbTTa2x
         VbxairlWOP9V0fy6DnTWwbtwDm70Zc85igfVuzmxHGBM+BOI8l75h55o/2+UvuNpr7Cb
         o7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144658; x=1783749458;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dWA/4m/UVmnMmxggqt7YCrXYgmO39jWI35he5TtM3O0=;
        b=H+OYdD8f1tAyb00C+8vKX6xPYBw2DBqDl/Izd6lGXOTJHT77EF+DM0oGLysYdGyRxT
         RY34UKqNHqqKiu9BfJ/1vSrDux+VPQjnMIjlkmqPLqZXnP5KGKpjjLsLaydKJkZJLc3K
         uWj8ro3pNpsEyEsfmOdGPauyXjM1P8ulM5j1bi+vkOBaYBcj9F7Oiet+WlE4/JC/eu3x
         wQfhBxHEhXp736Lwkmunj8/U+0DkIZhV9rZlOCU0OIjRyuM58V4GgqtIRxBObep+gH3P
         4CFoOpGl+AFddGX91E01R+XWjbBNN9L7dnuTOLIPG+8uqIkl3CE4Wt+CJohu2shmBrd2
         7sqw==
X-Forwarded-Encrypted: i=1; AHgh+Roty7I1lNdZVWYvo84EQMQ4F3OeUROGoNfRv5wMM4fuxiCkx4ejcSnjj8Td1f8cFn4MPQT49jnzdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YySgojDOGbVshic96739KQYjLZ03vfnuHvP7PXDr6OWQ4PA1GXB
	LHI/+f7V2zEzbhu0mHZK5P0NmeECWwHi9RDVy2ewuS554Px06iJtJehm
X-Gm-Gg: AfdE7ckwa/PDMXpZr12Pp5zfovBWqM8cbKXvlesJlavu/C7P+VSQMZolXTctjHQkuVz
	7wqWLqbcjbqqQO1VhKW1CRmn1v9CzGaIvGM07j5ArIHxYf6mV64ash7AoCehLCxuUvctoWW3uIr
	zXSkacPp9QQYI1/ugQTRflWpBwhbTvfyNPlwtrIUxqZJr1/2CrjkvAhGZMOzB5nXkEl01Ln5Yet
	QwC9yJZB5R0R7VpR5OBAKvlepMk2YBHJSDzRk5B7o2usFjq0LN3T8p8WTipZLXE/iIV1Rjr5fAn
	v5CfPvvGKXeSjZbX91h1sWKjlcsna5uZoxNaFlKU8SWS0q2su3bPBy5GeDA7zgZkcqHNP4ms+j+
	U8MNYtTvQo7MkGF2Nk4Hy/C7dI1KEkRwrAgUquo4ovkG8Gjkau0oiyDn375AyP8Q//9duQZvt+6
	TKnTXvQ0x0COj13aZD3TDsDtMUhQhvnSZ6OdcKUAWcTM2iIOw0S10SR51i4sulrV5DEC5O4UTKM
	yE=
X-Received: by 2002:a17:90b:524a:b0:36b:e8b9:46a4 with SMTP id 98e67ed59e1d1-38280d99abemr2441388a91.14.1783144657746;
        Fri, 03 Jul 2026 22:57:37 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:57:36 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:26 -0700
Subject: [PATCH 03/26] Input: maplecontrol - only enable present axes
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-3-41e424964da5@gmail.com>
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

The driver was unconditionally enabling all possible analog axes and
hats on the input device, even if the controller reported it did not
have them in its function data.

Move the input_set_abs_params() calls inside the capability check loop
so that only actually present axes are enabled on the input device.

Also, correct the D-pad (hat) axis limits. They were initialized with
inverted limits (min=1, max=-1). Correct them to min=-1, max=1, which
matches the values (-1, 0, 1) reported by the driver.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/maplecontrol.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/input/joystick/maplecontrol.c b/drivers/input/joystick/maplecontrol.c
index 6293b6e8148b..a498fc322c4d 100644
--- a/drivers/input/joystick/maplecontrol.c
+++ b/drivers/input/joystick/maplecontrol.c
@@ -118,26 +118,19 @@ static int probe_maple_controller(struct device *dev)
 	idev->close = dc_pad_close;
 
 	for (i = 0; i < 32; i++) {
-		if (data & (1 << i)) {
+		if (data & BIT(i)) {
 			if (btn_bit[i] >= 0)
 				__set_bit(btn_bit[i], idev->keybit);
-			else if (abs_bit[i] >= 0)
-				__set_bit(abs_bit[i], idev->absbit);
+			else if (abs_bit[i] >= ABS_X && abs_bit[i] <= ABS_BRAKE)
+				input_set_abs_params(idev, abs_bit[i], 0, 255, 0, 0);
+			else if (abs_bit[i] >= ABS_HAT0X && abs_bit[i] <= ABS_HAT3Y)
+				input_set_abs_params(idev, abs_bit[i], -1, 1, 0, 0);
 		}
 	}
 
 	if (idev->keybit[BIT_WORD(BTN_JOYSTICK)])
 		idev->evbit[0] |= BIT_MASK(EV_KEY);
 
-	if (idev->absbit[0])
-		idev->evbit[0] |= BIT_MASK(EV_ABS);
-
-	for (i = ABS_X; i <= ABS_BRAKE; i++)
-		input_set_abs_params(idev, i, 0, 255, 0, 0);
-
-	for (i = ABS_HAT0X; i <= ABS_HAT3Y; i++)
-		input_set_abs_params(idev, i, 1, -1, 0, 0);
-
 	idev->dev.platform_data = pad;
 	idev->dev.parent = &mdev->dev;
 	idev->name = mdev->product_name;

-- 
2.55.0.rc0.799.gd6f94ed593-goog

