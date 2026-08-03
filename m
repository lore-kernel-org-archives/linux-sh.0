Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5483A25B0B3;
	Mon,  3 Aug 2026 05:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785736088; cv=none; b=cTB1n9JB6cNe27gRHBUPK2EV6WyIG7bbcnl/cW//1U5FjF66MuGiEzJX3rlff+N//ozBNJCh59vai8grlj8CuTW9PUPd+e2QHltNAPhzXWXkqhY+73bvjZwRE9sbjobrS3PkpdZ69MGGLunGlLglzDM5YBrZmcG/F8uuwBc1HJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785736088; c=relaxed/simple;
	bh=KKkhm0x0PswMk5fTmMZ046+NBgMprmXtaMVED65x/+g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IsSqu3lf8uth6GP7xI7MbNu+60cYDcMBkKbClF9MDXQYU8lnxE+VyEam3tzs3JJCkpjc8MEh39t/npvOTp8FNcRwyYDPTXoEGLOKEXClgmmCuAJx7V+ManIGPhOmhlRdaM9qZJAHSxtE9TtDs+LSUHhCbNFgqvfWtDou6dvkLEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=dxECExoZ; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="dxECExoZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=MbYMA1z0gDPsLiUzsbAO8Hg1Ch6czRJUmSwRGriZ+VQ=; t=1785736084;
	x=1786340884; b=dxECExoZM4B6I5rjnzkkzN5IDsm5+PdoiZO9x/ZfwJ2v3mQ7Z7Pw8KyrpNh8r
	6OTuo3BnoVBa19G6ZhsNp/sE2vsuD/Sunry+cBCrFXEiHer1Z3AM2oyLFEggL9I4FGMRBu0OtSsco
	b27pAg7s42CkWUn9dhtP/bXgSQVnD/B/5gbg7/B8nWPz/SN0NiS61oVX7g1faCIwUkO9Heh96bEgf
	WdR9Kvr/yNMFsj2p4DmmRWSa8m3yjxLgaP6cJBMRQUVhhV6bTia54Wz/x+pHb41QVImU9ysr9/Wc8
	93BoGB4g1MAnBWBDnAqO3S6pMq5ZWOysYx17Yidtix+vPkIXMQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wqlWh-00000000JkN-0N9N; Mon, 03 Aug 2026 07:47:51 +0200
Received: from p5dc558fe.dip0.t-ipconnect.de ([93.197.88.254] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wqlWg-00000002Bbj-3cew; Mon, 03 Aug 2026 07:47:51 +0200
Message-ID: <32a0d810bfc56029453aa72cefa49cb40466f64e.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: mach-rsk: rsk7203: avoid using inline compound
 literals
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Yoshinori Sato	
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linus Walleij	
 <linusw@kernel.org>, Bartosz Golaszewski
 <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, kernel test
 robot	 <lkp@intel.com>
Date: Mon, 03 Aug 2026 07:47:50 +0200
In-Reply-To: <20260802-sh-rsk7203-swnode-props-v1-1-7a790cbac9e6@gmail.com>
References: <20260802-sh-rsk7203-swnode-props-v1-1-7a790cbac9e6@gmail.com>
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

Hello Dmitry,

On Sun, 2026-08-02 at 16:18 -0700, Dmitry Torokhov wrote:
> Using inline compound literals for property entries in software node
> initializers causes older compilers (GCC < 14) to fail with "initializer
> element is not constant".
>=20
> Under C11 (6.6/6.7.9), initializers for objects with static storage
> duration must be constant expressions. Taking the address of an unnamed
> compound literal nested inside an anonymous compound literal array is
> not guaranteed by standard C to be a compile-time constant address,
> causing older GCC versions to reject it.
>=20
> Fix this by declaring property entry arrays as named static const
> variables, ensuring their symbols evaluate to unambiguous compile-time
> address constants.
>=20
> Fixes: 6905cdac0e51 ("sh: mach-rsk: rsk7203: use static device properties=
 for LEDs and GPIO buttons")

Isn't that the patch that was forced into the kernel, overriding me
as the maintainer of arch/sh because Linus Walleij got impatient and
merged the patch into an immutable tree?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
