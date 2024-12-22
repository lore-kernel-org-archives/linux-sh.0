Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20F9184E;
	Sun, 22 Dec 2024 00:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734827603; cv=none; b=bZfR857LS1oOqsKyPCWM8107sYirYYj+qZsmhlNxIpSCGpkvgFd/V+TWPN6DNDYHAWCqaZ6Pw69NunhaGIv1ri0jak92bKQtsAUIN0mdwTy4CrM13qslIahbbyeBG/gLqSICFC+ZXe2Vah8dH7jCQEMQAQM4Tom/t99GmAci378=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734827603; c=relaxed/simple;
	bh=SV39a1hYqkUxT03KSsfanjcZIDYdUg4qGa+6Sy+9P3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uKgHUVUKDYqF5qAlXgExQ7Q+RfSdCxfyxznCSDNJUgbI3ft0gcD1CRF8gLxbi4DPs9lXgEZnX5zUCNFO9SkQl76amYgnkXytp9aPH1lpQiir392CWuzgncngnBj3Twb63B7XhV9MViLKa2P6rwSAcjVIJS0BPybqfvrNNoO/vy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tj3TeW/s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tj3TeW/s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DAFEC4CECE;
	Sun, 22 Dec 2024 00:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734827603;
	bh=SV39a1hYqkUxT03KSsfanjcZIDYdUg4qGa+6Sy+9P3s=;
	h=From:To:Cc:Subject:Date:From;
	b=tj3TeW/sqq/m30azdwghDsj+8Spk+2WawUG8YCicXN4qG7zdGpukC25dAW+r978+P
	 AIto7y0bxW5go2PvX/KkmggJGaF2iwavRLqjXj4/ibOS1m2jqROBhbHlw48Fz0Q3DE
	 jTFa1ZOZ0mfOVZAEchWOIHG9rL8fDCbPT0eOzuGT0XCGL3mrtECsj5sCBwHAGNvPuC
	 3SFNYoBS85dL5dqW4Gi5ARZtz0L8K0dR5wbq8oD3E+9IyAeENBlTDlLlNCgppQV2GE
	 rVar2E5hOqu5Svyw/YreOsKpwfLN89FBGdXvxVysqHGPAg8B1daKkX6TcZOm0CApUY
	 q2lEKILDZPQlA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH] sh: migrate to the generic rule for built-in DTB
Date: Sun, 22 Dec 2024 09:32:07 +0900
Message-ID: <20241222003315.2582655-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 654102df2ac2 ("kbuild: add generic support for built-in boot
DTBs") introduced generic support for built-in DTBs.

Select GENERIC_BUILTIN_DTB when built-in DTB support is enabled.

To keep consistency across architectures, this commit also renames
CONFIG_USE_BUILTIN_DTB to CONFIG_BUILTIN_DTB, and
CONFIG_BUILTIN_DTB_SOURCE to CONFIG_BUILTIN_DTB_NAME.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/sh/Kbuild            | 1 -
 arch/sh/Kconfig           | 7 ++++---
 arch/sh/boot/dts/Makefile | 2 +-
 arch/sh/kernel/setup.c    | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/sh/Kbuild b/arch/sh/Kbuild
index 056efec72c2a..0da6c6d6821a 100644
--- a/arch/sh/Kbuild
+++ b/arch/sh/Kbuild
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y				+= kernel/ mm/ boards/
 obj-$(CONFIG_SH_FPU_EMU)	+= math-emu/
-obj-$(CONFIG_USE_BUILTIN_DTB)	+= boot/dts/
 
 obj-$(CONFIG_HD6446X_SERIES)	+= cchips/hd6446x/
 
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 04ff5fb9242e..89185af7bcc9 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -648,10 +648,11 @@ endmenu
 
 menu "Boot options"
 
-config USE_BUILTIN_DTB
+config BUILTIN_DTB
 	bool "Use builtin DTB"
 	default n
 	depends on SH_DEVICE_TREE
+	select GENERIC_BUILTIN_DTB
 	help
 	  Link a device tree blob for particular hardware into the kernel,
 	  suppressing use of the DTB pointer provided by the bootloader.
@@ -659,10 +660,10 @@ config USE_BUILTIN_DTB
 	  not capable of providing a DTB to the kernel, or for experimental
 	  hardware without stable device tree bindings.
 
-config BUILTIN_DTB_SOURCE
+config BUILTIN_DTB_NAME
 	string "Source file for builtin DTB"
 	default ""
-	depends on USE_BUILTIN_DTB
+	depends on BUILTIN_DTB
 	help
 	  Base name (without suffix, relative to arch/sh/boot/dts) for the
 	  a DTS file that will be used to produce the DTB linked into the
diff --git a/arch/sh/boot/dts/Makefile b/arch/sh/boot/dts/Makefile
index 4a6dec9714a9..d109978a5eb9 100644
--- a/arch/sh/boot/dts/Makefile
+++ b/arch/sh/boot/dts/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_USE_BUILTIN_DTB) += $(addsuffix .dtb.o, $(CONFIG_BUILTIN_DTB_SOURCE))
+obj-$(CONFIG_BUILTIN_DTB) += $(addsuffix .dtb.o, $(CONFIG_BUILTIN_DTB_NAME))
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index f2b6f16a46b8..039a51291002 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -249,7 +249,7 @@ void __ref sh_fdt_init(phys_addr_t dt_phys)
 	/* Avoid calling an __init function on secondary cpus. */
 	if (done) return;
 
-#ifdef CONFIG_USE_BUILTIN_DTB
+#ifdef CONFIG_BUILTIN_DTB
 	dt_virt = __dtb_start;
 #else
 	dt_virt = phys_to_virt(dt_phys);
@@ -323,7 +323,7 @@ void __init setup_arch(char **cmdline_p)
 	sh_early_platform_driver_probe("earlyprintk", 1, 1);
 
 #ifdef CONFIG_OF_EARLY_FLATTREE
-#ifdef CONFIG_USE_BUILTIN_DTB
+#ifdef CONFIG_BUILTIN_DTB
 	unflatten_and_copy_device_tree();
 #else
 	unflatten_device_tree();
-- 
2.43.0

