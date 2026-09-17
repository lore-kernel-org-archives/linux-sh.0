Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D49E4F4CED;
	Thu, 17 Sep 2026 16:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663259; cv=none; b=K9kEhNKadyQiJc6itRmYmzFexGxqSrRDj5dKiHfdn3bmv5FlznYbiHu+ghC5U75CoWhgTatume8WiDVWd9EX5x++sTrweYcBiHFID2+X9IAYGfog9pV4jd7qvzWlP2/Qt+wJKgD3oqGMoYG689y48m/3jxNc9y59tdLGnxIdElo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663259; c=relaxed/simple;
	bh=qFn7dLToUkvIgv0m6saPs5B0Agok+SF6dJ4kaifw88U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W3RWcTb1s4GloAFvvxKoFO1lTzns7BHf2CWxq/AfgoFcq3jJEj1vStG6/hIBOypLV2YZh6o4r0Tm5Ctz7C2N9YuVeggy3HMH9q1/nkdlYt63ckOTMJJ+fdDwX+CrT4rj0fYhtrRSv6FUg7wsODrl51/3G3OL1JFx/Tw+eMH5SaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=rJO3Ncd/; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=1W+mBsO/; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="rJO3Ncd/";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="1W+mBsO/"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1789663110; bh=aoBMHO5+/N93x6VJ0ikS7kV
	mlAkKZm9tlGAN4/+qBSY=; b=rJO3Ncd/TnwsSG6RKws52boGwVzJTIPvSJEp4C7cL4OTLvpZqN
	IeFlOtZKzBFgxVuy03X79ASjrTRcxSsaBaD9ZdJTxYTO0Sierje8pTwulB9tiUTFE2kuMV4XHQk
	XE82T6ODkRn5X2pqSoOl3W5l5cOQQn5TOT48lwwWroD3Vt/yLF2+Wf7O+/ohZ8pz6AXLBx9CoF2
	FnR/Eylo5MjcHXjnT3NVHCcFMC7Z6gpgTF+4Lgu/K3KhQynA7F1Ttxb7PQmRf0TucjKBUzr7wvb
	H9lCObzaTfulg5yPgAF4gXSyoJ4OLQDlj4KxJmDr/tWhzqb+K/p4xnksRCWK8fPJ4Pw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1789663110; bh=aoBMHO5+/N93x6VJ0ikS7kV
	mlAkKZm9tlGAN4/+qBSY=; b=1W+mBsO/mmKw5OVcobpC6PP5Ha7M073LKARMu5sMFMTpULj9s4
	M4vkGskgCo9QyIECUmxAYNPQ1IJNLExTN4BQ==;
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
Subject: [PATCH v3 2/5] ARC: Emulate two-byte cmpxchg
Date: Thu, 17 Sep 2026 16:38:27 +0000
Message-ID: <20260917163830.3748-3-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917163830.3748-1-brads@mainlining.org>
References: <20260917163830.3748-1-brads@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ARC has no two-byte atomic compare and swap, so the __cmpxchg() macro
switch lets case 2 fall through to BUILD_BUG() via default. Route case
2 through the new cmpxchg_emu_u16(), which takes the old and new
values as unsigned long and narrows them itself, so the (uintptr_t)
casts on _o_ and _n_ are no longer needed and the case 2 call passes
them straight.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/arc/include/asm/cmpxchg.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
index 76f43db0890f..9b48b8fe0db2 100644
--- a/arch/arc/include/asm/cmpxchg.h
+++ b/arch/arc/include/asm/cmpxchg.h
@@ -50,6 +50,9 @@
 	case 1:								\
 		_prev_ = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *__force)_p_, (uintptr_t)_o_, (uintptr_t)_n_);	\
 		break;							\
+	case 2:								\
+		_prev_ = (__typeof__(*(ptr)))cmpxchg_emu_u16((volatile u16 *__force)_p_, (uintptr_t)_o_, (uintptr_t)_n_);	\
+		break;							\
 	case 4:								\
 		_prev_ = __cmpxchg(_p_, _o_, _n_);			\
 		break;							\
-- 
2.47.3

