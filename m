Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED823491E8
	for <linux-sh@vger.kernel.org>; Wed, 29 Oct 2025 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755636; cv=none; b=amjblBox9b5sJJ4jrJDvLTKQuau5WlGw0s9iC7PzLnWNbvqnEMhqStlSL6rgPcxeSBzuLeQFaPK3nKVhiL53oNmRC2yS9mv7AWslN40M6jqysYj6DQ403HlM3iAoFmKuNzeNFIVMFio+NhnBUMOSvnP177nOOcew41mJHamdv3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755636; c=relaxed/simple;
	bh=x/c8Gau2O3gfj3+358hMm8pmNs7v1wm+QbURDM7KfoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CjFWprSzjDK/QWGxmHpFVTh5atK0RCsj3qqpkmJnVC4oEhzx+E1Ddz4PpfoPy37ssFBGdfYJ1fd38MDAqKvEtIk4g8LQL8U4bLISU+2eO2h4OTdvJJq19/JoA4J/6CnzPFzRa8kg0z/V3CM4CENw19R5jLzADzEVwVgdoRzoP0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPTPgjgT; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPTPgjgT"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b4aed12cea3so12340066b.1
        for <linux-sh@vger.kernel.org>; Wed, 29 Oct 2025 09:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761755632; x=1762360432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3ZWzIw+tzavBMOmDgztL9+WJKK3w3KSDq6YVOazGFI=;
        b=nPTPgjgTOV4QvNiw767EkPXP8nZH+vMB95IK/uUyEapExC1xYDWPM9TY7fbFAnRlyR
         5go9001Apeiz1bCEoM9ktB19pnCqBYoMUiyerZmB97OscW9O+xPEWD3Y6x1trevTW6Gl
         gtcCynIa2cisxbIx6H8ZplCo7ErSv7aVeY2Jmyd1HkESnUSaaT5C6jz/K9oiV202/a/O
         ZCLReL5xckIEkVq8agGcgTNlA51Si/lOJzd6MVTxeioWIsLWGosNJ02BzgImHOjNw+nS
         ckb+/uuvh3BfuFZedwV9ZcgQrZ6O8PkRxXJZ+nnx1vURNkUTUuBoe6Rt32URkixI8fci
         PCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761755632; x=1762360432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3ZWzIw+tzavBMOmDgztL9+WJKK3w3KSDq6YVOazGFI=;
        b=oYgJ/p04W1lINzNsxnPHPorSjEVEuCES85GealR45lp69cGkzlDzZxaHU6+zRGzRue
         UiKSZfFZjjWs0vuLGh5g1a9qpgXxEkt9W8HpItZsk2AOKVvLO8NvWrAC16vR4PFwn1rZ
         7tjeczhHJBknC/W1hqY6XkW+KWFoh1oq8wQb+U1MN5ovoHjl0l46HKftM5PTBwwryIF4
         52fux07BVADwwRqXCLCfjaZ3KtRfO203HQqG+Yurh4F16gVvv4SP1emBu7+lLmsISV1X
         JzY4UG76R/mS07OC/pdL5iYSVxCWoBoB+PST/eE45qJv9Msk2LnXTq5ERkoNRIvnUZKY
         t35A==
X-Forwarded-Encrypted: i=1; AJvYcCXMJypfLApjE3DzKQw8M3R6ANA2Q6/6J71DsRXgI4KoGTTTt/df0hzmchPrgw3Y8oDu2i0Hn3hdnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPWd4g8ON2LoBk3d4SeSnVUyMXws0FtWBfAFfzMK9TWQ2tHS1k
	cSMieWn1/+knj61lgDMglildP+lRY0Ea2PgyS+yh5krEh+zAP7QwzC5a
X-Gm-Gg: ASbGncvyU3grooUvIPqFJuMXxL2FIjseQHtH/Psx/5ZjggdMBvN+l/RYO8WJNZUbw6u
	+k7JHS19kh/SkFhr9hIFAFcj0dLyEYb4qrdq4j9WJuIMsvXfNplzCgS8ACsZMrdJz0ig9mmVC85
	Imqcd1xsb4ZlyrRK9EDg9xsAiVDHW33quSjZbBEhnIahVus/0wiN6wPpjRZTlwIFUhWtZGx9don
	9yCMBXtNwg96n4qBVfg9kgQjEtf/DTv2vBfcQbj6ErP6u9DwYViWsCVtMQ7dhifn11rr2RTHqum
	T6m2aj5m/HWqxYUHwLsjEskXjgWGhTC+XZWrZpzNjtgN+NpCnThScM9EyKIUQdyIIazarJ7VbDG
	CyOzkIOkq7RwE08zDsxFC6r49fYPeSApFF2ObYYgBXH1EMU1EXPB9EYO187IhwZxTpXWpXIicYC
	jYwQ62r2v/TRpNR1wOLEWEveBzHvqVdOodc/TcOWwIrmFZPC+QKT9bYUErvEq3ZPWSGYtq
X-Google-Smtp-Source: AGHT+IHRieiPBGU6MC5P5jZHI6G/6PD4P6RVg3Iggx9u+yanu4koYZOv2T4MUr84z07ifr1PiVwzxA==
X-Received: by 2002:a17:907:3da4:b0:b6d:8da0:9a24 with SMTP id a640c23a62f3a-b703d2dc3fcmr322653366b.9.1761755631652;
        Wed, 29 Oct 2025 09:33:51 -0700 (PDT)
Received: from localhost (p200300e41f274600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f27:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b6da1e2226fsm1067814666b.20.2025.10.29.09.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 09:33:50 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-mips@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/7] clk: ingenic: tcu: Use contextual data instead of global variable
Date: Wed, 29 Oct 2025 17:33:33 +0100
Message-ID: <20251029163336.2785270-5-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029163336.2785270-1-thierry.reding@gmail.com>
References: <20251029163336.2785270-1-thierry.reding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>

Pass the driver-specific data via the syscore struct and use it in the
syscore ops.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v3:
- adjust for API changes and update commit message

 drivers/clk/ingenic/tcu.c | 63 +++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 33 deletions(-)

diff --git a/drivers/clk/ingenic/tcu.c b/drivers/clk/ingenic/tcu.c
index bc6a51da2072..8c6337d8e831 100644
--- a/drivers/clk/ingenic/tcu.c
+++ b/drivers/clk/ingenic/tcu.c
@@ -53,9 +53,9 @@ struct ingenic_tcu {
 	struct clk *clk;
 
 	struct clk_hw_onecell_data *clocks;
-};
 
-static struct ingenic_tcu *ingenic_tcu;
+	struct syscore syscore;
+};
 
 static inline struct ingenic_tcu_clk *to_tcu_clk(struct clk_hw *hw)
 {
@@ -332,6 +332,29 @@ static const struct of_device_id __maybe_unused ingenic_tcu_of_match[] __initcon
 	{ /* sentinel */ }
 };
 
+static int __maybe_unused tcu_pm_suspend(void *data)
+{
+	struct ingenic_tcu *tcu = data;
+
+	if (tcu->clk)
+		clk_disable(tcu->clk);
+
+	return 0;
+}
+
+static void __maybe_unused tcu_pm_resume(void *data)
+{
+	struct ingenic_tcu *tcu = data;
+
+	if (tcu->clk)
+		clk_enable(tcu->clk);
+}
+
+static const struct syscore_ops tcu_pm_ops __maybe_unused = {
+	.suspend = tcu_pm_suspend,
+	.resume = tcu_pm_resume,
+};
+
 static int __init ingenic_tcu_probe(struct device_node *np)
 {
 	const struct of_device_id *id = of_match_node(ingenic_tcu_of_match, np);
@@ -430,7 +453,11 @@ static int __init ingenic_tcu_probe(struct device_node *np)
 		goto err_unregister_ost_clock;
 	}
 
-	ingenic_tcu = tcu;
+	if (IS_ENABLED(CONFIG_PM_SLEEP)) {
+		tcu->syscore.ops = &tcu_pm_ops;
+		tcu->syscore.data = tcu;
+		register_syscore(&tcu->syscore);
+	}
 
 	return 0;
 
@@ -455,42 +482,12 @@ static int __init ingenic_tcu_probe(struct device_node *np)
 	return ret;
 }
 
-static int __maybe_unused tcu_pm_suspend(void *data)
-{
-	struct ingenic_tcu *tcu = ingenic_tcu;
-
-	if (tcu->clk)
-		clk_disable(tcu->clk);
-
-	return 0;
-}
-
-static void __maybe_unused tcu_pm_resume(void *data)
-{
-	struct ingenic_tcu *tcu = ingenic_tcu;
-
-	if (tcu->clk)
-		clk_enable(tcu->clk);
-}
-
-static const struct syscore_ops __maybe_unused tcu_pm_ops = {
-	.suspend = tcu_pm_suspend,
-	.resume = tcu_pm_resume,
-};
-
-static struct syscore __maybe_unused tcu_pm = {
-	.ops = &tcu_pm_ops,
-};
-
 static void __init ingenic_tcu_init(struct device_node *np)
 {
 	int ret = ingenic_tcu_probe(np);
 
 	if (ret)
 		pr_crit("Failed to initialize TCU clocks: %d\n", ret);
-
-	if (IS_ENABLED(CONFIG_PM_SLEEP))
-		register_syscore(&tcu_pm);
 }
 
 CLK_OF_DECLARE_DRIVER(jz4740_cgu, "ingenic,jz4740-tcu", ingenic_tcu_init);
-- 
2.51.0

