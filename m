Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40973C061C;
	Tue,  6 Oct 2026 07:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791273426; cv=none; b=vAmC4lrAEqFQatKZYTLc/buhYb6bStTkL9u0MkdV7DPKSh29EJatvQZvNjGxZsjDKjvP1Zkv1+huwqsTvDx4Fvuc3DhFRzb1i1duTelimY7REmmFtoNpjQVzL2o0GUjmlZE8X81V7P2eXuXB/UHw1P/3ZUkhvyyqUuPe3cQbVe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791273426; c=relaxed/simple;
	bh=LQzCfJd/VhyOA037RYW8J/+qU02bT3UBvR89rgb09Vk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ekByrhhdj/bgXh1CrVScMvh2WNoynD+lVbSSsvQa0cNggibwrgmJBQpPqAL73t79brMY57XNXNRiw6b1VHvS6LmHQ8L6KffR8VGhiZx4OrS4jUyhITPL/HVNtdcn7/ZPfajIQv8e4mliy0azCOgBdGQwEU6cgHdVEP+iirkfiwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=coFiJoFm; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="coFiJoFm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=uV3gWfZ+QqaqIONhUkTg9VxJ5s4VYhqbGm0trpUIXU4=; t=1791273423;
	x=1791878223; b=coFiJoFmb5E45QqmTHiBlDOZKj4WupblE+6v6xecl79inwesMSLRwP6ml89Hq
	luHv2+ge16DHfszKDfprhVith+RZlBUBaFCwDxM0iJxQ5kpihOjVP8gs0hqwcp4D3PfgetyVJMk5E
	0tp2os0hNt4Qd13gKidIU0OQIVjw/fMS5mDU1CmltbJ+1AJJMKkkPxSX5nKlP89FiTEKzbwu1vVlE
	GQJF4D2p8OQHBFdkb2aIeJ56alnipK0f8zTkPbD71i4uE8hszKMsEcQ7QEyz5qlnA9tT1KsvjS5sC
	AYMp1JAH+Rcz7ds2jDUvTjTUSq5dxwEhos47NpwvykbuTmJXQw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xE02n-00000000olD-1iPK; Tue, 06 Oct 2026 09:57:01 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xE02n-00000003Qzd-0iDm; Tue, 06 Oct 2026 09:57:01 +0200
Message-ID: <6b6a6b8b3b55eb6f499d2754488f20d0c39f52e3.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: Fix built-in DTB build with generic rule
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Florian Fuchs <fuchsfl@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-sh@vger.kernel.org
Cc: Rich Felker <dalias@libc.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 06 Oct 2026 09:57:00 +0200
In-Reply-To: <20260711000146.3348854-1-fuchsfl@gmail.com>
References: <20260711000146.3348854-1-fuchsfl@gmail.com>
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

On Sat, 2026-07-11 at 02:01 +0200, Florian Fuchs wrote:
> Commit 21bcc49974c2 ("sh: Migrate to the generic rule for built-in DTB")
> selected GENERIC_BUILTIN_DTB and renamed the Kconfig symbols, but left
> arch/sh/boot/dts/Makefile using the old obj-y form. So convert them as
> well, to fix the build error when using CONFIG_BUILTIN_DTB.
>=20
> Fixes: 21bcc49974c2 ("sh: Migrate to the generic rule for built-in DTB")
> Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
> ---
> The fix is the same like at other places like openrisc or nios.
> Without that, the build fails, when building with builtin device tree:
> CONFIG_BUILTIN_DTB=3Dy
> CONFIG_BUILTIN_DTB_NAME=3D"j2_mimas_v2"
> with an error like:
> .builtin-dtbs.S:6: Error: file not found: arch/sh/boot/dts/j2_mimas_v2.dt=
b
> ---
>  arch/sh/boot/dts/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/sh/boot/dts/Makefile b/arch/sh/boot/dts/Makefile
> index d109978a5eb9..16e281b859ae 100644
> --- a/arch/sh/boot/dts/Makefile
> +++ b/arch/sh/boot/dts/Makefile
> @@ -1,2 +1,2 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -obj-$(CONFIG_BUILTIN_DTB) +=3D $(addsuffix .dtb.o, $(CONFIG_BUILTIN_DTB_=
NAME))
> +dtb-y +=3D $(addsuffix .dtb, $(CONFIG_BUILTIN_DTB_NAME))

Merged into for-next for v7.4.

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
