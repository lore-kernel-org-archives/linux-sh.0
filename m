Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D0E27CCEE;
	Tue,  1 Jul 2025 13:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751378224; cv=none; b=VdqRgn9T2tBDuu0rbPXOX1VNkBZwvbX83M5MeMJdzB5I7O8RcsFl/vS53TeBZOhYv29eO7ioSxf7MDrnwL9/XlzHAKVCIRGjupekbBC0yWRJzmpvtUTQYe2FqPAc2WLjarPkVwvKjf/hbDbQwxjNY5r0YgxsN4vgpTMNom73Cmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751378224; c=relaxed/simple;
	bh=emrIt1jwMG6e8kMZ1aiwJ+UL6mDNQoGRBlRr53mFPnA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DWKQS1h/THipWdWJk7lthBtZ3BasYU75KUGqRJknLXo+ZyLsQolO5FSmLmhAi/+RL9bKuH32Fut0hXH6xu/CU5p1THe7Qkg9UT6i9FTXvpdlgzL3yng3JU5EFLxKDMVY8IzFC4rMwaX4KA5N66pmWb2lp/HklpjifQSCrYSwRw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C8F82F27;
	Tue,  1 Jul 2025 06:56:46 -0700 (PDT)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 526543F58B;
	Tue,  1 Jul 2025 06:57:00 -0700 (PDT)
From: Dave Martin <Dave.Martin@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Oleg Nesterov <oleg@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	linux-sh@vger.kernel.org
Subject: [PATCH 18/23] sh: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
Date: Tue,  1 Jul 2025 14:56:11 +0100
Message-Id: <20250701135616.29630-19-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250701135616.29630-1-Dave.Martin@arm.com>
References: <20250701135616.29630-1-Dave.Martin@arm.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of having the core code guess the note name for each regset,
use USER_REGSET_NOTE_TYPE() to pick the correct name from elf.h.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/kernel/ptrace_32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/kernel/ptrace_32.c b/arch/sh/kernel/ptrace_32.c
index 36f50ad81e83..06f765d71a29 100644
--- a/arch/sh/kernel/ptrace_32.c
+++ b/arch/sh/kernel/ptrace_32.c
@@ -291,7 +291,7 @@ static const struct user_regset sh_regsets[] = {
 	 *	PC, PR, SR, GBR, MACH, MACL, TRA
 	 */
 	[REGSET_GENERAL] = {
-		.core_note_type	= NT_PRSTATUS,
+		USER_REGSET_NOTE_TYPE(PRSTATUS),
 		.n		= ELF_NGREG,
 		.size		= sizeof(long),
 		.align		= sizeof(long),
@@ -301,7 +301,7 @@ static const struct user_regset sh_regsets[] = {
 
 #ifdef CONFIG_SH_FPU
 	[REGSET_FPU] = {
-		.core_note_type	= NT_PRFPREG,
+		USER_REGSET_NOTE_TYPE(PRFPREG),
 		.n		= sizeof(struct user_fpu_struct) / sizeof(long),
 		.size		= sizeof(long),
 		.align		= sizeof(long),
-- 
2.34.1

