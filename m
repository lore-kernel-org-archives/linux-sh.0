Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8CE5677C
	for <linux-sh@vger.kernel.org>; Fri,  1 Mar 2024 21:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326969; cv=none; b=axad/SyusussJxilncw+MustzLSQTviYwtZD5btpU9WSqIjhtAAzoMNFMNmki5E10Le0crBK+x9YupIsJv445G+jyw7LNIWnfO+x0yYX20iJnNMYaPNCo/n79jNd0wJttTsPos9tFPoZMnS59aiZRYeUKWd9PQa68IUTkIYzdis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326969; c=relaxed/simple;
	bh=IyCbUH6KEXOFyUaxC6Z2AdGKN2FSDiARrECLCPpfkC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=URh3MyobgeJ9nty9kKK0oQNhEcj1A6kChRZ8od+aHStPNjIe0O6mOFQg3if0LElHHMi+s7OmOarzBh+zX+nGHVInpgrhkeCXsfzJcwgvv8HFBSnw0T4cjHOoytdClc1myHhp59VOt2yjgFms6uzYCtPyA/kORV3KgxbAYWZUNN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:db22:6af9:7d18:6ee8])
	by albert.telenet-ops.be with bizsmtp
	id tZ2e2B0061TWuYv06Z2eSj; Fri, 01 Mar 2024 22:02:43 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rgA1T-0024g4-5p;
	Fri, 01 Mar 2024 22:02:38 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rgA1e-00D8r3-0D;
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
Subject: [PATCH 02/20] sh: fpu: Add missing forward declarations
Date: Fri,  1 Mar 2024 22:02:16 +0100
Message-Id: <1847145fc2181313b78bea8a81e6f0269d765968.1709326528.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1709326528.git.geert+renesas@glider.be>
References: <cover.1709326528.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

arch/sh/kernel/cpu/sh4/fpu.c:389:6: warning: no previous prototype for ‘float_raise’ [-Wmissing-prototypes]
arch/sh/kernel/cpu/sh4/fpu.c:394:5: warning: no previous prototype for ‘float_rounding_mode’ [-Wmissing-prototypes]

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/include/asm/fpu.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/sh/include/asm/fpu.h b/arch/sh/include/asm/fpu.h
index 04584be8986c418a..0379f4cce5ed25fb 100644
--- a/arch/sh/include/asm/fpu.h
+++ b/arch/sh/include/asm/fpu.h
@@ -64,6 +64,9 @@ static inline void clear_fpu(struct task_struct *tsk, struct pt_regs *regs)
 	preempt_enable();
 }
 
+void float_raise(unsigned int flags);
+int float_rounding_mode(void);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __ASM_SH_FPU_H */
-- 
2.34.1

