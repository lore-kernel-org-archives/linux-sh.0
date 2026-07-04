Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2769438AC92
	for <linux-sh@vger.kernel.org>; Sat,  4 Jul 2026 05:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144656; cv=none; b=lB6WqlNJeuphlmt4LOM3Giq1GRBG1UfoESR+LrW7HptRxV+U9JhKh0SPkgQnLS+EZiZPIMBtWk1CzIAC7tanzR6eIhd927FlwFI0cnXeqhoJj0t1/iYCk3qjiRkVQ9PkNNE2JM4RAPKWDad2MhpUwO4Fn8Rl59sBu+HqbsIzHTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144656; c=relaxed/simple;
	bh=nj/892zcwHqKY6k98/X1ebXGE0Sl7j7eE0rbpi7D+Lo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BCYFZ3Siv/FtBQdEQ3mGRJychBmR55+9KrBb8l22nAPofcB9BTmKAc/ZBVH4s8zqgOwmjuFmJlkfYqkQY101TL0CWM2DNSt0TkVFBm18elq0WfVyea4lCRqka/vAsm80R622UZoIwyc3eEq7uNlDkfQ8KTNE9Wu2ywNl/BBUZ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFGh4T35; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFGh4T35"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84347ad88edso1681248b3a.1
        for <linux-sh@vger.kernel.org>; Fri, 03 Jul 2026 22:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144654; x=1783749454; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DUBmbNocxonyJ3lOrR4g5OiG/+KsVvhX2DrdQTMHh3Q=;
        b=kFGh4T35jRq5eK5D7u7WTJrTUzUHCVRlEiRsQU9lX7Lqr3BoJANZWIHy6FpReZqC6m
         KXd2nynpVtx8YHQFnDpE9NcrACmGbVfsLmB+dOVhh6l9K3ZI9BN6CrWTdUee08/Y66lC
         yr1ko9FPzWS191W4txKH5mWwz3D7qA/NPcMfPQ5nqAkYLPEG2KyJQYQ3oRH+eZHM6N4a
         wEZ0KW/nNkV5saCNAVfEREx8D2q1A3bug7nFuNwHBliQS/P9gDuKQvHv5wNeCeSXICrA
         mOeiR0icgOiJnpuvKNub0QbI9Dt2ewQ0hvMc41nL20/xPbZr5V6Q2xGIn2rOVyju/nwP
         b2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144654; x=1783749454;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DUBmbNocxonyJ3lOrR4g5OiG/+KsVvhX2DrdQTMHh3Q=;
        b=ZpkDpa8t46of21PHNas0ODzUW78mOZhXoCNx2ndluYSIt1jxLYH01RbLH1hrQjVn8D
         4aZDIJnfadDEcYPk9rjAlAMm3eHOPVyXciOuAMyZHnJeFUvJKK403pkhKyWr1Y5Eswv6
         WWKVUxgbpg3ST1TXp86Fb2TjMuPKcy6MUBpMEFE8hP4CylIYB1daOdfvy8LUJXqrQqN9
         H7suFRX1oFF1y5FX4eF1PKXf+Vc/yBdB52hfe1dNlf0TcEZkthbrE8t0kjdOOAai1mTw
         lAIg1go3rPujqJZ4FAnRajKqgrxX5CNqb7ov9I1+QFaPbv9JiGTDQ1IXNiva0B1sRwaV
         dheQ==
X-Forwarded-Encrypted: i=1; AFNElJ89RV10zMIvm16DKKKxksjUeheHlywQle9Ux2gJNWn/qMFo6GaT47YVSBKK0MriLDZTVmJEQLj3KA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbTG22jjugXtbFHeckdpM8IdFn9OC3vS6mIN5NeZm0EDuwqdaf
	T5bqmo8O3/gS69febokDS8qarFTiaPihHVQ/eal60TIABpImosUqu99/
X-Gm-Gg: AfdE7ckpComeqbYGcNOopRlnupSTbvlrmpNx/KbgwhgA0T1im+dD4vkC4FsMHaZ8MPG
	0U/3XIS/dUQHhBWgtEmdKd4JtK6nd46ZTBqJRYAVctAGxhovArqEWcQUbaAn3r/XSdCjZbvn/O9
	ejM4SbSJDjPRJU8RvMdXbFgzIPOWzUURuQxA+ohOSU1+duzDJTDJ0Yi02BxSSeElPBPK4pwhRW0
	tpOyI7JePSSs0jOQ+yWHjx+em1VkQuybd8vrN1oXbYz+bql3oC2KUvtqfOLUeoHqfOhCpTepwoB
	76CotZi0tOxuVR0guydXk2m6wzEnG7S166DUvWlT4noqiluHfsqPtKAMK9uj2ZHEqYDMcTgoe0X
	K9CZvJ3uiyFDyNNSyLOTmRU3poR5Tp+yGy0UiattCUTRiPCpjC+5r8NDEPC+Bq1ZTHLsYtzmpQ7
	lP45cRxlQISFnQpTwoYHzsK8ZhjQgiwHojFlPN7cMpX0JEt6jVKA5b+sNbTqL2JF1PjCP3JIZdv
	18=
X-Received: by 2002:a05:6a20:d805:b0:3b4:65d3:17b1 with SMTP id adf61e73a8af0-3c03e4bb67dmr2019218637.43.1783144654392;
        Fri, 03 Jul 2026 22:57:34 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:57:33 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:24 -0700
Subject: [PATCH 01/26] sh: maple: include linux/device.h in linux/maple.h
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-1-41e424964da5@gmail.com>
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

struct maple_device embeds struct device and struct maple_driver
embeds struct device_driver. Therefore, linux/maple.h must include
linux/device.h to have their full definitions, rather than just
forward declaring struct device.

This fixes compilation of vmu-flash.c which includes linux/maple.h
without previously including linux/device.h (or headers that include
it).

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 include/linux/maple.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/maple.h b/include/linux/maple.h
index 3be4e567473c..22f2930251ed 100644
--- a/include/linux/maple.h
+++ b/include/linux/maple.h
@@ -2,10 +2,9 @@
 #ifndef __LINUX_MAPLE_H
 #define __LINUX_MAPLE_H
 
+#include <linux/device.h>
 #include <mach/maple.h>
 
-struct device;
-
 /* Maple Bus command and response codes */
 enum maple_code {
 	MAPLE_RESPONSE_FILEERR =	-5,

-- 
2.55.0.rc0.799.gd6f94ed593-goog

