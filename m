Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5DE48F82A;
	Tue, 22 Sep 2026 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790102427; cv=none; b=uhRYAgCzZne2dX20jjlUOWwn8cJvHd4b7jJsXsXR2wzLlZxiMI4J+LJqJkmy16eawD7vvy6XHR+aLUjLl+B6QJ9ez5yUKTpplDXc8ih048FTMmjuTnS7mf25mnChBSWnRgbKxJfFA08+usWkxfMY2uscDFUrkdlUKpi0r+gvWCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790102427; c=relaxed/simple;
	bh=BWsJRoAQqxj59ti8UCODVBFnlbBJmIcFm8+gdAHINSU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=WG+0Ko724TSOGOmvc0xEaXqH7sVzsdqzr/s6HVApKBV90kkc1cHooudI3zDrOU3jOblTzsjkb6s0sYtkm93EDTlNhwmOzhagITfzuT/jA6ANjZ/Az4jPAAGy+fulmVCOeF0Ks/8gFSNl3vN+7zo/6MTsSCGcmQNGR2ihSZi3kHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=QskZmMwd; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=suaoituA; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="QskZmMwd";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="suaoituA"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790102273; bh=GhL/OKSrQi7a2VgZmyNvxdS
	rDOhPoV7pImkjsaA2JhI=; b=QskZmMwdBGolMfxnZdaE963fhpAOlEkoqyHwSTJVngPOon5/D9
	h9WarS9jWq1oz3Fr0iFnGGxNi/hlWfs4mlhH3S68fi0Q/7eArzrF+iNNdveZfNB1x0yKd14vuu4
	dtdRZZcYbYmhcRFEms6X+FOjowsIUBiJz2Oa54fKQhR73e55cdYUJqiN++9xYBegvjigKAoL3C0
	tXxxi2mc1Wh6F+fFPnD25Td6ljiwJxXMH8+aYH/Gj6e4hSvreHLfnFv7Cw0eCPLi2BVQyuHH0hr
	WRFRGu/C03xDWq+X4Xae/C8gj+zStWRDAYh5c6zjrrSVpxBi5LXm89+yYQAhbR1ZNWw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790102273; bh=GhL/OKSrQi7a2VgZmyNvxdS
	rDOhPoV7pImkjsaA2JhI=; b=suaoituAEGJ9M5GSztQR2oQx0LBSBx/lwHTkfsLum+7Bb4sZMj
	yWqpW4ku2S5RUnqVWZnRTY07z/Chof4pp1CA==;
Date: Tue, 22 Sep 2026 19:37:54 +0100
From: Bradley Morgan <brads@mainlining.org>
To: paulmck@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, Vineet Gupta <vgupta@kernel.org>,
 Guo Ren <guoren@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 David Laight <david.laight.linux@gmail.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-snps-arc@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_0/5=5D_Add_two-byte_cmpxchg_em?=
 =?US-ASCII?Q?ulation_and_wire_it_into_the_architectures?=
In-Reply-To: <78f7ab38-46c8-4968-a2ae-4c3c98e32f4d@paulmck-laptop>
References: <20260922173354.14404-1-brads@mainlining.org> <78f7ab38-46c8-4968-a2ae-4c3c98e32f4d@paulmck-laptop>
Message-ID: <7BE5B8EA-FAFB-4CBB-8FF1-ECDEEB1618B0@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 22 September 2026 19:29:32 BST, "Paul E. McKenney" <paulmck@kernel.org>
wrote:
>On Tue, Sep 22, 2026 at 05:33:49PM +0000, Bradley Morgan wrote:
>> This is v4 of the two byte cmpxchg emulation series, wiring
>> cmpxchg_emu_u16() into arc, csky, sh and xtensa.
>> 
>> v3 had changed cmpxchg_emu_u8()'s success return to (u16)old, which was
>> a 16-bit mask in the 8-bit function, and a dead one at that, since the
>> compare guarantees the low 8 bits of old are the byte being returned.
>> David Laight asked where that cast came from. v4 returns old unmasked,
>> the exact behaviour the one-byte emulator always had, so nothing that
>> uses cmpxchg_emu_u8() through the widened prototypes sees a change.
>> 
>> David also noted v3 extended the (unsigned long)(0 ? *ptr : (old)) type
>> check to csky and sh but not arc and xtensa. v4 adds it there too, so a
>> cmpxchg(&p, 4, 5) fails to compile on every architecture in the series,
>> verified with each architecture's macro instantiated standalone.
>> 
>> While adding the type check to arc, the switch subject turned out to be
>> sizeof((_p_)), the pointer, not sizeof(*(_p_)), the pointee. On 32-bit
>> arc the switch was always 4, so the size 1 and size 2 cases were dead
>> code and every sub-word cmpxchg() went through the 32-bit llock/scond
>> pair, comparing whole words against sub-word values, so the compare
>> almost never succeeded. The switch now tests the pointee, and the u8
>> path it was always meant to dispatch actually runs, so the one-byte
>> emulation works on arc for the first time since the sizeof bug landed
>> with the original cmpxchg_emu_u8() wiring.
>> 
>> The host test of 972 cases across both halfword offsets against a byte
>> level reference model still passes, and a 20000 case randomized run
>> checking the masked compare and return against a hardware cmpxchg r16
>> model passes with zero mismatches.
>> 
>> David pointed out on v1 that a u16 prototype does not compile warning
>> free when exchanging a pointer type, because the switch statements in
>> the architecture macros instantiate every size case, so a pointer
>> cmpxchg() type checks the two byte case, and the (u16) casts there
>> warn. v4 keeps taking the old and new values as unsigned long and
>> casting to u16 inside the function, so the call sites need no narrowing
>> casts and pointer exchanges compile clean. The function still compares
>> and returns exactly the 16 bits the caller asked for, which matches
>> hardware cmpxchg r16 behaviour.
>> 
>> The ARMv6 wiring stays dropped from v1, per Arnd Bergmann's offer to
>> take the INTEGRATOR_CM1136JFS cleanup in his platform removal series.
>
>I have pulled these in, but only to expose them to things like the kernel
>test robot.  My guess is that they will go in by some other path.
>
>And to that end:
>
>Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
>
>But I could of course easily be missing subtle arch-specific bugs.

There are, according to sashiko, but I can't seem to make that thing happy
no matter what I do

>
>							Thanx, Paul
>
>> Bradley Morgan (5):
>>   lib: Add two-byte cmpxchg emulation function
>>   ARC: Emulate two-byte cmpxchg
>>   sh: Emulate two-byte cmpxchg
>>   csky: Emulate two-byte cmpxchg
>>   xtensa: Emulate two-byte cmpxchg

--- Thanks!
"I'm not a very positive person" - Linus torvalds
