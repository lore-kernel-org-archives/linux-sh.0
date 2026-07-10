Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8398175A85
	for <linux-sh@vger.kernel.org>; Fri, 10 Jul 2026 13:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690373; cv=none; b=QGZ9n/UTH329mx8ykSlW83LCpWptKEJ8W50s6CuySp8AABXuMhzOajEs1y/LIsPdVim3iDV1ZyznLHPZNJP0QnJvKoyfzq2k8rGFmaI3rcvoVj5m0iPGA7WmzkJyNtgytiHs5+R0Td6Yi/MZEmrPm26tdyYWUdO8D3I2gNW4uYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690373; c=relaxed/simple;
	bh=tO2lFZWioW3kKGX0uSWni6YKK238YT0v1wExvNUkqIQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KhsFdhUl5ThOXC+wRaXBi9n156/aq8VcOgRW9qb9kwB4NERfz77tCnBzrWRD1wNc3MxoireBz0G6Mr1uGHP9hSg1qLvdg9DnDCWsuHSHm4iq/TNJhfKofH1/na4/aXhZRvNK21yRd69SyBZlNRltgtwRCuDJf40JCWTnlCsnerk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=aRaZM5iS; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="aRaZM5iS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=5eSoTXH07WtDwZ8lw4FjSwyVSuPL9R2ymhqg1LkXOKM=; t=1783690370;
	x=1784295170; b=aRaZM5iSgaj2cmLwsudcs/cCeKceUEG7FhJ2DejNMJMz6IDbzHi8mK402/bC2
	5WzTCEXajAAZvY7BIEHeEF4KOdhqHMtTMG0ItGdVrAzKPvb4LE6alCAzTiOyDnIIPYxsLOvMhn5/F
	gbx88OgHln7XiVK3ePCCVG5hUctAAc8HPJIdf+Dz8GxOcM44wQsm3/DUW6gYQ6znNTyy0FPui0I76
	gpqXFLgL9q1XCOPcl7YJc5z1MEXFF4AnDlzkxDMdKs05j+mbSGXTbuetQd5mYrRYmye2gGoQ+XVZV
	ec/mK64jtoNM+ZFFHG7BE9sKlm03hWOnFKoqlYqYkZg3n0zaaA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wiBLN-00000001IjK-1GYG; Fri, 10 Jul 2026 15:32:41 +0200
Received: from p57bd94c1.dip0.t-ipconnect.de ([87.189.148.193] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wiBLN-00000000hl8-0L8D; Fri, 10 Jul 2026 15:32:41 +0200
Message-ID: <6beae3c6561a7155ee04ea432df85725078aec1d.camel@physik.fu-berlin.de>
Subject: Re: Toybox make root no longer works as expected
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Rob Landley <rob@landley.net>, "D. Jeff Dionne" <djeffdionne@gmail.com>
Cc: linux-sh <linux-sh@vger.kernel.org>, Geert Uytterhoeven
	 <geert+renesas@glider.be>, "D. Jeff Dionne" <jeff@coresemi.io>
Date: Fri, 10 Jul 2026 15:32:40 +0200
In-Reply-To: <6bd93131318b8e78d49fdc5f3e5fecc053f9c046.camel@physik.fu-berlin.de>
References: 
	<359d107fd9fe92a55e77be84c26d9ac86112fe13.camel@physik.fu-berlin.de>
		 <71c6a925c748fb3c9c2af30362387f0e562c0f6f.camel@physik.fu-berlin.de>
		 <55D40750-934F-4F70-A19C-11DC5F97A389@gmail.com>
		 <15ca13ffdfa494b4d774f75d3daaee2ac7a8c93f.camel@physik.fu-berlin.de>
		 <acc36891-6148-429c-aa99-3cf7c6681d6f@landley.net>
		 <84b1391eb542b5cd6bcbecdfbc63124187265402.camel@physik.fu-berlin.de>
		 <003c0770-c6f7-4fcf-b11e-74f42bfc14b8@landley.net>
	 <6bd93131318b8e78d49fdc5f3e5fecc053f9c046.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi,

On Sat, 2026-05-02 at 08:55 +0200, John Paul Adrian Glaubitz wrote:
> On Fri, 2026-05-01 at 16:27 -0500, Rob Landley wrote:
> > > What about the patches for J2 support? And can it work with a GCC git=
 tree like [1]?
> >=20
> > They're in musl-cross-make.
> >=20
> > https://github.com/richfelker/musl-cross-make/tree/master/patches/binut=
ils-2.44
> >=20
> > https://github.com/richfelker/musl-cross-make/tree/master/patches/gcc-9=
.4.0
> >=20
> > Two in each, I think. (Base support and then a later fdpic bugfix.)
> >=20
> > Alas, due to the way Rich maintains musl-cross-make (which is INSANE) i=
f=20
> > you want to know WHY any of the patches was added (relevant gcc bugzill=
a=20
> > entry and so on) you have to find the first release it was added to and=
=20
> > log THAT patch to find the commit message, because he never puts helpfu=
l=20
> > comments at the start of the actual files and the commit where the issu=
e=20
> > was first dealt with is sometimes quite the hunt.
> >=20
> > Another reason I wanted to migrate off mcm...
> >=20
> > Lemme know if you need me to dig for the source of the fdpic bugfix=20
> > thingies, I knew once but don't have it lying around. (Jeff might?)
> >=20
> > Oh, right also invented his own patch applying infrastructure (cowpatch=
)=20
> > which is like fuzz support but worse: silently eats failures of patches=
=20
> > to apply. I don't understand why it exists...
>=20
> Hmm, sounds like a bit too much to be able to do that in a short time now
> in order to be able to test the kernel patch. I guess I will merge the pa=
tch
> now anyways and send it to Linus unless someone else has done that alread=
y
> anyway.

Coming back to this. After recent changes to GCC [1], I would expect the ch=
ances
to be higher that a J2 toolchain build with GCC 17 would work better when b=
uilding
a current kernel tree.

Would you be able to help me build a fresh J2 toolchain from the GCC 17 tre=
e?

Thanks,
Adrian

> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D55212

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
