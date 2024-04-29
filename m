Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8998B17BA7
	for <linux-sh@vger.kernel.org>; Mon, 29 Apr 2024 07:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714377129; cv=none; b=KiKzMlJn7eBGztwSqssf2TSbgDLpPnPW5ZZcByjEGTiKY6YC/qu4rEw+ZnKaq/UxIklCITptX8BeE2aJXSg5LQ0c6SArD2CcPySbrGXVd3CYTTjfyaLKMGxC+t5Sw427DVOjLKii5MlC6FhuUpfcUY9IWzZmIXnEFTxyNVLSjUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714377129; c=relaxed/simple;
	bh=PxQgH10fTNbcBPO4JtBS7r/HZlwqa8oOjchq/R0cmpc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kcDKQFyLs7woFDNwkswD2J31eCphi74EQKPKzHLvhfFLYvJdOpsJ5e9Ydm19x1p39Qt3M5XCvy73konOtpK8OSDOionUwZT/rsjqCC3FTuu4sLL63Ymuk2DnvrwBY3QWyiJcOPrTMU5BqS2robQK0HCOBp13g22nait8iEldfko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=JptiQwXk; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="JptiQwXk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Y2vNbSqlx7NjM9T+YVyrpaQDqVK9QJDeiH+r+FV5SWI=; t=1714377126; x=1714981926; 
	b=JptiQwXkabhlx13WNyPM95LEHB/1dZgYxChlmuP31L9DeakCeYzSnnLemYIOHQS/ap+poiOVElG
	7NcqjmCPKPTGa36hGAg4MPYSQU3nTw8ErpoC1XbwXI+071nz1HCOVH22ToyeLiI6UDsIkjjN7lllg
	4NMfckJvH6txoArRe9I5BUeODOMWkPrna/FfrOqea6DqJlszPznmWpvanlt1OHpiGT/9h0DMoNpVw
	DcuiVDUNFmtRdEK90SLtAx9mxZiTDHAmqyTVC46W49XYVQQgU6fi4Ae9KyveHzc+ONZj5HdSCl0oA
	Dzwpnx3tDWcAs0i8wRFrMr9Kz9u8wYpPvzlA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s1Lnu-00000003Pqp-3Vtx; Mon, 29 Apr 2024 09:52:02 +0200
Received: from dynamic-077-191-138-057.77.191.pool.telefonica.de ([77.191.138.57] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s1Lnu-00000001D4U-2fMv; Mon, 29 Apr 2024 09:52:02 +0200
Message-ID: <23a3abf08f358588ef448c1a2f2ef53013ce6b69.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: boot: Remove sh5 cache handling
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>,  Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org
Date: Mon, 29 Apr 2024 09:52:02 +0200
In-Reply-To: <CAMuHMdW5jMg4K454S=jQkU7EZUXyKYetqFVejL0ft1uxAJQpGQ@mail.gmail.com>
References: 
	<23e9b3fd0d78e46c9fc1835852ba226aba92c3ca.1713959531.git.geert+renesas@glider.be>
	 <d5f53c4c490d0058956f6a501191107c4b148720.camel@physik.fu-berlin.de>
	 <CAMuHMdW5jMg4K454S=jQkU7EZUXyKYetqFVejL0ft1uxAJQpGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On Mon, 2024-04-29 at 09:49 +0200, Geert Uytterhoeven wrote:
> Hi Adrian,
>=20
> On Mon, Apr 29, 2024 at 9:46=E2=80=AFAM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> > On Wed, 2024-04-24 at 13:54 +0200, Geert Uytterhoeven wrote:
> > > Commit 37744feebc086908 ("sh: remove sh5 support") in v5.8 forgot to
> > > remove the sh5 cache handling.
> > >=20
> > > Suggested-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> > > --- a/arch/sh/boot/compressed/cache.c
> > > +++ /dev/null
> > > @@ -1,13 +0,0 @@
> > > -// SPDX-License-Identifier: GPL-2.0
> > > -int cache_control(unsigned int command)
> > > -{
> > > -     volatile unsigned int *p =3D (volatile unsigned int *) 0x800000=
00;
> > > -     int i;
> > > -
> > > -     for (i =3D 0; i < (32 * 1024); i +=3D 32) {
> > > -             (void)*p;
> > > -             p +=3D (32 / sizeof(int));
> > > -     }
> > > -
> > > -     return 0;
> > > -}
>=20
> > Interesting, looking at boot/compressed/cache.c, it seems that the whol=
e code
> > is actually a no-op and does nothing but increasing a pointer. So I agr=
ee we
> > should just delete it.
>=20
> It is not a no-op: it also reads from memory, to load new data in
> the cache, and evicting the old data.

Yeah, I actually came to this conclusion right after sending my reply. Howe=
ver, the
command parameter is never used.

Don't have the 32-bit SH CPUs any caches? The code itself is unconditionall=
y executed,
it seems.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
