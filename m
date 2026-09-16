Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CD64BF921;
	Wed, 16 Sep 2026 19:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789585688; cv=none; b=kd507vsMbNMf0BxilBMZuGht/ayFCQepNAtMM9n+mpDQytLB6phIxmi1S3NjmcDR6wun0B6Q6bWMkNfUUISPR0ZN0iJ1Tn215jYKRMLWoeyVQQRHJFm5wXLUVkrJEa8SrVEqg5e56Ym69V8qf/Uk1FPYEAnMpefTFwiSgmCqBVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789585688; c=relaxed/simple;
	bh=gu8G4dVWtsCiOpCF0KB7HhZktPSYMCZCLknTTefr//U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cCNtnLFcFHYjuMVcFC7Ndy3polF3zxClf8Swg/NkKZujHD0lkA2MEOLv4G5t6EgwHobWwqy3guHiRi7KT0Hk7OoK+IYmPvn4Ttq/r/OyrAzu01Pbs1uPgEvJ8FaouwM6KIIodApcOvXh3TvxiTRRoGszXY8ARiRfzaYP6GLQfYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Lb9FlTS2; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Lb9FlTS2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=c49o+u2lVVrnBZQ4GHd/1O9S2d4rwlq0WakWbVmbbeA=; t=1789585680;
	x=1790190480; b=Lb9FlTS2Rj+CLf5KgSngdBEh24EvyqHJSNI0gymDv4hN6ib1PdyQSv7AEOjqf
	yv3Ah56nD7Hr2mBVUkd0wD1EAQUCGf/Sllj2SY/4J6anhYEpXvkPkQNNDBeYrW9zz1PxPMQrBqBGY
	xk7/ibi8/WUyPewmg0Wl/BHMngMgDtjo4P+1SKuOlKBftfyQUkAJrhQT8yq5+warlkrdobvd+QM26
	gMyL1H4AIkmx9hl2IbdrnMhcYZjZgrl4RTQvywOfciBv/4x8pHh8xpTfqAg0zRK07DlZcl3mUJwxF
	tjg7fDZS6JySsQeQyqFZVVJzPqTP7lRba/wR3YtQlizeHyJ7qA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1x6uz2-00000001AXT-3NcN; Wed, 16 Sep 2026 21:07:52 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1x6uz2-000000032vo-2Nro; Wed, 16 Sep 2026 21:07:52 +0200
Message-ID: <6f21b23babf5a3792b65de7bd1dd010b9c268453.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: Fix built-in DTB build with generic rule
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Florian Fuchs <fuchsfl@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-sh@vger.kernel.org
Cc: Rich Felker <dalias@libc.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 16 Sep 2026 21:07:51 +0200
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

Hi Florian,

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

Good catch, thanks a lot!

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
