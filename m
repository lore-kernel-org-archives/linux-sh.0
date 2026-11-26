Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795736627;
	b=uS4Nr2oAoIBp0OojKN0AqiPjchddjkJbfgVPe+9iwJSKoCa0v9GbqlRYNs6sPO0vIP7W
	 IZiInmd3+WVkmpjlZaWsoCsv+jga0NMUSILgc0YDOaAoV+I6yS5ZtmM3m82hz88Tn8PFS
	 M38A6Mklv5P1/Wk2B+VnhIe3KoTmgkj9R5j41W4OI16iY/x5+58CPYuzTjpCvQBpsEtak
	 weFVeRS7LTqGkIvhbCuqhxKM+XT1kVTRwB7xTihIxaBOuN3VLNE1pdomHaE/riaRglGES
	 48boH9WJMVCt0OgOLS1A/eJ5HGUOkFnU5fLYFbI9bb+gU20YV9vo6Co0f7PLC3ne2vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795736627;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=3htbF9Yrsa3dnBt/nq5An7sUvlJzo+crmssFJrosLQw=;
	b=VOK8bJzxYzeB6C1g49SgF+H0/4jBh1G6cDrndimCRSSrX6a6zmqfyNJFvEI+YZMlAQbW
	 cHI3xqn1RmEFaViUFC1KJ7g11XaH72WQhqNA91iAR+XTkwNEg1AIPrJuc3kXB1yHLscxm
	 8I2Y2J/ee8z7p+o0GqSiB9LO2SEQEcgSW9am0cQdS/IB1ZCeXS1vb4vLwSiVmVWDDfkyP
	 B8g+TCpIpN5xlnyQGoZXtC21c02LoyQha9bZsEa6fyby6tMdsW9FDoGi8jM7wPghyxjFQ
	 bl93PZMf3tZe1sSkvXBbG7LRYZV5zgrjSWVI3pWWCK8j3/aitN1X7KLjzvyY0R3PYBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="wKpXo/ns";
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8CB606A31E
	for <linux-sh@vger.kernel.org>; Thu, 26 Nov 2026 23:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA8CB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wKpXo/ns
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cdeaf4ea5e0so1195768a12.1
        for <linux-sh@vger.kernel.org>; Thu, 26 Nov 2026 15:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795736626; x=1796341426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3htbF9Yrsa3dnBt/nq5An7sUvlJzo+crmssFJrosLQw=;
        b=wKpXo/nsQjXctCEIf32kJowgsK5LI1X/PTQRoqM3b7KHTuSJ5/9TRYcAvhtlHXK/gr
         H1L5qJAs1TQWB6VVZDf1eLjEe/wDnGR1S/ogaUUXPKnYfoaJznR1zt3MQPcxjiZj9YPQ
         18v/umtDejJYm3oi6iDr6Vu2hGve9wTNzyx+jT+VEBQQ6z30JvdBMSZXmS4SzIWcePax
         nx2wXptUElibm6JS2yQvuIrwOVepguKXCp0qp3zt9Wy86m29vyHT+POl1pq0orgFDY1/
         vsnFNoBy1liuzpB3Wrf+XZpx56lLJj/zCiYCWefktcR8js0c6CxVZ6roQzoIOASouiSK
         j2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795736626; x=1796341426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3htbF9Yrsa3dnBt/nq5An7sUvlJzo+crmssFJrosLQw=;
        b=23oyL0YoCQ9xEpcXdQJl6RXtfKIfeEaG9u8xSYDa7YHs39vc1ujUq4x70j2m+cJbmg
         Vl1pWSKsXPhJ2cpvuGPsPwTQeHA6aaDrMvv11XGBMqpW4B5GJytuelERC0/8VsE4JRCq
         YJZT9f+EhLp74jairvFsENdaJSwo2wjtQpOE/GTUo4iQUCVB23Bp4jFyLmI9AzI4SM1N
         /cvwfLUX5u6Evr1npgePccWcDToPK2mlp2UZPvKLZqAbWZnoPgCANKjgPjKx6SP+5gkb
         2UTf5USi+trk3CPPrfCeNGDSjM8dAQNiESEwuVubTns5YZjD+Xq2FEhiKxQS88o+w1mb
         WN7g==
X-Gm-Message-State: APuU4Z/ZD57ZE6Tx4wpIzR5ERd0U8nmH5eLIXzYpd3PtDOUE+S/q6rFr
	SiSfO78OuuPyBzkC8314zkcMUzkK/+mFXOZtYDMqgmF36GuYfuIJLyQXPqZvST2t6tI=
X-Gm-Gg: AZFdTZdWFg1IUDpJaxLlQRyiyr/RzvWGLO32NChrIUH1RHldI85RfSewBdbQd6hXkMz
	w0mZYtk/dHw5HXkRVm0eDJWXPF85QvManePXvugYgjn/5m55CiONz/eoXFxSWLMZejSLAhPuJfB
	1LT8hqzlxMB2Ur2QGs4oFfP+LgUZxsVnJe8aph1bjd1PqQU089xBSfIAkcbB26g0nKlVgnbKIqt
	DYzObwdq7OUlgUz66rBqt/KaU2npM7NhJH1EOcMJPoJq1FjOkfRStsOspepHvmc+/4ieTjx9uUO
	Okyp3BbMubxRuzAYMbvk8avATDS1aUuTKnYTjIa9uahlfYE9NxO/i/my+a7Prof6DNyNuEcNWwj
	sMHbSStzCywwULuNSFwCZmOctitfIWI+SSi7lbIwpoeflRqrRtfWJh7HNojMlfT18cdZZNE2e2h
	ra0KK/kpJ85ST63BJJapwzXIIZwPr8HDNbc2kSKQO+D4Ro7z0gNwepi4XazXODBIjH3nYlNwArW
	y2Bzdn40C0UwIcO2Ei7nEFkexiO34KHEbu0sCAWMiOmx49ZjjA+/oj/xLzGoFnti6wAL7+qqZhA
	cRGrpGhWXtIBtFft525l/clNh7SF5VVi9gh9W3Mdms0fZXdPI14=
X-Received: by 2002:a17:903:298d:b0:2f0:3dc0:9bbb with SMTP id d9443c01a7336-2f03f2115e7mr162175365ad.34.1795736626027;
        Thu, 26 Nov 2026 15:43:46 -0800 (PST)
Received: from fedora.tailc1fb0a.ts.net ([172.219.65.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f0bc695f31sm52493035ad.49.2026.11.26.15.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 15:43:45 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH] sh: Kconfig: remove trailing whitespace
Date: Thu, 26 Nov 2026 17:43:43 -0600
Message-ID: <20261126234343.74235-1-artem122novak@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove trailing whitespace from Kconfig entries and help text
in the SuperH configuration files.

Signed-off-by: Artem Novak <artem122novak@gmail.com>
---
 arch/sh/Kconfig        | 6 +++---
 arch/sh/Kconfig.cpu    | 2 +-
 arch/sh/boards/Kconfig | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 5512f446eed1..aa579aa041b5 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -234,7 +234,7 @@ config CPU_SUBTYPE_SH7201
 	select CPU_SH2A
 	select CPU_HAS_FPU
 	select SYS_SUPPORTS_SH_MTU2
- 
+
 config CPU_SUBTYPE_SH7203
 	bool "Support SH7203 processor"
 	select CPU_SH2A
@@ -485,7 +485,7 @@ config CPU_SUBTYPE_SH7366
 endchoice
 
 source "arch/sh/mm/Kconfig"
- 
+
 source "arch/sh/Kconfig.cpu"
 
 source "arch/sh/boards/Kconfig"
@@ -608,7 +608,7 @@ config GUSA
 	  This is the default implementation for both UP and non-ll/sc
 	  CPUs, and is used by the libc, amongst others.
 
-	  For additional information, design information can be found 
+	  For additional information, design information can be found
 	  in <http://lc.linux.or.jp/lc2002/papers/niibe0919p.pdf>.
 
 	  This should only be disabled for special cases where alternate
diff --git a/arch/sh/Kconfig.cpu b/arch/sh/Kconfig.cpu
index 336c54369636..4f03b29c7b16 100644
--- a/arch/sh/Kconfig.cpu
+++ b/arch/sh/Kconfig.cpu
@@ -2,7 +2,7 @@
 menu "Processor features"
 
 choice
-	prompt "Endianness selection" 
+	prompt "Endianness selection"
 	default CPU_LITTLE_ENDIAN
 	help
 	  Some SuperH machines can be configured for either little or big
diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
index d89b74177233..99fc5183e2fa 100644
--- a/arch/sh/boards/Kconfig
+++ b/arch/sh/boards/Kconfig
@@ -36,7 +36,7 @@ config SH_SOLUTION_ENGINE
 	select CPU_HAS_IPR_IRQ
 	depends on CPU_SUBTYPE_SH7705 || CPU_SUBTYPE_SH7709 || CPU_SUBTYPE_SH7710 || \
 	  CPU_SUBTYPE_SH7712 || CPU_SUBTYPE_SH7750 || CPU_SUBTYPE_SH7750S || \
-	  CPU_SUBTYPE_SH7750R 
+	  CPU_SUBTYPE_SH7750R
 	help
 	  Select SolutionEngine if configuring for a Hitachi SH7705, SH7709,
 	  SH7710, SH7712, SH7750, SH7750S or SH7750R evaluation board.
@@ -56,7 +56,7 @@ config SH_7619_SOLUTION_ENGINE
 	help
 	  Select 7619 SolutionEngine if configuring for a Hitachi SH7619
 	  evaluation board.
-	
+
 config SH_7721_SOLUTION_ENGINE
 	bool "SolutionEngine7721"
 	select SOLUTION_ENGINE
@@ -95,7 +95,7 @@ config SH_7751_SOLUTION_ENGINE
 	help
 	  Select 7751 SolutionEngine if configuring for a Hitachi SH7751
 	  evaluation board.
-	  
+
 config SH_7780_SOLUTION_ENGINE
 	bool "SolutionEngine7780"
 	select SOLUTION_ENGINE
-- 
2.56.1

