Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CF94A33;
	Sun, 26 Apr 2026 00:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777161818; cv=none; b=CnlO6VJLF8k99aiBMTbgR7yt2NDQq1pXg4a+UmRtGjBGvSDoCvOLmbOxe1bRF/J/LWeYy/X6ZTnegTYUAaswh1FVw9UvTd+QK8zELg760Kn6JhWXgTFZ82VLHmqonuybDSX1GHASMB/ta7vUd8wMBwKD+ugP47Ip61gMJdawr9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777161818; c=relaxed/simple;
	bh=hQ7BfdwbeYY76epRy34wW3xkAulivpd34SoBNKrXm2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UgAicjQNf4Vw88RaVjuClfnu3R5k4SdLrizO0zEvRQdRkFhXhf4OJ13rswrTv3TboIHmcSc7mPQ0tsqLkSxF+yDLMIy1AiVvvbx9LKCn+8JCiRQgghOZpdKFFfnNQ4YRdLMlnWCEkJCcczLZ47UggSn9sAUL9BukO3fGz0NwmCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8LigXVP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8LigXVP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA6EC2BCB0;
	Sun, 26 Apr 2026 00:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777161818;
	bh=hQ7BfdwbeYY76epRy34wW3xkAulivpd34SoBNKrXm2M=;
	h=From:To:Cc:Subject:Date:From;
	b=A8LigXVPb03wsUhe9kdR39a+uDfaHplygOhE7k6Gn3jsSqiTEjYcS1Cns3yBjGLAY
	 X5kEHmqSwlmra9DTXv1ge9YaWjzIziBAdRujU3hkwN0LIJtl4GcPBnCnUvg5C9+MOR
	 pMfSS4krJ71NBno2uxjf+gzx38+UzlsSJc7WLeZXkJe+8NLnTgETt+cJO/xrFn2qIO
	 2m/GUUb92GQHgif15SBn9Fy307wIrBaf4qC2Ic9x9neMyqDb/zFs2IIZX3KY7PdgJZ
	 29Pbfvj7jQej7VqYCFvK46wc7D+yEH24EGRHDVAOeK8iZaE/EhQSDSV6PQ2bjfPPag
	 ddwD4r8cmNgYw==
From: Sasha Levin <sashal@kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Sasha Levin <sashal@kernel.org>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sh: Use unified SCHED_MC Kconfig from arch/Kconfig
Date: Sat, 25 Apr 2026 20:03:36 -0400
Message-ID: <20260426000336.56516-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

kconfiglint reports:

  K008: config SCHED_MC has prompts in 2 separate definitions

SCHED_MC is defined in two places:

  arch/Kconfig:73 — generic definition, depends on ARCH_SUPPORTS_SCHED_MC
  arch/sh/mm/Kconfig:185 — SH-specific definition, depends on SMP

The SH-specific SCHED_MC was introduced in commit 896f0c0e8e4e ("sh:
Support SCHED_MC for SH-X3 multi-cores.") before the
generic ARCH_SUPPORTS_SCHED_MC mechanism existed in arch/Kconfig.

Commit 7bd291abe2da ("sched: Unify the SCHED_{SMT,CLUSTER,MC} Kconfig")
consolidated SCHED_MC definitions across most architectures into the
generic arch/Kconfig version. That commit did not touch SH because SH had
not opted into the unified mechanism by selecting ARCH_SUPPORTS_SCHED_MC.

Complete the unification for SH by:
1. Adding `select ARCH_SUPPORTS_SCHED_MC if SMP` to the SUPERH config
2. Removing the SH-specific SCHED_MC from arch/sh/mm/Kconfig

This is functionally equivalent: both definitions depend on SMP (the
generic one via ARCH_SUPPORTS_SCHED_MC, which we now gate on SMP) and
both default to y.

Assisted-by: Claude:claude-opus-4-6 kconfiglint
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sh/Kconfig    | 1 +
 arch/sh/mm/Kconfig | 9 ---------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index d5795067befaa..cf8437738a7bd 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -13,6 +13,7 @@ config SUPERH
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HIBERNATION_POSSIBLE if MMU
 	select ARCH_MIGHT_HAVE_PC_PARPORT
+	select ARCH_SUPPORTS_SCHED_MC if SMP
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select ARCH_NEED_CMPXCHG_1_EMU
 	select CPU_NO_EFFICIENT_FFS
diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
index 1862411665ab8..e6762a0e46e59 100644
--- a/arch/sh/mm/Kconfig
+++ b/arch/sh/mm/Kconfig
@@ -182,15 +182,6 @@ config HUGETLB_PAGE_SIZE_64MB
 
 endchoice
 
-config SCHED_MC
-	bool "Multi-core scheduler support"
-	depends on SMP
-	default y
-	help
-	  Multi-core scheduler support improves the CPU scheduler's decision
-	  making when dealing with multi-core CPU chips at a cost of slightly
-	  increased overhead in some places. If unsure say N here.
-
 endmenu
 
 menu "Cache configuration"
-- 
2.53.0

