Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21B13CAE95;
	Wed,  7 Oct 2026 20:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791405398; cv=none; b=jZgttd8gF9+y5+Suu291z4w09cLGUGR1+Dw88sQz1qipKNVcnz72HKUBftfSy8Iegj0iYw1KexiOXR4u9qEr0eIMUi086ciCegA/ub2XSSmBA0/84U30HDJbfdjzgZFInL2yeMLVZqjYOg2ldiF0LvdK3Q92dBIYGDxfJsSUsaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791405398; c=relaxed/simple;
	bh=OEgZT4mYe2skSavS51T0hfYdiwke7WK5sfJmN/5Ce1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r53xcz10mAOookEb/R7y/LpRg5p2E4lKpoVE56mw3qDqJiW1sfMeOB/8MymbrLSH6LV72B6U6k15KQfokWTkSnAlCaoZ8vf3oJpMWUexQj/2I+1vg9y0iIlcqUEOcvUxRfuY/dTLdi5PgppmaILUU2bQarGunddGIcL+pmmBNJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1qF0+Fb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1qF0+Fb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7381F00898;
	Wed,  7 Oct 2026 20:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791405397;
	bh=xXt5RIMHvtuAR90/1uXgSDsdIAHt0BZCrd9ZetmMa/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V1qF0+FbTw17dSzdjqXpqk+IpuwXWL3zFPvymNvK7tn13AnJphrM/hMFUTsQmFFvx
	 M+UQkKTdwxkQkRzSvSKtSzDTMpE4bI4j7FsHB7hFgIINThK9+AZg9oqpPhAftqpq8P
	 w+52S2oJEqDyoW3DFVJTssIWlZ8ryikoKUk5gTCEIMC9qA0daEKoIHDe1HjTludxQv
	 bT9Ic/piTrQz0xpMzQV+hJuzLwwvlrP/lf2VFJxjzThWb/vGNfFmOQKRUzxlyGT0rB
	 8YH53qZ1SljhZNlutOpFQ1IXU9OGpNLt0laeyYVRCDTll8DEhqkWnV3PFdos3EPtWk
	 eA9mg6WCw6JSw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 635D7CE1716; Wed,  7 Oct 2026 13:36:37 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Bradley Morgan <brads@mainlining.org>,
	Vineet Gupta <vgupta@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	linux-snps-arc@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-sh@vger.kernel.org,
	kernel-team@meta.com,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 2/5] sh: Emulate two-byte cmpxchg
Date: Wed,  7 Oct 2026 13:36:33 -0700
Message-Id: <20261007203636.1982188-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7f398d4a-7fae-4382-9cc4-8627e8aa912b@paulmck-laptop>
References: <7f398d4a-7fae-4382-9cc4-8627e8aa912b@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bradley Morgan <brads@mainlining.org>

SH has no byte or halfword atomic memory operations, so the __cmpxchg()
switch routes case 1 through cmpxchg_emu_u8() and lets case 2 fall
through to __cmpxchg_called_with_bad_pointer(), which is declared but
never defined, so a two-byte cmpxchg() fails at link time. Route case
2 through the new cmpxchg_emu_u16(), which takes the old and new
values as unsigned long, so the (unsigned long) casts move off the
call and into _old_ and _new_ declarations that type check the old
and new arguments against *ptr through (unsigned long)(0 ? *ptr : _o_),
the idiom David Laight suggested, so cmpxchg(&p, 4, 5) no longer
compiles silently.

[ paulmck: Apply kernel test robot feedback. ]

Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Bradley Morgan <brads@mainlining.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: <linux-sh@vger.kernel.org>
---
 arch/sh/include/asm/cmpxchg.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sh/include/asm/cmpxchg.h b/arch/sh/include/asm/cmpxchg.h
index 1e5dc5ccf7bf5..477d3025a441c 100644
--- a/arch/sh/include/asm/cmpxchg.h
+++ b/arch/sh/include/asm/cmpxchg.h
@@ -59,6 +59,8 @@ static inline unsigned long __cmpxchg(volatile void * ptr, unsigned long old,
 	switch (size) {
 	case 1:
 		return cmpxchg_emu_u8(ptr, old, new);
+	case 2:
+		return cmpxchg_emu_u16(ptr, old, new);
 	case 4:
 		return __cmpxchg_u32(ptr, old, new);
 	}
-- 
2.40.1

