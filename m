Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACD537DE9F;
	Tue,  6 Oct 2026 18:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791312881; cv=none; b=FdIoiQc/PO53C3JpAnpntn/nWOAn/v2V1udJuYDTvqIlEZA1NwAQUWDoxLOJlmdphMbhs/qDpWDTdPO0qkdLunAcWQwXYK7a4zUn6WKqvKyFm1lDcoGK+4ezfESPFrS5qK1NuhE4PygjNFrBVE0sfawGv6dDhz25QVXtHrlvCG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791312881; c=relaxed/simple;
	bh=+d+uXSIvdkVqsQ9if0xyyian9vOxSHK3+13o7F3iLOc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YVm+53PAFJ4VKzQP+lPu6UkjbBSLvxBFzxIVCLfHsDrpJEQlqPDvwxdVzDM931zFv9B3p0lMbFnxpRxbzyP3iJu5pnA3xOpFmoD4RIVJaNyEOMoxM1eqYL6u8wYwKP20CD1Xll5vkvnRlOfZLNdneYEB5Zs42mmxbHLkYNmTROg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=gD3yrS+N; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="gD3yrS+N"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=irkhygonqghS6Y0DxD5OBADk1ANh8qtMJlooPOOxnRk=; t=1791312876;
	x=1791917676; b=gD3yrS+NFtpRAxBaoJyLnzt031sBAs0+RJZfie24wmt6MELEcAjddlPs4cuo7
	JlEOeIJs1sSyfWIe05BQg6StOmy83jeTQt/Ofv7yPDlKG14wEE+QfgLXKKI1/6+gp/o1+Cm8bTiNN
	OjOukuvy9NzWTvW/KGXqKLm3SdgUKrGXCfpkkXj/rtHzR4lAaDAyNIor6WlcK3i/6sGBEY+2g6Caa
	3Pk5oc30O1+iVPrggMA+uz6Ehn502zOz1rPhuPW7vQx3UBKD/Etfryc0q7N3+/pJVkk3to+9A8l1e
	w3/WZSSzucIMhWD2uR47NEvjUw27voHjHJWxSVaAyM1hnVjbQQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xEAJ5-000000011Ty-0KGE; Tue, 06 Oct 2026 20:54:31 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xEAJ4-00000001wN5-3a1q; Tue, 06 Oct 2026 20:54:31 +0200
Message-ID: <cfaeee0744ee2e2148114ff5c65f74311b7479f2.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: lib: Restore r4 in shift helpers
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Florian Fuchs <fuchsfl@gmail.com>
Cc: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Geert
 Uytterhoeven	 <geert+renesas@glider.be>, Yoshinori Sato
 <yoshinori.sato@nifty.com>, 	linux-kernel@vger.kernel.org
Date: Tue, 06 Oct 2026 20:54:30 +0200
In-Reply-To: <asU-6UBmN4OjNsLV@lithos>
References: <20260714104147.2016549-1-fuchsfl@gmail.com>
	 <85c4e0b40ec4b52b73c1525c2340cdaf31fd7d6a.camel@physik.fu-berlin.de>
	 <e2d4c042a53eddc1ea8d800e171e6c59c9d3f7e1.camel@physik.fu-berlin.de>
	 <asU-6UBmN4OjNsLV@lithos>
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

Hi Florian,

On Tue, 2026-10-06 at 20:33 +0200, Florian Fuchs wrote:
> On 06 Oct 07:41, John Paul Adrian Glaubitz wrote:
> > > Please correct me if I'm wrong, but after reading the code in [1], it=
 looks
> > > to me as your patch doesn't preserve r4 but it's actually storing it =
into
> > > r0 to be used by the selected shift sequence.
>=20
> Yes, the value is copied to r0 for the shift sequence to use, but only af=
ter
> the r4 original value has been popped back into r4.
>=20
> The shift sequence themselfs only operate on r0 and then rts, so nothing
> touches r4 after this point.
>=20
> So the caller gets the original r4 back, which is what GCC expects.
>=20
> > > With the previous code, r4 is pushed onto the stack first but not res=
tored
> > > before the shift sequence is jumped to, so what your patch does not m=
ake sure
> > > that r4 is restored across the complete call of the shift helper but =
rather
> > > restore the input value in r4 from the stack before calling the jump =
sequence.
>=20
> Yes, it needs the selected shift sequence to not touch r4 as well.
>=20
> > Could you comment on this and maybe rephrase your commit message if you=
 agree
> > with my analysis? The patch itself is fine, but I think the description=
 is
> > somewhat inaccurate.
>=20
> I think your analysis is correct. The selected shift sequences don't touc=
h=20
> other register beside r0, so I think it is currently not necessary to mak=
e
> sure that r4 survives the complete call, even if the selected sequence wo=
uld
> touch r4.
>=20
> Is it more accurate or which aspect would need a better message, or do
> you dislike the "across the whole call" aspect? While the patch doesn't
> really make sure r4 is always preserved, it reflects the behaviour after
> the patch.
>=20
> 	Commit 940d4113f330 ("sh: New gcc support") reuses r4 as scratch for
> 	the jump table offset and pops the saved value into r0 in the jmp
> 	delay slot, so the helpers return with r4 still holding the table
> 	byte. GCC can keep a live value in r4 across the call, which leads to
> 	runtime data corruption.
>=20
> 	GCC calls __ashlsi3, __ashrsi3 and __lshrsi3 with a special convention:
> 	value in r4, result in r0, and only r0 and T clobbered.
>=20
> 	Pop the saved value back into r4 before the jmp and copy it to r0 in
> 	the delay slot. The shift sequences only operate on r0, so r4 is now
> 	preserved across the whole call.

Yes, this is much better. Can you send a v2?

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
