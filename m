Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3401335BA8
	for <linux-sh@vger.kernel.org>; Thu, 21 May 2026 05:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779340422; cv=none; b=a1M6sM6YqJkhijX/7RSF2eyJayagedP1FsiFbxT/z6Z0QBqGcKaGp5nAT32NlCdyqJP6ViM3XxpJoUgZ4648fKDQmg4D4y4ckwBD8CbMx9Mg0iJ7LLMRwJepQKx2HRv2NWkH/uA1pcQTpPwrx3KbcS6qtpmGX6EtJfER3JjOI2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779340422; c=relaxed/simple;
	bh=gGj3bx1qE3wnIKHp+6qyWe35fzxuLt4vuc4uZ4QLGkI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sW396oXJ9Eci0kVx+uqpGRrG0l1GVvVK+l/e2fWNSk8GRWQPuAe85YRdfnsA9Zsma5d+0erE/UoQXj3aJLiMHJUSdp7S4pC4RUoJp/ZiRSDaeEFrKR/g20HwHIlw7Kt10yWSjW6Py2OhgDD5dLuS/IPM6pz+KWyrY4B7q88D7kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ao51JG6S; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ao51JG6S"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2c156c4a9efso7918589eec.1
        for <linux-sh@vger.kernel.org>; Wed, 20 May 2026 22:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779340421; x=1779945221; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bnS66HRPMnJiuE1UMjp+LGMM6n3gYPvVDfnlD++FnrY=;
        b=ao51JG6S9WL9RcalrUA1ffhp0uzhjnaouLPW92MFWPq0svcNcbXcfXG4mxgq1x3ObK
         9nal6g2hBTFh4OOrUTbv16TcyES1uogbHx9sxW93vyc56C8FgyRowiQDVQZ0zVPY69Rw
         Bv063RkRAXFvXT2LR1F7pJZyNNrNiyjdK2OKc5c80kNB62bFuHPv58Z399ry7bqsmzJz
         X7rxNL4KvFbqZUmX0Kv8til2I/6A/IUfuTkmX7HblwzkKfvCxutBRCxSumCf07vHCm5h
         NqlhW82OrXof1Sw6tk1cEND5ctosdvyKLrNV0dexRfbXjm51nVIbTcCOG/GcdEmADLFI
         VRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779340421; x=1779945221;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnS66HRPMnJiuE1UMjp+LGMM6n3gYPvVDfnlD++FnrY=;
        b=NZeeSO0p/TVJQ2BW7DhXy7cEUlo68hMz7e3cHYcnBOrB73chgvD+gT7QKYgRwc71Bq
         WO2cEXrAxtcJjeIGtA4+L4ARjehL4lEyiFriQVC0QRccirn/hioA4ru5dnZ3GHSlPDxd
         WuO4DS79n8sbMO42SgWSFOqsOriubZ/20ylrPx10MYMrOyg6XxvaeyCNj8czMv1mqRu7
         umgcjE1Nosiqn7hXQleFTTJjyu7Vld7Mv/aqv34kANy5q/9pfH3X+NMzFEpaGfMGgI6C
         AvY5aaJPOIhCXu64NVANZW7TXBJNxu2KQzUR9wWtfdPoB9hBUqjC3PLEd0V4lJH/X3xi
         tEQg==
X-Forwarded-Encrypted: i=1; AFNElJ/LQXIXtkeqXwGAzxhaqfvN1E9ZMIwJ+XzPDd7bmfClDeKt/VriNe2Sl+hM/x3+917y8O7URVr82A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwX5D8cdWAsJFNEELk/VtFGMFDwPemxGU+CtR90bktMZq0SdbRV
	LuVW2jiA16d2cZ9YL1NOjaObBpwDrnEn4xqpuvpYXN6GsePY4+5Mjdhq
X-Gm-Gg: Acq92OF8mSu6xh4DZqJ54Ul3UjnmijyHp3j81KrikT2FWDNpZFh9/84wbFHYrlnNZYu
	tw/nMxvCsuDkHH99RvKD5lKAm4BpGAaJjzigMTdmW9i7G7fopG01Mi8lIg6Qj9pHkBWNXPDsgl6
	Jkqsyu2jCVox32FnawPUcp0rZVcwE2/Qx8TTSsYbjrwSEQIh9eU1Ye8mdLckbDTRqRlMdU2azJa
	5hogOwX/jso2jYx+vWF9CivzeTLsSJ82lREgOFRVTFofnoUDrjwQah1DrqqZGhSvtFzrLJ8JaqT
	tZ30vkI//TUSS75gvFPoa3rGwUsY4ylm/kKuFEh8ySgqKs22cmO8kGCPJ2P3zfHtKZfkUZgvMIa
	T3dHSxEf8N+NdDgL6p2wt2tLusLjAERXwa4xXrVi0b6L3wO5hYVYUB+ryf4Yyallwo5wA7KNbZq
	8H/DROPHLNi0iekJ+uyfe2dP40+JJ+O4zMhbcuIHp2gMMFyRhu3MrjHBa5d87HwA6v7oeKt0Hs7
	tnybVWWem14IU7Fw+4M7zev
X-Received: by 2002:a05:693c:300d:b0:2df:71f0:e5b3 with SMTP id 5a478bee46e88-3042f9716camr847573eec.20.1779340420662;
        Wed, 20 May 2026 22:13:40 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:d457:597:d576:1eb8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-135e5c0a918sm6231360c88.14.2026.05.20.22.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 22:13:39 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 0/5] rsk7203: switch to using static device property,
 drop legacy gpio API
Date: Wed, 20 May 2026 22:13:16 -0700
Message-Id: <20260520-rsk7203-properties-v2-0-465f3308021b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGyUDmoC/x3MSw6DIBRA0a00jEuCiJ921H00HQA+BC2fAtVG4
 95LHJ7BvTtKEA0kdL/sKMJikvGugF4vSGruRsBmKEaU0JbUFcExzR0lNQ7RB4i5tLinQlFZUXH
 rG1TCEEGZ3zl9vopV9BZnHYGfq2nNgw+Z50151lkRrJ1WrfXkmBVrC3NgY/Y+SN7xTUh4+8d3y
 Rtb6cibj0PH8QeJ8BEPtgAAAA==
X-Change-ID: 20260310-rsk7203-properties-82bf2c12b985
To: Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Arnd Bergmann <arnd@kernel.org>, linux-sh@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-gpio@vger.kernel.org
X-Mailer: b4 0.16-dev-6911d

This series of patches converts rsk7203 to use static device properties
for its devices, including gpio-keys and gpio-leds, and removing
dependency on legacy gpio API (in favor of gpiod API).

To configure pin functions the board is switched to use gpio-hogs, as
doing full conversion to pinmux is too challenging without access to
hardware.

v2:
- Added a patch to isolate the function gpiochip from the parent fwnode
  to prevent ambiguous property lookups
- Added a patch attaching a software node to the main PFC gpiochip device
- Adjusted the board setup to use the PFC's software node for LEDs and
  GPIO keys instead of creating a standalone node
- Added support to sh-pfc for configuring the secondary "function"
  gpiochip via a "functions" child software node.
- Converted board pin configuration from legacy gpio_request() to GPIO
  hogs, using postcore_initcall to ensure nodes are available during
  driver probe.

v1:

http://lore.kernel.org/r/jwtdoptatzfo47mbpmmjwhhhjn4mbw6ekp4gtoopca7azbcelo@uvtz4w2ga5qn

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
Dmitry Torokhov (5):
      pinctrl: renesas: gpio: isolate function gpiochip from parent fwnode
      sh: pfc: attach software node to the GPIO chip
      sh: mach-rsk: rsk7203: use static device properties for LEDs and GPIO buttons
      pinctrl: renesas: gpio: support software nodes for function GPIOs
      sh: mach-rsk: rsk7203: convert pin configuration to using software nodes

 arch/sh/boards/mach-rsk/devices-rsk7203.c | 282 ++++++++++++++++++++++--------
 arch/sh/include/cpu-common/cpu/pfc.h      |   3 +
 arch/sh/kernel/cpu/pfc.c                  |  20 ++-
 drivers/pinctrl/renesas/gpio.c            |  28 +++
 4 files changed, 254 insertions(+), 79 deletions(-)
---
base-commit: 6a50ba100ace43f43c87384367eb2d2605fcc16c
change-id: 20260310-rsk7203-properties-82bf2c12b985

Thanks.

-- 
Dmitry

