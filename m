Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B11185B76;
	Fri, 23 Aug 2024 12:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724417540; cv=none; b=LEgJgqHOtgKRinfFk1FFsHYErQPASYn9IMwVp5++/vmwUqA+/IXjFUMCdJvAsZ/UVXA/WgpETnG4QOzarSjx80l0pybID+2PtFyFPNVD9VvsZ3xlvPfHVTjKiOtCglGswqpO4V/B15BPJWiwbaQCQUQeareauK2By/1F+VgBDIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724417540; c=relaxed/simple;
	bh=MMKath5WwvO7L3+elI5+yBdP5O4pHtw49q2Ils6Ou1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=B2u9OyQ+L9YAVuRNJZdvsdG4aoHBbGXzoQQ/MVx5yUmiSdwuCzIwNDT6HJ4D+Ap9rI3aByGxJP0ZOy3V9RvUx5Gy9BcIEe7fgOqAHOWrlyPpBLKSbaOkch9pC/ys8mbo53gkDBYe8YY7jrKlTy8ZUeUca0BMUqm69blKr+r5J5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vasilevsky.ca; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vasilevsky.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a1d3e93cceso272054285a.1;
        Fri, 23 Aug 2024 05:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724417538; x=1725022338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S9E6XTkrddueeZOivGiIofK2AhGee/oAp8YjyBl5PzE=;
        b=RzrPPI5n0KYJORr+OA5u2AWThN3sfETMVx++P3fPNlsB7ntwUgYemuzgRbgf7eycoT
         BHnvopxyMECRocTEim27YkP7zLV1abhRX9LBFHGa2owjJFg/uucAJR0nKeBKxD+SqKgK
         OiS3a7LTBdHQhR1Eud6l/iA9VonZRjzPhP2H2QGIuN7Icm8kJ7cMp/D1irWxDgtApG7d
         remIIM/cRzT5tDqPgtYeBXGxvLemI72+8kS7spi1ikUq61v1bfzJoJ29VvAsqzppUwCZ
         jpo0Ujs0034+sckI/ttr956wJy4tYVSShotToX+vXCxMxLAEoYcclcdg4+4DxSIqyRdT
         TyIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOKZyJtMPGUEHBkvYAkHA/esI6mzpATmBNGdAJZ6FNc04aPnn0Wbyf6U/1pPZhcittvWBU13cF8q8=@vger.kernel.org, AJvYcCWzaOqtsBMrI51GmXw10/IDToWtYt4ywRZ6kg0BF+ZQoBzG3A8LCOIfitzfSHrZzA/SOgbPBJRKhccMGsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHtxMHOa+j7urHhvvLNIQbPW3iMeycgSuNLDWm8VSMZrY22n/A
	i3LoJKPSnhPRHedO5HCt8e34GXwjNNTF9R6UF5taOLPTlmiWA9XW
X-Google-Smtp-Source: AGHT+IF3mA/YQvpHZgkDzEa+/SMAZxpXC7oi2zf6N4sk58c/EQ2mjae+vOE2n5jzZqc4FH/k7dNcfw==
X-Received: by 2002:a05:620a:258f:b0:79f:12e9:1e51 with SMTP id af79cd13be357-7a688d09607mr398432085a.5.1724417537529;
        Fri, 23 Aug 2024 05:52:17 -0700 (PDT)
Received: from dogali.home (bras-base-mtrlpq3141w-grc-05-65-93-184-127.dsl.bell.ca. [65.93.184.127])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f41f249sm174739185a.126.2024.08.23.05.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 05:52:16 -0700 (PDT)
From: Dave Vasilevsky <dave@vasilevsky.ca>
To: glaubitz@physik.fu-berlin.de,
	bhe@redhat.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org,
	mpe@ellerman.id.au,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Dave Vasilevsky <dave@vasilevsky.ca>,
	=?UTF-8?q?Reimar=20D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
Subject: [PATCH] crash: Default to CRASH_DUMP=n when support for it is unlikely
Date: Fri, 23 Aug 2024 08:51:56 -0400
Message-Id: <20240823125156.104775-1-dave@vasilevsky.ca>
X-Mailer: git-send-email 2.34.1
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

Also defaults to CRASH_DUMP=n on sh.

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
index 54b2bb817a7f..200995052690 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1597,6 +1597,9 @@ config ATAGS_PROC
 config ARCH_SUPPORTS_CRASH_DUMP
 	def_bool y
 
+config ARCH_DEFAULT_CRASH_DUMP
+	def_bool y
+
 config AUTO_ZRELADDR
 	bool "Auto calculation of the decompressed kernel image address" if !ARCH_MULTIPLATFORM
 	default !(ARCH_FOOTBRIDGE || ARCH_RPC || ARCH_SA1100)
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a2f8ff354ca6..43e08cc8204f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1558,6 +1558,9 @@ config ARCH_DEFAULT_KEXEC_IMAGE_VERIFY_SIG
 config ARCH_SUPPORTS_CRASH_DUMP
 	def_bool y
 
+config ARCH_DEFAULT_CRASH_DUMP
+	def_bool y
+
 config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
 	def_bool CRASH_RESERVE
 
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 70f169210b52..ce232ddcd27d 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -599,6 +599,9 @@ config ARCH_SUPPORTS_KEXEC
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
index d7b09b064a8a..0f3c1f958eac 100644
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
index 0f3cd7c3a436..eb247b5ee569 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -880,6 +880,9 @@ config ARCH_SUPPORTS_KEXEC_PURGATORY
 config ARCH_SUPPORTS_CRASH_DUMP
 	def_bool y
 
+config ARCH_DEFAULT_CRASH_DUMP
+	def_bool y
+
 config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
 	def_bool CRASH_RESERVE
 
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index a822f952f64a..05a1fb408471 100644
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
index 1aa3c4a0c5b2..b04cfa23378c 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -549,6 +549,9 @@ config ARCH_SUPPORTS_KEXEC
 config ARCH_SUPPORTS_CRASH_DUMP
 	def_bool BROKEN_ON_SMP
 
+config ARCH_DEFAULT_CRASH_DUMP
+	def_bool n
+
 config ARCH_SUPPORTS_KEXEC_JUMP
 	def_bool y
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 007bab9f2a0e..aa4666bb9e9c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2087,6 +2087,9 @@ config ARCH_SUPPORTS_KEXEC_JUMP
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
2.34.1

