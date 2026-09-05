Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6992D8DDB
	for <linux-sh@vger.kernel.org>; Sat,  5 Sep 2026 06:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591229; cv=none; b=g90JygTXoLwpO/QVqqRDkzfn1LtgU2PLefnPgCp82UZSI2quCXo9FAmq1anCXGvdw15JAb6LQQzy3oA3ReU4QDDbGtuIFRFcJ85EzQXTyhaM3CL64q9L5my9DGz7aIsrYUlY1algqFI+mGn7Cl+aU40CuMxMcakjo9/K2fQgW4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591229; c=relaxed/simple;
	bh=x2A95Iv0lEfuOd7hH58O6FitTZcIOXmQmdFOWi+oEXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YIvqGigyrr4IxHl/VBJAektwD0KhWTmZmp5OC1P/iZa+loh4jIe5VGB8k5jKSPtG8FBlYmENIhQh2FcuG4ymxz//H4onuAnTshH675/yvVk3gKJTpfDPGbX/0sRdQ7JHQhcLjSggiyZap0HYvFSUEST+4MS6FTLyFepfCd7s5EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlaYdP+N; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlaYdP+N"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-484374f54d0so1064276f8f.3
        for <linux-sh@vger.kernel.org>; Fri, 04 Sep 2026 23:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788591226; x=1789196026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X7pGb6HgP4rfudTYiXwlBToHcnk2H7F2bu1v+T2a0+E=;
        b=FlaYdP+N9llvJ2kArrqLkW5mviUVSs5lGhAAEELyWHbG6xoh3/ZJjdCxYYER+KGNYe
         HWxNWi6kKVvlZrGpfTVcLZaFt7LDVt3vYNQFnhRZxwwRmvhz80EdukycbOGaQwYKkccX
         YxgMVJd+miOI2/TnIr1zteoOEtBVgLKuef9pSO8YRlVfCcj23L26K/zUI3bJ/FDQZ2nu
         x5LR9JSD3Jt9H66ZO3FDbe1hBGC3hFeaa1U8l2x9AgneCPKZKOKOu6Y5n/2Fyu36aWY3
         A2Dn5Q9kzMA5Fxp+PpCCLki2jc554Ny8TB8ndACtm1SdRb3lBibovFa1n52NE7PoXgGE
         Lfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788591226; x=1789196026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X7pGb6HgP4rfudTYiXwlBToHcnk2H7F2bu1v+T2a0+E=;
        b=YpJLRLdpPs5Zh9sN9Ai136WwKTtn5GeJ0HLssqvBcQqmLYZU7PebHW6JbSI4fqcqP7
         V9buL/6tRfNMOIv/h0FKFUl3yiSiGiRHWxnfYsiP6H4ichqqCEHhpoHVrIuKZEDVsoQP
         gFgcBp+fRKV2e6Tg3B+oKqZhAQuNMZKANGiQpM5hqRCc3rVRVOVAmPGEcC8XgDILI73I
         OEnk/Dy25Q3VeqEQozKguSzLxVXkLZhMANnYJ2FkxFXrcjIOEDhlM4BOzE2z+WkYM2jx
         O/yeNKhULR3eHyH1Vg1sQlil+4W2F73WwC4tm6uZfhRT6FKngq9F87hEHpZNKC5nEw5j
         rhVg==
X-Forwarded-Encrypted: i=1; AKwUvByT8nWYF7eU4FrS4Dt+GSxcQ2xHh4IlUMkn5lFbROs6tKEJ3OUb1lAXoVW06qQBx/ZVcFITOlTqog==@vger.kernel.org
X-Gm-Message-State: AFuF++keW5BdmTfoleLlCzFSoey49wXQkt3xCuRbtaaGotQWF2GWGSoO
	OsrAf+0bt71Gff3wJ0/prBmnT5BCeTb3sYJXCL4iSlrm1WBKSQwTDTOK
X-Gm-Gg: AYBFou0Dq4l3G/MtoaxIecZhS0LV+qO1cwB/OKvQ73EZarbQMpEJdqQMHRn2ocvQuVh
	buaSBuGN7fkRAIhGap++53RZ64mxVxpLztez8kpIz7NC6834/qh3kJWYV0q9E1LwMjxKyVDWupx
	ij0OfRfpkV1OCRGzqamj0qb62uA/G95+rNh+r0a44j3uWL6pGZEKjg76sw7abOrc9d5KatC9WTE
	2IwRSm7+1CLAz9+Hp7rDrdShDRAxkButJUt4ApXX/AdOy4g/DR1dYivVksFL0ptr1zMSw6yLyFT
	yE7CP39e2E0oVHqshmKgzW6QmRWypEOEMHy1eS4xhfaNjuTUgT40ReXUEFoVJjDhRTvHkqyecOl
	wnjJQi9YivWyqXAYPZauEwLZVh5cCb4+9PcVP1kPFlzA7xGvIAiaKDQrbSsscfl3KcS6xrUWmKR
	2ku+cFsM2kmO3+U8O9YCwMWgBKp6KWRb+Y6SCCgos9a1ljpPmyFlGAFO/bKDhPK32bf6pZAcc5u
	NukhmJ1Jke6ye9jmgrPltGHHFI2UU4iqm1a5ADavSWPpHNfLwmpIHwlggBMLXbllo5gjQFPP/16
	vt6ARH2ojx7+J3OESDilcaC7RuKXY6X88tPFVQ9J+ZBsdaXkWRU0aUDjZfi0+hDozwY=
X-Received: by 2002:a5d:5f89:0:b0:485:892b:bdad with SMTP id ffacd0b85a97d-485892bbf0bmr17241599f8f.12.1788591225481;
        Fri, 04 Sep 2026 23:53:45 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c5bc5sm12147519f8f.24.2026.09.04.23.53.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 04 Sep 2026 23:53:45 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	linux-sh@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/2] sh: Drop the selects of the removed CONFIG_USB_OHCI_SH symbol
Date: Sat,  5 Sep 2026 08:53:39 +0200
Message-Id: <20260905065340.24932-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260905065340.24932-1-kmehltretter@gmail.com>
References: <20260905065340.24932-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 4f6dfc2136fb ("usb: remove the dead USB_OHCI_SH option") removed
CONFIG_USB_OHCI_SH, but four SH board entries still select it under
CONFIG_USB_OHCI_HCD. Selecting a symbol that does not exist is silently
ignored, so these lines do nothing.

Remove them.

Fixes: 4f6dfc2136fb ("usb: remove the dead USB_OHCI_SH option")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 arch/sh/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index d60f1d5a94c0..01e37d5dded9 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -331,7 +331,6 @@ config CPU_SUBTYPE_SH7720
 	select CPU_SH3
 	select CPU_HAS_DSP
 	select SYS_SUPPORTS_SH_CMT
-	select USB_OHCI_SH if USB_OHCI_HCD
 	select PINCTRL
 	help
 	  Select SH7720 if you have a SH3-DSP SH7720 CPU.
@@ -341,7 +340,6 @@ config CPU_SUBTYPE_SH7721
 	select CPU_SH3
 	select CPU_HAS_DSP
 	select SYS_SUPPORTS_SH_CMT
-	select USB_OHCI_SH if USB_OHCI_HCD
 	help
 	  Select SH7721 if you have a SH3-DSP SH7721 CPU.
 
@@ -426,7 +424,6 @@ config CPU_SUBTYPE_SH7757
 config CPU_SUBTYPE_SH7763
 	bool "Support SH7763 processor"
 	select CPU_SH4A
-	select USB_OHCI_SH if USB_OHCI_HCD
 	help
 	  Select SH7763 if you have a SH4A SH7763(R5S77631) CPU.
 
@@ -452,7 +449,6 @@ config CPU_SUBTYPE_SH7786
 	select CPU_SHX3
 	select CPU_HAS_PTEAEX
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
-	select USB_OHCI_SH if USB_OHCI_HCD
 	select USB_EHCI_SH if USB_EHCI_HCD
 	select PINCTRL
 
-- 
2.53.0

