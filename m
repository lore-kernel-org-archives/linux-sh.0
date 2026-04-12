Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C3D30E82E;
	Sun, 12 Apr 2026 07:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775979063; cv=none; b=kTvEu+MNUYqDPOgHk8Y6dYy+UiEvev1pveaI76wI2z1lJ0rry/PQfzVeozS3Yo0ojzlbBSKYpd56KfuYc7Ghh7kIT41bEsozhxHtJ3HmhJayB5yazEQ4FLLEkbI4KDURMEsFdck5+JPhBefocA5kTqUlqPUx/DEM//Uhvg+hj7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775979063; c=relaxed/simple;
	bh=9Zin7NwcR9H8cJ92ZYsIBN8CjHyHgv9NCrYl3GmkNEA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B+t71IYAxeYTHtyIxasBlhHwWuOrozFi8mRdnlckkTzvHYGZVN1DhaRpGvZzFLSjFHGiXa2G2XvumEUJQ+gBHYJaRn+4TmfMXPZc50W7rgohCUs1BwOAckbSnsiClh/BGuwz3woVhk27kUrQ2CwcPstGZ9tUr5TqcOCLJouwDB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=SdWt4rWs; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="SdWt4rWs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=wo03sgOn/2ZMIziRoUSLmsnyVivFjnc3a6Uhv7GQJa4=; t=1775979062;
	x=1776583862; b=SdWt4rWsRPUqPYTKikoHcznffS8PAk/WSc82iL3ycvIUkPWdcCRTFuxbWghns
	kOAPvcHzi064ye5zNbkWnAXYeQr3uDHDYPitukTSF448J1ugmycmdYOFs3vtbteYJVeJxuw0k0P8I
	LdLuYFlFwIGFNoJJCuQryQf1iowwnFvM8t1H2GvK+JOyzsaWDvVptlML36XQeEt9084NNQhiiIOZD
	vMFxxIDNgLOqJnMzHsUP20npznNkbn0BoWG8euwf5xIN14bART/2GHoc81DGOpDcYip9PhctqgoSO
	kH2pAZykqS54qlU96IVfGouP0ChcKQpWzb1VZi6all0an41mmg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wBpHW-00000002QsR-2xsz; Sun, 12 Apr 2026 09:30:58 +0200
Received: from dynamic-077-183-202-106.77.183.pool.telefonica.de ([77.183.202.106] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wBpHW-00000001ctF-1gUd; Sun, 12 Apr 2026 09:30:58 +0200
Message-ID: <01d0e84f80124c4ef358bfd1503475856d2aa789.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: hp6xx: unset apm_get_power_status on unload
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Ahelenia =?UTF-8?Q?Ziemia=C5=84ska?=
 <nabijaczleweli@nabijaczleweli.xyz>,  Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Paul Mundt
 <lethal@linux-sh.org>,  Kristoffer Ericson <Kristoffer.Ericson@gmail.com>,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Artur Rojek	
 <contact@artur-rojek.eu>
Date: Sun, 12 Apr 2026 09:30:57 +0200
In-Reply-To: <ydtnrqqjuaz6uifqplujmqwdnpxoe7ma33d5hp4waavekerod2@tarta.nabijaczleweli.xyz>
References: 
	<ydtnrqqjuaz6uifqplujmqwdnpxoe7ma33d5hp4waavekerod2@tarta.nabijaczleweli.xyz>
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

Hi Ahelenia,

On Fri, 2025-10-17 at 00:05 +0200, Ahelenia Ziemia=C5=84ska wrote:
> The API for apm_get_power_status is "call it if it isn't NULL".
> If the module is unloaded and it's not unset,
> reading /proc/apm will jump into unloaded kernel memory.
>=20
> The first commit that added this incompletely refactored
> the assigned-to variable in __exit,
> the second deleted it instead of fixing it.
>=20
> Unset it on unload like drivers/macintosh/apm_emu.c.
>=20
> Fixes: 0a9b0db19262 ("[APM] SH: Convert to use shared APM emulation.")
> Fixes: 8c8ee8254767 ("sh: hp6xx: APM build fix and new battery values.")
> Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xy=
z>
> ---
>  arch/sh/boards/mach-hp6xx/hp6xx_apm.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/arch/sh/boards/mach-hp6xx/hp6xx_apm.c b/arch/sh/boards/mach-=
hp6xx/hp6xx_apm.c
> index e5c4c7d34139..089eca39c4e6 100644
> --- a/arch/sh/boards/mach-hp6xx/hp6xx_apm.c
> +++ b/arch/sh/boards/mach-hp6xx/hp6xx_apm.c
> @@ -98,6 +98,9 @@ static int __init hp6x0_apm_init(void)
> =20
>  static void __exit hp6x0_apm_exit(void)
>  {
> +	if (apm_get_power_status =3D=3D hp6x0_apm_get_power_status)
> +		apm_get_power_status =3D NULL;
> +
>  	free_irq(HP680_BTN_IRQ, 0);
>  }
> =20

Let's CC Artur Rojek who has worked on the hp6xx code before and should giv=
e his ACK.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
