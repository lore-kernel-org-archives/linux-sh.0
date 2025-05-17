Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2284218C937;
	Sat, 17 May 2025 09:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747474255; cv=none; b=GF5WkSwOyVkDQp2Pv+s1/QclXsaQ63OnK6kV7SSJFTPF3V7dTrP68DWuldK+un0FR0Gxp+u+bvbrswUFAIQtKfvKBIEFGTSStb+FQrq4etO2Mznj2V4d7uGKLVaR7qmk9GQ7QR0qtCyPMbxjLHO8CUq83tn6cex4CAJ0N3qZMaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747474255; c=relaxed/simple;
	bh=IAvZfmPr219OO3tilwUICqLsop+dgy1+GN0pkM/mw+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UiQWvaCmpm937IY+1YAi40/CuqM1gZr2HwpTqs0TAGOxar603osEbLKyYj+EmXDx2KcRFIZYBnUEaoOQh5+nct9QfRuupecBTOhPXahx79/7vJkIYdNYwk52NCmyEVE2HK3UYRWJS/vDeUz4nvOA34h1hyXed7ZONc1ZSAKaetM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDZLaZ51; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDZLaZ51"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3AAC4CEE3;
	Sat, 17 May 2025 09:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747474253;
	bh=IAvZfmPr219OO3tilwUICqLsop+dgy1+GN0pkM/mw+Y=;
	h=From:To:Cc:Subject:Date:From;
	b=cDZLaZ51sMYxM2Ko3rtu3sAOpZDlwHHYFYHuKLVOjHnIQ9OM9LgKmtI+0MBZXQB4I
	 2h8grkxJ5IIyfd69VqVvotKg/IaUWRlG5gZ90nG5JGJj3BMxdOhLITfrcjgjMm/M9j
	 Ms7jDUfeQsew1387vtyT0lTLc07fFV5HdeomJr4iIgs/iUJQ716LVTTejZe7XE8dUx
	 jVYuwwHwK6zFs6Slq8dgcNaVIGO7jdcIe/YxwI3buSs8B7pwkXISFxd7INJSyxrWb9
	 TQ2E4VeAGNsFtB0SYN8okFPcXYAItH+wOPf0CnS7t07eqlHv9gxCZBffWEko7tOBt1
	 jwfLpUZrJBMSA==
From: Mike Rapoport <rppt@kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Mike Rapoport <rppt@gmail.com>,
	Rich Felker <dalias@libc.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-kernel@vger.kernel.org,
	linux-sh@vger.kernel.org,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] sh: kprobes: remove unused variables in kprobe_exceptions_notify()
Date: Sat, 17 May 2025 12:30:48 +0300
Message-ID: <20250517093048.1149919-1-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

kbuild reports the following warning:

   arch/sh/kernel/kprobes.c: In function 'kprobe_exceptions_notify':
>> arch/sh/kernel/kprobes.c:412:24: warning: variable 'p' set but not used [-Wunused-but-set-variable]
     412 |         struct kprobe *p = NULL;
         |                        ^

The variable 'p' is indeed unused since the commit fa5a24b16f94
("sh/kprobes: Don't call the ->break_handler() in SH kprobes code")

Remove that variable along with 'kprobe_opcode_t *addr' which also
becomes unused after 'p' is removed.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202505151341.EuRFR22l-lkp@intel.com/
Fixes: fa5a24b16f94 ("sh/kprobes: Don't call the ->break_handler() in SH kprobes code")
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---

I don't know why the warning poped up only now, the code there didn't
change for some time :/

 arch/sh/kernel/kprobes.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/sh/kernel/kprobes.c b/arch/sh/kernel/kprobes.c
index 49c4ffd782d6..a250fb1b9420 100644
--- a/arch/sh/kernel/kprobes.c
+++ b/arch/sh/kernel/kprobes.c
@@ -404,13 +404,10 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
 				       unsigned long val, void *data)
 {
-	struct kprobe *p = NULL;
 	struct die_args *args = (struct die_args *)data;
 	int ret = NOTIFY_DONE;
-	kprobe_opcode_t *addr = NULL;
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
 
-	addr = (kprobe_opcode_t *) (args->regs->pc);
 	if (val == DIE_TRAP &&
 	    args->trapnr == (BREAKPOINT_INSTRUCTION & 0xff)) {
 		if (!kprobe_running()) {
@@ -421,7 +418,6 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
 				ret = NOTIFY_DONE;
 			}
 		} else {
-			p = get_kprobe(addr);
 			if ((kcb->kprobe_status == KPROBE_HIT_SS) ||
 			    (kcb->kprobe_status == KPROBE_REENTER)) {
 				if (post_kprobe_handler(args->regs))
-- 
2.47.2

