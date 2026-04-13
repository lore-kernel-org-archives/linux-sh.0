Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2441320A0B;
	Mon, 13 Apr 2026 10:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077239; cv=none; b=VL17I9/kJLwzVfizIMY1ImXIW4iXzl0Ca5yo/laaD5ibPWZJ10zPM8T485RebVEONOB27m6au6fCndPArirQi3V6zUXomhcQIQRAYeH9xKZjl456FdHmxxRwM6p8e2A+wvsp9zMMgBeRVhF55CYawPmtdaCQBDxOtaqWZNcwwTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077239; c=relaxed/simple;
	bh=tmm+GelxzH5APhqtu7GMS7JKHUp8PnSoAWwiNCsV7mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=up0wfvC8H00pLX+k5ZUf6zO6tTqdaZayga4TdezsJqAC/GH1DK9ddcYsiDYXX7/21IC8PAt07jMnnJZwGZPDpvfwlVKDQJsW/jCBD4tkRmzvGoqayrqv8alY9PDlj+VKPwFFtldFH+F4ysNrteC+pgnnLTm4TUL93sFmV/u7nAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptiEy90A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptiEy90A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0CDC116C6;
	Mon, 13 Apr 2026 10:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776077239;
	bh=tmm+GelxzH5APhqtu7GMS7JKHUp8PnSoAWwiNCsV7mQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ptiEy90AwAOhfOXWuZXo24IhG7Ft01/3nuCQ6IimufgpwPtNUmpV0Qowsw11mrxBS
	 lE0bj/24EtzatXBW6lZaX+yDTh9i8fRCiuRGZ47uesB3ICbCzQRZm4+QCOtk4vO2ft
	 7PfvdSj7Sdof4fdgeZxmBtt9Yb/DJ9jlv2fWQ2TxvofoJZbqQcOlbkzQZVmmD1Im9h
	 9oFC/Bx/6OdhOMPHAFy59BtdTVC+wOt9mjqm+lSGy0jeIUSyztC6Fftbu7nqmYX8Bb
	 xqyqOCyvkJfeEQubRxkRrwqmxMptRNuUnK4xc+ltGeSkqpT7ewrIuccl3UTbH4yTeQ
	 KfJAgenzEN/GA==
From: Mike Rapoport <rppt@kernel.org>
To: linux-sh@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Mike Rapoport <rppt@kernel.org>,
	Rich Felker <dalias@libc.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 09/10] sh: remove SPARSEMEM related entries from Kconfig
Date: Mon, 13 Apr 2026 13:46:47 +0300
Message-ID: <20260413104649.852228-10-rppt@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413104649.852228-1-rppt@kernel.org>
References: <20260413104649.852228-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Without NUMA support, SPARSEMEM related configuration options only create
unnecessary overhead.

Remove them.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/sh/Kconfig    |  8 --------
 arch/sh/mm/Kconfig | 10 ----------
 2 files changed, 18 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index d5795067befa..29d55f12ad50 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -390,7 +390,6 @@ config CPU_SUBTYPE_SH7723
 	select CPU_SH4A
 	select CPU_SHX2
 	select ARCH_SHMOBILE
-	select ARCH_SPARSEMEM_ENABLE
 	select SYS_SUPPORTS_SH_CMT
 	select PINCTRL
 	help
@@ -401,7 +400,6 @@ config CPU_SUBTYPE_SH7724
 	select CPU_SH4A
 	select CPU_SHX2
 	select ARCH_SHMOBILE
-	select ARCH_SPARSEMEM_ENABLE
 	select SYS_SUPPORTS_SH_CMT
 	select PINCTRL
 	help
@@ -442,8 +440,6 @@ config CPU_SUBTYPE_SH7785
 	bool "Support SH7785 processor"
 	select CPU_SH4A
 	select CPU_SHX2
-	select ARCH_SPARSEMEM_ENABLE
-	select SYS_SUPPORTS_NUMA
 	select PINCTRL
 
 config CPU_SUBTYPE_SH7786
@@ -477,8 +473,6 @@ config CPU_SUBTYPE_SH7722
 	select CPU_SH4AL_DSP
 	select CPU_SHX2
 	select ARCH_SHMOBILE
-	select ARCH_SPARSEMEM_ENABLE
-	select SYS_SUPPORTS_NUMA
 	select SYS_SUPPORTS_SH_CMT
 	select PINCTRL
 
@@ -487,8 +481,6 @@ config CPU_SUBTYPE_SH7366
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

