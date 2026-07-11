Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AA73FCC
	for <linux-sh@vger.kernel.org>; Sat, 11 Jul 2026 00:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783728724; cv=none; b=WHcqNkfh+K3TOl2qCFpNxj7l1HlFMfXysSFU8JxOmD9jzifZaPggHmB8DV9MxBwMAHpog3cb5q7WWI5ITFxa3bSUv/n0ahrjLkk/VxxuoAUmwyYCEzk6yTfHW1YwfIDfEeNLso1ypKjimQIDFHFe49Od8QZI3hWYgNDCpfi0lqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783728724; c=relaxed/simple;
	bh=0gQX7P1oIprqISCIJfxao//qb8rkST6dWjOV8CvC9Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OMtA4ue2zFRZCbbq85oRYCw42Uz7+H4Va4/ytgWMJ1Vpy0Rk1OWEw0x9+xF9GZwvOpDU68W36EBJWMLFyAELqOHZ0vE6llVsqGnw0v8EjSCCRgFGAM+MJcA/wsrL5cBFIqlXq7ZSSgtGqzhAeIuwHTfJIWn+wU/bzoo41N/K/yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2KzOsZc; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2KzOsZc"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493ae59eca6so7189465e9.1
        for <linux-sh@vger.kernel.org>; Fri, 10 Jul 2026 17:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783728722; x=1784333522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rb6ZPHPRfJJScY1Dh9Z5eLNSwZMQUx12yLpL0PFajyc=;
        b=B2KzOsZccRWk99krGrVs7b5o3qMWKoj5KdOzOUCERukm20mjXwNfBZYwnRxs7DV6c7
         5tUsIWB1A7JnOOSItZSDzutPq0rGSpqjmd7G3tkMVypb6WErIfnYu/RQpacEjOJ7e7Yj
         nF3/AENCEOciapOaDsmsoW2ZHbTLGVF9cTZWChmgA+M/ZVss4ac/2vDW4uNkkOePk7Sn
         uB9UbpC/NGGEEYBkys+TJSlaLJQt8XiSHcRu1hLGyw00GJgOmXega6N6fKBTEwGUp2R0
         l8arCgodhcA3rbOd6FuAXk+wAjO7dzA/nZDNPtFLy8fK2Z/fiX6Bh3Nbzllic5pELp7b
         5eeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783728722; x=1784333522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rb6ZPHPRfJJScY1Dh9Z5eLNSwZMQUx12yLpL0PFajyc=;
        b=YUki8f7VGtAjBFYDr3WjQbVJhShDNe79NQ1tntL5i/4ZcmsVb+UdS9YeX48YpUWqP0
         40S8E9KwMHybcE4YPyWX27qMCAjaahHaQEh172v20HpjNY3Yp6gdvktvHiBcuaszsWQa
         kw/xVVu2W4TpHZrxqf6H+LCx9N5GaygPow7VQXSYbB4ZrP1aBhgypNklBkl4oJbT71h3
         Uy15MZqijQbgk7qLT8lvpm0SE5wCJ9KMlJSHKELg9CeIXA860bPPQEjru4u9tI3E28so
         vLEKC6zVYeMxLXhKIWZ8nuENQ8Nq30BzEzdUfwIP+6fPBIaMB8HcIE8SmOgYBWOJss2Z
         CCjA==
X-Forwarded-Encrypted: i=1; AHgh+Rr1nYoQTt1hkJfCYHqpYlT6hm3B9x96khdVnCdprfhiL5s9sTgCVqjsiRLFWXM2baH27dPCVR+bUA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbz1W9CrQ8aRbd3eTEWTGX1IDOPxyCmtqbzuJ55XSAtA4hGRMh
	FyRC/Qa85PKdtlFnyJcUxEGdGTgV5iyV58kaoh4NlYyaBZz9R6QYvCU=
X-Gm-Gg: AfdE7ck7hVER/y/Fk+hfSChNt/sGJMdNJvT7PQlLYcRsSffjePwu+rv14h8awLlmzSe
	vW7M2S3iToP7vWNaatstJVqChXOSb4QuxISCMDyv+kaf1C0HMp/0Ddki9kLDQEg2PLifT+S2xEx
	uGRubn75ZWEbzF8aDKWEa4TN222Y8XLFhWH00fOZ5ux9ODZAjF5R/THPIoLoa1SNIFlLLyAH/MK
	K33GTFJoyV9CF9GvO4NV521gnIs9hUbh4/g+86XUf6n8XYmpL+O2jZNEx3heqvM2UpDDud8MAe0
	ruzf1m7DDtKW1jhmKRp7TeuhNfQZPTMQCQiApOXLuaiaxdZuiBVy2deo7v9rEAOh486tac5crek
	8YDxPgI6laCJJ/h0cBA41xZFdXGDlowU8fnwKR7T+2qCxyzAqwmjpFy2TRpM30W9/CcfOYWK7ml
	WZsJFfDQ2BPkirA0cJMuy6kgTbRnEBclVS4D55MolZbSPFyabmKATF4VrNn1fzItRcbsg10Q==
X-Received: by 2002:a05:600c:8718:b0:492:7101:3d88 with SMTP id 5b1f17b1804b1-493f881d4bfmr6762835e9.24.1783728721622;
        Fri, 10 Jul 2026 17:12:01 -0700 (PDT)
Received: from localhost ([2a02:810d:4a94:b300:9b34:9074:3c44:455f])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493eb73ae14sm170168835e9.11.2026.07.10.17.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 17:12:01 -0700 (PDT)
From: Florian Fuchs <fuchsfl@gmail.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-sh@vger.kernel.org
Cc: Rich Felker <dalias@libc.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Florian Fuchs <fuchsfl@gmail.com>
Subject: [PATCH] sh: Fix built-in DTB build with generic rule
Date: Sat, 11 Jul 2026 02:01:46 +0200
Message-ID: <20260711000146.3348854-1-fuchsfl@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 21bcc49974c2 ("sh: Migrate to the generic rule for built-in DTB")
selected GENERIC_BUILTIN_DTB and renamed the Kconfig symbols, but left
arch/sh/boot/dts/Makefile using the old obj-y form. So convert them as
well, to fix the build error when using CONFIG_BUILTIN_DTB.

Fixes: 21bcc49974c2 ("sh: Migrate to the generic rule for built-in DTB")
Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
---
The fix is the same like at other places like openrisc or nios.
Without that, the build fails, when building with builtin device tree:
CONFIG_BUILTIN_DTB=y
CONFIG_BUILTIN_DTB_NAME="j2_mimas_v2"
with an error like:
.builtin-dtbs.S:6: Error: file not found: arch/sh/boot/dts/j2_mimas_v2.dtb
---
 arch/sh/boot/dts/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/boot/dts/Makefile b/arch/sh/boot/dts/Makefile
index d109978a5eb9..16e281b859ae 100644
--- a/arch/sh/boot/dts/Makefile
+++ b/arch/sh/boot/dts/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_BUILTIN_DTB) += $(addsuffix .dtb.o, $(CONFIG_BUILTIN_DTB_NAME))
+dtb-y += $(addsuffix .dtb, $(CONFIG_BUILTIN_DTB_NAME))
-- 
2.43.0

