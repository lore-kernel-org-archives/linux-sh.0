Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEED256B68
	for <linux-sh@vger.kernel.org>; Fri,  1 Mar 2024 21:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326975; cv=none; b=B1UPNBEqkYrjTQx6ss/NSu8hepkdASyJdfF1vj9Wmn8UdAPUsUYYSmWiP0csVfMVnwkEtI7eYiEplgJ0tlRIi0KIwfU9W9svJHKUWXJPiSLkMHgUloGuP35M9+CqBPzjEzb0Us37ME+2bwWXLc3yzdfPyn998QqXY8U5QI0TbRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326975; c=relaxed/simple;
	bh=9lW4m2hBqtoyBY9j/Of2rXuYGWJ22vtCm1tmtrE98Pk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DW3Odbf8nyXGyPjC4xGSNk6eEEbMn8e7cTx27CRdo36aCxdpqFP1DYs4a41ER+LEUybYrN0BmVTQ4lNl3OkH+yySAbb8WInF/pCn+K4Qx33jg5d6hSP9Ggd4y/rYRo4EiQtOn84ivunhR/e823ozvDBgTchYe5COEtp/1nW/ru4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:db22:6af9:7d18:6ee8])
	by baptiste.telenet-ops.be with bizsmtp
	id tZ2e2B00B1TWuYv01Z2eXp; Fri, 01 Mar 2024 22:02:45 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rgA1T-0024h0-FT;
	Fri, 01 Mar 2024 22:02:38 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rgA1e-00D8s9-9o;
	Fri, 01 Mar 2024 22:02:38 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-sh@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 16/20] sh: kprobes: Merge arch_copy_kprobe() into arch_prepare_kprobe()
Date: Fri,  1 Mar 2024 22:02:30 +0100
Message-Id: <717d47a19689cc944fae6e981a1ad7cae1642c89.1709326528.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1709326528.git.geert+renesas@glider.be>
References: <cover.1709326528.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arch/sh/kernel/kprobes.c:52:16: warning: no previous prototype for 'arch_copy_kprobe' [-Wmissing-prototypes]

Although SH kprobes support was only merged in v2.6.28, it missed the
earlier removal of the arch_copy_kprobe() callback in v2.6.15.

Based on the powerpc part of commit 49a2a1b83ba6fa40 ("[PATCH] kprobes:
changed from using spinlock to mutex").

Fixes: d39f5450146ff39f ("sh: Add kprobes support.")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.
---
 arch/sh/kernel/kprobes.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/sh/kernel/kprobes.c b/arch/sh/kernel/kprobes.c
index aed1ea8e2c2f063b..74051b8ddf3e7bf9 100644
--- a/arch/sh/kernel/kprobes.c
+++ b/arch/sh/kernel/kprobes.c
@@ -44,17 +44,12 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	if (OPCODE_RTE(opcode))
 		return -EFAULT;	/* Bad breakpoint */
 
+	memcpy(p->ainsn.insn, p->addr, MAX_INSN_SIZE * sizeof(kprobe_opcode_t));
 	p->opcode = opcode;
 
 	return 0;
 }
 
-void __kprobes arch_copy_kprobe(struct kprobe *p)
-{
-	memcpy(p->ainsn.insn, p->addr, MAX_INSN_SIZE * sizeof(kprobe_opcode_t));
-	p->opcode = *p->addr;
-}
-
 void __kprobes arch_arm_kprobe(struct kprobe *p)
 {
 	*p->addr = BREAKPOINT_INSTRUCTION;
-- 
2.34.1

