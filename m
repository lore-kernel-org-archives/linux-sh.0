Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9E43A63F2;
	Thu,  2 Jul 2026 10:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782987953; cv=none; b=rMGMNHod626nL1cyDfbK2G4q046WMn6anw2+EIU9o5E0Ri0rwuetZMZQR/GE4m17/8MWPT9MVwLVYt7lEYZTmVuka1jghSJeJ9We2hn+WwY8kZG3Ee4Za+F0/PViU4SddvPj+i4ogYVB3Y0LrN3aqA9q/qXuJUozFLBzs+2rjO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782987953; c=relaxed/simple;
	bh=NNgNCJJAoAAB1VZRWsEn3B6r8GAxIvq7Tq/3+x7HS60=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uunO0xq5Ux6Mb36E1TdJ+XO6rmbFDjJ0nnsYOz0CJdouDDdVWUOi+qp0l0Q7Bq93PlBwrm42xZrvycVN/dFi/vBKglf/uGruI3bH6EFiytrkOLR1fNGszBg6kNKZzAMrCg4nBLhWR97tzVy+ZDDDyazAecwvOP/tGoGbqQxPk/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=HuJDg1ep; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="HuJDg1ep"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=55TxklwjXfiM4L+EMjVCNgEdP6JEKz4wJH2jPWpUYc0=; t=1782987951;
	x=1783592751; b=HuJDg1epNZNAutt4cYSbfZjAEnyjgG3CjxVRrXiC9kOrPSQ0CYAswbsAPdcQp
	tM6T3+SbP7x1B4EGLVUBMzVp6bwNPk9meLn+nmUOiDje/DJf49QrAYTz6GbZYTW0qhp15Uiu6W4Bv
	Inp0k3yUTauKvP1iCFLGPhwoXg0tQ7rY1jDk0UZylrhe5gYg/5IDiMT3q6GuNFWdIj5RZKizzcYsV
	k8nQ+p6KZ3HAOCTo1aPu/QG3Kar3bn9biLoW8RQ2//orMw2o+2F8nNr0gfmbYysWVYFk3CdG3HUsQ
	vlDOmHvNPacvCChRZJzDYH5Wiwch8LCRpaX4mZqOyOBr+hh1DQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wfEc8-00000003FhM-1Vt1; Thu, 02 Jul 2026 12:25:48 +0200
Received: from p57bd94c1.dip0.t-ipconnect.de ([87.189.148.193] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wfEc8-00000003mY4-0AtU; Thu, 02 Jul 2026 12:25:48 +0200
Message-ID: <eab1aaff6f37089d46401059ad7ff056aa5195c1.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v3 00/10] sh: remove NUMA and SPARSEMEM support
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann
 <arnd@arndb.de>,  Rich Felker <dalias@libc.org>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date: Thu, 02 Jul 2026 12:25:47 +0200
In-Reply-To: <akY7VSgIhorP54vh@kernel.org>
References: <20260702-sh-numa-v2-v3-0-57e2435603de@kernel.org>
	 <fe0e2ca854db64b1bb169ce47aaa2ce1e796b023.camel@physik.fu-berlin.de>
	 <akY7VSgIhorP54vh@kernel.org>
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

Hello Mike,

On Thu, 2026-07-02 at 13:20 +0300, Mike Rapoport wrote:
> > I feel like this is an attempt to force me to give up as a maintainer.
>=20
> This isn't an attempt to force you to give up, this is an attempt to merg=
e
> patches that have been out there for long time.

You posted these patches the first time in April. This isn't a long time.

There were patches that have been on the mailing list for years without
being merged.

Arnd has, for example, sent out patches to make to allow the kernel being
built with different alignment so that we can switch Debian's m68k port
to 32-bit without breaking anything. I have been waiting for these for a
long time now and these also haven't been merged. It just happens sometimes=
.

> They are related to mm because we are talking about mm features. And it i=
s
> long standing practice that Andrew takes patches that fall between the
> cracks.

It's not falling through the cracks. I have always picked up almost every
patch that people sent. It just sometimes takes me a little longer because
I'm not a professional maintainer, I also have a dayjob to attend and I als=
o
sometimes have a private life to deal with.

> v1 went out in the middle of April, there were no comments at all from yo=
u
> almost for a month and I sent v2 on May 10th.
>=20
> We are in July now, so this is definitely falling between the cracks.

No, it's not.

> > Otherwise, I can't really understand why you are building up so much
> > pressure for a niche and hobbyist architecture
>=20
> By pressure you mean an email in a few weeks?!

By pressure I mean insisting on getting it merged and now trying to work
around me completely ignoring me despite me being the maintainer.

Yes, that's pressure.

> This isn't about sh, this is about reducing NUMA and SPARSEMEM_STATIC
> footprint to ease the maintenance.
>=20
> A niche and hobbyist architecture does not need NUMA and SPARSEMEM.
> And for sh particularly they should have not be enabled at the first plac=
e.

Yes, and I will eventually pick up those patches to rectify this.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
