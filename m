Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603CE12E75;
	Thu, 19 Sep 2024 03:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726716270; cv=none; b=lRQ1kOA52tCKBzePoS4h1BL0svzAe3/DOvA4+yircSPtUwEA+2wdpT6Yb0C1BoXpCM0WxuDQ4YH+/Uoz2QKdV2IlualafqL6cf0IwNFCB3/JiubVCBERU/sngW94MxtJlkIEkTzTbkD7YJ9nNJmMrooMZrvrfMs7oahBrL0MIh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726716270; c=relaxed/simple;
	bh=XavaRRjgqHuw89P2ETaufGJfGVLuAtevPH8fhXQrExA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kIYgU3JEx5YtZKEG2jEoJL2xI8PlcAbcAhHrD6zE2ph7cNFz++ru+GZXzTiM8h/cOmyZDBv+ciL1IzncNLlDabN6JLdgemhoUaprLoTrlvO8ciTTkydYM5E9LQIEQf/3VGSUOWSv7lH9soc0hHyMJixD+0O4TCxGxYWTJm7cJl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=kKrfwXQz; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="kKrfwXQz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1726716265;
	bh=fZa83PjDF+loDF68mkxwlic+EMe/zFZXGtZzppvd0EI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kKrfwXQzYOVoLALAu4QL5cpeNLZ3QlBIP45hb3cw/4FvpWKiSfhgBqI9/imj0M0Hf
	 FcOhPgV7nLSzZozANLb+DWAG9iM+k7ioTpcaQK+Z/3dTu81vHqFjyQU4yBDtvMFr2T
	 vgAmi/i58LOQYT3ZCnzPkz+6KQPEwUlJBThCDLC1UDMLdR9fJmJayb6xiZjOp+/kTc
	 uSEJYWpnekmA0Y1inNEkjpEqoQabVADoCxvH3tbI5jTye0aknSrsJMoWCWl3DRbPgw
	 Z/PqCvPn1RU8HxzF+hG9DBu3xMzrAMEhf9/Xa+ut3OyOw8urSdGB6Ave3V6vLKrRLe
	 aveMIY2NWz7Aw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X8LTz0kTlz4xWZ;
	Thu, 19 Sep 2024 13:24:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Dave Vasilevsky <dave@vasilevsky.ca>, glaubitz@physik.fu-berlin.de,
 bhe@redhat.com, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 ebiederm@xmission.com
Cc: Dave Vasilevsky <dave@vasilevsky.ca>, Reimar =?utf-8?Q?D=C3=B6ffinger?=
 <Reimar.Doeffinger@gmx.de>
Subject: Re: [PATCH v2] crash, powerpc: Default to CRASH_DUMP=n on
 PPC_BOOK3S_32
In-Reply-To: <20240917163720.1644584-1-dave@vasilevsky.ca>
References: <20240917163720.1644584-1-dave@vasilevsky.ca>
Date: Thu, 19 Sep 2024 13:24:22 +1000
Message-ID: <87ttecpbq1.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dave Vasilevsky <dave@vasilevsky.ca> writes:
> Fixes boot failures on 6.9 on PPC_BOOK3S_32 machines using
> Open Firmware. On these machines, the kernel refuses to boot
> from non-zero PHYSICAL_START, which occurs when CRASH_DUMP is on.
>
> Since most PPC_BOOK3S_32 machines boot via Open Firmware, it should
> default to off for them. Users booting via some other mechanism
> can still turn it on explicitly.
>
> Does not change the default on any other architectures for the
> time being.
>
> Signed-off-by: Dave Vasilevsky <dave@vasilevsky.ca>
> Reported-by: Reimar D=C3=B6ffinger <Reimar.Doeffinger@gmx.de>
> Closes: https://lists.debian.org/debian-powerpc/2024/07/msg00001.html
> Fixes: 75bc255a7444 ("crash: clean up kdump related config items")
> ---
>  arch/arm/Kconfig       | 3 +++
>  arch/arm64/Kconfig     | 3 +++
>  arch/loongarch/Kconfig | 3 +++
>  arch/mips/Kconfig      | 3 +++
>  arch/powerpc/Kconfig   | 4 ++++
>  arch/riscv/Kconfig     | 3 +++
>  arch/s390/Kconfig      | 3 +++
>  arch/sh/Kconfig        | 3 +++
>  arch/x86/Kconfig       | 3 +++
>  kernel/Kconfig.kexec   | 2 +-
>  10 files changed, 29 insertions(+), 1 deletion(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
