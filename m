Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02D534BA40
	for <linux-sh@vger.kernel.org>; Wed, 29 Oct 2025 16:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755638; cv=none; b=e8nQ9U9iI/IupcTVs0HU/mFXhwsnn2p8Tuava+BL2I7CpEYxIQx9O73E8OE5mNhkYAEAqhyLEONnQvUyZuGcqnup8DiNain9Wx5qEHLmuvqSfKcsPNJ5VJBo7dRyHYD+m/vXcJjGOuEMzUhb1tfZ/ZURtMLHtLjXyx0VvEoG+Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755638; c=relaxed/simple;
	bh=oprYoP8yymfB2u4RbgujgsNH+i0ZQOd4dygbCg75p/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBsUOvUoHjx45WZ09t5DyaEp72NQ8uPnMYkoYkH6Z+R6ON+zMIF8ZpYgjuYEls7Jnr+/rR4pNzp8/sUKKjM8KUqDcMOEQkKF9+i2kPu8DB9k7wYLQMpNPnajTTFXBkwSmJEeBfwlVkq97GYD2rn4ZOS48OLHsg7nIWCOewvL464=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ly00Kxs6; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ly00Kxs6"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b3e9d633b78so23512466b.1
        for <linux-sh@vger.kernel.org>; Wed, 29 Oct 2025 09:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761755634; x=1762360434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7niwucTDN3MnvT2f7z1+zCVDCBNmgQwG7r5182Kk6g=;
        b=ly00Kxs6I33Cts0szvsBGq4htnfjRKgDLfJgp+irQhH6eKg2aQ+FeYSXrktnVcZglE
         LS1X8DzpiRogsiDYx1QlAxeVNlePirHa2e0t8myHtbCX7sceXUAroMRjnaP7pZtJAbGa
         ZQzZ7QGt9Cgzf9F2250kNiJs2S8eGvhA39TaZ7wBXvUJagjjHROm1FCFEM7ezV7ijWgH
         yYqbR7ZF6gG5NFwzSbTizMHnnb6tYgQvX8/iw3UfEgYviyLxh7pJ1sBtoXpBN5ZZsY3J
         VUAZn8FHew4EfgiHNxME1+S8wmyvm3kKigBup4ENf8sONeuxDxeoy2tUw78yc1EHNZon
         eVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761755634; x=1762360434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7niwucTDN3MnvT2f7z1+zCVDCBNmgQwG7r5182Kk6g=;
        b=fW+8MhIpJUeVBzrrBfke9bMRuiDCXy7AEqKCBNNiuN4VvCK5aM02hUB10tzF+CZyV9
         BSPpHLc9ll/GkWZ1NSX0526P9xDQpZkWKP+vT1DRzb5CarhecchXNbtPKwSS3wUZrXXz
         yQQMA2vCp6/M05bHz+gbvnZDV+atUY74/m8AKIRkCSTGS7Wp+9aNGKt+TiSMNjWvddxC
         +zaajJjOIU7mwsX0fWFZdSuqWNBgOzSAFl5BxSbAouEnUMyEMV7ASY6kOmrVFVwDTSGc
         TKXwccG0sRk/gHJOFZwOoqVLqTi5rb09vR0E4XUZdVG9ZVK2W1Fdki5G0kpiaLmJFTdv
         lqdw==
X-Forwarded-Encrypted: i=1; AJvYcCVJhhae0QDVY+W9cdhtRXI7oq4Q06Uhtop+VnuU5ES49Uvtam/9jCeeVV8Zvx1FbkYNZjqqOEdi6A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/F/R1jKYovujHPt5IPko/vo2jXvSW28R2T2QMdLwVDfBh725i
	f9jnqN7mBcCO647Xac8ZO+X+WTmucfm5zWGUecmRRSxTg2kxeo3v78Gf
X-Gm-Gg: ASbGncugn17yl4ZqX6bFlsgH1JMAqZfGgs+AdDroNvmuw2GJPDrJ7nb+QsrXR//0Wj6
	hgJ1V/+9T48CFIqMx6HAslvqkYN3Pq3oTzyZ6g6c6QlOtl6oLbcctgqoaMESghamiefP2B2H4dC
	Z0rflM+IwwwfV2NHMYfnaYIu92ZoAy4z4Usuj+P8flaQiUCV12fFqyGAo8/zlM1Ub1f38WHMkfo
	Q5cbkSc0i8CHFgGMpX2frkUZleCEl5ZCKAREM354ePKFF1FYRcPxmXXbY+Kp6/4YyIzr1hUgUcj
	dMOwgdeCx3Ejhn0zZ3sWIZIJoad4BltJ+Dik/tuovOZMOdnJY/24dhVR4vMNCvUKZWtIwjthqGj
	+2q5IENS86mCW48QRoS470HYU2B/zgz9/u6JjKsWGHS3B1fNMaXY2F/LMIrS5B6Q/qkPYaPcXwD
	JpgZ4+SUNxFTQR/U3hn5i+tLLc8Qh8BjngzDyK4YDelCuvUg0bpS8c9szRYrt2vW6PwCQO
X-Google-Smtp-Source: AGHT+IGxst0GGPbE3zlpzuYvmZD7MtT+fgNns/2gbspQBUcAcExwpAJ9gNyBIh9hmr+9IwgchPtgzg==
X-Received: by 2002:a17:906:6a21:b0:b3f:f6d:1d9e with SMTP id a640c23a62f3a-b7051f278acmr28890666b.6.1761755633985;
        Wed, 29 Oct 2025 09:33:53 -0700 (PDT)
Received: from localhost (p200300e41f274600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f27:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b6d853696a3sm1468789266b.27.2025.10.29.09.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 09:33:52 -0700 (PDT)
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
Subject: [PATCH v3 5/7] clk: mvebu: Use contextual data instead of global variable
Date: Wed, 29 Oct 2025 17:33:34 +0100
Message-ID: <20251029163336.2785270-6-thierry.reding@gmail.com>
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

 drivers/clk/mvebu/common.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mvebu/common.c b/drivers/clk/mvebu/common.c
index 5adbbd91a6db..8797de93472c 100644
--- a/drivers/clk/mvebu/common.c
+++ b/drivers/clk/mvebu/common.c
@@ -189,6 +189,7 @@ void __init mvebu_coreclk_setup(struct device_node *np,
 DEFINE_SPINLOCK(ctrl_gating_lock);
 
 struct clk_gating_ctrl {
+	struct syscore syscore;
 	spinlock_t *lock;
 	struct clk **gates;
 	int num_gates;
@@ -196,11 +197,10 @@ struct clk_gating_ctrl {
 	u32 saved_reg;
 };
 
-static struct clk_gating_ctrl *ctrl;
-
 static struct clk *clk_gating_get_src(
 	struct of_phandle_args *clkspec, void *data)
 {
+	struct clk_gating_ctrl *ctrl = data;
 	int n;
 
 	if (clkspec->args_count < 1)
@@ -217,12 +217,16 @@ static struct clk *clk_gating_get_src(
 
 static int mvebu_clk_gating_suspend(void *data)
 {
+	struct clk_gating_ctrl *ctrl = data;
+
 	ctrl->saved_reg = readl(ctrl->base);
 	return 0;
 }
 
 static void mvebu_clk_gating_resume(void *data)
 {
+	struct clk_gating_ctrl *ctrl = data;
+
 	writel(ctrl->saved_reg, ctrl->base);
 }
 
@@ -231,13 +235,10 @@ static const struct syscore_ops clk_gate_syscore_ops = {
 	.resume = mvebu_clk_gating_resume,
 };
 
-static struct syscore clk_gate_syscore = {
-	.ops = &clk_gate_syscore_ops,
-};
-
 void __init mvebu_clk_gating_setup(struct device_node *np,
 				   const struct clk_gating_soc_desc *desc)
 {
+	static struct clk_gating_ctrl *ctrl;
 	struct clk *clk;
 	void __iomem *base;
 	const char *default_parent = NULL;
@@ -288,7 +289,9 @@ void __init mvebu_clk_gating_setup(struct device_node *np,
 
 	of_clk_add_provider(np, clk_gating_get_src, ctrl);
 
-	register_syscore(&clk_gate_syscore);
+	ctrl->syscore.ops = &clk_gate_syscore_ops;
+	ctrl->syscore.data = ctrl;
+	register_syscore(&ctrl->syscore);
 
 	return;
 gates_out:
-- 
2.51.0

