Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DB832470F
	for <linux-sh@vger.kernel.org>; Wed, 30 Sep 2026 04:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790744306; cv=none; b=XFZdQzycYpZ67c8CsXntTPSyoJ8Z2KukeS+CtUw4b91LhpopM9ir4Hcr8kJrnv4tmxYU7kNGcn/aDHjdTu8IzHRprOCbzBD53z6LxLJtYT1VaY7LIVH9RuTNaPDtDQvhxM/r/Ro5e20nOJGmb3ao6RRYlnvStaodtMcnHK+6wsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790744306; c=relaxed/simple;
	bh=bocwqw7X310Ap6HbvXN88unuvzXmO6SuDNjdejac4+s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DrgOmXv3qn3Qe4Xp9112ZsmGLc7kDfrBRwEsh7vLPdry9XjEvST0Kp64v8TK3vZVmaVTZXR4/tzwykJhASz3w6ja4yR3IVneqx156OF5YypgIyekrD+4txV4AfztJW+UD22K0Ak7pruV1XKL61yl0br8a5SrUNSW5uGOsuC8/rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AT7DDBaR; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AT7DDBaR"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-3411e0ace58so6287831eec.0
        for <linux-sh@vger.kernel.org>; Tue, 29 Sep 2026 21:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790744303; x=1791349103; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uEa+/CcqrhlXh9egqa2jk7iOVWdF6h8G71PxTzsaVVk=;
        b=AT7DDBaRlgxqE5QlgB2sbI5BWR5GkjRwziO+IrDLO0I+hwDH86FtYEADRW99Tft9Lh
         Iatm4mCwlQT269h0uhR74TCyS8ZTtFCnTOPPSX8WSCmvs6dWB0s/j8wpug7ic/bntkqk
         RK1I3VkeVZKzeC3YQcM8Y0206QAYeYw0c4o7fE2hH67tMOIntui/KFi/Ig2nhxjPArxa
         Buk++fkVXOPEMSP91VSLWieErsRJCc6xIqedcZ9SamSS+d1XXxRAHD4I57/hHrx0lKVa
         XqiaYMWiAsJo0coNRsw9DKazohn7vhm563tuOFQK9eW9I+Xiz311VW4szHG3wHbH6eco
         3TcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790744303; x=1791349103;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uEa+/CcqrhlXh9egqa2jk7iOVWdF6h8G71PxTzsaVVk=;
        b=LuTo2wFfThd9cbhebBjQNI8N5Pt54f1bOp8LU8Q9UPMsyW2FfiQPkqlxP4g7nBv9Tx
         PWCl1GUA1dkanP5cYbI+AcKcBnzv2Pzxe58JeoPlz/xtj8OtxaMLzxs6vlLGl289SAB0
         +l0Iyx0TBYc9gKfWbnnxuRz8EUmT5lTHHF1g++ZiFyb4XmHnvMm7XqkvcwNXDroXUDF3
         IPRtRs8bPW1oiHQzXuHZqkNQx9h+rL1rGUfspHyPtOCOq+qkJokdC+BQMTSAYBUbXWCD
         tn2diwENIvh35OG82/QtmXJkWDKQATuwGWiiJOoUR9dbXhxSAnUqUwbVFV89I6yR4T9F
         LJmQ==
X-Forwarded-Encrypted: i=1; AKwUvBy0stpigjHXHNVcu7kjbAVGrGNVTnNEAWr8D3oePsoAJPac2xA7+ZadVagHf4PQM8Ydnx/nGCDLUg==@vger.kernel.org
X-Gm-Message-State: AFq9FYI6YEap4rymQ44rdYc/2xtOOx0meL8Ew+skP0IJvjEFuL9sReFi
	hmJsObULWNt2/+1FgYzYaJ80Xpno1fCQfDyWrIs+GV8JkhOTMfPgyl2p
X-Gm-Gg: AYBFou1zpW8CVTf/ZvzZbT991QnkpMatANEJtXP8PsJ0XUry61cQdp62VkSlKBCP8kh
	2i07QXRegJNRjv7Vpkq9xjAwlkcBtFPUS7/vXYPkErAq9uKIVp/9RnoVgw3HbL8x4qBSoCQ3W7G
	5D5lG1/4IJjbZVZrCTzrNNtqMUU0BvLTAaukn7ZOD2/lU6xyiF62Cc4voCFKkYVLy7IDTi57Dsq
	9nZU4WKKGmDJOWTmzH+qXyMRl2vYpxOxIhCMHCx6cu0K+tdZ7tXdh4SK+2vSysN83H3ajcpcqw6
	S+mTC5R0k7no6y3SpMnaf+xtZoKjlH0Yk9a3odOdsAqxeh/DiOh3cHrZugfskNrSvpttTH9oozI
	Zj42vMY/Dz034B57c5y/sTUYjZJUmJBNX/rkhWlX6iND3GUrTOsmNa1sd8t5pQs+3juiR4tSy7c
	fUNRF6uLZBzS48VYxRnhoc19WZVmiYsITbd41TugqEd5ZmJYbcE0xbZIuUi0ripDRvahZFQ+gSX
	TUFYZW2VrEDt99h2wd30G4fHp20VoLxdGw2IS/g+yXTWqJi62JP6OOATZOlE08=
X-Received: by 2002:a05:7301:d38c:b0:33b:dfe3:250d with SMTP id 5a478bee46e88-34cdc9b6537mr582806eec.23.1790744303385;
        Tue, 29 Sep 2026 21:58:23 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:101a:5ce6:a15e:d8ca])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34cf514b783sm571056eec.13.2026.09.29.21.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 21:58:22 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v3 0/5] sh: mach-rsk: rsk7203: switch to using static
 device property, drop legacy gpio API
Date: Tue, 29 Sep 2026 21:57:59 -0700
Message-Id: <20260929-rsk7203-properties-v3-0-02f84aeb8e47@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANeWvGoC/x3MSw6DIBRA0a00jEuCiJ921H00HQA+BC2fAtVG4
 95LHJ7BvTtKEA0kdL/sKMJikvGuoL5ekNTcjYDNUIwooS2pK4JjmjtKahyiDxBzaXFPhaKyouL
 WN6iEIYIyv3P6fBWr6C3OOgI/V9OaBx8yz5vyrLMiWDutWuvJMSvWFubAxux9kLzjm5Dw9o/vk
 je20pE3H4eO4w9iiNjntgAAAA==
X-Change-ID: 20260310-rsk7203-properties-82bf2c12b985
To: Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Arnd Bergmann <arnd@kernel.org>, linux-sh@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-gpio@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.17-dev-6c14f

This series of patches converts rsk7203 to use static device properties
for its devices, including gpio-keys and gpio-leds, and removing
dependency on legacy gpio API (in favor of gpiod API).

To configure pin functions the board is switched to use gpio-hogs, as
doing full conversion to pinmux is too challenging without access to
hardware.

Changes in v3:
- Avoided using inline compound literals for property entries in
  software node initializers to fix compilation errors with older GCC
  compilers (GCC < 14).
- Collected Acked-by and Reviewed-by trailers from Bartosz Golaszewski
  and Linus Walleij.

Changes in v2:
- Added a patch to isolate the function gpiochip from the parent fwnode
  to prevent ambiguous property lookups.
- Added a patch attaching a software node to the main PFC gpiochip device.
- Adjusted the board setup to use the PFC software node for LEDs and
  GPIO keys instead of creating a standalone node.
- Added support to sh-pfc for configuring the secondary "function"
  gpiochip via a "functions" child software node.
- Converted board pin configuration from legacy gpio_request() to GPIO
  hogs, using postcore_initcall to ensure nodes are available during
  driver probe.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
Dmitry Torokhov (5):
      pinctrl: renesas: gpio: isolate function gpiochip from parent fwnode
      sh: pfc: attach software node to the GPIO chip
      sh: mach-rsk: rsk7203: use static device properties for LEDs and GPIO buttons
      pinctrl: renesas: gpio: support software nodes for function GPIOs
      sh: mach-rsk: rsk7203: convert pin configuration to using software nodes

 arch/sh/boards/mach-rsk/devices-rsk7203.c | 314 ++++++++++++++++++++++--------
 arch/sh/include/cpu-common/cpu/pfc.h      |   3 +
 arch/sh/kernel/cpu/pfc.c                  |  20 +-
 drivers/pinctrl/renesas/gpio.c            |  28 +++
 4 files changed, 281 insertions(+), 84 deletions(-)
---
base-commit: 6474fa070f2b8013b4b87350b775b8c3be6e8aac
change-id: 20260310-rsk7203-properties-82bf2c12b985

Thanks.

-- 
Dmitry

