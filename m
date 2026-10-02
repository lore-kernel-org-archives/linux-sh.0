Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CD0282F14
	for <linux-sh@vger.kernel.org>; Fri,  2 Oct 2026 00:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790902275; cv=none; b=JM2/XI+9E7OKdfO043L0pDBtAGtWihGESp5+HOSQKSMA2okKxMe5gDXe+HZUcj/AXMFz17VpUvGDE66x1YiPznstFgScIts55qulNepkWRMD/AmkJeQW+HIitWgTkAV53fOY6Aev0Q9LjekylKI7f7a9T6YzTTrPgmQRRT+k4yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790902275; c=relaxed/simple;
	bh=8Dmb/mLuWXLyyFW0llcc/hS/zATbTYC9yx7tgMnoKB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NP8eWiBgKboxRbief68kfexLDjpldy3+TZpKEJVp3WK+ipdPFxpQPwR8c6vpA92vcVoxAnqxCmE3H8qaWLwppOb/PVmnS/u4L/4XLDuDnlXt51w9N+LhBslyEA49bU0+PbUWllf+IsgvhbrE8te1YflyfpcNK/sr5sttWdE+Kv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbP5GCru; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbP5GCru"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd88a115ebso41558195ad.2
        for <linux-sh@vger.kernel.org>; Thu, 01 Oct 2026 17:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790902274; x=1791507074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oX/x1rko7bkYDh6myuQsKqrjTrNd8ZRwr/c3ViywoeE=;
        b=NbP5GCru04jOZ17vVfF09BaLOp1q1KQRfvLj40gNVAinBu3qHTW1mFJEtwvGg5R1TF
         3vk/nT55Z23+yCB+tWUC3YeRLvRGHIIwJrGb6l/6CEqEehWCbPAf+ZCNKs8cozMcHf3D
         o//PP8U6Hm7EJJEHxsudhccEPCTyDdHX+r/BRXUM/04s6aItVQ9TpJtE0VZMclCCfZ/s
         QRWsrD1gbkpMGjeuRGiqQVHMTbGTD6cXJOFVZt3zLbSRWVX3VI+u+fEZFVAUCxfjDDOW
         BD8W3D9et3UU0BSGxx32nOvKZJgEoKc1CTlnmAZD8klliUAXIpTqhVwz0X8dir2VoN3R
         KSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790902274; x=1791507074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oX/x1rko7bkYDh6myuQsKqrjTrNd8ZRwr/c3ViywoeE=;
        b=Ti5llDTMOqIvoJ7512TNh1lgbhzdZAp2XOUJV/zGbHmNDjL2BqhoEe1WVf0OcvWIur
         41Sy24/N1AinBPlLeOgfMDYQjGlnAMr63Hcal8b9F2xElyi1qRHD5K2CNX6UQyA7LGnH
         5Y2h0EBS/0BCsiKgqHSmVZ4N47pc80TFRfDIwhLjHzif/mBnJ2oA0+K26xyQQo9EzTnL
         1EG9ZBlqZlHx/oRmHnVuxrLir970ZssWju2qTOihHkPp4lggmRumaqdc0fky3SzqrpUh
         D41ZRlfFpxndAsEWHxKUz7bgZCtpsG6GCsFxKq8MpBD9w2KtbZzMR/jm4EG5SBZOl0eA
         C19w==
X-Gm-Message-State: AFq9FYLFgu7rK9yc7o56OItmS2h+RbuLLZUdzADFpIK+xUw1PfkE+j3n
	QZIDD8x2kR+GRIJ9I+EeIiASs9p6suKus2/r4ITsCLYYrZGsu92c3ssFftj0diAY
X-Gm-Gg: AYBFou3aqnIlJ7eS0dby0C7XC2vAPdIm42Y9UH4IyrtIqqqnZoa9fezOHdDz/ycUHVo
	tW3ci/+KNynTaFNyOikeaQ4eT1pcS06/GBOaYE3IpWj4TrQFobKvWOzU9FjmSRNpYBW3lSZ6VUa
	uXlX0OiE97Wfzo8Eq/Vg9mc1FUUEStr7IZgpS7FyTZod3WYqJtMFpmJwfeHKuK3FSxJnIPHakDJ
	COXMpSVlCJYiLE2qjA3M9lW2Nd8YVnG9jcxpSKVW44RwFZ7LSqYBwg0itIlhj84tlxu36NM/oiE
	McEhwIBlIBVsN1HZBn7rRKp/wOnFGvWtJnZZkeWyugIMuHc9gV0JnnsovXFh7N2EzQlvD+UpxcJ
	/g2xfdYje2wh7J2TqOdq2lkMfcsnB3FDkB7gMD/Ac+XKicg11kpsbRFo8/x3kOIAAvlAGE0GDE5
	aC1A5prauoc0e97Cdmi7Y2l6QaAiH3Tg4QJUkDEEumDD+0bzjfHG/J/Rew3/ZPogaae5Ax4BbGS
	Oj7bOs4HNWRQ+NWzmLjv2/V5KJcUY/Qer9NZNxdClmai9H3
X-Received: by 2002:a17:90b:2e4b:b0:3a4:b076:f0e7 with SMTP id 98e67ed59e1d1-3a6ce59f8eemr1022412a91.6.1790902273529;
        Thu, 01 Oct 2026 17:51:13 -0700 (PDT)
Received: from localhost.localdomain (d173-183-236-7.abhsia.telus.net. [173.183.236.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6dd4bd483sm361966a91.4.2026.10.01.17.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 17:51:12 -0700 (PDT)
From: Artem Novak <artem122novak@gmail.com>
To: ysato@users.sourceforge.jp,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH] sh: add SH7305 interrupt controller support
Date: Thu,  1 Oct 2026 18:50:38 -0600
Message-ID: <20261002005038.32239-1-artem122novak@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add interrupt controller support for the Renesas SH7305.

Describe the TMU interrupt vectors, interrupt mask registers and
interrupt register used by the SH7305, and register the controller
through the existing SuperH INTC framework.

Signed-off-by: Artem Novak <artem122novak@gmail.com>
---
 arch/sh/kernel/cpu/sh4a/Makefile      |  1 +
 arch/sh/kernel/cpu/sh4a/intc-sh7305.c | 85 +++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)
 create mode 100644 arch/sh/kernel/cpu/sh4a/intc-sh7305.c

diff --git a/arch/sh/kernel/cpu/sh4a/Makefile b/arch/sh/kernel/cpu/sh4a/Makefile
index baf73a8fc2a0..1e6cc301056a 100644
--- a/arch/sh/kernel/cpu/sh4a/Makefile
+++ b/arch/sh/kernel/cpu/sh4a/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_CPU_SUBTYPE_SH7770)	+= setup-sh7770.o
 obj-$(CONFIG_CPU_SUBTYPE_SH7780)	+= setup-sh7780.o
 obj-$(CONFIG_CPU_SUBTYPE_SH7785)	+= setup-sh7785.o
 obj-$(CONFIG_CPU_SUBTYPE_SH7786)	+= setup-sh7786.o intc-shx3.o
+obj-$(CONFIG_CPU_SUBTYPE_SH7305)	+= intc-sh7305.o
 obj-$(CONFIG_CPU_SUBTYPE_SH7343)	+= setup-sh7343.o
 obj-$(CONFIG_CPU_SUBTYPE_SH7722)	+= setup-sh7722.o serial-sh7722.o
 obj-$(CONFIG_CPU_SUBTYPE_SH7723)	+= setup-sh7723.o
diff --git a/arch/sh/kernel/cpu/sh4a/intc-sh7305.c b/arch/sh/kernel/cpu/sh4a/intc-sh7305.c
new file mode 100644
index 000000000000..3b26d7ef0577
--- /dev/null
+++ b/arch/sh/kernel/cpu/sh4a/intc-sh7305.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas SH7305 interrupt controller support
+ *
+ * Copyright (C) 2026 Artem Novak
+ */
+
+#include <linux/init.h>
+#include <linux/sh_intc.h>
+
+enum {
+	UNUSED = 0,
+	ENABLED,
+	DISABLED,
+
+	TMU0_TUNI0,
+	TMU0_TUNI1,
+	TMU0_TUNI2,
+};
+
+/*
+ * SH7305 TMU interrupt event codes.
+ */
+static struct intc_vect vectors[] __initdata = {
+	INTC_VECT(TMU0_TUNI0, 0x400),
+	INTC_VECT(TMU0_TUNI1, 0x420),
+	INTC_VECT(TMU0_TUNI2, 0x440),
+};
+
+/*
+ * SH7305 IMR4 / IMCR4
+ *
+ * TMU0 channels occupy bits corresponding to TUNI0..2.
+ */
+static struct intc_mask_reg mask_registers[] __initdata = {
+	{
+		0xa4080090, 0xa40800d0, 8,
+		{
+			0,
+			TMU0_TUNI2,
+			TMU0_TUNI1,
+			TMU0_TUNI0,
+			0,
+			0,
+			0,
+			0,
+		}
+	},
+};
+
+/*
+ * SH7305 IPRA
+ *
+ * Four 4-bit interrupt priority fields:
+ *
+ *   bits 15..12  TMU0 channel 0
+ *   bits 11..8   TMU0 channel 1
+ *   bits  7..4   TMU0 channel 2
+ *   bits  3..0   unused here
+ */
+static struct intc_prio_reg prio_registers[] __initdata = {
+	{
+		0xa4080000, 0, 16, 4,
+		{
+			TMU0_TUNI0,
+			TMU0_TUNI1,
+			TMU0_TUNI2,
+			0,
+		}
+	},
+};
+
+static struct intc_desc intc_desc __initdata = {
+	.name		= "sh7305",
+	.force_enable	= ENABLED,
+	.force_disable	= DISABLED,
+
+	.hw = INTC_HW_DESC(vectors, NULL, mask_registers,
+			     prio_registers, NULL, NULL),
+};
+
+void __init plat_irq_setup(void)
+{
+	register_intc_controller(&intc_desc);
+}
-- 
2.55.0

