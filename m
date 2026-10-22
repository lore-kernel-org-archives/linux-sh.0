Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792645833;
	b=yx4bD50jZWRgUtrbYURgjYULY4DCbL+bsEAu3OiPm+xaW2yYXkLSuDC69TjEdMFORBeL
	 J7QAILBhoKHp3Sc7R1YiNHfhpBToc5y3SlhWBGBOQl8dyStUGkDAC0MPE6wtYblXJa/TP
	 2JOZ5hwD5hPYWZIFJBPUknzHosDt4UWdNUB5VjIxTnAbjCT+ifJUDy8K3MEY5L3LHLfGb
	 76zGgwrT1jxWlt3KSlaQGWT2ZCKDhWi4ILPi+oI4B2HpuFMvUcOrV1qfgVsLtHqdO6hqM
	 0vfyefCcY4wpDkrQJShVW8fvyOlx0XhLnZHXigztUFMA8oWyIsvYg02OGjVvn1SIrrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792645833;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=d8YT79KohHQd4B1gwgaLu89B/DI46ezv+k6nEUESdQA=;
	b=I2SDV9hCD2wgyYqs1Csd+U6r9fRNj4U1HLDWPNJ0+VFyqTFapVpdQXcFD0uUk/bOLNI2
	 EWqKjeIyPdg7L4ZHO0HVahhkN1rCLpw4+R1O+ToshLf24aY1VrXj7FvQ+UxzgJt0D3YOs
	 sTu342gwU/yUvgJpUIU1RImqywKWlfMdmRaKXlfucqpLPHDUsorTVCdR6LP0Cusp0R8dU
	 7kncZWx3xyMZ6t0Zq/ILd7pP0KGTvu3DgMOp7lODX/2t1jx/dZ5XNX8t2wzWC4pFXwuje
	 fb3K6Xo6Y4g70SW3tpPBNs7KhDiUCaA2xofQTUVnOzVYoqFkB9D82fZwID2/ILkIszA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gspN8Xft;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD095606A31D
	for <linux-sh@vger.kernel.org>; Thu, 22 Oct 2026 05:10:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD095606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gspN8Xft
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e942864693so7298495ad.1
        for <linux-sh@vger.kernel.org>; Wed, 21 Oct 2026 22:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792645832; x=1793250632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=d8YT79KohHQd4B1gwgaLu89B/DI46ezv+k6nEUESdQA=;
        b=gspN8Xftp3Q3k5OTLrZQTRdqCMZyQBiLvK6Mt3/U5g1kLrg0bvWUSaF6kCODhEm8Fy
         bKo+kni2CMkkD9FsKX0bCO6w6haGJOqlThLUZvi2urRKymlOeRQ6T7xw1fzeUfmAqGeJ
         2r0BoQpXwuy2ysil5Z5985WdGoyz0bZNGjmJ7n569O0bfX64xIp+3SvDe+8dzcYvLk2I
         Bidy+rXewHjAcGvuX+CSOz/xtKN45cjUrxUNUUt9cInHQJcA0CRJcTZd/J3Wzh59FhM6
         vtPBTw76MNsg13wG2AgB/OI2xGkc9wLkW1mJaJOlqGqCzv3hP6VrHd/EfgSlzgDQa1lD
         Z4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792645832; x=1793250632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d8YT79KohHQd4B1gwgaLu89B/DI46ezv+k6nEUESdQA=;
        b=Ef0fqRduqsPTauKHfLfkx0axroIl97uSXUMDxQts5O32tZB4jNqnHJ676fRfLcIFGg
         TZQPeTyl51/bWRlPpBkaMdYzFPmmQ/Vdt0ecpUqiYk4Gm//KVEPfk9LOHYblUfLF1GT7
         rYYcnuex4b4Ut6OhQ0kNM4ZM06y9eRiM0WveRywZ/JaQ+AFmSlgIu+BB1lA8KbEY3O6c
         S38orGhj9ucwjOStUZZ0+D7LfX0O4NU7KFZexgdpbJxkzCi9zwxFRl5bZsVWhqnl/lNv
         6kZCO50PbgJqXlaJvrtJweMRDFlEf+mI71jO2aTvw/JZCQRN/qc8WYfLPvkIzUUP0skQ
         5Tlg==
X-Gm-Message-State: AFq9FYJxEKc2EI65uh9FNcy1+izVCzKdIIak+Xwp1R8Bz5jMrahGf8l2
	4hd9G9slyRrENpyQdX53JvG9j6xg3u6gr2EDlFeNaiHuz8mH1rTB3Mvk
X-Gm-Gg: AYBFou2GxkEktCYVeUOP3DKtk9o9PCKv0+7RhFOGQxNm45cOuMiUA3EXxY/eE7gy4/A
	Wa6kOlr9DQ8QwBTTkYA254czLbjrmBfvnyL6m+uFKwISB/MMhS2MsDnhV6W4XH92MOm6QEiWkz2
	ibPFrrryrjy9pN3DtD2mtuQPw9yfzETfWmj7PwgEq8nIwADCbEzQObb3ygky9AFGyBqbZX6V8E0
	Vr4+X65cBDTgeBaFePFhdFnSz74Gued/a4+lMzQdu0PMgiQ878cybQuB3gf79Me3vLk240/rq+U
	ah7sWOX1M7iask4y21I07yO7nhIb1wc6YRJRIjt5FEtCVkQdTslqb+YxMdTUf0SX4iA9vHYYUxG
	OOziLv619OoN8AbU1RzKdI9/KPOdIdqXQvd7DBVAdZiC2IG/L9NBG7e2jZ/3YWJFr59zzGvXybQ
	3xULhV3qOAdUsV6dmHTnm4eia0zKMMYu2xpIdVgUm+XlYGQEqQ/dpZ1x99J86xmDUNG4pZBEWAC
	W+J1BCSRxdixL9Wvj0b783Kw8FK6sPuOvPTS4mPQHd2ealyTghRQhlIGKB4H3ZSabp0UT2qXvLE
	8vmUxlIsaWycjQ==
X-Received: by 2002:a17:902:da87:b0:2e9:9846:2da7 with SMTP id d9443c01a7336-2ea437a7307mr35411635ad.5.1792645832198;
        Wed, 21 Oct 2026 22:10:32 -0700 (PDT)
Received: from archlinux (d173-183-236-7.abhsia.telus.net. [173.183.236.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b486b20sm18260895ad.59.2026.10.21.22.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 22:10:31 -0700 (PDT)
From: Artem Novak <artem122novak@gmail.com>
To: glaubitz@physik.fu-berlin.de,
	dalias@libc.org
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH] sh: sh7305: add TMU0 module clock gate
Date: Wed, 21 Oct 2026 23:10:21 -0600
Message-ID: <20261022051021.322705-1-artem122novak@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Register the SH7305 TMU0 module-stop clock using MSTPCR0 bit 15.

Provide the fck clock lookup for the sh-tmu.0 platform device.

Signed-off-by: Artem Novak <artem122novak@gmail.com>
---
 arch/sh/kernel/cpu/clock-cpg.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/sh/kernel/cpu/clock-cpg.c b/arch/sh/kernel/cpu/clock-cpg.c
index 5b75a384cbf3..5a1f1479416b 100644
--- a/arch/sh/kernel/cpu/clock-cpg.c
+++ b/arch/sh/kernel/cpu/clock-cpg.c
@@ -16,6 +16,20 @@ static struct clk peripheral_clk = {
 	.flags		= CLK_ENABLE_ON_INIT,
 };
 
+#ifdef CONFIG_CPU_SUBTYPE_SH7305
+/*
+ * SH7305 TMU0 module clock.
+ *
+ * MSTPCR0 bit 15 gates the peripheral clock to TMU0.
+ * Early platform initialization enables the gate before timer setup.
+ */
+static struct clk sh7305_tmu0_clk =
+	SH_CLK_MSTP32(&peripheral_clk, 0xa4150030, 15, 0);
+
+static struct clk_lookup sh7305_tmu0_lookup =
+	CLKDEV_ICK_ID("fck", "sh-tmu.0", &sh7305_tmu0_clk);
+#endif
+
 static struct clk bus_clk = {
 	.parent		= &master_clk,
 	.flags		= CLK_ENABLE_ON_INIT,
@@ -58,7 +72,15 @@ int __init __deprecated cpg_clk_init(void)
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 
 	clk_add_alias("fck", "sh-tmu-sh3.0", "peripheral_clk", NULL);
+#ifdef CONFIG_CPU_SUBTYPE_SH7305
+	if (!ret) {
+		ret = sh_clk_mstp_register(&sh7305_tmu0_clk, 1);
+		if (!ret)
+			clkdev_add(&sh7305_tmu0_lookup);
+	}
+#else
 	clk_add_alias("fck", "sh-tmu.0", "peripheral_clk", NULL);
+#endif
 	clk_add_alias("fck", "sh-tmu.1", "peripheral_clk", NULL);
 	clk_add_alias("fck", "sh-tmu.2", "peripheral_clk", NULL);
 	clk_add_alias("fck", "sh-mtu2", "peripheral_clk", NULL);
-- 
2.56.0

