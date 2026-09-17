Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4B252F29F;
	Thu, 17 Sep 2026 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663355; cv=none; b=DjtmUBQKCs/MaRaZtwNFvZY1J8s/WGUGUS8Vfx5+htP2PromL6VP6fRo7xRIg/M/3LTz/AO8tEuBSgPrWdn7G/W/cyBWoWTpKC8CEt0Mrrmxl6CpFb2mEtLi+gej5G45RzLutbuE0XMhhVU02AwqFZ6NKC2Eczco81kDwFt9dJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663355; c=relaxed/simple;
	bh=TmHI8JCwuZQTm90hLrpMH12GXmAQtGw0tM+6wx4Xe7Y=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=QWCKLNXpNENGwsdJ0Z933LbyxepRMdl7z0EPGzu9IIcoF4TTpuAgX7Q++fTVqxmdpU4FWNH8nLRN+gNuVH/YjybaGr17/G9i6Ygce42Y5HZvpBPsMVHzrAcG9y4Xyf9bRIQQf3fOqhUXANxRYfwmwZdI4mnnC/29OEZd7yg7vLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=hJueiS/4; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=OI0tFVhm; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="hJueiS/4";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="OI0tFVhm"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1789663338; bh=juRRI8MQIpYjs0BhSu4tGaP
	+X+54DRB7SI1nxHvfH+A=; b=hJueiS/4t9OIuq2NQI0xcpJLPZdB552eAartHZwhIRDKn64ALf
	tSgWAozL9qE69oGlBA4nItYz5U0gvzMObF4aZq3gme9/kDmlLuKbn5BJ/3mViw5MvejlDjHZfON
	kmeetPp1OvQ1nmXwCiaXikD7BLKpSRvJjtDRM3ndq0EeofS7penuWEXRneYhidDhLY/Mb4Dcj23
	8sUuqe5so33bKmLb+ZJUXuXDQqXl5N26KngeqCErKgeuFY6yf2VMRahb5JAcl1yhxsQzUbTAm5+
	DRNKu6+AgD8R7ohQF+jjvakxrRusxddhLkAm9cEF4Q12qaSXI86sco8BSB8IBZIDKpQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1789663338; bh=juRRI8MQIpYjs0BhSu4tGaP
	+X+54DRB7SI1nxHvfH+A=; b=OI0tFVhmDQud8l5AFH+TUgN/Ou4Qha125rpyARyZ9HM2eKky3n
	5f3b2rkTqXr9Q6g6MRRBktwz1ZwCCN9hTfBQ==;
Date: Thu, 17 Sep 2026 17:42:18 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Andrew Morton <akpm@linux-foundation.org>, Vineet Gupta <vgupta@kernel.org>,
 Guo Ren <guoren@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>
CC: Arnd Bergmann <arnd@arndb.de>, "Paul E . McKenney" <paulmck@kernel.org>,
 David Laight <david.laight.linux@gmail.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-snps-arc@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] xtensa: Emulate two-byte cmpxchg
In-Reply-To: <20260917163830.3748-6-brads@mainlining.org>
References: <20260917163830.3748-1-brads@mainlining.org> <20260917163830.3748-6-brads@mainlining.org>
Message-ID: <93B03090-99CA-4226-91F0-7A7508521953@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 17 September 2026 17:38:30 BST, Bradley Morgan <brads@mainlining.org>
wrote:
>Xtensa has no two-byte atomic compare and swap, so the __cmpxchg()
>switch lets case 2 fall through to __cmpxchg_called_with_bad_pointer(),
>which is declared but never defined, so a two-byte cmpxchg() fails at
>link time. Route case 2 through the new cmpxchg_emu_u16(), which takes
>the old and new values as unsigned long, so the (unsigned long) casts
>on _o_ and _n_ at the call move into the function and the macro's
>__typeof__(*(ptr)) typing of _o_ and _n_ remains the pointer-integer
>type check.
>
>Signed-off-by: Bradley Morgan <brads@mainlining.org>
>---
> arch/xtensa/include/asm/cmpxchg.h | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/arch/xtensa/include/asm/cmpxchg.h b/arch/xtensa/include/asm/cmpxchg.h
>index b6db4838b175..8dea8e357fc0 100644
>--- a/arch/xtensa/include/asm/cmpxchg.h
>+++ b/arch/xtensa/include/asm/cmpxchg.h
>@@ -76,6 +76,7 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
> {
> 	switch (size) {
> 	case 1:  return cmpxchg_emu_u8(ptr, old, new);
>+	case 2:  return cmpxchg_emu_u16(ptr, old, new);
> 	case 4:  return __cmpxchg_u32(ptr, old, new);
> 	default: __cmpxchg_called_with_bad_pointer();
> 		 return old;
>
Oops! Forgot to add R-B tag! Merger, could you add this when it's ready to
merge?
--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
