Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684EC3EF65B;
	Wed, 16 Sep 2026 20:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789589109; cv=none; b=r6DGTImJEFBy+QOCiM0lAYCSU6CbIyN0c3dQnUyiEjPwEEAGcp19SXLmh1srpGklqTTWj/UO7jscIa9CgGn504mwEmXuezUeU4Qqtb5EIVposswgdr0wzjxTKyjLnB5V0hZ7RWotsqfc0u8g5mOeBi3AC64Bb9+aamg3+HdNYZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789589109; c=relaxed/simple;
	bh=1ff5/nczEYO3kkyeg21AsMw/jo427+wb5UJ/kpXO3vM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZ9m4dC93cp3g/gYH5ZdZZou6qaWKfaLDSCtOAPmqR2+dtGPfuxlPRnjhCt7gQe9dzJCEMrfLkEtifC5Uea87KIQKYrz/P6SUtemK+xdFbs/Q73vKYM9Qi6hcYF8pkXCdbZvrcTGsUQs49yxfnmoSRsUXKlSWfM3jP5f47/U0+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=dHD1HWO+; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=uI3PUxmR; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="dHD1HWO+";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="uI3PUxmR"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1789588935; bh=1OXxOnbJI64tKjJBlcCcfNg
	/vmHmtRmMcXj4ssSqyI8=; b=dHD1HWO+3ETnfnxub467tSSinQ6AbN2y51X23r7Bht5gWglVMM
	Nlok2iptk4U04M82fZ8leUzk+ihL0NaLL0vHYPP724yQVZpGa0nhB+gU/iFlpfsKkxixDusu7lr
	jNrcKoYFAtqETzQbBh+8faNx0fAIDAJzXgmjmFL/7O9pwJcm2qkOczsS+Y1C2rAGPhsY749WDAS
	7QD6arsF02kSpsoXWAicZSTfVh/szo1ff2QIaozy+ivpS0WkK+HyoA64/bjnUA+WbHr4pf5zlmV
	ZEWf44Kg6LsJGRcm1aQhpiX9vRdMJUTsYyIhtKwB1iy5zZnB74NPLci+wPUR09zctmA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1789588935; bh=1OXxOnbJI64tKjJBlcCcfNg
	/vmHmtRmMcXj4ssSqyI8=; b=uI3PUxmRuoMkYc14i+UHDku63fW62n8nkas/svUZhCU0d/DWk0
	TsjJew1QWX6XuXf9vkWZTCLMrkejqMK85fDg==;
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
Subject: [PATCH v2 2/5] ARC: Emulate two-byte cmpxchg
Date: Wed, 16 Sep 2026 20:02:12 +0000
Message-ID: <20260916200215.21774-3-brads@mainlining.org>
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

ARC has no two-byte atomic compare and swap, so the __cmpxchg() macro
switch lets case 2 fall through to BUILD_BUG() via default. Route case
2 through the new cmpxchg_emu_u16(), which now takes natural u16
arguments, so the (uintptr_t) casts on _o_ and _n_ become (u16) casts.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/arc/include/asm/cmpxchg.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
index 76f43db0890f..4451c2011ee3 100644
--- a/arch/arc/include/asm/cmpxchg.h
+++ b/arch/arc/include/asm/cmpxchg.h
@@ -50,6 +50,9 @@
 	case 1:								\
 		_prev_ = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *__force)_p_, (uintptr_t)_o_, (uintptr_t)_n_);	\
 		break;							\
+	case 2:								\
+		_prev_ = (__typeof__(*(ptr)))cmpxchg_emu_u16((volatile u16 *__force)_p_, (u16)_o_, (u16)_n_);	\
+		break;							\
 	case 4:								\
 		_prev_ = __cmpxchg(_p_, _o_, _n_);			\
 		break;							\
-- 
2.47.3

