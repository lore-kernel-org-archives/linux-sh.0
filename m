Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D6F335A7;
	Mon,  9 Sep 2024 06:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725864013; cv=none; b=LaC8UWA7Q7eAs8oS0iotLZbwVIK2XDtRfQ5dDSGp7PmD5r4tyZxiCdbxcgBT7cE8rVzKZBEo6Kf2TgKpcQC8PBtDtb87K/gYjZVWXV/BvSjIEjx+yPkwrakduyrje6cZt+dtF7iVM1GaNs7gt1v3pKSzbs+Oz4BhjbYilU2vPMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725864013; c=relaxed/simple;
	bh=6PbbI4EATTD/OrTPSWHrhxuPyO3m+IU1wrsU9S79Rm0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BwVDbOflTFf4NKKGWCAWfM31aqM5fci8GWW8OZwIimO5WoYzCu7F28uEkR7SdKx728xF7Yc/+MW+b0tV3wGAcR+wQMTFYvzfBj/RSg8vi4Jhp3RWtJBXbOMtts3vxHpCDTjJxW5YS2IVt+iaCKqNwd5kMhbK0AneJqzbvODTh5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=V9dqjOT5; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="V9dqjOT5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1725864005;
	bh=6PbbI4EATTD/OrTPSWHrhxuPyO3m+IU1wrsU9S79Rm0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=V9dqjOT5cG2Z/ik0KS2Ug814aSRbGFjOwq9SedHMMKCwpDrApwYz0ArGViy5Lb/a6
	 yyUPuQILPkjStOT8poYnkXv2Jooq74dG20gBuKXWTIdbtJfuzKXTK1LVngFS+qL47Y
	 plgL18Xfd9FhnusGMn98V4drs3aZqenn6kZzlW+KAAn68oBd1MaE8NVVkazwUXht2r
	 y2quNbgbn/OHE5rKZB9Fx2hIk0Mg2qRd4DwRBh0Sau3G8FCHg4cobRsRqgbBZ3xziP
	 FB93Q+bcT6tCTUMRm6xjrcCEfb6yStHAyYy1QsneaiFUFc7x2lJo9kSs8Zj/PeDUv+
	 ly/dIYijM2sMA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X2HJL6vpQz4w2F;
	Mon,  9 Sep 2024 16:40:02 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Dave Vasilevsky <dave@vasilevsky.ca>, glaubitz@physik.fu-berlin.de,
 bhe@redhat.com, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Reimar =?utf-8?Q?D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
Subject: Re: [PATCH] crash: Default to CRASH_DUMP=n when support for it is
 unlikely
In-Reply-To: <c04fe24a-26e6-44b5-a2dd-00eac589e36b@vasilevsky.ca>
References: <20240823125156.104775-1-dave@vasilevsky.ca>
 <c04fe24a-26e6-44b5-a2dd-00eac589e36b@vasilevsky.ca>
Date: Mon, 09 Sep 2024 16:40:02 +1000
Message-ID: <87ed5t49fh.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dave Vasilevsky <dave@vasilevsky.ca> writes:
> I received a notification from Patchwork that my patch is now in the
> state "Handled Elsewhere".[0] Does that mean someone merged it
> somewhere? Or that I should be using a different mailing list? Or
> something else?
>
> I'd appreciate some guidance.

It was sent/Cc'ed to linuxppc-dev, so it was picked up by the linuxppc
patchwork, which is fine and normal.

Because it touches many arches I don't plan to merge it, I would expect
the kexec maintainers to take it.

So I marked it as "Handled Elsewhere" in the linuxppc patchwork - ie.
not handled via the powerpc tree.

That doesn't mean anyone else has merged it, it just means I haven't and
don't plan to.

cheers
