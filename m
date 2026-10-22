Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792651189;
	b=oD7Riof8RcPugTpB3ERkFApqIAQUdn3cqTAAqX8PKYTZ8HfpuJLCoDfX7uqNdKDKxhpK
	 QV3MdebilbwXsnEh4NjYd1tAxuyV2cNTg1EqBtWEuY4+tDQupj80c75952ek+kJ182IC2
	 c3QKWo1ER40OIhoedVxkdj7vLbj2ER1p0HythAXg0Z4xTHYKIQvOm0yo/zUrli4gFH93W
	 lffevAh+6avuqg46vtgLHIQLf8rRThAosVFhvLDDcx5NOgQ3fB2LVzbeGg27USc781qGu
	 RliuVZ5lVpxGVzg+3ExqWH1jrYO3W4Fmx+bYqXi48ersd846jW80SfYCV9o/kYoCguw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792651189;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=F5xNpfAD02cdt0fNkq//IluH1XyFdn8v8eKHcwoQ9gY=;
	b=WhWcLZhmFNH11mqjLNzmZMWX902qtH3r2FEtb6s60aTsjwTxuRxUWWJHEQYY3GJ1OLpV
	 cjwf9F3ZIFwPEIRuPLYslN1et0RrWX1TdisFPgUpNEQNV2ODknWYaExDysja3bGQM1K6x
	 JiQXvBhyRtI7aWiS7Lhhzm8iE8QykuS1qwb0pWOjReo5YEHz6DstpO5yQIOCgamVfbcRz
	 vE0IUg5kHWHmSV65uWnW9c6F5I2vBmWtuNPX5F7ivRL1o6jvarDNnbJy8qgVMtGLkXABU
	 ZlouxbaAr9dNwf+Q88HTIk+LC83FMP+JHbY1wUwIXLvIogm/sgFeUgLM37lXrq6SHlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=S+FhUgHa;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879C8606A322
	for <linux-sh@vger.kernel.org>; Thu, 22 Oct 2026 06:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 879C8606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=S+FhUgHa
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d577so1312851a91.1
        for <linux-sh@vger.kernel.org>; Wed, 21 Oct 2026 23:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792651189; x=1793255989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F5xNpfAD02cdt0fNkq//IluH1XyFdn8v8eKHcwoQ9gY=;
        b=S+FhUgHa7+uJvTERie8Eh+msu/qTG4smFNLP7wCxYwDWhkeJbRRuAkaHCtBDkN2fEL
         vTIyTesqVTz5mj+Kj5pqX2in9paYHMVI31pf+KR6BhS80h24s94OxeoGHU1EhzUzCD4v
         1bYTBaxHGRJNNe4kVXyokdUyndbRv+JcWmgi80V8XhMtZK4rcxdsHVh2HHE460qnLyZZ
         m0BJm0oSk/veJuxGfR31bNOzusliR9hLo1FznTK9+BFpAsDjaLnBbkt0nvzhgdYkvF+9
         ef1XE6lJv215fO7aJDmVWCGij9Jormnc4lhs5dvnaOj+FxvzBPK6fQVvKQyBSBJXVUoe
         U/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792651189; x=1793255989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F5xNpfAD02cdt0fNkq//IluH1XyFdn8v8eKHcwoQ9gY=;
        b=haUHOPGOMfB+HOgpmcx9v8uDSVFIHNja+oD6ObXvf5LpDhp2LlPxj+an2y3dvhY9Nu
         2hLL3aaShOPrD1J+NskJ1UXNR3qITpeWSY/9YVelURb/4clUU/78h7/cZRT5twq/D50y
         Fv2oR2uZFF9Jsg/Lpv/8VbzPkECPhLa+WCp4AULhi9G0KPht2HYdscNlY79dHop9vB4P
         8/8DVGhtSMjvobga84EElB6RxH98W6yVLUd9hKbNXJDO0QaFoFC17edIF9ylPQycxl0j
         nm5144uR5n8GBUZltbx5/rGEqlFgH+bNFNbgjzWeGaDwbp0kya77jDj2fP9lAe4G2pWC
         t/8w==
X-Forwarded-Encrypted: i=1; AKwUvBwNXg/2qi64jyslKzlYvQx6YytWqJAswDazNst23f5EYyX42tawY9UUZqwxQJFpupM8aXZTSS3eyQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIxM+e08C3k03yArLIHhPWPDQZX6WftvJN2TnY8pRzs7PAaXIe1
	Owg+AhUPVOyJXFEEk3owcC+ALVirOXSBFbDrCjcstLf1/44HgUZ6xppH
X-Gm-Gg: AYBFou0slfJ7v3hcN/WbpLN26Vk4oilNE/NPKv/8xUxfv7R2ic7ErytYzzWYJAv2Je+
	yZbI2ZyvCebbSE0fYwV/peZuKUwLAyV7wzIKORpXqeSNoXurnGeaX/Q6EGjmCQEd7Of/RZ8FE/5
	v4bpI4J3aRkSsY5TCaR/OnFAjsa3CIN9zbc0AZOOVqZs/5JIBC6XszjfvuMKJLefmqlUs9VtyHm
	NBnlWIUymfBHpWbe3nB2wnOzaosFX/h4Eq68s2s7Iz2lYlGUhelrV/K3pEgNTnsqNZ/6ZrZ4IHs
	qowWaQaTajvewvJMSo7P9gyZxxrqvH6zbafmf2T9a4rWagzb4f7vULFh2jjD0VMAaG6j+SFY02Z
	LT3/wyznCB2XZVzf+wAqtoH9i/gZGFr59mc9cY65HeRjpLXMqN8ZEEO3CLg3lNidY6JNsLUJvp7
	6pHZ1hYqg5t/YAdQ56+a40Tk4hI+nO8ZfzLwthzn6ZceIUf/yUgeKe+jaBWLABrxb06VY+WFA0k
	y5Yaj6HV0MZ5hdQE79wIs/ec9XmD+KeQIXRs0y5xytlyrFySnv0bmXEx5Yxud/K2l8w2lRUkW/s
	H+gbmbv8dM0LwA==
X-Received: by 2002:a17:90b:17c5:b0:3ac:adce:60be with SMTP id 98e67ed59e1d1-3ad86f44ed6mr4102493a91.21.1792651188958;
        Wed, 21 Oct 2026 23:39:48 -0700 (PDT)
Received: from archlinux (d173-183-236-7.abhsia.telus.net. [173.183.236.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada4887669sm2784741a91.2.2026.10.21.23.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 23:39:48 -0700 (PDT)
From: Artem Novak <artem122novak@gmail.com>
To: glaubitz@physik.fu-berlin.de
Cc: dalias@libc.org,
	ysato@users.sourceforge.jp,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	geert+renesas@glider.be,
	Artem Novak <artem122novak@gmail.com>
Subject: [RFC PATCH 1/2] sh: dts: add Casio fx-9750GIII board
Date: Thu, 22 Oct 2026 00:39:35 -0600
Message-ID: <20261022063936.472520-2-artem122novak@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022063936.472520-1-artem122novak@gmail.com>
References: <20261022063936.472520-1-artem122novak@gmail.com>
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

Describe the Casio fx-9750GIII graphing calculator, which uses the Renesas SH7305 processor.

Added the board Device Tree and its DTB build rule.
The description uses existing SH7305 SoC include
and affirm the calculator memory region.

Signed-off-by: Artem Novak <artem122novak@gmail.com>
---
 arch/sh/boot/dts/Makefile       |  1 +
 arch/sh/boot/dts/fx9750giii.dts | 15 +++++++++++++++
 2 files changed, 16 insertions(+)
 create mode 100644 arch/sh/boot/dts/fx9750giii.dts

diff --git a/arch/sh/boot/dts/Makefile b/arch/sh/boot/dts/Makefile
index d109978a5eb9..4887fb16dbf2 100644
--- a/arch/sh/boot/dts/Makefile
+++ b/arch/sh/boot/dts/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
+dtb-$(CONFIG_SH_FX9750GIII) += fx9750giii.dtb
 obj-$(CONFIG_BUILTIN_DTB) += $(addsuffix .dtb.o, $(CONFIG_BUILTIN_DTB_NAME))
diff --git a/arch/sh/boot/dts/fx9750giii.dts b/arch/sh/boot/dts/fx9750giii.dts
new file mode 100644
index 000000000000..bccae22e4899
--- /dev/null
+++ b/arch/sh/boot/dts/fx9750giii.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2026 Artem Novak
+/dts-v1/;
+
+#include "sh7305.dtsi"
+
+/ {
+	model = "Casio fx-9750GIII";
+	compatible = "casio,fx-9750giii", "renesas,sh7305";
+
+	memory@8000000 {
+		device_type = "memory";
+		reg = <0x08000000 0x00080000>;
+	};
+};
-- 
2.56.0

