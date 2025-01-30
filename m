Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CBA1B0415;
	Thu, 30 Jan 2025 08:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738226396; cv=none; b=Y3pU0QwqpxL5gBawZhVlW9dk2G9capf/Kg/t6UTPu+Fz012R9yGS8bLW8lL4m3jk/bo6uyO7GHRd3ZTO8LVKiK4LF9suSXrQn+vdwx6OXBgtsfimClOOPLroW2wrOjz2NdMwgGRd+KB/v4NL+rPwSR3GgupDBGbOMTucEhM7wk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738226396; c=relaxed/simple;
	bh=xru6o8b5Uqfw2olO4dSfWMmnEM5D0REdzLt7kl7S5FU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZTO6aI00tcl5jQhh2kphz4T6M/AKesSxxTPXrCoPwp7MpV14dguSgoSUAPGKoVyLJQwv2nMUd6tIPuamsYb8HI6MA7w0ZSrKBixS1lKR4zpG95EwxLJeMen3pECOgPV13rnZzrEk0OYdYRwRVc/tsY86E5A76ZgnBVPI3Fl2dFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=nSjo+f0Z; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="nSjo+f0Z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=v9opNwDwn255UtavLuQBZ+mOTvHfGlJaF7SL6xxekMY=; t=1738226394; x=1738831194; 
	b=nSjo+f0ZqkjmsnQ2kTBHhaTAgkIIRNvap5ObGbZ+MwURQr0Up96xFd+zhqhQDxGttT0rQUKaRTs
	DSlxY4jsHGi+g6XfosHdP2U9phxAVbEWUoRrc0288c19PKVXa40hZBh64PGRaONNobPTdEM1XEX2J
	517WU2/Rm1jTXSVqOfkNLb0KfxM2TKsTqSiAjqp/ru0LOCzCAQzjpW2oWiKr+8lGUgyVuFhc8FOOW
	ELpIY41IZHqflgrgrV+kIXLm5U7NcP3dnTklxIXyf7hg04b/6Uyr7iE8dKXNBX89k6TyrDxz8iYkA
	5yG1Y4zjwHYFXjJuNFtnfos93JcqvLiOpMGQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1tdQ5W-00000000EmF-3Q5N; Thu, 30 Jan 2025 09:39:50 +0100
Received: from p5dc55198.dip0.t-ipconnect.de ([93.197.81.152] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1tdQ5W-00000001l3r-2KTZ; Thu, 30 Jan 2025 09:39:50 +0100
Message-ID: <f447d1a9256033253d9bd9193ad639479e7c8575.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: migrate to the generic rule for built-in DTB
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Masahiro Yamada <masahiroy@kernel.org>, Yoshinori Sato
	 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org
Date: Thu, 30 Jan 2025 09:39:49 +0100
In-Reply-To: <20241222003315.2582655-1-masahiroy@kernel.org>
References: <20241222003315.2582655-1-masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Masahiro,

On Sun, 2024-12-22 at 09:32 +0900, Masahiro Yamada wrote:
> Commit 654102df2ac2 ("kbuild: add generic support for built-in boot
> DTBs") introduced generic support for built-in DTBs.
>=20
> Select GENERIC_BUILTIN_DTB when built-in DTB support is enabled.
>=20
> To keep consistency across architectures, this commit also renames
> CONFIG_USE_BUILTIN_DTB to CONFIG_BUILTIN_DTB, and
> CONFIG_BUILTIN_DTB_SOURCE to CONFIG_BUILTIN_DTB_NAME.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  arch/sh/Kbuild            | 1 -
>  arch/sh/Kconfig           | 7 ++++---
>  arch/sh/boot/dts/Makefile | 2 +-
>  arch/sh/kernel/setup.c    | 4 ++--
>  4 files changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/sh/Kbuild b/arch/sh/Kbuild
> index 056efec72c2a..0da6c6d6821a 100644
> --- a/arch/sh/Kbuild
> +++ b/arch/sh/Kbuild
> @@ -1,7 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-y				+=3D kernel/ mm/ boards/
>  obj-$(CONFIG_SH_FPU_EMU)	+=3D math-emu/
> -obj-$(CONFIG_USE_BUILTIN_DTB)	+=3D boot/dts/
> =20
>  obj-$(CONFIG_HD6446X_SERIES)	+=3D cchips/hd6446x/
> =20
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index 04ff5fb9242e..89185af7bcc9 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -648,10 +648,11 @@ endmenu
> =20
>  menu "Boot options"
> =20
> -config USE_BUILTIN_DTB
> +config BUILTIN_DTB
>  	bool "Use builtin DTB"
>  	default n
>  	depends on SH_DEVICE_TREE
> +	select GENERIC_BUILTIN_DTB
>  	help
>  	  Link a device tree blob for particular hardware into the kernel,
>  	  suppressing use of the DTB pointer provided by the bootloader.
> @@ -659,10 +660,10 @@ config USE_BUILTIN_DTB
>  	  not capable of providing a DTB to the kernel, or for experimental
>  	  hardware without stable device tree bindings.
> =20
> -config BUILTIN_DTB_SOURCE
> +config BUILTIN_DTB_NAME
>  	string "Source file for builtin DTB"
>  	default ""
> -	depends on USE_BUILTIN_DTB
> +	depends on BUILTIN_DTB
>  	help
>  	  Base name (without suffix, relative to arch/sh/boot/dts) for the
>  	  a DTS file that will be used to produce the DTB linked into the
> diff --git a/arch/sh/boot/dts/Makefile b/arch/sh/boot/dts/Makefile
> index 4a6dec9714a9..d109978a5eb9 100644
> --- a/arch/sh/boot/dts/Makefile
> +++ b/arch/sh/boot/dts/Makefile
> @@ -1,2 +1,2 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -obj-$(CONFIG_USE_BUILTIN_DTB) +=3D $(addsuffix .dtb.o, $(CONFIG_BUILTIN_=
DTB_SOURCE))
> +obj-$(CONFIG_BUILTIN_DTB) +=3D $(addsuffix .dtb.o, $(CONFIG_BUILTIN_DTB_=
NAME))
> diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
> index f2b6f16a46b8..039a51291002 100644
> --- a/arch/sh/kernel/setup.c
> +++ b/arch/sh/kernel/setup.c
> @@ -249,7 +249,7 @@ void __ref sh_fdt_init(phys_addr_t dt_phys)
>  	/* Avoid calling an __init function on secondary cpus. */
>  	if (done) return;
> =20
> -#ifdef CONFIG_USE_BUILTIN_DTB
> +#ifdef CONFIG_BUILTIN_DTB
>  	dt_virt =3D __dtb_start;
>  #else
>  	dt_virt =3D phys_to_virt(dt_phys);
> @@ -323,7 +323,7 @@ void __init setup_arch(char **cmdline_p)
>  	sh_early_platform_driver_probe("earlyprintk", 1, 1);
> =20
>  #ifdef CONFIG_OF_EARLY_FLATTREE
> -#ifdef CONFIG_USE_BUILTIN_DTB
> +#ifdef CONFIG_BUILTIN_DTB
>  	unflatten_and_copy_device_tree();
>  #else
>  	unflatten_device_tree();

Looks like a good idea to address possible race conditions during build.

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
