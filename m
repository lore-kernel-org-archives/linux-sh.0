Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03585346AE3;
	Wed, 24 Jun 2026 08:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782289174; cv=none; b=MydYMxFsoq9ivWdfY+aICLhvM95KdvMrz1jQNyzu9dtcCkuI8xyfvcbk6BlHlOwlISDbZqrzB+lVJIC7/ewZ1ddZ1pwc+1OuLoE30p8EPfhHk6+idT5GGLxCeUhdxcPrD4fw2+QzVxKPXHpkf5OpsbmKoLnR2oXU8j8RPhaRPNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782289174; c=relaxed/simple;
	bh=WMCfETlY6On4NXbfxcoFIMzb5TnxnRSu4dU3fAplPs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bi68X0cxfC0g8obZF0T51SaLPdjZlQNL93UAGicl5cximg+tZmuNGe2aCENz5GQAd75fMXIfARPD94U/6NLq289XexHmvVPFb5ATnUIiVFA/CXWKSjVEjF8NjKe3nSqt2bpGrBbynNGZ/BrS2DItSA5bKwdEyFY1TS+wTCnJoc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-03 (Coremail) with SMTP id rQCowAAH5pwOkztqsBWwFQ--.24089S2;
	Wed, 24 Jun 2026 16:19:26 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sh: Use generic OHCI platform provider symbol
Date: Wed, 24 Jun 2026 16:19:26 +0800
Message-ID: <20260624081926.12426-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAH5pwOkztqsBWwFQ--.24089S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy3Cr4rZF1kJr13AryrJFb_yoW8tFWUpr
	Zayw13WrykXFsavay7CrWkK3yrXas7JFZrCwsYyF17Jrykt34rZw4kXrWxJryDGr93Ja4r
	GFyrKa43Ja1UA3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUj2YLD
	UUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The old SuperH-specific `USB_OHCI_SH` provider symbol no longer carries
an OHCI provider object.  The current platform OHCI provider is
`USB_OHCI_HCD_PLATFORM`, which builds ohci-platform.o.

Several SH CPU subtypes still select `USB_OHCI_SH`, and the
sh7757lcr defconfig still enables it directly.  Switch both the subtype
selects and the defconfig to `USB_OHCI_HCD_PLATFORM` so the intended OHCI
provider remains reachable when `USB_OHCI_HCD` is enabled.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 arch/sh/Kconfig                  | 8 ++++----
 arch/sh/configs/sh7757lcr_defconfig | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
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
@@ -341,6 +341,6 @@ config CPU_SUBTYPE_SH7721
 	bool "Support SH7721 processor"
 	select CPU_SH3
 	select CPU_HAS_DSP
-	select USB_OHCI_SH if USB_OHCI_HCD
+	select USB_OHCI_HCD_PLATFORM if USB_OHCI_HCD
 	help
 	  Select SH7721 if you have a SH3-DSP SH7721 CPU.
@@ -426,5 +426,5 @@ config CPU_SUBTYPE_SH7763
 	bool "Support SH7763 processor"
 	select CPU_SH4A
-	select USB_OHCI_SH if USB_OHCI_HCD
+	select USB_OHCI_HCD_PLATFORM if USB_OHCI_HCD
 	help
 	  Select SH7763 if you have a SH4A SH7763(R5S77631) CPU.
@@ -452,5 +452,5 @@ config CPU_SUBTYPE_SH7786
 	select CPU_HAS_PTEAEX
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
-	select USB_OHCI_SH if USB_OHCI_HCD
+	select USB_OHCI_HCD_PLATFORM if USB_OHCI_HCD
 	select USB_EHCI_SH if USB_EHCI_HCD
 	select PINCTRL
diff --git a/arch/sh/configs/sh7757lcr_defconfig b/arch/sh/configs/sh7757lcr_defconfig
--- a/arch/sh/configs/sh7757lcr_defconfig
+++ b/arch/sh/configs/sh7757lcr_defconfig
@@ -58,8 +58,8 @@ CONFIG_HWMON is not set
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_SH=y
 CONFIG_USB_OHCI_HCD=y
-CONFIG_USB_OHCI_SH=y
+CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_STORAGE=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHI=y

