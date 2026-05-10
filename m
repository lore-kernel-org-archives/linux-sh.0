Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09BC396587;
	Sun, 10 May 2026 13:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778421379; cv=none; b=Vyyuw21fR3S+KWrBoToZV3kJ9tkXscHX76/KRLQkwkRcEoxYGV65WnuOG9Ik6cpu3WvIXOCRVAbUGWjxUKtz315XkglNbDLOtuDepDwL4UK4SxrVokboKl+c2ZeF9Ew9w62z/K5dhnw+hCppHiYHec8IeVch10Q6RokSqNerccg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778421379; c=relaxed/simple;
	bh=AJnDtX1NJ4+f7zL2d6aAAQhuSPiHbmuimqf/ugSMF3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhGFWGabYsKt9r4C9IWkYxKa4uGVCnqYYMK7urk1yMvYxPof2s4mVfgw5o6bq6/ebFQsVq5gnLVSBcYKk4nmZnIz9RNtz4lUBBE7OBvMrOs4ena3Hv1ly1JRFHUnYHF0oqWJnLfodL1tTdqAl+MxhjjL+0JgVliVa8kAPIoCugE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtlkZWfV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtlkZWfV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46639C2BCB8;
	Sun, 10 May 2026 13:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778421378;
	bh=AJnDtX1NJ4+f7zL2d6aAAQhuSPiHbmuimqf/ugSMF3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QtlkZWfV2M2zpY3Roc5bD1Ovu5EmRn5/cjlJxaY1+jEMkio4OOZ5MD1BI6bqiUUyJ
	 umf3xT2Cznkv6XmDamvYgZ3kAqftzhfiEOkozxhDkF5bBSt2vISedirn4gA6vaHrdj
	 DfNvXHmadpqFZMDOtqyh23mXxhJx39ymj4ugcy7YMbMSb4S5AQkHjUS2WbnHa8xIuZ
	 9vtgcVIPE2eah4akGVOU/WF7P0nL5IIlnRZbxt4muptfKZf7ZmDTGjEO3d0hDZHokk
	 Am/dYEuKMgsGbau39DH5vG46GuVBNIDAl+BcO/+7fBPWGKjASRtBYFxGOW/AFOdL7e
	 hX6xBUHSVVYkA==
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
Subject: [PATCH v2 09/10] sh: remove SPARSEMEM related entries from Kconfig
Date: Sun, 10 May 2026 16:55:45 +0300
Message-ID: <20260510135546.13554-10-rppt@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260510135546.13554-1-rppt@kernel.org>
References: <20260510135546.13554-1-rppt@kernel.org>
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

