Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13AD44E676;
	Wed, 16 Sep 2026 20:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789588976; cv=none; b=LNvXGhbVDfGp/YfTWlOUqFqPATUB+FWXG4qMHK969jci1q6uJVu3FaWNwqNo10+8LrHXRwftq5WURrbhw8UAsNEciamwBI7asV/lMYF9BFq64WzFTg4IGmmspT9oE3JMZV/9b891c8pkFOyeD/FxOLsz40EaEdpiYWFEx8nJVR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789588976; c=relaxed/simple;
	bh=QtQDFR8Z/m7pyHbAm56/oeaw6UvTCiKR8EswNkTs6AU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j+ehpABl2BlRihaY6uXqKwslNMOI18X50XkpWG9+ujVqwaDTQrKz3mc2gyrVdbH5iQEyb/ZwUvdTm3ebU1vPBgVI5wX7a4SVihP6rrVcByh0YgSSkeb24itHZJTa9IcUcbjBRBc0fzNFNU9Nq5nK9rso47F9aXJSx6kMGsVtL+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=UJOLaJ1e; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=RfW+hV8x; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="UJOLaJ1e";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="RfW+hV8x"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1789588934; bh=R2ofPh15IK7hgrgGQONfmRW
	iJZeWXsO+PWe6T21uQx0=; b=UJOLaJ1eyafCKV7a9AtG/fexlsbAVjlyPySLlnSeJySUvFOZaP
	4ivAjaB+xDcuO0CdoybKoj+vJONuC3Tb+wIIawMuN2W4yTVV7XL/vQS+aGNg8qxBTvx9aQEB8RI
	D88wovBOYCyHHqNMDoMZSoRzCubZKLXUbZFsCXFa7mnhJVr9I03m3tjBj7ra8QUv19EBSRf3YXx
	8f22tl/BbOpqpsKu84+DEF8VuaNyoXthTbr0J72gnJGsPOOqDTkdZA8vrQMkx1nsV5oE9mKjtYf
	FcXtpW0eu26p18O/zFsBnUSPRljeLLZR0HEVQksZHbCd3mhyvRxCPDT1idi8cwTXLzg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1789588934; bh=R2ofPh15IK7hgrgGQONfmRW
	iJZeWXsO+PWe6T21uQx0=; b=RfW+hV8x62kBsD6o0b/ZReKRmxQZWh484SkNrMwIY/kuHPPt2G
	urIZ9Plfi1IN8HPS2awi6YU6YCnDO+a5QZAA==;
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
Subject: [PATCH v2 0/5] Add two-byte cmpxchg emulation and wire it into the architectures
Date: Wed, 16 Sep 2026 20:02:10 +0000
Message-ID: <20260916200215.21774-1-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds cmpxchg_emu_u16() next to cmpxchg_emu_u8() and wires it into
the architectures that use the one byte emulation, arc, csky, sh and
xtensa.

David Laight noted that uintptr_t was an odd choice for the API and
suggested u16 as the natural type, so v2 takes u16 arguments and the
cast work moves to the architectures. The arc and csky call sites
cast to u16 instead of uintptr_t, and sh and xtensa pass the values
through unchanged, letting the narrowing happen at the function
boundary.

The experiment answers David's question about what the 32 bit word
compare does with an API typed u16. It compares only the 16 bits that
make up the halfword being emulated, because the union splice packs
the caller's old value into the selected halfword of the compare word
before the word wide cmpxchg runs, and the union layout puts every
h[i] at byte offset 2*i on both endian layouts. A value wider than 16
bits can never reach the compare, so the return value is the old
halfword contents, exactly what cmpxchg() returns on architectures
with a native two byte variant.

The ARMv6 wiring is dropped. Arnd Bergmann's platform removal series
makes the ARMv6 path unreachable once it lands, and he offered to take
the INTEGRATOR_CM1136JFS cleanup as part of it, so the wiring here
would be churn against his tree. I will forward port this part once
the mach-versatile removal actually happens, if the path still exists
then.

Patch 1 adds the function, the prototype, and renames the Kconfig
symbol to ARCH_NEED_CMPXCHG_1_2_EMU since it now gates both
emulations. Patches 2 through 5 add case 2 beside each existing case
1, following each file's current style. The function body follows the
two byte implementation in Paul's April 2024 RFC series, of which only
the one byte part landed as commit a88d970c8bb5 ("lib: Add one-byte
emulation function").

Verification. A host test ran 972 cases across both halfword offsets,
matching and mismatching compares, against a byte level reference
model, all passing. The remaining checkpatch warnings are the volatile
and long line ones that the merged cmpxchg_emu_u8() lines already
carry.

Changes since v1:
- u16 arguments instead of uintptr_t, per David Laight
- ARMv6 wiring dropped, per Arnd Bergmann's offer and the discussion
  with Paul McKenney
- copyright lines now carry both authors, Paul's 2024 line and mine

Thank you, Paul McKenney, for suggesting this, and thank you David
Laight and Arnd Bergmann for the review.

Bradley Morgan (5):
  lib: Add two-byte cmpxchg emulation function
  ARC: Emulate two-byte cmpxchg
  csky: Emulate two-byte cmpxchg
  sh: Emulate two-byte cmpxchg
  xtensa: Emulate two-byte cmpxchg

 arch/Kconfig                      |  2 +-
 arch/arc/Kconfig                  |  2 +-
 arch/arc/include/asm/cmpxchg.h    |  3 +++
 arch/csky/Kconfig                 |  2 +-
 arch/csky/include/asm/cmpxchg.h   |  9 +++++++++
 arch/sh/Kconfig                   |  2 +-
 arch/sh/include/asm/cmpxchg.h     |  2 ++
 arch/xtensa/Kconfig               |  2 +-
 arch/xtensa/include/asm/cmpxchg.h |  1 +
 include/linux/cmpxchg-emu.h       |  4 +++-
 lib/Makefile                      |  2 +-
 lib/cmpxchg-emu.c                 | 38 ++++++++++++++++++++++------------
 12 files changed, 58 insertions(+), 11 deletions(-)
-- 
2.47.3

