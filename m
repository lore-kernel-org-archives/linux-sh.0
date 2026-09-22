Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B93040DB4A;
	Tue, 22 Sep 2026 18:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790103581; cv=none; b=VwDKvoUC91lCBOrZ54odtwDcT7bEwstb39WaUpYcz3iEYLqG+UrGcfRerXE14XRDjmpInU5Fkzv2vlaL97t3K9pXGubzo55bDql3jWSbK0KsLe0ZPdZy9Y7/EHQaRcuu7bKiFuFGxiQxWUi0WgQBu4d3ZcvCgStFHhd9g0Hq4Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790103581; c=relaxed/simple;
	bh=mu9PB79vwgp0Rjt5HJRKG3AfiFHvTniTn/hC1L/y3XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkJkVzkEBo2P6MXqW5mO23xtik0jn+LShuc9a9iUqBlapOdjKeywXnNAjSZJlq0dOsgTQZQmB/NZtwJa5/i934h++CAxkBmQE/myeiJdPqA/UEmimnEuTJ553NCroHnLYWa/4XsVow0BW8r3IeALkAfsJaqLKVv1YFWdVTJ4hFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mU7cMGgi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mU7cMGgi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D261F00893;
	Tue, 22 Sep 2026 18:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790103579;
	bh=2cS0IN+mc7LICkSPU79FRHl95e7HBKcBaYCxbvbel3k=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=mU7cMGgiTHgl6EgoD5ZAQvaO6UK/6ezxZLiGew5Jwl8ZCUXUbkXhYfVHg6T1MtIGe
	 qvM1nuCU6EqwgLJ8eYlcn6LmSeAR38zdJ11dtLb+FUCNMOKjsfoKIIVFm5EgzWh7BY
	 UbUkwyhh2tO5IIZx7m65tXRrTMeq12/63dLPpdGJemMK20AyfMMUWFDmc+a2X6NfQ0
	 4alX4aHc32U0mWaK67LZynEkpMMrJcYkT8ckVk1UEJQhfkGma4mVhtexZlIqs0eB/y
	 kKJZPKX2eNxxXLlUnc9fOMkM5zX7p7gUPtJA8Evc2MjxZBI4J/CGoooGJBsXyoVO49
	 bW8MESKURf+CA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 43257CE0836; Tue, 22 Sep 2026 11:59:39 -0700 (PDT)
Date: Tue, 22 Sep 2026 11:59:39 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Bradley Morgan <brads@mainlining.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vineet Gupta <vgupta@kernel.org>, Guo Ren <guoren@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>, Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	David Laight <david.laight.linux@gmail.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-snps-arc@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] Add two-byte cmpxchg emulation and wire it into
 the architectures
Message-ID: <9a7883a3-a1b1-4d37-8234-f4c62b2e6e27@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260922173354.14404-1-brads@mainlining.org>
 <78f7ab38-46c8-4968-a2ae-4c3c98e32f4d@paulmck-laptop>
 <7BE5B8EA-FAFB-4CBB-8FF1-ECDEEB1618B0@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7BE5B8EA-FAFB-4CBB-8FF1-ECDEEB1618B0@mainlining.org>

On Tue, Sep 22, 2026 at 07:37:54PM +0100, Bradley Morgan wrote:
> On 22 September 2026 19:29:32 BST, "Paul E. McKenney" <paulmck@kernel.org>
> wrote:
> >On Tue, Sep 22, 2026 at 05:33:49PM +0000, Bradley Morgan wrote:
> >> This is v4 of the two byte cmpxchg emulation series, wiring
> >> cmpxchg_emu_u16() into arc, csky, sh and xtensa.
> >> 
> >> v3 had changed cmpxchg_emu_u8()'s success return to (u16)old, which was
> >> a 16-bit mask in the 8-bit function, and a dead one at that, since the
> >> compare guarantees the low 8 bits of old are the byte being returned.
> >> David Laight asked where that cast came from. v4 returns old unmasked,
> >> the exact behaviour the one-byte emulator always had, so nothing that
> >> uses cmpxchg_emu_u8() through the widened prototypes sees a change.
> >> 
> >> David also noted v3 extended the (unsigned long)(0 ? *ptr : (old)) type
> >> check to csky and sh but not arc and xtensa. v4 adds it there too, so a
> >> cmpxchg(&p, 4, 5) fails to compile on every architecture in the series,
> >> verified with each architecture's macro instantiated standalone.
> >> 
> >> While adding the type check to arc, the switch subject turned out to be
> >> sizeof((_p_)), the pointer, not sizeof(*(_p_)), the pointee. On 32-bit
> >> arc the switch was always 4, so the size 1 and size 2 cases were dead
> >> code and every sub-word cmpxchg() went through the 32-bit llock/scond
> >> pair, comparing whole words against sub-word values, so the compare
> >> almost never succeeded. The switch now tests the pointee, and the u8
> >> path it was always meant to dispatch actually runs, so the one-byte
> >> emulation works on arc for the first time since the sizeof bug landed
> >> with the original cmpxchg_emu_u8() wiring.
> >> 
> >> The host test of 972 cases across both halfword offsets against a byte
> >> level reference model still passes, and a 20000 case randomized run
> >> checking the masked compare and return against a hardware cmpxchg r16
> >> model passes with zero mismatches.
> >> 
> >> David pointed out on v1 that a u16 prototype does not compile warning
> >> free when exchanging a pointer type, because the switch statements in
> >> the architecture macros instantiate every size case, so a pointer
> >> cmpxchg() type checks the two byte case, and the (u16) casts there
> >> warn. v4 keeps taking the old and new values as unsigned long and
> >> casting to u16 inside the function, so the call sites need no narrowing
> >> casts and pointer exchanges compile clean. The function still compares
> >> and returns exactly the 16 bits the caller asked for, which matches
> >> hardware cmpxchg r16 behaviour.
> >> 
> >> The ARMv6 wiring stays dropped from v1, per Arnd Bergmann's offer to
> >> take the INTEGRATOR_CM1136JFS cleanup in his platform removal series.
> >
> >I have pulled these in, but only to expose them to things like the kernel
> >test robot.  My guess is that they will go in by some other path.
> >
> >And to that end:
> >
> >Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> >
> >But I could of course easily be missing subtle arch-specific bugs.
> 
> There are, according to sashiko, but I can't seem to make that thing happy
> no matter what I do

Hahahahaha!!!

We forgot to CC the architecture maintainers.

For the changes to lib/cmpxchg-emu.c:

	Cc: Andrew Morton <akpm@linux-foundation.org>
	Cc: Arnd Bergmann <arnd@kernel.org>

For ARC:

	Cc: Vineet Gupta <vgupta@kernel.org>
	linux-snps-arc@lists.infradead.org

For sh:

	Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
	Cc: Rich Felker <dalias@libc.org>
	Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
	Cc: <linux-sh@vger.kernel.org>

For csky:

	Cc: Guo Ren <guoren@kernel.org>
	Cc: <linux-csky@vger.kernel.org>
	Cc: <linux-kernel@vger.kernel.org>

For xtensa:

	Cc: Chris Zankel <chris@zankel.net>
	Cc: Max Filippov <jcmvbkbc@gmail.com>

They might be willing to help.  ;-)

							Thanx, Paul

> >> Bradley Morgan (5):
> >>   lib: Add two-byte cmpxchg emulation function
> >>   ARC: Emulate two-byte cmpxchg
> >>   sh: Emulate two-byte cmpxchg
> >>   csky: Emulate two-byte cmpxchg
> >>   xtensa: Emulate two-byte cmpxchg
> 
> --- Thanks!
> "I'm not a very positive person" - Linus torvalds
