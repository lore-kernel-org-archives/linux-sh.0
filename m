Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F8C351C10;
	Wed,  7 Oct 2026 05:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791349437; cv=none; b=IucNpV5F+p/w9T0tnalxMNPqt1uUR0uG2nbCc9XGIeJlKFgUt68iIk4zgCLKbqaOavy+qBLjB0PswyiEbzOe/zCUbNCRuz1DN2bN7YjKIeQw5EN1wljkwFX68h/oeV4+X4XJr4Bkag3dVKmBraCuxEyIzkVwyQeOdtUxe3PKDIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791349437; c=relaxed/simple;
	bh=HrxPrYsRT6rlkfcwoT1sUdkzsUIXpnHfaOUTqVxYOeI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bWhUGNNiIOchzcWpQTaUX5qkWj7JT/xXoNtVbcJDFs4O1tA33jXsbFoqPIA8A+oCAaOtJV/7bLIOmjOe4evzyDqGhgCzFDHoIRBHq4bj45dP7uQnpx1UTEluE5AM+dA2AN1lNw5x/eHhOA7nz1nF/caUcvLiZhTyWcyAom0lPnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=aB1YlcKV; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="aB1YlcKV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=JgKVOr3//Y1BtigImTWrriv6FmQt9qqx/tARqp6KMNA=; t=1791349433;
	x=1791954233; b=aB1YlcKVd1As2DX8sBsmU/3MUrQWJcQORyv7l/k6Fhg0mdpxehh7e8NnAcS1J
	wd+73h2+jmGkrM9yOVy3gxPnOi+RzZPMfuf73tjowyLrLHNX9P61IBFXut+L+7RL9spzp7qhDNX1k
	LmpnDMd1gCvXVTbpZlGARv4wb3z/A9I6CwDNrao2JYP0hs4ANflre7v70zdmfz7Rd+xqICr16GaOc
	33zqy/ijBWH54QXAxvxzQtIkOrgQddSLqcz3Exm5aj7uRGtorY4OpmL+KwZcuxPbajtSCkqDMJ55V
	PaBGdpTZL2TxKR5Zn+e0+3tR10G4+egCBkK7HV+sHoRwR6tVGw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xEJoj-00000002trN-2Bbb; Wed, 07 Oct 2026 07:03:49 +0200
Received: from p5b13a90a.dip0.t-ipconnect.de ([91.19.169.10] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xEJoj-00000003rIa-1ESO; Wed, 07 Oct 2026 07:03:49 +0200
Message-ID: <8f3cf9ae2df4d6c23787850a18e62bc8dfadfa9a.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: lib: Restore r4 in shift helpers
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: David Laight <david.laight.linux@gmail.com>
Cc: Florian Fuchs <fuchsfl@gmail.com>, Rich Felker <dalias@libc.org>, 
	linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, linux-kernel@vger.kernel.org
Date: Wed, 07 Oct 2026 07:03:48 +0200
In-Reply-To: <20261006224440.04ab3693@pumpkin>
References: <20260714104147.2016549-1-fuchsfl@gmail.com>
		<85c4e0b40ec4b52b73c1525c2340cdaf31fd7d6a.camel@physik.fu-berlin.de>
		<e2d4c042a53eddc1ea8d800e171e6c59c9d3f7e1.camel@physik.fu-berlin.de>
		<asU-6UBmN4OjNsLV@lithos>
		<cfaeee0744ee2e2148114ff5c65f74311b7479f2.camel@physik.fu-berlin.de>
	 <20261006224440.04ab3693@pumpkin>
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

On Tue, 2026-10-06 at 22:44 +0100, David Laight wrote:
> On Tue, 06 Oct 2026 20:54:30 +0200
> John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> wrote:
>=20
> > Hi Florian,
> >=20
> > On Tue, 2026-10-06 at 20:33 +0200, Florian Fuchs wrote:
> > > On 06 Oct 07:41, John Paul Adrian Glaubitz wrote: =20
> > > > > Please correct me if I'm wrong, but after reading the code in [1]=
, it looks
> > > > > to me as your patch doesn't preserve r4 but it's actually storing=
 it into
> > > > > r0 to be used by the selected shift sequence. =20
> > >=20
> > > Yes, the value is copied to r0 for the shift sequence to use, but onl=
y after
> > > the r4 original value has been popped back into r4.
> > >=20
> > > The shift sequence themselfs only operate on r0 and then rts, so noth=
ing
> > > touches r4 after this point.
> > >=20
> > > So the caller gets the original r4 back, which is what GCC expects.
> > >  =20
> > > > > With the previous code, r4 is pushed onto the stack first but not=
 restored
> > > > > before the shift sequence is jumped to, so what your patch does n=
ot make sure
> > > > > that r4 is restored across the complete call of the shift helper =
but rather
> > > > > restore the input value in r4 from the stack before calling the j=
ump sequence. =20
> > >=20
> > > Yes, it needs the selected shift sequence to not touch r4 as well.
> > >  =20
> > > > Could you comment on this and maybe rephrase your commit message if=
 you agree
> > > > with my analysis? The patch itself is fine, but I think the descrip=
tion is
> > > > somewhat inaccurate. =20
> > >=20
> > > I think your analysis is correct. The selected shift sequences don't =
touch=20
> > > other register beside r0, so I think it is currently not necessary to=
 make
> > > sure that r4 survives the complete call, even if the selected sequenc=
e would
> > > touch r4.
> > >=20
> > > Is it more accurate or which aspect would need a better message, or d=
o
> > > you dislike the "across the whole call" aspect? While the patch doesn=
't
> > > really make sure r4 is always preserved, it reflects the behaviour af=
ter
> > > the patch.
> > >=20
> > > 	Commit 940d4113f330 ("sh: New gcc support") reuses r4 as scratch for
> > > 	the jump table offset and pops the saved value into r0 in the jmp
> > > 	delay slot, so the helpers return with r4 still holding the table
> > > 	byte. GCC can keep a live value in r4 across the call, which leads t=
o
> > > 	runtime data corruption.
>=20
> I'm sure you can write that more concisely.

In what sense?

> > > 	GCC calls __ashlsi3, __ashrsi3 and __lshrsi3 with a special conventi=
on:
> > > 	value in r4, result in r0, and only r0 and T clobbered.
>=20
> That misses out the other value passed in r5.

Well, technically yes. But I assume Florian omitted it because the change m=
ainly
concerns r4. But yes, r5 could be mentioned as the number of shifts paramet=
er.

> What is T?

T is the test bit of the status register.

> > >=20
> > > 	Pop the saved value back into r4 before the jmp and copy it to r0 in
> > > 	the delay slot. The shift sequences only operate on r0, so r4 is now
> > > 	preserved across the whole call. =20
>=20
> That seems unnecessary detail for a commit message.
> Why not just:
> 	GCC uses a special calling convention for __ashlsi3, __ashrsi3 and
> 	__lshrsi3 that requires all registers except r0 (which contains the
> 	result) be preserved.
> 	Commit 940d4113f330 ("sh: New gcc support") reused r4 as a scratch
> 	register leading to data corruption.
> 	Change the code so that r4 is preserved.

Well, I wanted the description to be more explicit as it helps understand
what's going on easier.

> If you are reading sh assembler you should know it has delay slots
> after branches.
> (I've not looked at it before, but it is the only way the code could
> be valid.)

I don't see how mentioning that is adding too much information.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
