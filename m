Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A970476CD2;
	Fri, 21 Aug 2026 10:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787308456; cv=none; b=pEYH00/ziotnb5E3ZK8K6lUwRksCY0E5H4W6itlXpjnXmgJm3Wax3zU1LtLOTnhrEkBnkuAPo2ECFzuwcB2ahppsA7hP1ZIoiAu0vX1N/bfT7JZ8FxNIHTZxczRKaOgcI750OZ0keK1ty36S45d8EyBzlzGCIy7nUWvQTRj2Ba0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787308456; c=relaxed/simple;
	bh=pHOBcl8/Q+K9bP7Hsrv/yMaehK6NWXwZxywf8BXFayI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Th3h0ZsB36h++UzO1SYn9wx0JcAxEdE+ns4/bE1S4V5ur2fexJ0luJ3RnZUaOdkIZccm1dahZVbDaamPW1inUxqfyPyI+UG1N+icCcTKC1/juwjpCr/FvfmW/+NZicxb1yhi/ptl8lN4k/l3VPZSc8JJEPwffsBwy7ZGkfWkiZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=HrmCOd4n; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="HrmCOd4n"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UMsFCm+qYgJKHAiyRTdxYoM65XCm+oJPeQyzj0hxfIo=; b=HrmCOd4nLcUtCK7qfyUmKPtuqj
	i0oeWCU2byqPUc9nE+Cw7KOplMnW7oJSdWpjKD0NtZM1E3u8GJWJOrgRiaCROBT/mScA54ZzOU52S
	pi6QzpqWU3kH8Z45lc9ulGefD6Id3vdJCy/HtD/8UyQaaXPydtlSIBVGLl7Y+mjhDR00AVmFIL9Xj
	txd4M2d37pWDBPOPsBMEwt/2syl7Ar/uLvEM1msMppKUjXycRTy9mLiQGo//ijWkslYtk4a0FCuOB
	mVZTo08jsd+qvvoPuwXX5NOKJCJ2KKE1SK3zqA2BY25WBnZ23BjdC99tZppQsoh2aRWtwhjZdrdP9
	z21nsZYg==;
Received: from [151.115.150.205] (port=40542 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1wxMZa-00000004veU-3gM0;
	Fri, 21 Aug 2026 12:34:06 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Oleg Nesterov <oleg@redhat.com>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH] sh: prevent ptrace from changing privileged SR bits
Date: Fri, 21 Aug 2026 10:33:36 +0000
Message-ID: <20260821103335.3627506-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

PTRACE_POKEUSR writes every word in struct pt_regs, including SR, without
filtering privileged bits. The general register regset setter exposes the
same write through PTRACE_SETREGS and PTRACE_SETREGSET.

The exception return path restores the saved SR with rte after adjusting
only the interrupt mask. An unprivileged same-UID tracer can set SR.MD and
make its tracee resume at a user address in privileged mode.

Preserve the saved non-user SR bits in both write paths and accept only
the bits in SR_USER_MASK. Recompose SR after user_regset_copyin() even on
error because the copy may have updated a prefix of the register set.

Assisted-by: Codex:gpt-5
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 arch/sh/kernel/ptrace_32.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/sh/kernel/ptrace_32.c b/arch/sh/kernel/ptrace_32.c
index 8794081483fb..bb69c35cb9a7 100644
--- a/arch/sh/kernel/ptrace_32.c
+++ b/arch/sh/kernel/ptrace_32.c
@@ -146,6 +146,7 @@ static int genregs_set(struct task_struct *target,
 		       const void *kbuf, const void __user *ubuf)
 {
 	struct pt_regs *regs = task_pt_regs(target);
+	unsigned long sr = regs->sr & ~SR_USER_MASK;
 	int ret;
 
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
@@ -159,6 +160,7 @@ static int genregs_set(struct task_struct *target,
 	if (!ret)
 		user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
 					  sizeof(struct pt_regs), -1);
+	regs->sr = (regs->sr & SR_USER_MASK) | sr;
 
 	return ret;
 }
@@ -391,6 +393,11 @@ long arch_ptrace(struct task_struct *child, long request,
 		    addr > sizeof(struct user) - 3)
 			break;
 
+		if (addr == offsetof(struct pt_regs, sr)) {
+			unsigned long sr = get_stack_long(child, addr);
+
+			data = (data & SR_USER_MASK) | (sr & ~SR_USER_MASK);
+		}
 		if (addr < sizeof(struct pt_regs))
 			ret = put_stack_long(child, addr, data);
 		else if (addr >= offsetof(struct user, fpu) &&
-- 
2.47.3

