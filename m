Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15684443AA6;
	Thu, 20 Aug 2026 12:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787229607; cv=none; b=BfiRGKjF+/7y6xWkKRI2SVRLjOIlJH1izpXRkcc2wSdJ9jzOpPZ0M8uCVsQVtdvdSEazA+7V4Z6DQ1LI6Ebf22WJH1vfaC3Q6GacOt0CIX0L2oNyKiYUuOSLe4MO0pWfl0muUNHCl54Q0yABrzPNEJSPjTM/5/dZ9k/nJFh0FLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787229607; c=relaxed/simple;
	bh=BmweJCqX9dWIqsSML7Tpnw9jwVleeosjKS1qGX4GjDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K3y1xRrgvbNpAR3Cy2ID4rtRtm3+mmoorzQsXUmm56pMGgQHec5iSlyxE3HbOSaThwb0yzdn9ghVbqgM8hwvdj1Jz+IonjtuIzJ6XPps61aHpIlI6utDW2yN1/6LWdfzMwD+aOe6jKDoUXC48Cih0f8ePZSkUHE5LFBtUmFb5rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=To2F83aF; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DIdrZeRL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="To2F83aF";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DIdrZeRL"
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	by smtp-out1.suse.de (Postfix) with ESMTP id 9C1EB850C5;
	Thu, 20 Aug 2026 12:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1787229599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/NCC33IaKEZ0fWHdHEd2H21wGez9FDtWg5D1vtSTTAg=;
	b=To2F83aFJ75j1Vu6p+ONhTo+agdKGw9zvf+o+QJbqloIh/RbmjVEusIVsttz8qAEnEjm+k
	EX/SyRIw2lO/bsBKIiKcf8f+P33etapda+HhtlbpVLeUZ1pOYDSMq6KaRy+Johrx2kyD7H
	0pI9EJ1VPbe1aEUFuBMxJEcq9xluGSg=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=DIdrZeRL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1787229595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/NCC33IaKEZ0fWHdHEd2H21wGez9FDtWg5D1vtSTTAg=;
	b=DIdrZeRLfc1GDKxqTi+hUDcO82skkQQBFcezOVx+xZJ29hrYQM12/ulLHpDY3FFPZ6VOyX
	L7QDkgw4+I/6OU74wBmvm4KdABvxnKynU7W1Cu4F/oYCxQXkzFy4ihKW5voHyV+7yaVPmi
	H1q8RNlu8+taycjtfJCpNhq3kbALVik=
From: Anthony Iliopoulos <ailiop@suse.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sh: remove unused setup_profiling_timer function
Date: Thu, 20 Aug 2026 14:39:29 +0200
Message-ID: <20260820123931.142532-1-ailiop@suse.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [16.19 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_SPAM_SHORT(2.50)[0.834];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DIRECT_TO_MX(0.00)[git-send-email 2.55.0];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.com:dkim];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b306:2000::2:from];
	DKIM_TRACE(0.00)[suse.com:+];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Score: 16.19
X-Spam-Level: ****************
X-Spamd-Bar: ++++++++++++++++
X-Rspamd-Queue-Id: 9C1EB850C5
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: YES
X-Rspamd-Action: add header
X-Spam: Yes

setup_profiling_timer() is not used by any code at this point. Since a
default weak implementation exists, there is no need to keep this
arch-specific definition around. Remove it along with the now-redundant
profile header includes.

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 arch/sh/kernel/smp.c  | 9 ---------
 arch/sh/kernel/time.c | 1 -
 2 files changed, 10 deletions(-)

diff --git a/arch/sh/kernel/smp.c b/arch/sh/kernel/smp.c
index 108d808767fa..7209a72134be 100644
--- a/arch/sh/kernel/smp.c
+++ b/arch/sh/kernel/smp.c
@@ -21,7 +21,6 @@
 #include <linux/sched/hotplug.h>
 #include <linux/atomic.h>
 #include <linux/clockchips.h>
-#include <linux/profile.h>
 
 #include <asm/processor.h>
 #include <asm/mmu_context.h>
@@ -322,14 +321,6 @@ void smp_message_recv(unsigned int msg)
 	}
 }
 
-#ifdef CONFIG_PROFILING
-/* Not really SMP stuff ... */
-int setup_profiling_timer(unsigned int multiplier)
-{
-	return 0;
-}
-#endif
-
 #ifdef CONFIG_MMU
 
 static void flush_tlb_all_ipi(void *info)
diff --git a/arch/sh/kernel/time.c b/arch/sh/kernel/time.c
index 821a09cbd605..f3e70d2d573b 100644
--- a/arch/sh/kernel/time.c
+++ b/arch/sh/kernel/time.c
@@ -9,7 +9,6 @@
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/profile.h>
 #include <linux/timex.h>
 #include <linux/sched.h>
 #include <linux/clockchips.h>
-- 
2.55.0

