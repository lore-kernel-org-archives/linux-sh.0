Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A668C35C6AA
	for <linux-sh@vger.kernel.org>; Fri,  2 Oct 2026 04:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790914135; cv=none; b=XX2qSR+BcUugX9NIOKj0e+th4vpOYdkjMGEBYnO/52ur2xW3PaFD8P10MEFH7ysQ1TBsAcIlFtNTRNqrygxEZcORtky10tv/G6X1yZgA7q2UAktS4tfOMQzZ6QOYQLaPY6xYpGVL98fRcYMsMZzt/yz9wSvGCbf231YhscA5NDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790914135; c=relaxed/simple;
	bh=exTaw7F3OobWYcwyFrrXr9e3wYrNqRET2QMDSQUyVW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ktlMTg5AKntMzMjSGoEyxoKSF1p8hQC0xAui3WBMBAmwlR0p+JD0v3e9Mi1G12MjWp0ETYsuOQySxLTyeA5ymu4boIvXjptEWlnqiGxys+T5z8TE5FLgk1/QPSTuEBuKUZ/mZPAVSTx7bYJbZcNZy6NItEltYxu/8mp4s0nQfQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLaj9a6f; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLaj9a6f"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a6e665bbeeso117523a91.1
        for <linux-sh@vger.kernel.org>; Thu, 01 Oct 2026 21:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790914133; x=1791518933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=708/R6aTK88LREMdk5KzZq8mEqWh1gKpczYWgyOqNNg=;
        b=mLaj9a6ffVazLplNaUUH+YEM8JRxIDoZxYi5pmEV05u/LBYIYYmsTraZ2H+1NSzne/
         MkzoDdB/3B+6EiDnQUVDDF7RTYRt0RGgx+BcWQ4wbIFNl6us2Zh2JJHSp6chMWm0DdqK
         xLDxDVIMKrGL7oCiEQ4wHGzWkpjPwrMsMMxW9WzhLTRmOh6sl94P5N4w7LiKGjKAGvQb
         0om5a7i+SJk3mX8CXdGnsNmfAROOKpfhT/SMlvv7Pm89ZmWLynrUjq8oMOJQAMuVsa50
         Iez+On4karyy1lMgXaJgqnAGLAZCf1Oe0R60s5elyR8xTOAtfjVLFWqbLIq3EvF0jdf4
         g68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790914133; x=1791518933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=708/R6aTK88LREMdk5KzZq8mEqWh1gKpczYWgyOqNNg=;
        b=mZV8pvRcxc/B/1KeIR3fk7ypp0Y/sJZlCxpOoMcCz4ZIQZq5IMFphhKEtHH7dHSjJN
         dyGTjBrTcuQ2V1SN1UMb1rE0xyFJqrUEZdF/8arbWttSqqbs495pTMafXqK+3fXFZjyh
         Aj4f9znx/OXQHHPaeQMjghbpJ2gGqHAM8rq7m9vi9gRbDRSAVn9zdG9H95peORS6MyhQ
         bJYMxLLzwUsENIIKtSbrBcO5xALSZ6QQfiWh0y4YQXHJfoOwVKJPa367JxSNohHnnT+x
         mbjCHyO8hitkIENZfYqAe2VAimoRA594H9X1sSrhU9G5uFbmjcT9aqVB1r/QK3xJ/GWe
         VdUA==
X-Gm-Message-State: AFq9FYJOKr5umJEG6Vn6QWpdvez3/4MeyXtJ3oNMwwPpjADfPNXGG7eO
	q2sKMph3OlVWhGF26NnPukHnsFeaqasinGMO4pKSwlaisz/kY02C+P5t
X-Gm-Gg: AYBFou2ZIEA/Dexl6Uh8aQEWVp/zOOi4/C4EePUyJPtGWn6A86XBDTeECwUsbyjvX6r
	q59ZL4TQb3g9JpCBPOTsQOuZ2wAGsnhAfEXTC9o4er/gVXIeyyDto/jhSM6+MiG/1Vc/YBuwYae
	tHHt6znajWtDoNGHqBuMaE+xXy/aaqusIs6Q4xDGs685pjGB50omranWiM0+9JXTEyOdQKIyE/P
	Lp4pBPMyyJshW5SmxobDaGcf2XqKVmiMfDrZw8L01HMbmatCu1w0fR8sQTU5Ck50UZvKGzTX8kH
	1MiQ7RuDALQDkwebmmpOzjpn4TkXy9J99V2m++iC5+b6TU8SuTolL/b3iTiZVkdMfT5eUjlY/iN
	Ep9ZRSiASH0Wi0Wfn7PaTZz+MQ6CJUcNxN8wfgccRb2V99xulntNIkxx5IxexIFx57oOVs3NEdE
	cpFeHm2D+QxG0EkhM7Wf6l+h4869o34Wb+zWDrjq/2vYfYjZ8Pu/ULwp+zx1QKXjLTKaiIv9fYN
	eN5Ntb5vACJcqPflD6RHOBbZXfkXqJFFpfU73G7oG/O9MIA
X-Received: by 2002:a17:90b:2787:b0:3a4:f4e8:e09c with SMTP id 98e67ed59e1d1-3a6ceb0557fmr1361660a91.33.1790914132164;
        Thu, 01 Oct 2026 21:08:52 -0700 (PDT)
Received: from localhost.localdomain (d173-183-236-7.abhsia.telus.net. [173.183.236.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6ccc92646sm2119079a91.1.2026.10.01.21.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 21:08:51 -0700 (PDT)
From: Artem Novak <artem122novak@gmail.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cacioandpepe <artem122novak@gmail.com>
Subject: [PATCH RESEND 2/2] sh: add SH7305 CPU subtype support
Date: Thu,  1 Oct 2026 22:08:00 -0600
Message-ID: <20261002040800.131862-3-artem122novak@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002040800.131862-1-artem122novak@gmail.com>
References: <20261002040800.131862-1-artem122novak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: cacioandpepe <artem122novak@gmail.com>

Add the SH7305 as an SH4AL-DSP CPU subtype.

Recognize the SH7305 in the SH-4 CPU probe using the existing
0x300b PVR family with PRR value 0xc0, and expose the processor
name through the SH CPU information interface.

Signed-off-by: cacioandpepe <artem122novak@gmail.com>
---
 arch/sh/Kconfig                 | 9 +++++++++
 arch/sh/include/asm/processor.h | 2 +-
 arch/sh/kernel/cpu/proc.c       | 3 ++-
 arch/sh/kernel/cpu/sh4/probe.c  | 3 +++
 4 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index d60f1d5a94c0..e71b5476769e 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -467,6 +467,15 @@ config CPU_SUBTYPE_SHX3
 
 # SH4AL-DSP Processor Support
 
+config CPU_SUBTYPE_SH7305
+	bool "Support SH7305 processor"
+	select CPU_SH4AL_DSP
+	help
+	  Select this option to build the kernel for systems based on the
+	  Renesas SH7305 processor. The SH7305 belongs to the SH4AL-DSP
+	  processor family and is used in embedded systems such as Casio
+	  graphing calculators.
+
 config CPU_SUBTYPE_SH7343
 	bool "Support SH7343 processor"
 	select CPU_SH4AL_DSP
diff --git a/arch/sh/include/asm/processor.h b/arch/sh/include/asm/processor.h
index 2a0b5713ab80..96321c46ce85 100644
--- a/arch/sh/include/asm/processor.h
+++ b/arch/sh/include/asm/processor.h
@@ -36,7 +36,7 @@ enum cpu_type {
 	CPU_SH7723, CPU_SH7724, CPU_SH7757, CPU_SH7734, CPU_SHX3,
 
 	/* SH4AL-DSP types */
-	CPU_SH7343, CPU_SH7722, CPU_SH7366, CPU_SH7372,
+	CPU_SH7343, CPU_SH7305, CPU_SH7722, CPU_SH7366, CPU_SH7372,
 
 	/* Unknown subtype */
 	CPU_SH_NONE
diff --git a/arch/sh/kernel/cpu/proc.c b/arch/sh/kernel/cpu/proc.c
index 5f6d0e827bae..b6fbe27742e0 100644
--- a/arch/sh/kernel/cpu/proc.c
+++ b/arch/sh/kernel/cpu/proc.c
@@ -25,7 +25,8 @@ static const char *cpu_name[] = {
 	[CPU_SH7786]	= "SH7786",	[CPU_SH7757]	= "SH7757",
 	[CPU_SH7722]	= "SH7722",	[CPU_SHX3]	= "SH-X3",
 	[CPU_MXG]	= "MX-G",	[CPU_SH7723]	= "SH7723",
-	[CPU_SH7366]	= "SH7366",	[CPU_SH7724]	= "SH7724",
+	[CPU_SH7305]	= "SH7305",	[CPU_SH7366]	= "SH7366",
+	[CPU_SH7724]	= "SH7724",
 	[CPU_SH7372]	= "SH7372",	[CPU_SH7734]	= "SH7734",
 	[CPU_J2]	= "J2",
 	[CPU_SH_NONE]	= "Unknown"
diff --git a/arch/sh/kernel/cpu/sh4/probe.c b/arch/sh/kernel/cpu/sh4/probe.c
index ef4dd6295263..7f77fc64258c 100644
--- a/arch/sh/kernel/cpu/sh4/probe.c
+++ b/arch/sh/kernel/cpu/sh4/probe.c
@@ -143,6 +143,9 @@ void cpu_probe(void)
 		break;
 	case 0x300b:
 		switch (prr) {
+		case 0xc0:
+			boot_cpu_data.type = CPU_SH7305;
+			break;
 		case 0x20:
 			boot_cpu_data.type = CPU_SH7724;
 			boot_cpu_data.flags |= CPU_HAS_L2_CACHE;
-- 
2.55.0

