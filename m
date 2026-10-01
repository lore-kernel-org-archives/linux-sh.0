Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591A647ACFB
	for <linux-sh@vger.kernel.org>; Thu,  1 Oct 2026 06:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790837875; cv=none; b=GIgy/uIPP+cWrhWEbQL3fjpa2hh6CjQ/dv5OGnTuI3jgNae/zqe1h/lKVx1oW4XGD7oERgauR3UBFXCK3oDSVXTfyQnJwua0mgiPEWN1G+tk4MmLCKJv47Y/F+LouoVh9MO02vGCA9RPXEMJ39he3s0x4EVy4bSxIwkzSDWtj5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790837875; c=relaxed/simple;
	bh=LgGoDxD9QQwhwkXxmY2/np1ME4QMxNQVluFC+Tj0ly0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVxxw6gKT+CVbJZByKuAL+RXfJcOllQFjH5QEuGoiXJ7PBwNv3mJOFuyHnulkDAlLRgT6Atd2MUlWOCn+O4K1NbhEOJrS2gjnFi/OLPZplmZMYcyChAyhSx8QFUezHvWLxd7hUiMnLRAeH1Ok6yxNeR0MKAWJ6lLXmWUb2cGS9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7U+2vM5; arc=none smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7U+2vM5"
Received: by mail-pz2-f37.google.com with SMTP id 41be03b00d2f7-cc7d1802740so1181843a12.1
        for <linux-sh@vger.kernel.org>; Wed, 30 Sep 2026 23:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790837874; x=1791442674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m1rzJCEn/PqQYXJoEBGqCyOeQp6LYxfEwiJe7Zi6fNM=;
        b=R7U+2vM5+Ts/+mKuPEznZuKzNRU1LtNxFbbt6sNgCHVsR9lpa1XtHK58XiJBThamir
         YPzvCkq0jonP7TJPab3XDeEU2QADy0BzzBmoqksSAizsZ3vDlIfc1xSHacoVoUSupVs/
         C0W8+BA4C17Geh8wEaFexGbBo62T0hHoij0mKLe3w9yv4ygzZSJk1jZmrHxk0eNOACeL
         +l1SaYeY006EWiQQiSUopQKzCev/mt/ywUFa7pw638xApIl4+RgbQuO6D2y5WQlUM8Kr
         +/tTT/YKYPssQ3/gHNy0aAExzXtq47u//s+qjKHaDCkuD4SAocTqDlacGhzrBZednR7t
         UETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790837874; x=1791442674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m1rzJCEn/PqQYXJoEBGqCyOeQp6LYxfEwiJe7Zi6fNM=;
        b=Zs75qD8XkXZo9raI5GdagVOWi2mdY/mk99ulHmklgj9Byv3NU67emmNWjVf9g+LbB0
         fkLWIdCXh1Q4PmgMQqiXTEr5AojLJrN0Uu3ftL2wLdZ+RfTPVkmGbvD4Zud/epmgZkpf
         r1GXbQ84Fn4zHP+AqYbPfwBb2zXJSlZkp3oYedP/YD0Htxo04nvWNbWWY9SPk1cfWUVs
         8f+vgwOju88FGN0H9Iy84sy6herNkivPsNiFWgYEfse6Qr3E6GR/hRfpfCgeSJz1LggR
         vebhcg5RA6WtyNNLmrxKsJmfbY4MqZbwviUlRdB5aOMMELx8wief3f9CTBf/k9evOqez
         hp9Q==
X-Gm-Message-State: AFq9FYKsblGotW8qUANsIUI10mBSlX/COGmDHYdNpwc/maBrDkpXwr5M
	LfiLs4Lj6/Q7kQ4ay1hGn4lgIltqb6Rcx31BAufLulUDOZP6l+hZm3qd
X-Gm-Gg: AYBFou2qW2IGY5Zt5w8xm4e+UJ3dRrZpDMawxve7Y84vYMIwpwk5CFXbi5os5NGyXLn
	6eyazyKMAwPLmO7tiFf7tl3M/hqF8sFQr4eVK+kGg6BV1y0Br6la+qbpvb6v3ijlGsE2QZkrcTq
	CSuI3Y3y0LZJA0/NzcnQOu4tw69uST46JcXr9gHbSBujyQ2KwDV+W1U4wa69QYRxL9/wUTLzxRE
	V6frVVuV1DCfbdAvlOQbRtB6eqmogNIiEvl5aIz/u0fZYUGl17Qo81aGSPIDVpyQdDRtCSvo6Qm
	B1hNufeQdZUhg2mgkt5dxAMkcOTVeatLVUxF4/VHbhRKOyDPeSaridoXHnV49MQ0dOVJE9evzna
	vHuwxqejnPIvcdNkKpPPrkQcfGkAdG9Opor+Fyb8o5lLf+0/WNbtryfDfo1mJbahYsafECna34l
	WBHYfEWQU3Hrq4FMsRO7rD/ToSrgQUDBQoXyPrHKfKnguUulOKGwTWbqNUInRfvlBXhWlevnZoH
	PU7EuLKUXDQihFiVByKSNshaQdWDHGSwze0x46SUPfmm+ZF
X-Received: by 2002:a17:90b:5283:b0:39e:24ab:9f82 with SMTP id 98e67ed59e1d1-3a4d151e992mr2891716a91.10.1790837873602;
        Wed, 30 Sep 2026 23:57:53 -0700 (PDT)
Received: from localhost.localdomain (d173-183-236-7.abhsia.telus.net. [173.183.236.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f44d0a30sm2873138a91.16.2026.09.30.23.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 23:57:53 -0700 (PDT)
From: cacioandpepe <artem122novak@gmail.com>
To: ysato@users.sourceforge.jp,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cacioandpepe <artem122novak@gmail.com>
Subject: [PATCH 2/2] sh: add SH7305 CPU subtype support
Date: Thu,  1 Oct 2026 00:57:36 -0600
Message-ID: <20261001065736.753215-3-artem122novak@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001065736.753215-1-artem122novak@gmail.com>
References: <20261001065736.753215-1-artem122novak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

