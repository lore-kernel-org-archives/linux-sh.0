Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715E636E46F;
	Thu,  1 Oct 2026 16:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790872870; cv=none; b=jPyiKkabLZhAQhjv+mRWr9TKMEvtmz9yw3nA4KB8ACa6+ugywEupkON9lP3mv851A3fR8k2fPOzRBcTLoxzTG0Ynwol4ef8BgYCnqiybnrt/CZG/YptUSJ8BE18Socf6L1yFtJGXaC2gUy3HyRbxBJaH0HwCDc7aJMuVzB9ogyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790872870; c=relaxed/simple;
	bh=6UefJdn0vBCHGV64Wk+1bs5aMzO1Zx8UIvb1GAVrUAI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uQLoZnfKwKR8pZhUSUhLXMwmSmW0JZiZ2vzDHG5aePDoq0FESm9bCqBw9ruQ13UPC7/uREy5RsYheH7wNfIh4rVcgGpP/5Iu9fDB0/pBj5ekaXtuVFFUzQbYA+QaQBuzi7eulqnsGIlAedf0s0d/ljBFD7ZTrYfyWP7BL8dJRJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=OClwcbqB; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="OClwcbqB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=CcnbKH72/xakJdn4+pXD8ZcS1KfVTKDmYVimX4BquTA=; t=1790872866;
	x=1791477666; b=OClwcbqBKuZv4D+pBUnnKTVA9vk+d0AagH9Vg2UvJgMpX3C5mXW+NJTwty0UG
	Bcym4x9Kxdan3z8jUM+s5mnPxU9/0j6DTSA2Ocv1YXnN6pPhYAfQzh0d5EtDX0UD7hS5nvg+TE74J
	fh91LCa/oHvGejeSFeQpz79bcMW82iNdGNWhsL4WOr1kpeWqCGjvrcnLAexcmamsfY0Jga9TdHmDD
	8A1NOH2jXrNftztiVwl+JrTuKgKKVqE2TZdf+7E4Dcfdsb62lJv31A9EvPBWHQQnCfdqQLm4b0s+c
	ZspBOX3X48nzQjX6jiNAhsFZuaSm+dgw6uNEYvDk28Bz8cxImQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xCJqB-00000003Ykz-1Ah0; Thu, 01 Oct 2026 18:41:03 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xCJqB-00000001qgT-0HOx; Thu, 01 Oct 2026 18:41:03 +0200
Message-ID: <7e991a2c3cc33696ea8d15734b89b67c8bb46f5d.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/2] sh: kfr2r09: fix i2c adapter leaks
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Johan Hovold <johan@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>, 	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 01 Oct 2026 18:41:02 +0200
In-Reply-To: <ar5afD7Sx-hBgTxp@hovoldconsulting.com>
References: <20260508120601.426115-1-johan@kernel.org>
	 <aiwtIkdGNMFqJmHk@hovoldconsulting.com>
	 <06c0871d4999dcb09aeca6bbf6a6eb282147d606.camel@physik.fu-berlin.de>
	 <anx_ntq7VbbuQtkF@hovoldconsulting.com>
	 <ar5afD7Sx-hBgTxp@hovoldconsulting.com>
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

Hi Johan,

On Thu, 2026-10-01 at 15:05 +0200, Johan Hovold wrote:
> On Wed, Aug 12, 2026 at 04:13:50PM +0200, Johan Hovold wrote:
> > On Sat, Jun 13, 2026 at 07:11:02AM +0200, John Paul Adrian Glaubitz wro=
te:
> > > On Fri, 2026-06-12 at 18:00 +0200, Johan Hovold wrote:
> > > > On Fri, May 08, 2026 at 02:05:59PM +0200, Johan Hovold wrote:
> > > > > The kfr2r09 platform setup code fails to drop the references it a=
cquires
> > > > > to the I2C adapter.
> > > >=20
> > > > > Johan Hovold (2):
> > > > >   sh: kfr2r09: fix i2c adapter leak on USB gdaget setup
> > > > >   sh: kfr2r09: fix i2c adapter leak on serial console setup
> > > >=20
> > > > Can these be picked up now?
> > >=20
> > > I will try to review some patches this weekend.
> >=20
> > Any chance to get these into 7.3?
>=20
> Can these be picked up now?

Yes, I'll pick them up for v7.4. I have already reviewed and merged
some patches for v7.4. I need to perform some more tests but yours
should go in with v7.4 as well.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
