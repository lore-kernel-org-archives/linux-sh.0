Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4981C6B7;
	Sat, 11 May 2024 19:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715455823; cv=none; b=YbzzJO1Jt1uXm7c1f8toY8JOISTYX8oqBU6UXU7B6y5HOMjlxQMV9BVbtrtftpaIn4Eh2GF/lPSWHxTT7kZAMDEdH6Ze9Q/p7UDTCEhLHwFPtfEiyQYNGGxRcNOlka8v7RHH+ShQcxvE8LKSPMD5/89IblznNjkB/7+9G5LyEPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715455823; c=relaxed/simple;
	bh=UMiHuXovsO9jrvFr2B88I117qzdlRC9jsvRcXVd5ueM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UyiLQAoucSjlWG5ZJcnihnwHnCQ2UB83rVZIfng05YXPrgHPJYYk0r6oB6riKWKwlorbpzfRH1HrJkMsKrDO0CiaAXeWOg9+MjJOGa8LJeyCgnrAAl9GGiOxAZZHnMGP9tSsqD5VUJeTkY0Aq0fHyfvDV8PpTyFsDwtYNpBAw7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=DfqLIEV3; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="DfqLIEV3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rd4X6oeIsPEko/YtXGb2SSHu5VdimYDlh48ZOg06U2g=; t=1715455820; x=1716060620; 
	b=DfqLIEV3FcWSFhoxvVhGLxfX4UjFrKpMlhaVYfEBcW0QlWNq1hnNzaRaACQmjjd2YFDAmkV6vsP
	5y3twb6N7iKGSoc9KkoMWmM6glULtxtBXw1wcyLRzm/G8KVcjLRqa6hQ9S2deRMvy4n+qlXHUGN4L
	W8AMQhp7zwayzYxOolPK5wrjKj5BGDkh9HNZ+utA3U6Ml2+lmRyAjM1+Sqywb2F2hCkCXFKQPKu0E
	xkIQfY7dF0OBx/T5fkaPh+yTz3D8uyZBEU3F4VGU9BVMac6DI7SSl6BXNh4fPg/ihL7GY6snBm2Yu
	DJsCw+//J2uaInvFZfznHaQty2vMJKj7wkag==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s5sQC-00000003bGP-1019; Sat, 11 May 2024 21:30:16 +0200
Received: from dynamic-078-055-008-036.78.55.pool.telefonica.de ([78.55.8.36] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s5sQC-00000002jBD-08vM; Sat, 11 May 2024 21:30:16 +0200
Message-ID: <1ba5bbc958e6e5e1e442d942d490aeea9cfda602.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 1/1] sh: dreamcast: Fix GAPS PCI bridge addressing
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Artur Rojek <contact@artur-rojek.eu>, Yoshinori Sato
	 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Paul Cercueil
	 <paul@crapouillou.net>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 11 May 2024 21:30:15 +0200
In-Reply-To: <20240511191614.68561-2-contact@artur-rojek.eu>
References: <20240511191614.68561-1-contact@artur-rojek.eu>
	 <20240511191614.68561-2-contact@artur-rojek.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi,

On Sat, 2024-05-11 at 21:16 +0200, Artur Rojek wrote:
> The G2-to-PCI bridge chip found in SEGA Dreamcast assumes P2 area
> relative addresses.
>=20
> Set the appropriate IOPORT base offset.
>=20
> Tested-by: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>  arch/sh/Kconfig                       | 3 ++-
>  arch/sh/boards/mach-dreamcast/setup.c | 3 +++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index 217bdc4d0201..f723e2256c9c 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -126,7 +126,8 @@ config ARCH_HAS_ILOG2_U64
> =20
>  config NO_IOPORT_MAP
>  	def_bool !PCI
> -	depends on !SH_SHMIN && !SH_HP6XX && !SH_SOLUTION_ENGINE
> +	depends on !SH_SHMIN && !SH_HP6XX && !SH_SOLUTION_ENGINE && \
> +		   !SH_DREAMCAST
> =20
>  config IO_TRAPPED
>  	bool
> diff --git a/arch/sh/boards/mach-dreamcast/setup.c b/arch/sh/boards/mach-=
dreamcast/setup.c
> index 2d966c1c2cc1..daa8455549fa 100644
> --- a/arch/sh/boards/mach-dreamcast/setup.c
> +++ b/arch/sh/boards/mach-dreamcast/setup.c
> @@ -25,10 +25,13 @@
>  #include <asm/irq.h>
>  #include <asm/rtc.h>
>  #include <asm/machvec.h>
> +#include <cpu/addrspace.h>
>  #include <mach/sysasic.h>
> =20
>  static void __init dreamcast_setup(char **cmdline_p)
>  {
> +	/* GAPS PCI bridge assumes P2 area relative addresses. */
> +	__set_io_port_base(P2SEG);
>  }
> =20
>  static struct sh_machine_vector mv_dreamcast __initmv =3D {

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
