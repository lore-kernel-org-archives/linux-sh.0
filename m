Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE183B9929
	for <linux-sh@vger.kernel.org>; Mon, 15 Jun 2026 22:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781563271; cv=none; b=utoFZ8STz+HcTkQLEswvSCrELDE9/cBQBEsG+u5MvnVkkEW3F9WTZNowQNTigQifEjfwBILJsNUYSt2jlDUnw+T1TSbZ+2tOWORn5IAx1OTaLtt0R/gj5E6LCMGFv88EbAn004GXyrkZx4iOblio1/NLpV9AQHIqqB3LmdtjTAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781563271; c=relaxed/simple;
	bh=tI5z0nPgDSY8GNZiGBwBMs7QuHhlWzL2L6aDMk7tof8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y8FkAoRrF/IltWi8wzWO5157yFPFChqtWv+WVsSoxrN2ofV5KG7TlLcWOPpqHPrMe40GfTZQtHvO0PUMH2jMjgHnM29stuRlXA+KG1PukczP5shN6lALPIrmxjsdWselixF3CWmY4NnYuvAK73eJ31sIs/4l8WXpbgN16TXsOsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2zhzwy4; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2zhzwy4"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-13986d61b4eso320077c88.0
        for <linux-sh@vger.kernel.org>; Mon, 15 Jun 2026 15:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781563269; x=1782168069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sluTHDdEFnjsZhTNB5XteUlBeqYlx2vBtEHvRnRLYHY=;
        b=B2zhzwy4+KtlBGopE8MI30E21kdGRbaynoNPl/+TRNeEzD+awcpldnpjqID2TPOdi2
         LVlg1uE/x1mfCRsOK8vYSNbDQ/TMZo12OcNI42T+coWb8r2LHcvLT/CJKuaMHlM1WlLQ
         w/0ZUe959sIJ7kCUG8O8XMu6hBWQ35DmUu0Eg1K5K+Tbm7iI0AgzAl3up3HFRq6mf5Yd
         QEHlL7Hb8x5yRg9SeiQWLBtM2luMLAgHdokkrFWsC5Jur/8mhMNXVRxhiGyy9t/sYv2i
         +gZxUklj5uPfPDJjhbciTagXLU1DqAUpOSV2rFt7IHBUMPVVbdscpgrflXOGF36F7i6w
         9iIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781563269; x=1782168069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sluTHDdEFnjsZhTNB5XteUlBeqYlx2vBtEHvRnRLYHY=;
        b=ldHTO6pZADQHlrNVdmfe/VgyoOcgVxIzSNjAGn1bw/DsOVknDan8lffV3gnSSPExd8
         LgoUTZx20zO8+niLivEusjv7uFu5M3wLH7k5KE67o6z8B/Lpk0K2eF7r9Vvk13VRAjPk
         KHXgkg6XXjL19idTu8U9YunvPkEvttIo0e83wRZKTt8EHeYwYMVbzJz5NormjqwAIWvC
         pmL2ujNZV0ITHUDXLpNLLiEXjDOJ9jt/hLj0s5XMWE93FznF1wr8aPpy7L7HJK3TRWcU
         1/OfmTFm22DSjAgoozRvoTAt/nMh9ZC+n78p4fAwxborAm2GylrrtmRXFDGLpNukCt4B
         i1CQ==
X-Forwarded-Encrypted: i=1; AFNElJ/sfo+tedxTCLQ+f5fDwC7wE0YYLol0FjgLsfrJe3GlCMJxcGcIoXhZhyToceYA6/6WAFiYkWMCrw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfvrVX8Pmrzxg3p5OhlDjaFgmZ5YGt8k97MZ9clugeu5D+LKHS
	4SofUXHXYDhiNVk2wvEF02HKkhN+6BjUE/7vzVO1/YLOvId/TzI3gG88v40yzWqDPwc=
X-Gm-Gg: Acq92OHPl5+2m0cq9tMtBhakw6CSAg8S+21Eb5Zu9dp684dFpKwjljBliFpalmNwjEd
	k7v5bnR/CqaUrzLlr2+Y6vvcI2o0AjMtqFPpnKcoHOq/BW9DYIYIBlLqS+rje3VaC2WKHhkkGNe
	DkEtweGVaYXUH54nSmqMw3gQ5JT+WUM39dPm3UuNk5gzl5kyD6FJFjgfbeQRNrt+ipBdyQ90Qj6
	G50oOF3jHVmqVV3DvlGfHy/A+y37qKwJLliVhXVrKer39DWVaB678RZ/qHpxZUlm5LCXcOVIhU+
	G0SCpac8dqDTtXRgR0+jnJ6pxpJ58wPXiuAlhL0JaA+Fm5d7G50Z2xWit5N2/9/BHnI/hmfKD7c
	LauyXwIfJe6j11NnVjGEW6BIWM7k4ydIInbxocjZaFRICJqwzRQhCPq4DUF4wLiTU26WZPWk+be
	65kAKBSvF8LRsBlIOExrgZ+KE+JEOSOV3zbUDyqBedNatT2Qk715ecHGSakceCeBiGT7/xl1KJS
	b682A7QuZmmlDNipmfa2S5X38HVq4x84w5Z8E2PgYZ72z27yJ0TvDoe8PEfIlUX2F4djQaTLBNw
	cXPo32Ro6g+yizyH8Q==
X-Received: by 2002:a05:7022:6890:b0:12d:c730:c7f with SMTP id a92af1059eb24-13985f391b7mr451449c88.33.1781563269073;
        Mon, 15 Jun 2026 15:41:09 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b9815a6sm11911466c88.15.2026.06.15.15.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 15:41:08 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	linux-sh@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: [PATCH v2] sh: mm: Remove checks for nonexistent CONFIG_CPU_SUBTYPE_ST40
Date: Mon, 15 Jun 2026 15:40:48 -0700
Message-ID: <20260615224049.19649-2-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CONFIG_CPU_SUBTYPE_ST40 option was removed in commit f96691872439
("sh: Kill off the remaining ST40 cruft."), but a check for it was
added later in commit d02b08f6e8b184ff ("sh: Clean up places that make
29-bit physical assumptions."). Remove this dead code. Also remove the
definition of and references to the MMUCR_SE bit mask, because it is
defined as zero on all CPUs other than ST40.

Discovered while searching for CONFIG_* symbols referenced in code but
not defined in any Kconfig file.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
Changes in v2: Correctly indicate that the check was added after ST40
support was removed (thanks Geert)

 arch/sh/include/cpu-sh4/cpu/mmu_context.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/sh/include/cpu-sh4/cpu/mmu_context.h b/arch/sh/include/cpu-sh4/cpu/mmu_context.h
index 421b56d5c595..4a6148e1ea84 100644
--- a/arch/sh/include/cpu-sh4/cpu/mmu_context.h
+++ b/arch/sh/include/cpu-sh4/cpu/mmu_context.h
@@ -43,12 +43,6 @@
 #define MMUCR_URC		0x0000FC00
 #define MMUCR_URC_SHIFT		10
 
-#if defined(CONFIG_32BIT) && defined(CONFIG_CPU_SUBTYPE_ST40)
-#define MMUCR_SE		(1 << 4)
-#else
-#define MMUCR_SE		(0)
-#endif
-
 #ifdef CONFIG_CPU_HAS_PTEAEX
 #define MMUCR_AEX		(1 << 6)
 #else
@@ -69,7 +63,7 @@
 
 #define MMU_NTLB_ENTRIES	64
 #define MMU_CONTROL_INIT	(MMUCR_AT | MMUCR_TI | MMUCR_SQMD | \
-				 MMUCR_ME | MMUCR_SE | MMUCR_AEX)
+				 MMUCR_ME | MMUCR_AEX)
 
 #define TRA	0xff000020
 #define EXPEVT	0xff000024
-- 
2.43.0

