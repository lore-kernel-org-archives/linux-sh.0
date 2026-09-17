Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161745326B5;
	Thu, 17 Sep 2026 16:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663114; cv=none; b=DvMlbHDfEp0yKctpkJrgX38l2Ziv50Qj4m/6oX9ojGeQk8db7f9DFI3+ccVhGRGPUej+zMuyYNgWycThEp6Q5ZvGN8DFb650KBIPZ162iI6GwAubjpTZHpk6YdSU8GHUEmLXw6czmhHLUxXhWYnOtxjI188Qfyv+0p2lO+4hi68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663114; c=relaxed/simple;
	bh=BX9WNdZufbWprvJbPMPD1w4q+D+NjqKR6JUQjxpvVYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mkx4az2CgWeVSd/ppb4laoK+hVwkRU62GHQI/J2NGduBywlFCRNxLJTdgsiotccfdfzpF65G23ZDZM9qu5zLQAFy3ROBGTfmoq8AoTZcK+3iALfMUaGJESN9aZKGUWknQDh0xFKLEwfAxFbeP9B8rO2vJti1zE6fgRULlQqWAXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=Uey6ojlB; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=GJFMSOJ/; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="Uey6ojlB";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="GJFMSOJ/"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1789663110; bh=UzuuztJ96GodZiYpCdr9PXx
	KbUbb9g6GDMlOpp8jCz0=; b=Uey6ojlBricx6j3eF+zvmZVsAm3pr7poFIvNCspe5oYMpEOujq
	8k9LgLJQ9U+Lj+i519fVPnOGYoy1NAEv4cCcmxBAuwCeEOe+TMECGOodA4gRNB7zYxN9tPstrKn
	r756ENzcqc4qcBPAdjnGfFotcpPyxeemJKBB21Q54VDhotiIWots39X7XD+lduqUQ/dCPkNZO16
	C5vpqWiERKYPZqdSFsHBx49rjm6qMxDUsnBnD9xw+n6d/NTENC/qTVN7Yrulxhl5L9MmCTzKBFD
	7eaqZZiY0dXEnN1sk4iBpnOokSX1bLUBb9R6S+auGhuMe4cl/cX9BfU9jMHwMvqjwzQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1789663110; bh=UzuuztJ96GodZiYpCdr9PXx
	KbUbb9g6GDMlOpp8jCz0=; b=GJFMSOJ/EFRHywZQSyCl/9IdHYQgafn6hclK0Aj0bToaciOukv
	QY8DN1ApE4yNlmhRfc4Vsd89PmOMG64jVeDA==;
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
Subject: [PATCH v3 0/5] Add two-byte cmpxchg emulation and wire it into the architectures
Date: Thu, 17 Sep 2026 16:38:25 +0000
Message-ID: <20260917163830.3748-1-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v3 of the two byte cmpxchg emulation series, wiring
cmpxchg_emu_u16() into arc, csky, sh and xtensa.

v2 tried u16 as the parameter type. David Laight pointed out that
this does not compile warning free when exchanging a pointer type,
because the switch statements in the architecture macros instantiate
every size case, so a pointer cmpxchg() type checks the two byte
case, and the (u16) casts there warn. v3 takes the old and new
values as unsigned long and casts to u16 inside the function, so the
call sites need no narrowing casts and pointer exchanges compile
clean. The function still compares and returns exactly the 16 bits
of the emulated halfword, which matches hardware cmpxchg r16
behaviour, and a host test of 972 cases across both halfword offsets
against a byte level reference model still passes.

David also noted the missing pointer to integer type check in some
of the macros, so cmpxchg(&p, 4, 5) compiled silently. The csky
macros typed __old and __new through __typeof__(old), which skips
the check, and sh had none either. Both now type check through
(unsigned long)(0 ? *(ptr) : (old)), the idiom David suggested,
which keeps the pointer to integer conversion explicit while making
the compiler reject mismatched types. Both of his test cases now
fail to compile on every macro shape.

The ARMv6 wiring stays dropped from v1, per Arnd Bergmann's offer to
take the INTEGRATOR_CM1136JFS cleanup in his platform removal series.

Thank you, Paul McKenney for suggesting this, and David Laight and
Arnd Bergmann for the review that shaped all three revisions.

Bradley Morgan (5):
  lib: Add two-byte cmpxchg emulation function
  ARC: Emulate two-byte cmpxchg
  csky: Emulate two-byte cmpxchg
  sh: Emulate two-byte cmpxchg
  xtensa: Emulate two-byte cmpxchg
-- 
2.47.3

