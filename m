Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793667459;
	b=uLDARILukW9eI7XHrw3tUBHObqvu60pbkfUz8PlrxQD+Yy+Tip3FKN+/BjAR/QlV3fjH
	 v47pXsf3zQUQeumBYB90j51Jku09CFDxwQzc8tQerzP0eNRd58PPpcG+eXe1dGZGetIdb
	 rX+3Tih4h1NIRMHdvKCT7Jq2UOluzth12NgFVWuNrL2Y3nApUMbJtC4hZAaFdnYn8dAUV
	 F1fvS8N70AKPSeaXZmfFryDiTZrVVixuk3ZoJVy1YmXB0O6FLmqvhOSTvY1bQXgK1c/YG
	 EPPLc557i5n+ojyDH3Xaaa2XQGUnRT3R60WeN1kJd0nj0Qn50XxD79yzXExFhBw3aQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793667459;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+2UKtwt9x18VdYCAR8wQw2Q9Kvi9rO1UD6jFCQWD72A=;
	b=aBjjl5ZiQ+9k9/h8amBb6tsl02n4mS0PBFEcgwAtoOq2WSxxGOb7phWDLrwmMXnHsC6z
	 7WHAyvCcsSAIvEpNFepllN96zrSoBnd+Tjbny+rTmym1Q4+1ciDu4J0yROmM72BMxS6gG
	 4beq/xXAXNNcMBkfYEa/uhzSD01Ul+Iwk0/tr2GwWVgqV5SOVbaSZG5D6Z88r8LwxjkYi
	 kVbU/lyyh3amNA2g+5Ha+BRFEqvG4m1xb0PDM75bB862d6UFC/EvqWpVJ5RboacP+7R/f
	 cXF94Kf1LcqzOEjFDir1ySvYCMfsGYgzx1I1oGBr2zcFBYuOw2t7Nmv79e7yjugoF8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XsjO+6aX;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3846606A326
	for <linux-sh@vger.kernel.org>; Tue,  3 Nov 2026 00:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3846606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XsjO+6aX
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e5fb79ce82so23792715ad.0
        for <linux-sh@vger.kernel.org>; Mon, 02 Nov 2026 16:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793667458; x=1794272258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+2UKtwt9x18VdYCAR8wQw2Q9Kvi9rO1UD6jFCQWD72A=;
        b=XsjO+6aXkaIaFVChcZh88jLO5eIUKPLFIacVr+396eDBXm8EUjvI8v5UG1G1j9Xqg+
         B46l6ECyTDjY2Icx0PqjmIdSBZRCDTw5MfmNZfIUjBf3GTpODMnH3vbQFObHDa1TmX7f
         rMYldfyvF1fyWJZ26l7gxmL7G5TGuNI8XZK4/4DsjaTOIO7UFpy1c8RpXeiku5WwPiuE
         WsVjSU8LnXzAdP1ZHLf9YgD1mHCAUE7g+AfdFhUoqkVZNOvLk5EuCxtEMgeORxQN8Hjs
         Ov3uawyyjtWAFE3E2YIghd6fp6vLoETL1M/Hkps8bxfgoezKfa/Ljnq+rPEnMfddcnfw
         HAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793667458; x=1794272258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+2UKtwt9x18VdYCAR8wQw2Q9Kvi9rO1UD6jFCQWD72A=;
        b=QCrVgxU1FaLTNcEIfnVDZIzXnF5GKntr7Rv6Yi39+bO9/uSAjXjNRrD8FFR3tHFJT7
         ytXYmaS1hJHZ8CN+k+sX7fDHMF8Joud4Pv1UDiQcUr4SJ7n9OuMRDfzLyUiumcMauWGm
         +65uMwQ9u3hJAZiEJbfQCc++vm9YvDeyFnm67zNVhyHJVADcWLanaMUGApeJdhVtHctD
         E6tlVd1jbUvU9/tEGTUHrUZcaS9V3+BGtKCFf/fyBJi9znoa5Q5jf+Q81IvgnEw9Znlk
         HQwa4G5VIMgsa3XgxYwESeeBLd05HXSJp5zPAa11VDYMePCqlClPFdabzIiJiVk7dDP+
         rFxA==
X-Forwarded-Encrypted: i=1; AKwUvByPyqfAiOKBAxh2GPXAJNL7s/7x9Jt2UcXVtr4bpLG1OtoJM++IGN03Qcvyw42TFsBCeOtlb3pTVw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+qYxUpIGjX2ccDUsABIa3Z0T+ZrwFExIoZ8yefv0tEFsBHLGMa
	PlgTw9vZ3dACLpXWPoQ0ff/uqQiz0eRjUJGERmhLomDS15s/ofgK38nS
X-Gm-Gg: AYBFou2ayY+hr++W+769w84dhzRq9DCKLO2tBo+kiWHG0FK+PSSyTL69hasVrOlnnB6
	Pb6PDm983B/9ThHAQPwo+no88H3rEzdvk1rSs2BtG8+up2tQhpoTEj8J7+Bd76tRoGrjAt3uhCX
	u8quLJANosTrqciGAdza6CYCUhCIFuBmD4hyL1wusX3A4IwWFl1a4eevT9IbKvskBAOu8FUk+bV
	f6EvVsL2lVGpeP116evaG9G0+Pm1FBXEe4yPIHrUIaESID2i11JadRxUI6hx2Gizdjy4ev0nQRS
	D1aO/EfGqYDo571pTYaSY/SZUd14GfRUayN8mTk+59m4WG/D6krkgIu7G98pt4DFCWoSmh8gFgd
	5KgHm1TgHM5+QlY5oIsC5+K1cED+kTpfFS4PRUEHGcrAVRd3je/q57zSle+GX3aVu4XwxLz7iCD
	005GU+C1KxlYD0BQQ5vPoJ3yqW2B8cSO6VikprrLgtoWJmDFAb4jNx5h46n0/ADMUI356nr4OQ1
	nom2RDk458WLFfrW9nt0FK3wCgS4wU/qymXmE19z8kKHepS+GKwzK87HoX8ktxrkjpqr4MurJBy
	D6JRJaTL1nazYhsnNnGqsv6gX/9/mQrX7BpgXmn+PetoqpOwcJLLpdUa85nvFfjNi4sgR9wu39b
	nbGK/B4gu6A==
X-Received: by 2002:a17:903:1251:b0:2df:9497:3c89 with SMTP id d9443c01a7336-2eb36526a09mr98398335ad.59.1793667458033;
        Mon, 02 Nov 2026 16:57:38 -0800 (PST)
Received: from fedora.lan (d173-183-236-7.abhsia.telus.net. [173.183.236.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39267b8asm32654855ad.44.2026.11.02.16.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 16:57:37 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: ysato@users.sourceforge.jp,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	linux-sh@vger.kernel.org
Cc: geert+renesas@glider.be,
	linux-kernel@vger.kernel.org,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH v3] sh: sh7305: add TMU0 clock support
Date: Mon,  2 Nov 2026 18:56:45 -0600
Message-ID: <20261103005645.101643-1-artem122novak@gmail.com>
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

Register the SH7305 master, peripheral, bus and CPU clocks using
the SuperH clock framework. Add the TMU0 module clock gate using
MSTPCR0 bit 15.

Keeping SH7305 clock initialization independent of the legacy CPG
initialization framework, which relies on arch_init_clk_ops().
Disable SH_CLK_CPG_LEGACY for SH7305.

Signed-off-by: Artem Novak <artem122novak@gmail.com>
---
 arch/sh/Kconfig                        |  2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7305.c | 78 +++++++++++++++++++-------
 2 files changed, 59 insertions(+), 21 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 5ce7df11c3ec..c5cc486eb1a3 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -536,7 +536,7 @@ config SH_CLK_CPG_LEGACY
 	def_bool y if !CPU_SUBTYPE_SH7785 && !ARCH_SHMOBILE && \
 		      !CPU_SHX3 && !CPU_SUBTYPE_SH7757 && \
 		      !CPU_SUBTYPE_SH7734 && !CPU_SUBTYPE_SH7264 && \
-		      !CPU_SUBTYPE_SH7269
+		      !CPU_SUBTYPE_SH7269 && !CPU_SUBTYPE_SH7305
 
 endmenu
 
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7305.c b/arch/sh/kernel/cpu/sh4a/clock-sh7305.c
index 0e683dd6de11..03d4b5f987dd 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7305.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7305.c
@@ -7,6 +7,8 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/clkdev.h>
 #include <linux/sh_clk.h>
 
 #include <asm/clock.h>
@@ -84,13 +86,13 @@ static unsigned int sh7305_divisor(unsigned int shift)
 /*
  * master_clk is the clock before the B/I/P divider stages.
  */
-static void master_clk_init(struct clk *clk)
+static unsigned long master_clk_recalc(struct clk *clk)
 {
-	clk->rate = sh7305_base_rate();
+	return sh7305_base_rate();
 }
 
 static struct sh_clk_ops sh7305_master_clk_ops = {
-	.init = master_clk_init,
+	.recalc = master_clk_recalc,
 };
 
 
@@ -140,27 +142,63 @@ static struct sh_clk_ops sh7305_cpu_clk_ops = {
 
 
 /*
- * Ordering must match arch/sh/kernel/cpu/clock-cpg.c:
- *
- *   0 master
- *   1 peripheral
- *   2 bus
- *   3 cpu
+ * SH7305 main clocks.
  */
-static struct sh_clk_ops *sh7305_clk_ops[] = {
-	&sh7305_master_clk_ops,
-	&sh7305_peripheral_clk_ops,
-	&sh7305_bus_clk_ops,
-	&sh7305_cpu_clk_ops,
+static struct clk master_clk = {
+	.ops		= &sh7305_master_clk_ops,
+	.flags		= CLK_ENABLE_ON_INIT,
 };
 
-void __init arch_init_clk_ops(struct sh_clk_ops **ops, int idx)
-{
-	if (idx < ARRAY_SIZE(sh7305_clk_ops))
-		*ops = sh7305_clk_ops[idx];
-}
+static struct clk peripheral_clk = {
+	.ops		= &sh7305_peripheral_clk_ops,
+	.parent		= &master_clk,
+	.flags		= CLK_ENABLE_ON_INIT,
+};
+
+static struct clk bus_clk = {
+	.ops		= &sh7305_bus_clk_ops,
+	.parent		= &master_clk,
+	.flags		= CLK_ENABLE_ON_INIT,
+};
+
+static struct clk cpu_clk = {
+	.ops		= &sh7305_cpu_clk_ops,
+	.parent		= &master_clk,
+	.flags		= CLK_ENABLE_ON_INIT,
+};
+
+static struct clk *main_clks[] = {
+	&master_clk,
+	&peripheral_clk,
+	&bus_clk,
+	&cpu_clk,
+};
+
+#define MSTPCR0		0xa4150030
+
+static struct clk mstp_clks[] = {
+	SH_CLK_MSTP32(&peripheral_clk, MSTPCR0, 15, 0),
+};
+
+static struct clk_lookup lookups[] = {
+	CLKDEV_CON_ID("master_clk", &master_clk),
+	CLKDEV_CON_ID("peripheral_clk", &peripheral_clk),
+	CLKDEV_CON_ID("bus_clk", &bus_clk),
+	CLKDEV_CON_ID("cpu_clk", &cpu_clk),
+	CLKDEV_ICK_ID("fck", "sh-tmu.0", &mstp_clks[0]),
+};
 
 int __init arch_clk_init(void)
 {
-	return cpg_clk_init();
+	int i, ret = 0;
+
+	for (i = 0; !ret && i < ARRAY_SIZE(main_clks); i++)
+		ret = clk_register(main_clks[i]);
+
+	if (ret)
+		return ret;
+
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
+
+	return sh_clk_mstp_register(mstp_clks, ARRAY_SIZE(mstp_clks));
 }
-- 
2.56.0

