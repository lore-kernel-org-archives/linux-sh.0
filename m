Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1B68287E;
	Sat, 18 Apr 2026 11:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776511622; cv=none; b=XKh1mPfNjmvUXOTUkJfxd1IqqniiM/yQz01tu++8DC/DF9+dzl1HIrtNNZyrEr+4/TDoT3uk4kdD4H7vz+t1qT11tcnTo4iHKmFpsggEmDkBxaMFzcvTbniMMhE7+NvsJtHtB7BYQUb65l2iHjetAInZmNIcyr1KuUBhV+PxeNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776511622; c=relaxed/simple;
	bh=Fmiqm650w7WhKoxKFvWuvet+kZ3PS0N6KW0k6s0Duj4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BZYu8Yh5+6xc8QF9+ldPCVxQ4wnvGuErSe8sOZGBaVAPNvcY52+1RPf90kYW7id/NdLLxolAYpQDA5BfaxjeYjZQxxWnUmTkHdoy9BUZC0f5TqK2Q8gJeQbiCkrcxgJ6Ix2lC+KVIRuh06TLlByeWqhBDoeJT3wUxtRz072R2dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=hUT54fQG; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="hUT54fQG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=xoicl74O04B4uGIdkQcALoDdUhYvNm3feXrd0P/Qug0=; t=1776511620;
	x=1777116420; b=hUT54fQGsXNKdxzIdyTqHu3N33D12QnKgrC/AlX2Kdj0udVlopsJPk9vp4BXW
	pf3Mt5ET2rsAuWfyOaLgFo7Dg6DirfCTMBviAreY2jVqECJy7eMxEXByLy+QDb5u2oZSBH3/H0XsR
	QAWtufcnvqUE+SJROypigM9SSvPonJeFrrgY7gfa+JvI3FQctgVfafNMYRDZT70P1UDfkuW8cHqqY
	R5vZE4+CbIkQGcFiDHtWxxMNAF9uChvG84MXfHzs9q/9TF3Yn02dGHjIJgKRvtZcskrkajrgIP4OT
	ANBmWBko4Sio7UiDEakJUJ6C4I2A8paEVQZLMyTB+YbgA92IUQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wE3p5-00000002r7Y-2IEL; Sat, 18 Apr 2026 13:26:51 +0200
Received: from pd9f74830.dip0.t-ipconnect.de ([217.247.72.48] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wE3p5-00000001RrH-1KH5; Sat, 18 Apr 2026 13:26:51 +0200
Message-ID: <92295dd525d946777e84269cff6e9a3f2f585286.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: fix fallout from ZERO_PAGE consolidation
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Rich Felker
 <dalias@libc.org>,  Thomas Wei?schuh <thomas.weissschuh@linutronix.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, 	linux-kernel@vger.kernel.org,
 linux-sh@vger.kernel.org
Date: Sat, 18 Apr 2026 13:26:50 +0200
In-Reply-To: <aeNeKYwMJA3JXO8d@kernel.org>
References: <20260417103208.1217010-1-rppt@kernel.org>
	 <30ff5e1e6c0c3d4e0fb3b6f36a5372ed6bf45d19.camel@physik.fu-berlin.de>
	 <ef7d133aabff5ce58a91f0274f3ed05947c8aa48.camel@physik.fu-berlin.de>
	 <aeNeKYwMJA3JXO8d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Mike,

On Sat, 2026-04-18 at 13:34 +0300, Mike Rapoport wrote:
> Hi Adrian,
>=20
> On Sat, Apr 18, 2026 at 10:33:56AM +0200, John Paul Adrian Glaubitz wrote=
:
> > On Fri, 2026-04-17 at 12:56 +0200, John Paul Adrian Glaubitz wrote:
> > > >=20
> > > > base-commit: 43cfbdda5af60ffc6272a7b8c5c37d1d0a181ca9
> > >=20
> > > Thanks, I'll try to test this patch this weekend and will pick it up =
for v7.1.
> > > I have already collected a number of patches for v7.1 with my Reviewe=
d-by.
> >=20
> > I just realized that this patch actually depends on 6215d9f4470f ("arch=
, mm:
> > consolidate empty_zero_page"), so I cannot take it directly into my tre=
e now.
> >=20
> > Shall we wait for v7.0-rc1 then, so I can pick it up as a regression fi=
x?
> =20
> Or we can ask Andrew to pick it via mm tree.

Let me take it for v7.0-rc2, so I can take more time for testing the patch.

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
