Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE1334F246
	for <linux-sh@vger.kernel.org>; Wed, 29 Oct 2025 16:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755640; cv=none; b=HKoVTNoGSmTo7iSqsWtXOb7gkbDz+fyC5rJOaLcvqmJV/q4z9ovgUg2U625qOMDuVSw50q18VkMfDX7dxTYwOCtCqCO5Zq7slwCHoQJ02ObvEoqRiYIV+/qtVWVEqNy/6OOxEytkPKd0Oh47XZGVy9NKZAhtRSDUauMkp7S8i4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755640; c=relaxed/simple;
	bh=KUSAVjewTwFiW9VLR1yzUFBIzCxCjea5cQlqAAL9Lys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MfGVsqpkG9uqHyoHWf9TNUSbiaeMYwrCBW19ZC5ouDYoRkePv+9SMbG8A8SPVhqQWyDA3E0KikDJg3Ch+reGTpka2x8UwDeBtUlYViEi7Qous1e28Zw9zEZVuZOUdTmCk/GWTm5MW8rpETAZj0ehAxGWPy+AiTSp1eTHtbiL3Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSdr/5bv; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSdr/5bv"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-63c21467e5bso6152049a12.0
        for <linux-sh@vger.kernel.org>; Wed, 29 Oct 2025 09:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761755636; x=1762360436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhxpRTp1uOQ7/yJc+0xNuSmcJdpaGHV/pw/kDcH2Yfg=;
        b=lSdr/5bvX4L9Id/q8FSipvEwyetUWz4WBkeyFYVVVBlPnTV0rwAUOnpEDqL/+tXuVS
         GWLtaRaqPNWhScrtCqGSSZ98mmwDjO+WvH7T1yO8nP9q1FAMPcGqOuObAHYfNdZF0+9B
         bXXAVe9Cozlc9uzmQ8teNiGwlXYryaqB1D731+cUoqfSp2P6yQKgQ1UXp7UAWaPfZGSv
         RSMgbmZdoi+3AXqfLwumOuYWEKwtFi4b8lc6qU/xzrKw8n2zBAOlOBCcIWQcs4HF4ep1
         /IDVCbq9wBw+RZUO8VY9DM/HQ7eVcmMHMiy9uH8+dZk4CV4dt+fw1/fa2fb9mMMDBdqD
         bktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761755636; x=1762360436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhxpRTp1uOQ7/yJc+0xNuSmcJdpaGHV/pw/kDcH2Yfg=;
        b=cPS25leWvz2tIvYtgMni6tyLq84HoFFokHBI9Gy22IW6IUqfUNhE6g4PqlxxYtkTvj
         lC2RU0ePUS15QZLWY9xcqpfpF85PDj4L88TmRQguYjnLUaIfU6LOsQ1KigyILQ21jq/5
         oj1hZq/cMNfqUe085E5PhZYj1AcPf5s8YUVu9v6sKxj2PdTymJqj9X56jMXbC/jE8m/Y
         Kr7f+zVoi0p7EmUQPaPHUvkSNDfbr7Mhk+hy76wx7bjaWkbD8XK6Gc4J7plGniZUKq25
         GtENACsBSX9dR5yB1JWk2Cc2PTAEjjYZGPh1lubHZXhChutnjkIg+4e2A9bUOeSk0esX
         8ACg==
X-Forwarded-Encrypted: i=1; AJvYcCXlawx+cEDqhLNdK5O5ue8msPXsZvOgOHytruGBFEhcYSb/rTblkEpveDCJXflrMeWgIflP77IlPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPyMfrB5RVRbIV6aC4w7uAF1fPNKXrzv0GZtOad8UVOH6ELLru
	vh1/1CHOlzYtfm5SfRhQ1DdrMJoyTrdBm1JKl8BYqlD9a4ddD4qrX+Qo
X-Gm-Gg: ASbGnct57NaGmlQ1opx/+i2VkNFpzUAffr14v/kuw7yHWlEQ9HKDZ4QTYUmk4L5ciEn
	HV44tYTSVd+T6BktRP9EQTVt1Ag66y/bJGg4eM05NfYnuaVPd0/CbMWEUqPuxVjeRGeeTXa0S78
	sIl2b+rzQ1tM8qbaM5QVWWhIOfotyJuoaroaBKowEuJ2K6/BH84dKeEEW5TubCnuxuO9tvav4Zg
	XcSiTZ54asb+x4SFbtIs9slyt3VVWiOpRaRdBzmOQaarb08qhitYx7daCZ5lyIcgxXXBktkbSQ3
	oCIBvaTI/4tDMgCqUWGBfUS6kW4U2D7yko4upm4BDSdon2+q7wHX6m36p5GoAmL3z5BKcYRRczW
	goQvv6N5v08kkafnye4RJPhn5+QV9Osk3q/NSxdz6c0NS7X6KZLKbMbn2Ma3DH4br3dLZpQ5Fnj
	naUkuhw0ppeJ+9VfUjt67dSwwBuAFuJxfUNq4GM5bhXm4V9z9TnjrpQZf9rKAeSSvkEilC
X-Google-Smtp-Source: AGHT+IEBhKyqSuQzRg5+jPbNr1lJJJfXBtMjYTViFyDgVE4pc7ia4Gu9caVkoUUyuihmK5MM+ILYDA==
X-Received: by 2002:a05:6402:5c9:b0:62f:50ff:b675 with SMTP id 4fb4d7f45d1cf-6404437f5a7mr2656312a12.33.1761755636037;
        Wed, 29 Oct 2025 09:33:56 -0700 (PDT)
Received: from localhost (p200300e41f274600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f27:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-6404de640fcsm1695354a12.8.2025.10.29.09.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 09:33:54 -0700 (PDT)
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
Subject: [PATCH v3 6/7] irqchip/irq-imx-gpcv2: Use contextual data instead of global variable
Date: Wed, 29 Oct 2025 17:33:35 +0100
Message-ID: <20251029163336.2785270-7-thierry.reding@gmail.com>
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
- remove unused global variable

 drivers/irqchip/irq-imx-gpcv2.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index 04f7ba0657be..ebfc659af385 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -19,6 +19,7 @@
 
 
 struct gpcv2_irqchip_data {
+	struct syscore		syscore;
 	struct raw_spinlock	rlock;
 	void __iomem		*gpc_base;
 	u32			wakeup_sources[IMR_NUM];
@@ -26,8 +27,6 @@ struct gpcv2_irqchip_data {
 	u32			cpu2wakeup;
 };
 
-static struct gpcv2_irqchip_data *imx_gpcv2_instance __ro_after_init;
-
 static void __iomem *gpcv2_idx_to_reg(struct gpcv2_irqchip_data *cd, int i)
 {
 	return cd->gpc_base + cd->cpu2wakeup + i * 4;
@@ -35,14 +34,10 @@ static void __iomem *gpcv2_idx_to_reg(struct gpcv2_irqchip_data *cd, int i)
 
 static int gpcv2_wakeup_source_save(void *data)
 {
-	struct gpcv2_irqchip_data *cd;
+	struct gpcv2_irqchip_data *cd = data;
 	void __iomem *reg;
 	int i;
 
-	cd = imx_gpcv2_instance;
-	if (!cd)
-		return 0;
-
 	for (i = 0; i < IMR_NUM; i++) {
 		reg = gpcv2_idx_to_reg(cd, i);
 		cd->saved_irq_mask[i] = readl_relaxed(reg);
@@ -54,13 +49,9 @@ static int gpcv2_wakeup_source_save(void *data)
 
 static void gpcv2_wakeup_source_restore(void *data)
 {
-	struct gpcv2_irqchip_data *cd;
+	struct gpcv2_irqchip_data *cd = data;
 	int i;
 
-	cd = imx_gpcv2_instance;
-	if (!cd)
-		return;
-
 	for (i = 0; i < IMR_NUM; i++)
 		writel_relaxed(cd->saved_irq_mask[i], gpcv2_idx_to_reg(cd, i));
 }
@@ -70,10 +61,6 @@ static const struct syscore_ops gpcv2_syscore_ops = {
 	.resume = gpcv2_wakeup_source_restore,
 };
 
-static struct syscore gpcv2_syscore = {
-	.ops = &gpcv2_syscore_ops,
-};
-
 static int imx_gpcv2_irq_set_wake(struct irq_data *d, unsigned int on)
 {
 	struct gpcv2_irqchip_data *cd = d->chip_data;
@@ -279,8 +266,9 @@ static int __init imx_gpcv2_irqchip_init(struct device_node *node,
 	 */
 	writel_relaxed(~0x1, cd->gpc_base + cd->cpu2wakeup);
 
-	imx_gpcv2_instance = cd;
-	register_syscore(&gpcv2_syscore);
+	cd->syscore.ops = &gpcv2_syscore_ops;
+	cd->syscore.data = cd;
+	register_syscore(&cd->syscore);
 
 	/*
 	 * Clear the OF_POPULATED flag set in of_irq_init so that
-- 
2.51.0

