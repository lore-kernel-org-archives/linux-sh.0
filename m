Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D65361DBF
	for <linux-sh@vger.kernel.org>; Sat,  5 Sep 2026 14:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788619972; cv=none; b=cTSTAQnuvt6YZWX6+7ldgPJTmZLGH6NMUPbRekMSy8jF9MIGeB9sOMjtnPfatsFwcBMUzKZwVQUaLsPCrzmrzCpCJhRILIt5/O88GFeS1QuQG/jDFtGCW09xQBb9S/mR9s/T/o1dhnKfXZdZmBgCrc0Qqxyd14WljrqYYUO9yE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788619972; c=relaxed/simple;
	bh=S7c7ZBrkJsIqjNyyfy3SaRYqAcjs8KgrZJdd3LyuyZI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rEqR4ja6v2ii8XZWok0uMI5dpyCfDLLwMLi9EeGXlXqJJkbr8hDCl4poy51dETQ9mAsC7sG3PIQj2LbNGV+7igzrv0mbMEoqbKnCsi/4YRRM8MnQjBAsNfI8nhNMLPXezAYeOYWrcxhsd81rA4enJcI1UKJg4a6+LlA3ncmyfk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5hhkcSb; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5hhkcSb"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49557167508so24287615e9.1
        for <linux-sh@vger.kernel.org>; Sat, 05 Sep 2026 07:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788619969; x=1789224769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OfMiV4sac4ZgnZLIuFSOoZEdJ1/aeRtOI0TR+jwk25c=;
        b=l5hhkcSb2shjaZLdUBrBX8/0VK4jJ+AlNZ5PA/FiPYTCik/6kiw3WplVohx5PMG5ho
         NbXgO/WspsvnfpKMBxyL1jctBSapD2pCERcvqzuU2oCpW4wEHlIKwbOv4lO9lFMcGnLB
         3VQ2JH5bvejSZIqqm16oH/m8CMERPztdCXxyJugm1+RTfQEB01yym0QW1dW6H75nDGZs
         De8D5zWChJGq2oMW1PA7SHstblIJFfuNN5VmpR6NuCbn2j22BubtjHq/hevk+fFYH+aV
         r//HjOkRcVfuWB+yI3bU0Tgx3IcA29jW007lG88I1OXV6C+FrS66TZRpSH6mpsXFyKaC
         GVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788619969; x=1789224769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OfMiV4sac4ZgnZLIuFSOoZEdJ1/aeRtOI0TR+jwk25c=;
        b=rMM2kwjpx6phQoEDFOU6ECXt73bP4wRAN57scdoCYfPYzxV7Nmt+zfi7W3nEwQ99XS
         53QNvFQa+kUPvC1qkUtYYaIYL1aqUgFQpWulaQ9gwkBkdmQKkjzGVHhEDWlhCPe7isSs
         JyhYVnnTZrcDSxpePqpiY5HdJegRYtH0spboNz9a6sYeXnmPfToFCa9Ft+vBzWFAElZJ
         5UEIssizrG7Y9Oh/pMwDxI0PQPyt6g9XtU2lRL6iDEiiFCBNGJKoKB4eh0SVpKTJ2DkE
         JPY3XTpPevS8QL8es/XceiN6Tv9sbkrO4Nl/waKKRQzwsEvBqdcuO842gKUVXc4n/uqV
         7Itw==
X-Forwarded-Encrypted: i=1; AKwUvByv0nDNYv71Fa63X80esr4WJ2eLV7fW0WId6+RlV6pG4mIyk24HYxrNTJ6ZZIAruksGR4zoOIz4FA==@vger.kernel.org
X-Gm-Message-State: AFuF++kbEL6DhLotcx+CEiSrNvkyZqzF1+qaRyWsYVVea+snDELIxJuR
	qtJedt85rhutLFnW+mt9iPedmkfZY6HHCDMttKGgeVIy7RvQeAxMUBMSda6XQDn1
X-Gm-Gg: AYBFou0bW20XUjYZLQUi3yTqwwD45Qd7Ai7IRD6a/fu6YzP7HyJ8fh629/sgXkoBvDp
	aKmtsvu0xYDVYGod+T/Gb7XBrS0FQOqSyrdasHJCMmosKs8C+/k0aCOSJ266Q59NSm7azSqvKDf
	wEIoVnaHnKz65sZh0YrT2aC9RyK8EyOjAwmzqDoGTbQ5ODr0uYb9rhIhoUK8DV+I8mFSefZxkaf
	XbN+vG4BS2MRzJa5lmTkcGeY8KoceH6CZ+1ELb1xLs3zbh5WxzmErlrxzOziRQvIOn80+fLQws7
	ozKgY8ntQNaRSYgywXzqsOCiKVgN9dTPTKcq9BMiPcwSrf2UWyHO0AIA46307j6zaxZTOi5a9n3
	DXJ453kxaDvW57C5kxiGuMI5iW5wHL2vhHLxcfW2DvMxtqyR+77GVG8shzCgY/JJBD8t0YRyDtW
	FsjuF9KsnyQNGHCMRlbkLbJA98nlSenV71HPchyKGtuu3NGu615elc2dNC/aoHthlgPCAUQ+Z4l
	uQsPMrRe6wvZ2XDcRdXf4Ccb2PkOAabbrv5Y57gPflBZGTFNehV9vhaXosJb83V1nNmbMPK8aRb
	bpkVwz7TAjFbMucncubot8i+wN1ScWNcsGyzXvXBChbboNY3bmtFY2FWbW+5uKOBcLw=
X-Received: by 2002:a05:600c:3f12:b0:49c:c8de:96a9 with SMTP id 5b1f17b1804b1-49cf7fdd2dfmr235359335e9.2.1788619968489;
        Sat, 05 Sep 2026 07:52:48 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf75cd8d0sm142176605e9.2.2026.09.05.07.52.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 07:52:47 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Karl Mehltretter <kmehltretter@gmail.com>
Subject: [PATCH v2] sh: Use generic OHCI platform provider symbol
Date: Sat,  5 Sep 2026 16:52:25 +0200
Message-Id: <20260905145225.88518-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pengpeng Hou <pengpeng@iscas.ac.cn>

The old SuperH-specific `USB_OHCI_SH` provider symbol no longer carries
an OHCI provider object.  The current platform OHCI provider is
`USB_OHCI_HCD_PLATFORM`, which builds ohci-platform.o.

Several SH CPU subtypes still select `USB_OHCI_SH`, and the
sh7757lcr defconfig still enables it directly.  Switch both the subtype
selects and the defconfig to `USB_OHCI_HCD_PLATFORM` so the intended OHCI
provider remains reachable when `USB_OHCI_HCD` is enabled.

Fixes: 4f6dfc2136fb ("usb: remove the dead USB_OHCI_SH option")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
[Karl Mehltretter: rebased, added Fixes: tag]
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Resend of Pengpeng's patch from June, which Geert reviewed but which
never got applied. Geert asked for it to be picked up instead of my
"sh: Drop the selects of the removed CONFIG_USB_OHCI_SH symbol", which
is withdrawn:
  https://lore.kernel.org/r/CAMuHMdWYBp0d7m0Q8rWva+EA=4nOezm1os_6ZVcrh43aPjCCPQ@mail.gmail.com/

Changes since v1 (https://lore.kernel.org/r/20260624081926.12426-1-pengpeng@iscas.ac.cn/):
- rebased on current mainline so that git am applies it
- Fixes: tag as suggested by Geert, his Reviewed-by collected
- checked with make ARCH=sh sh7757lcr_defconfig and an SH7720 config
  with USB_OHCI_HCD, ohci-platform.o builds with sh4-linux-gnu-gcc

 arch/sh/Kconfig                     | 8 ++++----
 arch/sh/configs/sh7757lcr_defconfig | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index d60f1d5a94c0..f987d999126a 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -331,7 +331,7 @@ config CPU_SUBTYPE_SH7720
 	select CPU_SH3
 	select CPU_HAS_DSP
 	select SYS_SUPPORTS_SH_CMT
-	select USB_OHCI_SH if USB_OHCI_HCD
+	select USB_OHCI_HCD_PLATFORM if USB_OHCI_HCD
 	select PINCTRL
 	help
 	  Select SH7720 if you have a SH3-DSP SH7720 CPU.
@@ -341,7 +341,7 @@ config CPU_SUBTYPE_SH7721
 	select CPU_SH3
 	select CPU_HAS_DSP
 	select SYS_SUPPORTS_SH_CMT
-	select USB_OHCI_SH if USB_OHCI_HCD
+	select USB_OHCI_HCD_PLATFORM if USB_OHCI_HCD
 	help
 	  Select SH7721 if you have a SH3-DSP SH7721 CPU.
 
@@ -426,7 +426,7 @@ config CPU_SUBTYPE_SH7757
 config CPU_SUBTYPE_SH7763
 	bool "Support SH7763 processor"
 	select CPU_SH4A
-	select USB_OHCI_SH if USB_OHCI_HCD
+	select USB_OHCI_HCD_PLATFORM if USB_OHCI_HCD
 	help
 	  Select SH7763 if you have a SH4A SH7763(R5S77631) CPU.
 
@@ -452,7 +452,7 @@ config CPU_SUBTYPE_SH7786
 	select CPU_SHX3
 	select CPU_HAS_PTEAEX
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
-	select USB_OHCI_SH if USB_OHCI_HCD
+	select USB_OHCI_HCD_PLATFORM if USB_OHCI_HCD
 	select USB_EHCI_SH if USB_EHCI_HCD
 	select PINCTRL
 
diff --git a/arch/sh/configs/sh7757lcr_defconfig b/arch/sh/configs/sh7757lcr_defconfig
index 93066ae429ec..ed2894784a82 100644
--- a/arch/sh/configs/sh7757lcr_defconfig
+++ b/arch/sh/configs/sh7757lcr_defconfig
@@ -58,7 +58,7 @@ CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_SH=y
 CONFIG_USB_OHCI_HCD=y
-CONFIG_USB_OHCI_SH=y
+CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_STORAGE=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHI=y

base-commit: 986c24e0fe44f844b44d365b71ce831947f50298
-- 
2.53.0

