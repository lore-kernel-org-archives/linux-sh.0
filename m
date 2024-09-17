Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB7817BA4;
	Tue, 17 Sep 2024 16:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726591070; cv=none; b=DGiFy1SzK6mZ4r1I5FHMRQW2tZX6FINBUDSsi/ssACwtGkhbgpemnS4LR1yTH0Fkv2SNoR1YTa2fcMhG50+HDQEwbdcLcL/PI+cDNt+PTGeV86qScpYXYGxej32/PCLAX/GuQ0sYYsdso/Ry60PpG6uVLym7h5vKzvbwagyFwbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726591070; c=relaxed/simple;
	bh=TUNIZL1YIT6oeKwTzfmH+eZkxFoJIJp4HqU/22HUYFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jl5onO9Xy47bfHQ6G2IFddUTMWpUVdmj8teM20DR+SdaC0SBA6VuZQ0iSr9vIbCjOFRUUNrMAWy4oYdbI7sgviep7orZD9yph+VZZW470b2kpOPDbcDBGD0KtEw73LSvSk69V37oXPx9Ly/B+HLTfI5NI+MOZPnXybf+pDm+UgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vasilevsky.ca; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vasilevsky.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6c34fb4f65eso42262926d6.0;
        Tue, 17 Sep 2024 09:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726591067; x=1727195867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kXQda56YrJG4pLuPYq9YltdvrEvuSPsYRw5+Mc1L42w=;
        b=odaD9kq7mBJgcp/FAX/q5NkkVx/zovPrOh1FAJkb0Mug+2XVnVZ289MSIVsKwmsnZc
         u3mcDZv8AYneVPWi7d+vwD+9MSx7C3g++HrqgWbMtRhstJ9f+3zSFkM0cK4iPtLDxaMa
         DvNZsP0LOdTDayxgQzYGnSU7ctjy7DZ00/SF5uQh/nb6zGaNTNrtQbYPTPHqVXbCr0l2
         3sO5SUGZ4qrXTuXcZBGLoNVnneOZEnM4AFS1zFgl9YvVhZCqtD/m48Z7HrgJrtGlnvdb
         Qiw68y2LqEIiNLFZkeBHX2mEvlp5YlKLnSUfzffVamtuWzJbNyAPM+rDq9hYaMx3tHbd
         LFCg==
X-Forwarded-Encrypted: i=1; AJvYcCV1n7OgZWxclG3BUffYBxggIbKFlW7QD/AEW/OWl2a737ywvXavXxpMqa1rNn2FcpsI3jD9IaVKjnY=@vger.kernel.org, AJvYcCXhuiTavRC5fCLZ6EvSjvokQxN6DJAY5wwUTFIHJKISrpcgUgHKcsWAtiDYUtkEYjpzy2mCKES5Xb2XJl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkEH3360uYh+6vVjTyow672f8tVu+gkQkx1aSzTs7d5/bqCD7a
	RX29KuNdZUINqPh718sXKgtEZzMbbQM9ymUI28csheR2ZVo9mEr6
X-Google-Smtp-Source: AGHT+IGGBf9/e6O1ntWmc2YX7CGXE6d5jsChz8P2QxTASGHH97EqpLpTUE3r9bE7rmFWJ1jTgtOJ2w==
X-Received: by 2002:a0c:f411:0:b0:6c3:5c75:d2bc with SMTP id 6a1803df08f44-6c57e0d6734mr261842196d6.47.1726591067519;
        Tue, 17 Sep 2024 09:37:47 -0700 (PDT)
Received: from dogali.home ([70.24.204.168])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c58c625f50sm36131796d6.3.2024.09.17.09.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 09:37:46 -0700 (PDT)
From: Dave Vasilevsky <dave@vasilevsky.ca>
To: glaubitz@physik.fu-berlin.de,
	bhe@redhat.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org,
	mpe@ellerman.id.au,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ebiederm@xmission.com
Cc: Dave Vasilevsky <dave@vasilevsky.ca>,
	=?UTF-8?q?Reimar=20D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
Subject: [PATCH v2] crash, powerpc: Default to CRASH_DUMP=n on PPC_BOOK3S_32
Date: Tue, 17 Sep 2024 12:37:20 -0400
Message-ID: <20240917163720.1644584-1-dave@vasilevsky.ca>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fixes boot failures on 6.9 on PPC_BOOK3S_32 machines using
Open Firmware. On these machines, the kernel refuses to boot
from non-zero PHYSICAL_START, which occurs when CRASH_DUMP is on.

Since most PPC_BOOK3S_32 machines boot via Open Firmware, it should
default to off for them. Users booting via some other mechanism
can still turn it on explicitly.

Does not change the default on any other architectures for the
time being.

Signed-off-by: Dave Vasilevsky <dave@vasilevsky.ca>
Reported-by: Reimar Döffinger <Reimar.Doeffinger@gmx.de>
Closes: https://lists.debian.org/debian-powerpc/2024/07/msg00001.html
Fixes: 75bc255a7444 ("crash: clean up kdump related config items")
---
 arch/arm/Kconfig       | 3 +++
 arch/arm64/Kconfig     | 3 +++
 arch/loongarch/Kconfig | 3 +++
 arch/mips/Kconfig      | 3 +++
 arch/powerpc/Kconfig   | 4 ++++
 arch/riscv/Kconfig     | 3 +++
 arch/s390/Kconfig      | 3 +++
 arch/sh/Kconfig        | 3 +++
 arch/x86/Kconfig       | 3 +++
 kernel/Kconfig.kexec   | 2 +-
 10 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0ec034933cae..4cc31467298b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1598,6 +1598,9 @@ config ATAGS_PROC
 config ARCH_SUPPORTS_CRASH_DUMP
 	def_bool y
 
+config ARCH_DEFAULT_CRASH_DUMP
+	def_bool y
+
 config AUTO_ZRELADDR
 	bool "Auto calculation of the decompressed kernel image address" if !ARCH_MULTIPLATFORM
 	default !(ARCH_FOOTBRIDGE || ARCH_RPC || ARCH_SA1100)
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ed15b876fa74..8c67b76347d3 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1559,6 +1559,9 @@ config ARCH_DEFAULT_KEXEC_IMAGE_VERIFY_SIG
 config ARCH_SUPPORTS_CRASH_DUMP
 	def_bool y
 
+config ARCH_DEFAULT_CRASH_DUMP
+	def_bool y
+
 config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
 	def_bool CRASH_RESERVE
 
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 0e3abf7b0bd3..7ba3baee859e 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -600,6 +600,9 @@ config ARCH_SUPPORTS_KEXEC
 config ARCH_SUPPORTS_CRASH_DUMP
 	def_bool y
 
+config ARCH_DEFAULT_CRASH_DUMP
+	def_bool y
+
 config ARCH_SELECTS_CRASH_DUMP
 	def_bool y
 	depends on CRASH_DUMP
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 60077e576935..b547f4304d0c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2881,6 +2881,9 @@ config ARCH_SUPPORTS_KEXEC
 config ARCH_SUPPORTS_CRASH_DUMP
 	def_bool y
 
+config ARCH_DEFAULT_CRASH_DUMP
+	def_bool y
+
 config PHYSICAL_START
 	hex "Physical address where the kernel is loaded"
 	default "0xffffffff84000000"
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8a4ee57cd4ef..c04f7bb543cc 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -682,6 +682,10 @@ config RELOCATABLE_TEST
 config ARCH_SUPPORTS_CRASH_DUMP
 	def_bool PPC64 || PPC_BOOK3S_32 || PPC_85xx || (44x && !SMP)
 
+config ARCH_DEFAULT_CRASH_DUMP
+	bool
+	default y if !PPC_BOOK3S_32
+
 config ARCH_SELECTS_CRASH_DUMP
 	def_bool y
 	depends on CRASH_DUMP
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 86d1f1cea571..341ef759870a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -882,6 +882,9 @@ config ARCH_SUPPORTS_KEXEC_PURGATORY
 config ARCH_SUPPORTS_CRASH_DUMP
 	def_bool y
 
+config ARCH_DEFAULT_CRASH_DUMP
+	def_bool y
+
 config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
 	def_bool CRASH_RESERVE
 
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index c60e699e99f5..fff371b89e41 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -275,6 +275,9 @@ config ARCH_SUPPORTS_CRASH_DUMP
 	  This option also enables s390 zfcpdump.
 	  See also <file:Documentation/arch/s390/zfcpdump.rst>
 
+config ARCH_DEFAULT_CRASH_DUMP
+	def_bool y
+
 menu "Processor type and features"
 
 config HAVE_MARCH_Z10_FEATURES
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index e9103998cca9..04ff5fb9242e 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -550,6 +550,9 @@ config ARCH_SUPPORTS_KEXEC
 config ARCH_SUPPORTS_CRASH_DUMP
 	def_bool BROKEN_ON_SMP
 
+config ARCH_DEFAULT_CRASH_DUMP
+	def_bool y
+
 config ARCH_SUPPORTS_KEXEC_JUMP
 	def_bool y
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d1fe732979d4..7f39db779574 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2092,6 +2092,9 @@ config ARCH_SUPPORTS_KEXEC_JUMP
 config ARCH_SUPPORTS_CRASH_DUMP
 	def_bool X86_64 || (X86_32 && HIGHMEM)
 
+config ARCH_DEFAULT_CRASH_DUMP
+	def_bool y
+
 config ARCH_SUPPORTS_CRASH_HOTPLUG
 	def_bool y
 
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 6c34e63c88ff..4d111f871951 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -97,7 +97,7 @@ config KEXEC_JUMP
 
 config CRASH_DUMP
 	bool "kernel crash dumps"
-	default y
+	default ARCH_DEFAULT_CRASH_DUMP
 	depends on ARCH_SUPPORTS_CRASH_DUMP
 	depends on KEXEC_CORE
 	select VMCORE_INFO
-- 
2.43.0

