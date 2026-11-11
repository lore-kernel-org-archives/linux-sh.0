Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794359239;
	b=JOBmqO7nqQTRPqR6lyiGrXTA/TkF9osP14BSAl5l0FQ+1brC0VjqBSb/dO70o7enx0H7
	 ektsRu6wuEB6dBWeyCz15F38M3Y3r80SU6RTnTUSaVMRYQYaoYOlnGAMj2DP66H3ZC7xx
	 VPzz7clnU9AIsrIpl1Mg9/1XsCycEtySnWQ3tFzCbQXaDYhi0q3AbJ6Zum4qglm92OyAb
	 GVWXiNQiV8pekyaz5GNlVHOYS17417PIxm5IbVc/Gk2lm/+r7ctMaHp9w6xUWhB8xWs/9
	 EJtSl6MCQLVoJ3IdCFMA/qDTm1l/920Rlh8bnFxqXhSFSYJRhwkFbk+31VK+iGzCO+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794359239;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ToK+iR8w3wDaa5NXwZCWSs8d2l9SzJJLzelf57++HEI=;
	b=lSnNnPs5sNHwm0sGq/+hvprYXinpPadkseQyaoJT6l+Ii1fT2lTGleMN3BJMTzyFcxt9
	 o7B5OibmuSdOciTOtZZzKky38Dbp4C+aOe5BKi5nWWITJmRsQABZMf73R9lAHr3NjbcB1
	 BqdsllTrvpA9lNZ7iFacuXK+SuDWjIRnLkb4zBFulJs9sDS/2hhJ7EmwmfAD5JqgoR63C
	 VCwtbiw3kxfoWekC/CdzJSeXV06azFXTKF3C7CXW4i7tC3e36Ze1zOARET6DRjfDaMDf6
	 OiESs7BkilRZiBkGq8mjdB9hBBj+wD76GRdbkUfhdM2BYjDfLlHZxZRvzoLMu7UiBxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="GKmrTV/a";
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FC6606A32A
	for <linux-sh@vger.kernel.org>; Wed, 11 Nov 2026 01:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42FC6606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GKmrTV/a
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cdd9e925075so269868a12.0
        for <linux-sh@vger.kernel.org>; Tue, 10 Nov 2026 17:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794359239; x=1794964039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ToK+iR8w3wDaa5NXwZCWSs8d2l9SzJJLzelf57++HEI=;
        b=GKmrTV/aBoY3AgozSvxPrGMJWFyVuri9g1qzqqHoIOgBIajOClz9w+BtF1Eb6W4i2j
         QuLxGWloT0KXsv5Bz+g+v1zJ9gu3X5lmd7gi+ORzExtfNyJpBjEvuj2aIkwgp3DXLzxf
         sKgHmbH8Nu/keEmfKgNUgeEyTHUwJUltr8wSsw02nbCRJb/sLctBBgCy/JsNpnoOYe9v
         MzQ0+EMsJ82wzUBLs0YEfqCecfKktJwJH+jaB+J4zC/tfxI9gp+7F0lRtF1Yq29x5f3W
         LUyLupX9pnRgOdPqsrkm3sWu12qF3tDV02FhmveL+dzM7Om6P6m6B5sHsAYpSyO5V+L0
         IhbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794359239; x=1794964039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ToK+iR8w3wDaa5NXwZCWSs8d2l9SzJJLzelf57++HEI=;
        b=l8dc8QEX4ptTRTOBaw/kjhEUTvFIEWpDpuazUiaKhYmeKQhaD6Sn8QmgVPigrOXCW/
         TBizXbpW3TlhyQvZL77I/npIjlGPgClfNIIuurbrs/wfZDvSTt3VVC99W9mJTJgr6auo
         7OKrUoS/ulnV8R1LTGY7Qj9/ONcyX5yO0GIlq4+ASUFnSCw/8uXtdjLWM+vAxI5tsAgj
         xpLeZLemqS8H9c38gpqrcGvyt5Ra9r2xrZwDpHjU9ivbLlSCG0jS4KBSBor+P0xYQ9jX
         TE1MUrNd6KCliCq8z/n5gN3SCzT+HEZ6FMAr350jlQy2klqYfaHMwlThwUHKE60ERj0x
         +a8g==
X-Gm-Message-State: APuU4Z/SS2R6BqKgoRa219P/gkEHGMsyVEVxf40YFQyJ2OCUpYOUhPOK
	t4ndiTH4qKJZx5keYFZx4Ucimtk9jlIapFd0WHXggbkNTXQehe7IExOq
X-Gm-Gg: AYBFou0ZPRmGUuq56P7brbVxuvvyycfhbCZruco14n4q/wIunfeJe0WH9HHhJiXZB9x
	o2/VB89k82cN5e2dsJyn5P+B/nXDFGtfG6b62KBIx8mVLfAeNeUxVAlkOTHewB9WYz3b5wVQcD9
	UTMS5FBciQA+BqNnap2HLWqsAgMewrKcV/Jk5PInL4kg/H8jXvVxWBp/1+BBLA47G66RQ9N2spc
	UmnNOxWpzFTjxTQMCsaUV/Fu2d40v2lhQWFjL28U+GOC7tj+lPhS8WslvBEJcLsTHe3JqMw4uXV
	EAVlFq7uFpheajccnkZhMZBV2H9ebp9YeWX9jwRo/1Kzsapuna4fDtluSBtLt2qCbRxuiYflXjg
	BeGuvMt4aYXQZ1RXtf5r4H6CjtuDhxKIAp+tkkNrlXq8tS0kWheuIyO7KRnyVsGTLR2L935XXTY
	mhjmn6EQshh2cYEORKZaqsiQI22//RBtpdk2GdISHr7BH0FejNvsuwTOZZ0RN46al81fvvrXYdE
	9UoySbHN5P2ppsNJp/e62DJr0x65Tl38XQEUjFPpudqZtSgv7WrrdY5D5yQy4VPGMPyUF+vXJc0
	FQIr/flnsdfLGxzwQbHP4YOKQug92jLlgd3dtxi8TSunMRDRH2Z+9+VPszclOith61tW38a0o3K
	Z7kFN0Irs4w==
X-Received: by 2002:a17:90a:dfd0:b0:3a8:a98c:ea07 with SMTP id 98e67ed59e1d1-3b182e6a121mr545395a91.13.1794359238511;
        Tue, 10 Nov 2026 17:07:18 -0800 (PST)
Received: from fedora.lan (d173-183-236-7.abhsia.telus.net. [173.183.236.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b181f8fd59sm701711a91.1.2026.11.10.17.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 17:07:18 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: ysato@users.sourceforge.jp,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	geert+renesas@glider.be
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH v4 1/2] sh: sh7305: add TMU0 clock support
Date: Tue, 10 Nov 2026 19:07:13 -0600
Message-ID: <20261111010714.227429-2-artem122novak@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111010714.227429-1-artem122novak@gmail.com>
References: <20261111010714.227429-1-artem122novak@gmail.com>
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

Convert the SH7305 clock implementation to the Common Clock
Framework.

Register the master clock and the CPU, bus and peripheral
divider clocks, and add the TMU0 module clock gate.

Provide a clkdev mapping for the TMU0 functional clock so
the TMU driver can acquire it through its existing clock
lookup.

Signed-off-by: Artem Novak <artem122novak@gmail.com>
---
 arch/sh/include/asm/clock-sh7305.h     |  11 ++
 arch/sh/kernel/cpu/sh4a/clock-sh7305.c | 262 +++++++++++++++++--------
 2 files changed, 195 insertions(+), 78 deletions(-)
 create mode 100644 arch/sh/include/asm/clock-sh7305.h

diff --git a/arch/sh/include/asm/clock-sh7305.h b/arch/sh/include/asm/clock-sh7305.h
new file mode 100644
index 000000000000..2ef73845eacc
--- /dev/null
+++ b/arch/sh/include/asm/clock-sh7305.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_SH_CLOCK_SH7305_H
+#define __ASM_SH_CLOCK_SH7305_H
+
+#include <linux/init.h>
+
+int __init sh7305_clk_init(void);
+
+void __init sh7305_of_setup(char **cmdline_p);
+
+#endif /* __ASM_SH_CLOCK_SH7305_H */
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7305.c b/arch/sh/kernel/cpu/sh4a/clock-sh7305.c
index 0e683dd6de11..fc941524c268 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7305.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7305.c
@@ -4,12 +4,15 @@
  * Renesas SH7305 clock framework support
  */
 
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/err.h>
 #include <linux/init.h>
-#include <linux/kernel.h>
 #include <linux/io.h>
-#include <linux/sh_clk.h>
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
 
-#include <asm/clock.h>
+#include <asm/clock-sh7305.h>
 
 /*
  * SH7305 Clock Pulse Generator
@@ -17,6 +20,7 @@
 #define SH7305_FRQCR		0xa4150000
 #define SH7305_PLLCR		0xa4150024
 #define SH7305_FLLFRQ		0xa4150050
+#define SH7305_MSTPCR0		0xa4150030
 
 /*
  * FRQCR:
@@ -34,34 +38,28 @@
  *   FLF   bits 10..0
  */
 
+static void __iomem *sh7305_cpg_base;
+
 static unsigned long sh7305_base_rate(void)
 {
-	u32 frqcr  = __raw_readl(SH7305_FRQCR);
-	u32 pllcr  = __raw_readl(SH7305_PLLCR);
-	u32 fllfrq = __raw_readl(SH7305_FLLFRQ);
-
-	unsigned int pll;
-	unsigned int fll;
+	u32 frqcr = __raw_readl(sh7305_cpg_base);
+	u32 pllcr = __raw_readl(sh7305_cpg_base + (SH7305_PLLCR - SH7305_FRQCR));
+	u32 fllfrq = __raw_readl(sh7305_cpg_base + (SH7305_FLLFRQ - SH7305_FRQCR));
+	unsigned int pll, fll;
 	unsigned long rate = 32768;
 
-	/*
-	 * SH7305 PLL ratio is STC + 1.
-	 * Unlike SH7724 it must NOT be doubled.
-	 */
+	/* SH7305 PLL ratio is STC + 1; it is not doubled. */
 	pll = ((frqcr >> 24) & 0x3f) + 1;
 
-	/*
-	 * FLL ratio is FLF, halved when SELXM == 1.
-	 */
+	/* FLL ratio is FLF, halved when SELXM == 1. */
 	fll = fllfrq & 0x7ff;
-
 	if (((fllfrq >> 14) & 0x3) == 1)
 		fll >>= 1;
 
-	if (pllcr & (1 << 12))
+	if (pllcr & BIT(12))
 		rate *= fll;
 
-	if (pllcr & (1 << 14))
+	if (pllcr & BIT(14))
 		rate *= pll;
 
 	return rate;
@@ -69,98 +67,206 @@ static unsigned long sh7305_base_rate(void)
 
 static unsigned int sh7305_divisor(unsigned int shift)
 {
-	u32 frqcr = __raw_readl(SH7305_FRQCR);
+	u32 frqcr = __raw_readl(sh7305_cpg_base);
 	unsigned int field = (frqcr >> shift) & 0xf;
 
-	/*
-	 * SH7305 divider:
-	 *
-	 *     divisor = 2^(field + 1)
-	 */
 	return 1U << (field + 1);
 }
 
-
 /*
- * master_clk is the clock before the B/I/P divider stages.
+ * Master clock: the clock before the B/I/P divider stages.
  */
-static void master_clk_init(struct clk *clk)
+static unsigned long sh7305_master_recalc_rate(struct clk_hw *hw,
+					       unsigned long parent_rate)
 {
-	clk->rate = sh7305_base_rate();
+	return sh7305_base_rate();
 }
 
-static struct sh_clk_ops sh7305_master_clk_ops = {
-	.init = master_clk_init,
+static const struct clk_ops sh7305_master_clk_ops = {
+	.recalc_rate = sh7305_master_recalc_rate,
 };
 
+static const struct clk_init_data sh7305_master_clk_init = {
+	.name = "master_clk",
+	.ops = &sh7305_master_clk_ops,
+};
+
+static struct clk_hw sh7305_master_clk = {
+	.init = &sh7305_master_clk_init,
+};
 
 /*
- * Pphi - peripheral clock.
- *
- * P1FC occupies FRQCR bits 3..0.
+ * Peripheral, bus and CPU clocks share the master clock as parent.
  */
-static unsigned long peripheral_clk_recalc(struct clk *clk)
+struct sh7305_divider {
+	struct clk_hw hw;
+	unsigned int shift;
+};
+
+static unsigned long sh7305_divider_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
 {
-	return clk->parent->rate / sh7305_divisor(0);
+	struct sh7305_divider *divider =
+		container_of(hw, struct sh7305_divider, hw);
+
+	return parent_rate / sh7305_divisor(divider->shift);
 }
 
-static struct sh_clk_ops sh7305_peripheral_clk_ops = {
-	.recalc = peripheral_clk_recalc,
+static const struct clk_ops sh7305_divider_clk_ops = {
+	.recalc_rate = sh7305_divider_recalc_rate,
 };
 
+static const char * const sh7305_parent_names[] = {
+	"master_clk",
+};
 
-/*
- * Bphi - bus clock.
- *
- * BFC occupies FRQCR bits 11..8.
- */
-static unsigned long bus_clk_recalc(struct clk *clk)
-{
-	return clk->parent->rate / sh7305_divisor(8);
-}
+static const struct clk_init_data sh7305_peripheral_clk_init = {
+	.name = "peripheral_clk",
+	.ops = &sh7305_divider_clk_ops,
+	.parent_names = sh7305_parent_names,
+	.num_parents = ARRAY_SIZE(sh7305_parent_names),
+};
 
-static struct sh_clk_ops sh7305_bus_clk_ops = {
-	.recalc = bus_clk_recalc,
+static struct sh7305_divider sh7305_peripheral_clk = {
+	.hw.init = &sh7305_peripheral_clk_init,
+	.shift = 0,
 };
 
+static const struct clk_init_data sh7305_bus_clk_init = {
+	.name = "bus_clk",
+	.ops = &sh7305_divider_clk_ops,
+	.parent_names = sh7305_parent_names,
+	.num_parents = ARRAY_SIZE(sh7305_parent_names),
+};
 
-/*
- * Iphi - CPU/internal clock.
- *
- * IFC occupies FRQCR bits 23..20.
- */
-static unsigned long cpu_clk_recalc(struct clk *clk)
-{
-	return clk->parent->rate / sh7305_divisor(20);
-}
+static struct sh7305_divider sh7305_bus_clk = {
+	.hw.init = &sh7305_bus_clk_init,
+	.shift = 8,
+};
 
-static struct sh_clk_ops sh7305_cpu_clk_ops = {
-	.recalc = cpu_clk_recalc,
+static const struct clk_init_data sh7305_cpu_clk_init = {
+	.name = "cpu_clk",
+	.ops = &sh7305_divider_clk_ops,
+	.parent_names = sh7305_parent_names,
+	.num_parents = ARRAY_SIZE(sh7305_parent_names),
 };
 
+static struct sh7305_divider sh7305_cpu_clk = {
+	.hw.init = &sh7305_cpu_clk_init,
+	.shift = 20,
+};
 
-/*
- * Ordering must match arch/sh/kernel/cpu/clock-cpg.c:
- *
- *   0 master
- *   1 peripheral
- *   2 bus
- *   3 cpu
- */
-static struct sh_clk_ops *sh7305_clk_ops[] = {
-	&sh7305_master_clk_ops,
-	&sh7305_peripheral_clk_ops,
-	&sh7305_bus_clk_ops,
-	&sh7305_cpu_clk_ops,
+static struct clk_hw *sh7305_main_clks[] = {
+	&sh7305_master_clk,
+	&sh7305_peripheral_clk.hw,
+	&sh7305_bus_clk.hw,
+	&sh7305_cpu_clk.hw,
 };
 
-void __init arch_init_clk_ops(struct sh_clk_ops **ops, int idx)
+static const struct {
+	struct clk_hw *hw;
+	const char *con_id;
+} sh7305_clk_lookups[] = {
+	{ &sh7305_master_clk, "master_clk" },
+	{ &sh7305_peripheral_clk.hw, "peripheral_clk" },
+	{ &sh7305_bus_clk.hw, "bus_clk" },
+	{ &sh7305_cpu_clk.hw, "cpu_clk" },
+};
+
+#define SH7305_MAIN_CLK_COUNT	ARRAY_SIZE(sh7305_main_clks)
+#define SH7305_LOOKUP_COUNT	(SH7305_MAIN_CLK_COUNT + 1)
+
+static struct clk_lookup *sh7305_lookups[SH7305_LOOKUP_COUNT];
+static struct clk_hw *sh7305_tmu0_clk;
+
+static DEFINE_SPINLOCK(sh7305_mstp_lock);
+
+static void sh7305_clk_unregister_lookups(void)
 {
-	if (idx < ARRAY_SIZE(sh7305_clk_ops))
-		*ops = sh7305_clk_ops[idx];
+	int i;
+
+	for (i = SH7305_LOOKUP_COUNT - 1; i >= 0; i--) {
+		if (sh7305_lookups[i]) {
+			clkdev_drop(sh7305_lookups[i]);
+			sh7305_lookups[i] = NULL;
+		}
+	}
 }
 
-int __init arch_clk_init(void)
+static void sh7305_clk_unregister_all(unsigned int registered)
 {
-	return cpg_clk_init();
+	/* Remove clkdev references before unregistering their clocks. */
+	sh7305_clk_unregister_lookups();
+
+	if (sh7305_tmu0_clk) {
+		clk_hw_unregister_gate(sh7305_tmu0_clk);
+		sh7305_tmu0_clk = NULL;
+	}
+
+	while (registered--)
+		clk_hw_unregister(sh7305_main_clks[registered]);
+
+	if (sh7305_cpg_base) {
+		iounmap(sh7305_cpg_base);
+		sh7305_cpg_base = NULL;
+	}
+}
+
+int __init sh7305_clk_init(void)
+{
+	unsigned int i, registered = 0;
+	int ret;
+
+	sh7305_cpg_base = ioremap(SH7305_FRQCR,
+				  SH7305_FLLFRQ - SH7305_FRQCR + sizeof(u32));
+	if (!sh7305_cpg_base)
+		return -ENOMEM;
+
+	for (i = 0; i < SH7305_MAIN_CLK_COUNT; i++) {
+		ret = clk_hw_register(NULL, sh7305_main_clks[i]);
+		if (ret)
+			goto err_unregister;
+
+		registered++;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(sh7305_clk_lookups); i++) {
+		sh7305_lookups[i] =
+			clkdev_hw_create(sh7305_clk_lookups[i].hw,
+					 sh7305_clk_lookups[i].con_id, NULL);
+		if (!sh7305_lookups[i]) {
+			ret = -ENOMEM;
+			goto err_unregister;
+		}
+	}
+
+	/*
+	 * MSTPCR0 bit 15 is active-high stop control.
+	 * CLK_GATE_SET_TO_DISABLE describes this polarity without
+	 * changing the hardware state during registration.
+	 */
+	sh7305_tmu0_clk =
+		clk_hw_register_gate(NULL, "tmu0_fck", "peripheral_clk", 0,
+				     sh7305_cpg_base +
+				     (SH7305_MSTPCR0 - SH7305_FRQCR),
+				     15, CLK_GATE_SET_TO_DISABLE,
+				     &sh7305_mstp_lock);
+	if (IS_ERR(sh7305_tmu0_clk)) {
+		ret = PTR_ERR(sh7305_tmu0_clk);
+		sh7305_tmu0_clk = NULL;
+		goto err_unregister;
+	}
+
+	sh7305_lookups[SH7305_MAIN_CLK_COUNT] =
+		clkdev_hw_create(sh7305_tmu0_clk, "fck", "sh-tmu.0");
+	if (!sh7305_lookups[SH7305_MAIN_CLK_COUNT]) {
+		ret = -ENOMEM;
+		goto err_unregister;
+	}
+
+	return 0;
+
+err_unregister:
+	sh7305_clk_unregister_all(registered);
+	return ret;
 }
-- 
2.56.0

