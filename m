Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E391349363D;
	Tue, 22 Sep 2026 17:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790098444; cv=none; b=Yijrl3uZh/EtPHIXuhmDkZnlctRHp5lcLfD1QvOavOh9AxEei+V6PztXRH06k9Q4cCtfsJlTCQNkaMge8HRaA1e6gzQnwFzhh5BHbLfxh3qGoDv91cYSm+m29Rus9Vr/B6WMABiwM54ddwpy7mrDee0hCEiAb6AIf6NIpMDLkS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790098444; c=relaxed/simple;
	bh=0baLLuys1CJ0oeIru0FLFNP/+yOGsexT1mFgt23wufo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l87sXhnGuMLZ5YtECgWbfGAc0yQZEWXozvpxxom5v0rRdN70DcVLcjpQ8EeKp87t0C/zTCLIbID5SmTUCXnT7HXXeho94BPjNvJ1T109qg9ZbHaQ7G+qmDL7c+jb+uMtju6lLA3eNaowO83id3EJWAth4WIKIZtV1qcJAAY42XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=reY1I7bK; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=0LZJeU2U; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="reY1I7bK";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="0LZJeU2U"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1790098433; bh=p7eL7CEIsluHKDjAYrzTOKe
	1um/hH8UVgVqh8wu1Mrs=; b=reY1I7bKx8E1NX5G7MHIHjJw5IDTmfzKhS1aJ3QFxkzjO7p/15
	EVi/yiR56Xb+TJtQq/3JAHmuoES6j7Dr9psJoCQ5Fhv7FtDy5a/O9CRDbsIRKsJbgBgZxw71QWm
	M1lk8neNwuQ6vk58PS4BCxHsshhR8ZwwJehGqtclvIhgczTIijjEz7zHA7nlDc54JMQ17bNphXo
	io91Yf3QB8Ovj/umVLgrn4CFA37++tuZg4EHeNScSMYJotqbaJceekbpJ8DSoFQijqgH7kY9uhn
	oSIknC3KdA3mcLjNlqAHWHH18yEIgyuI4u8GAhKNik6LGZThBfiDhaL88xYcw3fwEEQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1790098433; bh=p7eL7CEIsluHKDjAYrzTOKe
	1um/hH8UVgVqh8wu1Mrs=; b=0LZJeU2UH4F42xHxTDjd5Jdv6lSrF838OnZFhE5Bj/h6DwFdjm
	qnsVv4Evk9XOS0XFcLbg4zjI3n1ITBysM3CA==;
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
Subject: [PATCH v4 0/5] Add two-byte cmpxchg emulation and wire it into the architectures
Date: Tue, 22 Sep 2026 17:33:49 +0000
Message-ID: <20260922173354.14404-1-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v4 of the two byte cmpxchg emulation series, wiring
cmpxchg_emu_u16() into arc, csky, sh and xtensa.

v3 had changed cmpxchg_emu_u8()'s success return to (u16)old, which was
a 16-bit mask in the 8-bit function, and a dead one at that, since the
compare guarantees the low 8 bits of old are the byte being returned.
David Laight asked where that cast came from. v4 returns old unmasked,
the exact behaviour the one-byte emulator always had, so nothing that
uses cmpxchg_emu_u8() through the widened prototypes sees a change.

David also noted v3 extended the (unsigned long)(0 ? *ptr : (old)) type
check to csky and sh but not arc and xtensa. v4 adds it there too, so a
cmpxchg(&p, 4, 5) fails to compile on every architecture in the series,
verified with each architecture's macro instantiated standalone.

While adding the type check to arc, the switch subject turned out to be
sizeof((_p_)), the pointer, not sizeof(*(_p_)), the pointee. On 32-bit
arc the switch was always 4, so the size 1 and size 2 cases were dead
code and every sub-word cmpxchg() went through the 32-bit llock/scond
pair, comparing whole words against sub-word values, so the compare
almost never succeeded. The switch now tests the pointee, and the u8
path it was always meant to dispatch actually runs, so the one-byte
emulation works on arc for the first time since the sizeof bug landed
with the original cmpxchg_emu_u8() wiring.

The host test of 972 cases across both halfword offsets against a byte
level reference model still passes, and a 20000 case randomized run
checking the masked compare and return against a hardware cmpxchg r16
model passes with zero mismatches.

David pointed out on v1 that a u16 prototype does not compile warning
free when exchanging a pointer type, because the switch statements in
the architecture macros instantiate every size case, so a pointer
cmpxchg() type checks the two byte case, and the (u16) casts there
warn. v4 keeps taking the old and new values as unsigned long and
casting to u16 inside the function, so the call sites need no narrowing
casts and pointer exchanges compile clean. The function still compares
and returns exactly the 16 bits the caller asked for, which matches
hardware cmpxchg r16 behaviour.

The ARMv6 wiring stays dropped from v1, per Arnd Bergmann's offer to
take the INTEGRATOR_CM1136JFS cleanup in his platform removal series.

Bradley Morgan (5):
  lib: Add two-byte cmpxchg emulation function
  ARC: Emulate two-byte cmpxchg
  sh: Emulate two-byte cmpxchg
  csky: Emulate two-byte cmpxchg
  xtensa: Emulate two-byte cmpxchg
