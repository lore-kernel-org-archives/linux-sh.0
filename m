Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B49847ECC9;
	Thu,  2 Jul 2026 09:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985102; cv=none; b=DbIuatIo2VXdHT0qlt1ItKgANpCNffqZUWinsHGj3LYP/FDoTSQhz4kP/XCFF8DyutIVGvG9NJh486PzGVvmqSc598ZgrsXAaenxm396dDp2u5PnTtW8VEgmu7oX5G+yXpKv7yARBrZheTdsORTCPr4VieLeQMIISFAptzp3MRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985102; c=relaxed/simple;
	bh=keSa1/QKjebu4MBsHJIXelNNoRsG4+I50intosyXVyg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FZU+7u/s7HdkpavHW2GLeM8PWWbKErjJdDvbjYW4BL8uqTDlLX5eJsFa6AtrMg6yubXt587x9RrZsbclLDSOk2sFt8OC9lJJ3x9nTUUavzsXuQ1DMcvx4v+jQ2daEyoWtlDMlj0+/vqB+65+PPwNCcAcQoQVf7trSfs+IlUy3b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGru0hrx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGru0hrx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC5F1F00A3D;
	Thu,  2 Jul 2026 09:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782985101;
	bh=upyXmw4nrdzOXbkYVStmuPoB6Ey2lHZRvF54ro+8+gU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kGru0hrxwHy0+qvaa8yShrm27AgRSjyg0iaAron6Ztsn5FD4bSA+/M+BjOJ3MOmQZ
	 /XkWngyRYGDrTkPx0YM3Pm1/eqJvMv172zCmIr6Z0WpC7W4CB6qoYbFSJRIajHYmFt
	 XGBdKGAWbgpwztPrnzywht/2U7f4sUuMXvkHMvQc0qJrLEGu8Mi44B5eyPeuExl2z2
	 YQ3mUqN3mH7zR11ATeopR1v0O6oV2r5bKHA0rI/rdVVmYhCJaqNCmxhrXzPAJDuGd3
	 NtVGIjQqdI070eTLfJzishP9B8zMJzMZdoAZfr8FrUy+xc/I0xT9SiEB6OF4IM4Q3w
	 3gBA9dX3NRnpA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 02 Jul 2026 12:37:58 +0300
Subject: [PATCH v3 09/10] sh: remove SPARSEMEM related entries from Kconfig
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-sh-numa-v2-v3-9-57e2435603de@kernel.org>
References: <20260702-sh-numa-v2-v3-0-57e2435603de@kernel.org>
In-Reply-To: <20260702-sh-numa-v2-v3-0-57e2435603de@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Mike Rapoport <rppt@kernel.org>, Rich Felker <dalias@libc.org>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailer: b4 0.16-dev

Without NUMA support, SPARSEMEM related configuration options only create
unnecessary overhead.

Remove them.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/sh/Kconfig    |  6 ------
 arch/sh/mm/Kconfig | 10 ----------
 2 files changed, 16 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index d0ba91eba71a..ec50072a6f22 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -386,7 +386,6 @@ config CPU_SUBTYPE_SH7723
 	select CPU_SH4A
 	select CPU_SHX2
 	select ARCH_SHMOBILE
-	select ARCH_SPARSEMEM_ENABLE
 	select SYS_SUPPORTS_SH_CMT
 	select PINCTRL
 	help
@@ -397,7 +396,6 @@ config CPU_SUBTYPE_SH7724
 	select CPU_SH4A
 	select CPU_SHX2
 	select ARCH_SHMOBILE
-	select ARCH_SPARSEMEM_ENABLE
 	select SYS_SUPPORTS_SH_CMT
 	select PINCTRL
 	help
@@ -438,7 +436,6 @@ config CPU_SUBTYPE_SH7785
 	bool "Support SH7785 processor"
 	select CPU_SH4A
 	select CPU_SHX2
-	select ARCH_SPARSEMEM_ENABLE
 	select PINCTRL
 
 config CPU_SUBTYPE_SH7786
@@ -472,7 +469,6 @@ config CPU_SUBTYPE_SH7722
 	select CPU_SH4AL_DSP
 	select CPU_SHX2
 	select ARCH_SHMOBILE
-	select ARCH_SPARSEMEM_ENABLE
 	select SYS_SUPPORTS_SH_CMT
 	select PINCTRL
 
@@ -481,8 +477,6 @@ config CPU_SUBTYPE_SH7366
 	select CPU_SH4AL_DSP
 	select CPU_SHX2
 	select ARCH_SHMOBILE
-	select ARCH_SPARSEMEM_ENABLE
-	select SYS_SUPPORTS_NUMA
 	select SYS_SUPPORTS_SH_CMT
 
 endchoice
diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
index 71fecbbb080e..c7d889a1a9d7 100644
--- a/arch/sh/mm/Kconfig
+++ b/arch/sh/mm/Kconfig
@@ -115,16 +115,6 @@ config VSYSCALL
 config ARCH_FLATMEM_ENABLE
 	def_bool y
 
-config ARCH_SPARSEMEM_ENABLE
-	def_bool y
-	select SPARSEMEM_STATIC
-
-config ARCH_SPARSEMEM_DEFAULT
-	def_bool y
-
-config ARCH_SELECT_MEMORY_MODEL
-	def_bool y
-
 config IOREMAP_FIXED
        def_bool y
        depends on X2TLB

-- 
2.53.0

