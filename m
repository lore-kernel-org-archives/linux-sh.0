Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7BA40F742;
	Wed,  7 Oct 2026 20:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791405400; cv=none; b=UUEKcYmL9kXdEGQmETXoKjfyv833WokCt9o4mUp8g9lL2SzdM7UdNSd5N/TSGg095mKzQgkn2ghf5fFpanguy22dB7ZiIgdLgUg1JDIXc/edM0C2MAUCT3MTgMj99QJaLtyDDvE4wkbyLjg2K9vMxlhSfjNtKZx2lEFUJacitqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791405400; c=relaxed/simple;
	bh=4aJa0emWd9XRsanYKO7gRR9edGUDD+fSig1VlzWwPwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AcWwx/aUS0Msi3tFUL4OLkyVY16puOIxO6cymmCzO4N1C+mUrfoyGqmxJZSfIsfxcGqk7SgK2bIR7WdBK6xZ00S1pfjM2XOtdnuuRd6MXGdX2LUeq6e1ylmk1KZam6DrRQD3GOKiWWOcjTErWlhqiNOBu/lnk9TlApSBI4e0O/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFM84YxP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFM84YxP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FF21F0089D;
	Wed,  7 Oct 2026 20:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791405397;
	bh=DwR+Icn/O6BJifyfJAm+hF0AIuvvzHeAbd8YOtPmg7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AFM84YxParxFhIM0Vhs0eYo5leJXbo2bOLnf3+VzDyrL9vKLgo6E33T26dtUOYo8r
	 BKsMuN0kvFUQhQoI4vWsKew6s78p7tqO8nbr+eBqouVP6WrGZ6avmaMj45+29cPTKr
	 p5olhih/3WuJ0FV608FexLlqJ5LXN+rXERKB94gIi+9x1wd3wer4pQKUgBE0VavPsa
	 xRRIBibtzjfp9hoiV9OKlX3QQWTgp498lZVZfDLDc7Uo2ns3z/dwIxqzzTZ21jdYb4
	 /o6tmgcdeuFdHQt/6RuRlFOyTBdIbeUFkMMjckY+/TEx222A4/i8/3wPGrDG9AhsUS
	 KTCBICobo8ECA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6C516CE26CA; Wed,  7 Oct 2026 13:36:37 -0700 (PDT)
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
Subject: [PATCH 5/5] xtensa: Emulate two-byte cmpxchg
Date: Wed,  7 Oct 2026 13:36:36 -0700
Message-Id: <20261007203636.1982188-5-paulmck@kernel.org>
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

Xtensa has no two-byte atomic compare and swap, so the __cmpxchg()
switch lets case 2 fall through to __cmpxchg_called_with_bad_pointer(),
which is declared but never defined, so a two-byte cmpxchg() fails
at link time.

Route case 2 through the new cmpxchg_emu_u16(), which takes the
old and new values as unsigned long and narrows them itself, so
the call needs no extra casts.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 arch/xtensa/include/asm/cmpxchg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/xtensa/include/asm/cmpxchg.h b/arch/xtensa/include/asm/cmpxchg.h
index b6db4838b175a..8dea8e357fc0f 100644
--- a/arch/xtensa/include/asm/cmpxchg.h
+++ b/arch/xtensa/include/asm/cmpxchg.h
@@ -76,6 +76,7 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
 {
 	switch (size) {
 	case 1:  return cmpxchg_emu_u8(ptr, old, new);
+	case 2:  return cmpxchg_emu_u16(ptr, old, new);
 	case 4:  return __cmpxchg_u32(ptr, old, new);
 	default: __cmpxchg_called_with_bad_pointer();
 		 return old;
-- 
2.40.1

