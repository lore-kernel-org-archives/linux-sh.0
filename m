Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52023F1ABF;
	Tue, 22 Sep 2026 19:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790103979; cv=none; b=RyPwEcdPyusy9CqatLcWMvb11aU6dsTab4MUtZ96oOlGEJNFTbotGsUg7R9qU7CEUHCmTII7nl4+9l5ErATk8DVBn2bSRK3VMVcOmAF2tF3FgnzWTLvJZWZ8YH5ZcMvl2G50RiOIuDRmUqmzCHM/2zNASvcj+Dq2yYSsK7J01OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790103979; c=relaxed/simple;
	bh=vfqSh+6dOBrxU+Yer9o6ibXq3uxxBtm6KWGhNCy9agc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=jS3f64j8EkoycSoZ7tnsL7fJmeMVg0Tp66YYV7Jx1RIPETi6Uh9BxitRZqzRtLa+9+gpLxv/8r1qvBzUpJtue+v7MkFZd1Wl+ajzaZNlqggWMpI0v2/qaq+RlVhva5uP2xCOQ9g5rnYmAmeZ75OOyP0+tnqw39CmZ9peqiNZed4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=qBxUeZo5; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=RoEzRPn8; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="qBxUeZo5";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="RoEzRPn8"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790103833; bh=TXaHVKdaLMh+Ggtg/GTxwal
	8Era3WZxI1OjtReeFIak=; b=qBxUeZo5jMTJ/dYL/FeHqDowud3vRRB6k+650h/bZa3pX9YQka
	eHY7fGy7zIlm2mejkhNcuAbVp4meYb3FGhyqXAcpfomoB++ZuvXck8103V7aOYNB21HZusx7Fns
	BWopUhPjeC5YT4s4kwK343xsKKu8ggaHtqGkifogQ4WKEmSlGV94diTZBWsQ0WUT43f4B1U3/g1
	wiNEVIXckvi6sDIE3mp2uWM+WRzI9jJU0j/17VmQBFIeMURSLrArmqARiJcr8Xe0iVOCEBObOp/
	Vir5HUZ+Ukq0kr/qCBqwTeBm9EIp3AF3oXgYNuu+zFnaBFyQB7RTkXqmNhRuOB54HKQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790103833; bh=TXaHVKdaLMh+Ggtg/GTxwal
	8Era3WZxI1OjtReeFIak=; b=RoEzRPn8UZ836Q5JOcKpdIaPTh1MS71atIZc6oRwHGNE/2t2ly
	Nea7OmIU7IOscYdUl2SZ/QzqYeQQzcVLGQBA==;
Date: Tue, 22 Sep 2026 20:03:51 +0100
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
In-Reply-To: <9a7883a3-a1b1-4d37-8234-f4c62b2e6e27@paulmck-laptop>
References: <20260922173354.14404-1-brads@mainlining.org> <78f7ab38-46c8-4968-a2ae-4c3c98e32f4d@paulmck-laptop> <7BE5B8EA-FAFB-4CBB-8FF1-ECDEEB1618B0@mainlining.org> <9a7883a3-a1b1-4d37-8234-f4c62b2e6e27@paulmck-laptop>
Message-ID: <FDE80F3F-6F96-4A6A-8536-0B2A4ED793A6@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 22 September 2026 19:59:39 BST, "Paul E. McKenney" <paulmck@kernel.org>
wrote:
>On Tue, Sep 22, 2026 at 07:37:54PM +0100, Bradley Morgan wrote:
>> On 22 September 2026 19:29:32 BST, "Paul E. McKenney"
><paulmck@kernel.org>
>> wrote:
>> >On Tue, Sep 22, 2026 at 05:33:49PM +0000, Bradley Morgan wrote:
>> >> This is v4 of the two byte cmpxchg emulation series, wiring
>> >> cmpxchg_emu_u16() into arc, csky, sh and xtensa.
>> >> 
>> >> v3 had changed cmpxchg_emu_u8()'s success return to (u16)old, which
>was
>> >> a 16-bit mask in the 8-bit function, and a dead one at that, since
>the
>> >> compare guarantees the low 8 bits of old are the byte being returned.
>> >> David Laight asked where that cast came from. v4 returns old
>unmasked,
>> >> the exact behaviour the one-byte emulator always had, so nothing that
>> >> uses cmpxchg_emu_u8() through the widened prototypes sees a change.
>> >> 
>> >> David also noted v3 extended the (unsigned long)(0 ? *ptr : (old))
>type
>> >> check to csky and sh but not arc and xtensa. v4 adds it there too, so
>a
>> >> cmpxchg(&p, 4, 5) fails to compile on every architecture in the
>series,
>> >> verified with each architecture's macro instantiated standalone.
>> >> 
>> >> While adding the type check to arc, the switch subject turned out to
>be
>> >> sizeof((_p_)), the pointer, not sizeof(*(_p_)), the pointee. On
>32-bit
>> >> arc the switch was always 4, so the size 1 and size 2 cases were dead
>> >> code and every sub-word cmpxchg() went through the 32-bit llock/scond
>> >> pair, comparing whole words against sub-word values, so the compare
>> >> almost never succeeded. The switch now tests the pointee, and the u8
>> >> path it was always meant to dispatch actually runs, so the one-byte
>> >> emulation works on arc for the first time since the sizeof bug landed
>> >> with the original cmpxchg_emu_u8() wiring.
>> >> 
>> >> The host test of 972 cases across both halfword offsets against a
>byte
>> >> level reference model still passes, and a 20000 case randomized run
>> >> checking the masked compare and return against a hardware cmpxchg r16
>> >> model passes with zero mismatches.
>> >> 
>> >> David pointed out on v1 that a u16 prototype does not compile warning
>> >> free when exchanging a pointer type, because the switch statements in
>> >> the architecture macros instantiate every size case, so a pointer
>> >> cmpxchg() type checks the two byte case, and the (u16) casts there
>> >> warn. v4 keeps taking the old and new values as unsigned long and
>> >> casting to u16 inside the function, so the call sites need no
>narrowing
>> >> casts and pointer exchanges compile clean. The function still
>compares
>> >> and returns exactly the 16 bits the caller asked for, which matches
>> >> hardware cmpxchg r16 behaviour.
>> >> 
>> >> The ARMv6 wiring stays dropped from v1, per Arnd Bergmann's offer to
>> >> take the INTEGRATOR_CM1136JFS cleanup in his platform removal series.
>> >
>> >I have pulled these in, but only to expose them to things like the
>kernel
>> >test robot.  My guess is that they will go in by some other path.
>> >
>> >And to that end:
>> >
>> >Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
>> >
>> >But I could of course easily be missing subtle arch-specific bugs.
>> 
>> There are, according to sashiko, but I can't seem to make that thing
>happy
>> no matter what I do
>
>Hahahahaha!!!
>
>We forgot to CC the architecture maintainers.
>
>For the changes to lib/cmpxchg-emu.c:
>
>	Cc: Andrew Morton <akpm@linux-foundation.org>
>	Cc: Arnd Bergmann <arnd@kernel.org>
>
>For ARC:
>
>	Cc: Vineet Gupta <vgupta@kernel.org>
>	linux-snps-arc@lists.infradead.org
>
>For sh:
>
>	Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>	Cc: Rich Felker <dalias@libc.org>
>	Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>	Cc: <linux-sh@vger.kernel.org>
>
>For csky:
>
>	Cc: Guo Ren <guoren@kernel.org>
>	Cc: <linux-csky@vger.kernel.org>
>	Cc: <linux-kernel@vger.kernel.org>
>
>For xtensa:
>
>	Cc: Chris Zankel <chris@zankel.net>
>	Cc: Max Filippov <jcmvbkbc@gmail.com>
>
>They might be willing to help.  ;-)
>
>							Thanx, Paul
>
>> >> Bradley Morgan (5):
>> >>   lib: Add two-byte cmpxchg emulation function
>> >>   ARC: Emulate two-byte cmpxchg
>> >>   sh: Emulate two-byte cmpxchg
>> >>   csky: Emulate two-byte cmpxchg
>> >>   xtensa: Emulate two-byte cmpxchg
>> 
>> --- Thanks!
>> "I'm not a very positive person" - Linus torvalds
If I have to do another 100 revisions I'll die, I'm suggesting getting the
new function in first, then converting arches later? Or does this break
arches.
--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
