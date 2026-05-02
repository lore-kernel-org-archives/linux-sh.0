Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03FB2DCF6C
	for <linux-sh@vger.kernel.org>; Sat,  2 May 2026 06:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777704945; cv=none; b=BiD+ij0/lUcHvlRA1UCP5HLBKX2dP9RoPvj3rBKXeGoK2o+FOA9kcESnGOyfo+J4R6UgUzJid55CG+1dkv6Pm33+n6pF6x7j+SM8IcncMZ6KYeXzBV/EschotzuIbIdvP7PbiKDErt2rqiykI9zvrChsomxh8mV4UEAc5NRDoLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777704945; c=relaxed/simple;
	bh=0mxp1SyOukJH/GNksVzhJUAgUpUWGIxKEbQ0lXmMw7Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U/9nKq5B626801HaJTl2Aia/9TQjfDOKw6kGOI5jMg82bD1wt6D0vH4IBKfyJtYARQj/pJQqLMXoa6bLARKHXyMsdTTSNJUfSB+/NqCeJU+tHpk6ezSJhsXVktDvyhtVIyHPpBIL0P943KJ3GeHphWCW7zUen1j31VG+Hfbbgxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=lVC0+h4y; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="lVC0+h4y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=5SNk5vPJ95wMG2vE3JGj+xzLcK0O5SFVS13QHCDnT5c=; t=1777704942;
	x=1778309742; b=lVC0+h4ykn3sO3WMATx5qAnTZ81eBHlF1uTsUxf8YGZnWWVM7xNKVtlUbaJk+
	hqR/lBe3Gwmo4frA3wJAQp/mIo4f//5Q1E2kbMEVfBswETy8jp6aDklPWaMrvM+L/R4Rc5mvvJ3Oy
	flos7urSDXf8crmZupEV+E3qM8G1J6LP96F3wgN7bsF1G2OQQCyIK5uIajmUL8/OgRcrNTaL8NJ6W
	Z5NDx1n8FgcKqUbQJVQGmaGFjCO6Da/4reh+e48z4yg4T/1phQ35ZuIelySCvS1pGR+8WkrNUEfLr
	0fHsQ89HByi8pJqpb0n10OL/PHgLk0Y6uA78R6G8Qy/IUgoMYw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wJ4GD-000000005ZU-1FU0; Sat, 02 May 2026 08:55:33 +0200
Received: from p5b13ad18.dip0.t-ipconnect.de ([91.19.173.24] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wJ4GD-00000000CNb-0JKi; Sat, 02 May 2026 08:55:33 +0200
Message-ID: <6bd93131318b8e78d49fdc5f3e5fecc053f9c046.camel@physik.fu-berlin.de>
Subject: Re: Toybox make root no longer works as expected
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Rob Landley <rob@landley.net>, "D. Jeff Dionne" <djeffdionne@gmail.com>
Cc: linux-sh <linux-sh@vger.kernel.org>, Geert Uytterhoeven
	 <geert+renesas@glider.be>, "D. Jeff Dionne" <jeff@coresemi.io>
Date: Sat, 02 May 2026 08:55:32 +0200
In-Reply-To: <003c0770-c6f7-4fcf-b11e-74f42bfc14b8@landley.net>
References: 
	<359d107fd9fe92a55e77be84c26d9ac86112fe13.camel@physik.fu-berlin.de>
	 <71c6a925c748fb3c9c2af30362387f0e562c0f6f.camel@physik.fu-berlin.de>
	 <55D40750-934F-4F70-A19C-11DC5F97A389@gmail.com>
	 <15ca13ffdfa494b4d774f75d3daaee2ac7a8c93f.camel@physik.fu-berlin.de>
	 <acc36891-6148-429c-aa99-3cf7c6681d6f@landley.net>
	 <84b1391eb542b5cd6bcbecdfbc63124187265402.camel@physik.fu-berlin.de>
	 <003c0770-c6f7-4fcf-b11e-74f42bfc14b8@landley.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On Fri, 2026-05-01 at 16:27 -0500, Rob Landley wrote:
> > What about the patches for J2 support? And can it work with a GCC git t=
ree like [1]?
>=20
> They're in musl-cross-make.
>=20
> https://github.com/richfelker/musl-cross-make/tree/master/patches/binutil=
s-2.44
>=20
> https://github.com/richfelker/musl-cross-make/tree/master/patches/gcc-9.4=
.0
>=20
> Two in each, I think. (Base support and then a later fdpic bugfix.)
>=20
> Alas, due to the way Rich maintains musl-cross-make (which is INSANE) if=
=20
> you want to know WHY any of the patches was added (relevant gcc bugzilla=
=20
> entry and so on) you have to find the first release it was added to and=
=20
> log THAT patch to find the commit message, because he never puts helpful=
=20
> comments at the start of the actual files and the commit where the issue=
=20
> was first dealt with is sometimes quite the hunt.
>=20
> Another reason I wanted to migrate off mcm...
>=20
> Lemme know if you need me to dig for the source of the fdpic bugfix=20
> thingies, I knew once but don't have it lying around. (Jeff might?)
>=20
> Oh, right also invented his own patch applying infrastructure (cowpatch)=
=20
> which is like fuzz support but worse: silently eats failures of patches=
=20
> to apply. I don't understand why it exists...

Hmm, sounds like a bit too much to be able to do that in a short time now
in order to be able to test the kernel patch. I guess I will merge the patc=
h
now anyways and send it to Linus unless someone else has done that already
anyway.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
