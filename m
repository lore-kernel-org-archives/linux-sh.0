Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5541C44CF59;
	Wed, 16 Sep 2026 20:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789588958; cv=none; b=MBCv4d0vncM5kk6pRUfFpifmTVutxbeBd42nIkYX8X4HlkUYyDfWPeKJVnZNFy0akYBEOiimsbb3U2DpQGEdyjeXfz4cwNkNPBvvM1i61MLCYon5bKfERwcQi/7r4wgbrjGReFj5JQTwkzd2ga3pEvXH3ZcaNgGP41TaF3YighE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789588958; c=relaxed/simple;
	bh=jx0Zx1g4wNsvY8q0Db6cnJp5c6jT78Iv5NaDUTXeIq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLeHv+MkRzV9abjB0dCaTeHLMTEEjvFarnMym8FYn0Sq+8zv+VPd84TSx875pQA/Xk8nNXoyZctanaW003g0fsMI88dHKhYYNlTuLjLjEKaJiS4KNke+JhbRaB/msMEv/1jVA0doQOzuZ4KIu7eGtiASzPc9HXVGkrnGD+K1jM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=J5uzYWVo; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=pUfIpFDU; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="J5uzYWVo";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="pUfIpFDU"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1789588935; bh=bk9a2sZlBh+9sgTTR/422Om
	IP2fbvRL5lRZQb9brs4o=; b=J5uzYWVo7LQtFPeY6m2AI6v4sHFlb+ZTkoSDlXYPGYtHWFcLHm
	DsVac8sF15Uxj3D7omudGeiD4mbn67jPJLKLRXnWKGvuDXI6kyCzf2z94W632dIMhByXOJWvVVe
	AdZQ0GMEvykUA+EEb1ejhnufDic3Bw4gcHrGOp4gg8PD5wYDyK6QjzgdJVWDCwTaHmFurmtHuji
	u93yzz2WjlJxeiqZWBpvRtw8wVQndPZkzDw2pY/DRe1uLJyums6S8beOJsQcc8uk8kge+Y8jADC
	8j4GbXqkbEzXenlEFJlwK9wsXH91mkTtTe9hQWkVD9/dPzoWM2WR5F7bilW7WrVw1tg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1789588935; bh=bk9a2sZlBh+9sgTTR/422Om
	IP2fbvRL5lRZQb9brs4o=; b=pUfIpFDUZhhLSGE5we0cUGPeAfTc0D/RPS5cHNQxuWnUR+4aWf
	hndgdIK7DT/YSNE0TLHEHVd4Mb4SNPlVDaAQ==;
From: Bradley Morgan <brads@mainlining.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Vineet Gupta <vgupta@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-snps-arc@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bradley Morgan <brads@mainlining.org>
Subject: [PATCH v2 3/5] csky: Emulate two-byte cmpxchg
Date: Wed, 16 Sep 2026 20:02:13 +0000
Message-ID: <20260916200215.21774-4-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260916200215.21774-1-brads@mainlining.org>
References: <20260916200215.21774-1-brads@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CSKY has no two-byte atomic compare and swap, so the __cmpxchg()
switches in cmpxchg.h let case 2 fall through to the undefined
__cmpxchg_called_with_bad_pointer(), failing at link time. Route case
2 through the new cmpxchg_emu_u16(), which now takes natural u16
arguments, so the (uintptr_t) casts on __old and __new become (u16)
casts in all three switch instances.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/csky/include/asm/cmpxchg.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/csky/include/asm/cmpxchg.h b/arch/csky/include/asm/cmpxchg.h
index db6dda47184e..e53628268e8c 100644
--- a/arch/csky/include/asm/cmpxchg.h
+++ b/arch/csky/include/asm/cmpxchg.h
@@ -65,6 +65,9 @@
 	case 1:							\
 		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)__ptr, (uintptr_t)__old, (uintptr_t)__new); \
 		break;						\
+	case 2:							\
+		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u16((volatile u16 *)__ptr, (u16)__old, (u16)__new); \
+		break;						\
 	case 4:							\
 		asm volatile (					\
 		"1:	ldex.w		%0, (%3) \n"		\
@@ -98,6 +101,9 @@
 	case 1:							\
 		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)__ptr, (uintptr_t)__old, (uintptr_t)__new); \
 		break;						\
+	case 2:							\
+		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u16((volatile u16 *)__ptr, (u16)__old, (u16)__new); \
+		break;						\
 	case 4:							\
 		asm volatile (					\
 		"1:	ldex.w		%0, (%3) \n"		\
@@ -132,6 +138,9 @@
 	case 1:							\
 		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)__ptr, (uintptr_t)__old, (uintptr_t)__new); \
 		break;						\
+	case 2:							\
+		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u16((volatile u16 *)__ptr, (u16)__old, (u16)__new); \
+		break;						\
 	case 4:							\
 		asm volatile (					\
 		RELEASE_FENCE					\
-- 
2.47.3

