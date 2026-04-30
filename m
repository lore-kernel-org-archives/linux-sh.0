Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D1639EF32
	for <linux-sh@vger.kernel.org>; Thu, 30 Apr 2026 07:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777533447; cv=none; b=otrMv530zkdUXvA4aS6ahaXsFHnpVxrEkfpyKm30gHcP4X2UxF+6fGrrXcaOrl0HokIG9wLDrU5ZDiO31sBARMrYLBiOEOxsim9XTj4t7mQYnwk4W0GBZqeEttDyuzfr5uaoJAFEcfoByFCECN539LBkZN0XvbV4JveS85w7aLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777533447; c=relaxed/simple;
	bh=NDGHiPZ+xt7XEdYFT+GhaehwGXi/S5cv2JOlFmpsqQ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TLPBCdREugXoYvH6uPt74ttcK3JmeKDclEZkHcbbpZ+MR2JBptdJX/TX/My446f90/5jOyAEFyPtcKmPvqF8vZq6f3iJTxaPEXUcpLC8w+zBYGrismMDdt6kmYAiif4ihP3tWhNrcU9hwLjYs9JmaB6scqSTBAW0kEUKbKkwNSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=C0b/FrFZ; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="C0b/FrFZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=xezSEPBl/uBFptQwopbHLOza7NyqaricZTs98iCtNSA=; t=1777533445;
	x=1778138245; b=C0b/FrFZJ+MOSzNJHRiUHf+picckkp6xGemX9W6W59QOwnsYxVsL9JGOgyama
	AOM9KUqNUpb0Yveg9MudSCAyr9a24K9IIn3NZSqdqKTi09aFjGZ0eHujMj/a/rmm41T/ygJ1fUig1
	B18+xr8GEoIVoVjFGn4qR/KlAnoaeeI/ZcoBZkY1SGhntauI2cbly8CaGme5IB0vUZYVfcgzUX4Gz
	TA/RR226uhM8QCqrmep3iitwmzgULqy3vToGtTauoYbXzQ1V1N707llQDRpnTy93i6PYjUgEr/PI3
	ur50fl3LgPYwvsZr9E1qgaq5mQIhwqMVgyFxKOdCW1mSbWQX0Q==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wILeE-00000002Y05-2K9h; Thu, 30 Apr 2026 09:17:22 +0200
Received: from p5dc559e1.dip0.t-ipconnect.de ([93.197.89.225] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wILeE-00000000i8u-1Lmj; Thu, 30 Apr 2026 09:17:22 +0200
Message-ID: <15ca13ffdfa494b4d774f75d3daaee2ac7a8c93f.camel@physik.fu-berlin.de>
Subject: Re: Toybox make root no longer works as expected
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: "D. Jeff Dionne" <djeffdionne@gmail.com>
Cc: Rob Landley <rob@landley.net>, linux-sh <linux-sh@vger.kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, "D. Jeff Dionne"
 <jeff@coresemi.io>
Date: Thu, 30 Apr 2026 09:17:21 +0200
In-Reply-To: <55D40750-934F-4F70-A19C-11DC5F97A389@gmail.com>
References: 
	<359d107fd9fe92a55e77be84c26d9ac86112fe13.camel@physik.fu-berlin.de>
	 <71c6a925c748fb3c9c2af30362387f0e562c0f6f.camel@physik.fu-berlin.de>
	 <55D40750-934F-4F70-A19C-11DC5F97A389@gmail.com>
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

Hi Jeff,

On Thu, 2026-04-30 at 16:13 +0900, D. Jeff Dionne wrote:
> Can you do a --version on that toolchain gcc for me please.  Overflow and=
 internal
> compiler error suggest maybe -mj2 is not in the command line, for instanc=
e.

I'm using Rob's toolchain from 2024:

glaubitz@node54:/data/home/glaubitz> sh2eb-linux-muslfdpic-cc --version
sh2eb-linux-muslfdpic-cc (GCC) 11.2.0
Copyright (C) 2021 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

glaubitz@node54:/data/home/glaubitz>

> In the meantime, here is the (IIRC current) build script we use to genera=
te toolchains
> for J-Core J2 J1 Linux and bare metal.  It=E2=80=99s a but convoluted, pa=
tches on patches=E2=80=A6
> no one has the time to clean this up as we=E2=80=99d like.
>=20
> https://codeberg.org/J-Core/librelane-vhdl-build/src/branch/master/01-too=
lchains.sh

I can give it a try. Would be good if Rob could publish a recent version of=
 the toolchain.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
