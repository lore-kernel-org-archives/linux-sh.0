Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3808344237B;
	Wed, 16 Sep 2026 20:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789589096; cv=none; b=YptdlyaCQKKRG3rqLpKUNRipFt3pui1QqzaOwmY83kiSK9pQg6VwLvb2waSz9H7DeiZARODQMYDxIoznZUp0h05EsHIPrM/r1BN60QVCub5JtaBHQcCzCFlR8cyt6YedSPujmyP/TG5YhzjCy9epNdKPgsP+uLlNRZCpc6HDj9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789589096; c=relaxed/simple;
	bh=q8VUuAMu4loyahpVZ49szfxRv+8c4UDMw+jk/d97UGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QBklRKvS3exBJ8HIqfe6MlSow0Aug1wW/85+MneBsp1/h87tne7zNB9oiGw7mcvWN5whRRcEgVbdzxPDAbnWo4NRXRIn3dnH12ymIAhUmP2j0+vHp5fN7Ogz59VbfFRe59SKt3tLL3z4iTcZx3gcDQL/6woyIBi2cvPC+AqOzvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=QrcW/ZGs; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=GUPIOwdm; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="QrcW/ZGs";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="GUPIOwdm"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1789588936; bh=Cmoc+LvxrB8XTyAuxieF0n1
	oKRJqDrHiKarYKzS8wOk=; b=QrcW/ZGsGc/8zHko7LRpzYzG2forpReCVNUoEO/bRUiepdOsvJ
	Vr1/YF1bZ3Bw296iaAHCQclAkdJYIUR6E02L/Nq8tZfvVx22f7rYSWrsMTbLU1cW0SCq8DSeYnN
	BVg5WtgXATQq/GpIUm611bYcR9qe+DJR5ZKoAs7PnYH1aR23/+8gPaqNZIrUr/UxGocpngHCThG
	6HdW+Z51I7gGEhp+ZvlZ1zvFuicUibVeNY7bBLL5ZQc36Yj4a2dB1Cftd463cVKFVEOrAXDUAFN
	OOPI0h8Jmnqq22PWIuHK9IRam5z0qayaxb78HeVB4twBKIFxpaTu0fnjuLZrjs0ddrw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1789588936; bh=Cmoc+LvxrB8XTyAuxieF0n1
	oKRJqDrHiKarYKzS8wOk=; b=GUPIOwdm1MvUm482CkvGoF26O4/6Ajr0KBRTAKBF4cQt4KT7lo
	wqg+pzOKceAgkHmRUcBiSMNVP21Ag6YNpZDg==;
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
Subject: [PATCH v2 5/5] xtensa: Emulate two-byte cmpxchg
Date: Wed, 16 Sep 2026 20:02:15 +0000
Message-ID: <20260916200215.21774-6-brads@mainlining.org>
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

Xtensa has no two-byte atomic compare and swap, so the __cmpxchg()
switch lets case 2 fall through to __cmpxchg_called_with_bad_pointer(),
which is declared but never defined, so a two-byte cmpxchg() fails at
link time. Route case 2 through the new cmpxchg_emu_u16(), which takes
natural u16 arguments, so the unsigned long old and new narrow at the
function boundary.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/xtensa/include/asm/cmpxchg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/xtensa/include/asm/cmpxchg.h b/arch/xtensa/include/asm/cmpxchg.h
index b6db4838b175..8dea8e357fc0 100644
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
2.47.3

