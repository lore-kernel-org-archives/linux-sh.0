Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E099343E4A2;
	Wed, 16 Sep 2026 20:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789588968; cv=none; b=lpac5oVIwpVM9k4KvsgxgpnFo0erk8PYRnGqZ/agJpb10lnRByL/UhwDuP+gby02pFdtAn/Lcv1qBKftawGN9bLqNRz7kHvLv/OaNpn1xFTdZQ0PaDSkOA2XsBaMcVdOKJ1KWv51P5hquu5PMMQx0VC6DtbaG8PHmmRgmf2Eh2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789588968; c=relaxed/simple;
	bh=CnPQk5xHz0wKRKYP2fkyD+/dsIdYEO5cOQ4XeQu+MWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=id4VXdAilOya2FDt6r6cGb5b2clLoGKvL7nLItLgNWUEJbCrOxm4We0S1EBexIiVZnC1eYkdfnoVWREb5DBQQMvUW3tZJkMi1AXfLUUFe3FQR0HFvoUeUfUXQsDDq+N/RwaqT7JYUhlRGGhnign6dA2RHSerFDlcf70pEMnddv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=l73A9EjS; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=c/LfVz7t; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="l73A9EjS";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="c/LfVz7t"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1789588936; bh=RgSuWwdEtSR5tNlSbUFwtN1
	6+B/ED9O57B5SFsv+Sao=; b=l73A9EjSO6yR6WdliduzVn1CIfORqheLdIQdtdeLPAZWyxa11E
	0EpQWuNSbKcVrw6PeoDKKdoWN+1GVE9Y3rUy61FOsYrMa6HlNwD5eFBP/TP3STbRo5rOM15u0fY
	eidU56394BfiA2yBlM5yUYZEVUwCri+GzP55lMhuMNqYZF23VD1XlvH+ZNUXSp/NAme1jN8dn/d
	WQ2vxtBU2pLRQkqx12FsrNhBILKg59O6X61+8Xr1psbu/fpKurkzCb+rJn0m03Gkgwvq+cPHdpZ
	sYpRIl7fzRzn6hw/P8r+DoiAg72kDqixBXDxYCFvYlf6IvbNFBDlunD7/F4ulbwfOWA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1789588936; bh=RgSuWwdEtSR5tNlSbUFwtN1
	6+B/ED9O57B5SFsv+Sao=; b=c/LfVz7tNPTCmaPlbh3i+J7cFoigXYI7S5Rs8blqt5qqX61PKQ
	yrpQBKSCbiZBXokixP1nlTHs/FbUvzFV2UDQ==;
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
Subject: [PATCH v2 4/5] sh: Emulate two-byte cmpxchg
Date: Wed, 16 Sep 2026 20:02:14 +0000
Message-ID: <20260916200215.21774-5-brads@mainlining.org>
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

SH has no byte or halfword atomic memory operations, so the __cmpxchg()
switch routes case 1 through cmpxchg_emu_u8() and lets case 2 fall
through to __cmpxchg_called_with_bad_pointer(), which is declared but
never defined, so a two-byte cmpxchg() fails at link time. Route case
2 through the new cmpxchg_emu_u16(), which takes natural u16
arguments, so the unsigned long old and new narrow at the function
boundary.

Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/sh/include/asm/cmpxchg.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sh/include/asm/cmpxchg.h b/arch/sh/include/asm/cmpxchg.h
index 1e5dc5ccf7bf..477d3025a441 100644
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
2.47.3

