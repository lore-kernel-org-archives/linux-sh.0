Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC1543FD18
	for <linux-sh@vger.kernel.org>; Wed, 23 Sep 2026 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790155971; cv=none; b=cCgTqoI6VVZ6FoBNVL4vQd3aMlx/fmR02ZZA9aHKdIqS6v9ofenXdpj/83KwlP0UOqnQnN80/wH7jL8D6qkAgMZ40pQm8HtI3a8YKsUSzd694Q4RfWOisJUCL2xaOTkxh0vzFH4ug2ZUNJLFTULjPczDGt+8b7Tr22a+Iqp1hig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790155971; c=relaxed/simple;
	bh=9yDvyN9MI78GMvcpn95njYuuU2JHgmS5aXoXqel5FDU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EnJK8ed21dyyJF96tHCs5X40TXOu+oNCkgI6wwnxUtHu37Kg/1SbQxG8+kLArEQh6j3VJp6o3sr9mCJRWzqV8DfT3GuVvuLbETTYs20ki6Iqm0qbcZqRGL41yB1Bu08LqdrD6v7rVpD3pWCGZItm3bgdKeIl5ifvWxP0s1lgPGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cS5l8ef1; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cS5l8ef1"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b91369d18so4687245e9.0
        for <linux-sh@vger.kernel.org>; Wed, 23 Sep 2026 02:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790155967; x=1790760767; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N7ccE9C9Rji5d1/6O5twnMh1K4GrGyorEDQqGjRm4Rc=;
        b=cS5l8ef1wOMNXdri/eHBwDmah6pw0P+HjSHCpvKZLC5Yj7cBQYiVmx2Ce2l7CxYGpI
         j7Y7IQ8XCndKiVqdCOWDs34SvE1cszgRup3rKKvIPWuI3vTi9SX7gN1NoNkfMxZUF+Dd
         XudV1wGAxay0cCSGRGPfBXFKstWbBiOkqBUbiGP17MfT/b0b7+l1VvE52EV8LMBLtvUq
         CmB+613yqH4LPKpJo8ruDPFCS2jTne6g7k6RYfyFb+oLXHn/vEskWTqnRIhme/3TvZM9
         1dbouGeKTWPbXttOX+83Jg+/E1/bhrvG354Y/s+1qumz2cXQNBsJucxqoL8FSYDguY1H
         0JCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790155967; x=1790760767;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N7ccE9C9Rji5d1/6O5twnMh1K4GrGyorEDQqGjRm4Rc=;
        b=aWQVjXqWULysBaQssYeAxl3Op/qJOJJYPZbMzGPmZMtDG36OnK9wlnBVCtHE6fzhzV
         GcR40RcQw4In30Yoq8gd59oG9BJ+j4Fv2J+l09wQyWng9Ir9ndr/OhlYNPI0hSg6OtlK
         cexQU/+A/AutP4rE96X8KOJ6upPbm5ofpFHEVwXVyu3Qv3ZKXwBFoxkJkWQQ0WAOn+Wy
         jFCoILqjZbNh6mQ1Vs7C9hPIVzRYaFJlI6zGIzFAXPHMDtnVFyCoLpaSrTsVVWVusVJ/
         1NuKBA1EvH+aVs/f3NKBqcrxCkzHDaceC7CJDDjCX2+RkFgcBIR2CXWRjZOTSk9LuVEP
         vGEw==
X-Forwarded-Encrypted: i=1; AKwUvBwtjJtqXZXiK4CxRRGu3r1KqaFgpTzoX+n4zoJ63rNOuWwUtx1QG0iqkfV8p5sEFuOYQ35RjB/vlQ==@vger.kernel.org
X-Gm-Message-State: AFuF++l0I2YusRbfplP0lJCKUIU97FK1zqXMBMcN8YpdF0/gtwCe4P+c
	1b+0d9EHSKHtWPb/FHx4yRpNn28pLTwTKMMhgCd8Ivu956dxUysLb0yl
X-Gm-Gg: AYBFou2YAIxq8xO/uujwgQe+YXuIaeIn3bFMxBNPxrpCwbjlmHeDNQOBo/EbYPau102
	B0CthOX7yrnI+oLoilgNgGOMtcc8W+PfqwkmViXSAZvYZRIlz5WSUUCJcdWEbvcWeAiDUIYisoS
	YUPsHK5IlTRfEkUXgsZIgxwA1qcZnG6ty/T8S6v1hnBIuAj6fwwzGWDn/8/syzY/VHlUlB+jvIB
	KeVJQnExIj78GU08WifpxNgp4MtJjTeu1fwTlD+1S2dXmnWdB/Co6+1DvFl+fHYjUyiLriOYY7C
	BJhU0uxFfOBUaifu1O1gGvrEIJagAb8nyFO8DOD0c6BQBfnrwV4oNZersQp52AqWRZEI5dlfRbZ
	hLqBAcTE2tNq6deWWsWKdT8O/PoXuy57D/+3FOQCgCMZC0dJqetCoK27fxcVUnru2uB33tL9mVX
	KYZc/p3Q9wUPluLYCabiGfUJ31+uYy7IgOVJHJiFZc/3v+WWLIPrhML3IIfe6lN/zcGHSBUv1b2
	QedMpLxItZWGoQ2Io8KG1ktKu5+zjVXPVE=
X-Received: by 2002:a05:600c:4f4f:b0:499:bf8c:cfd1 with SMTP id 5b1f17b1804b1-49fdee0afadmr31059425e9.2.1790155967384;
        Wed, 23 Sep 2026 02:32:47 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde1aca52sm64655025e9.14.2026.09.23.02.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 02:32:47 -0700 (PDT)
Date: Wed, 23 Sep 2026 10:32:45 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Bradley Morgan <brads@mainlining.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vineet Gupta
 <vgupta@kernel.org>, Guo Ren <guoren@kernel.org>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Chris Zankel
 <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann
 <arnd@arndb.de>, "Paul E . McKenney" <paulmck@kernel.org>, John Paul Adrian
 Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-snps-arc@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] Add two-byte cmpxchg emulation and wire it into
 the architectures
Message-ID: <20260923103245.4c13e90d@pumpkin>
In-Reply-To: <20260922173354.14404-1-brads@mainlining.org>
References: <20260922173354.14404-1-brads@mainlining.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 17:33:49 +0000
Bradley Morgan <brads@mainlining.org> wrote:

> This is v4 of the two byte cmpxchg emulation series, wiring
> cmpxchg_emu_u16() into arc, csky, sh and xtensa.

Apart from a minor niggle, for the series.
Reviewed-by: David Laight <david.laight.linux@gmail.com>

> 
> v3 had changed cmpxchg_emu_u8()'s success return to (u16)old, which was
> a 16-bit mask in the 8-bit function, and a dead one at that, since the
> compare guarantees the low 8 bits of old are the byte being returned.
> David Laight asked where that cast came from. v4 returns old unmasked,
> the exact behaviour the one-byte emulator always had, so nothing that
> uses cmpxchg_emu_u8() through the widened prototypes sees a change.
> 
> David also noted v3 extended the (unsigned long)(0 ? *ptr : (old)) type
> check to csky and sh but not arc and xtensa. v4 adds it there too, so a
> cmpxchg(&p, 4, 5) fails to compile on every architecture in the series,
> verified with each architecture's macro instantiated standalone.
> 
> While adding the type check to arc, the switch subject turned out to be
> sizeof((_p_)), the pointer, not sizeof(*(_p_)), the pointee. On 32-bit
> arc the switch was always 4, so the size 1 and size 2 cases were dead
> code and every sub-word cmpxchg() went through the 32-bit llock/scond
> pair, comparing whole words against sub-word values, so the compare
> almost never succeeded. The switch now tests the pointee, and the u8
> path it was always meant to dispatch actually runs, so the one-byte
> emulation works on arc for the first time since the sizeof bug landed
> with the original cmpxchg_emu_u8() wiring.
> 
> The host test of 972 cases across both halfword offsets against a byte
> level reference model still passes, and a 20000 case randomized run
> checking the masked compare and return against a hardware cmpxchg r16
> model passes with zero mismatches.
> 
> David pointed out on v1 that a u16 prototype does not compile warning
> free when exchanging a pointer type, because the switch statements in
> the architecture macros instantiate every size case, so a pointer
> cmpxchg() type checks the two byte case, and the (u16) casts there
> warn. v4 keeps taking the old and new values as unsigned long and
> casting to u16 inside the function, so the call sites need no narrowing
> casts and pointer exchanges compile clean. The function still compares
> and returns exactly the 16 bits the caller asked for, which matches
> hardware cmpxchg r16 behaviour.
> 
> The ARMv6 wiring stays dropped from v1, per Arnd Bergmann's offer to
> take the INTEGRATOR_CM1136JFS cleanup in his platform removal series.
> 
> Bradley Morgan (5):
>   lib: Add two-byte cmpxchg emulation function
>   ARC: Emulate two-byte cmpxchg
>   sh: Emulate two-byte cmpxchg
>   csky: Emulate two-byte cmpxchg
>   xtensa: Emulate two-byte cmpxchg

