Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200862367D9;
	Sat, 18 Apr 2026 19:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776541412; cv=none; b=LZNwRQmgnvNqnpDxHJm/RdPDMcTCO0SrQvGi/mznlRGm2B761j0iCI3g3+cPGKcVq8JpK10WVGf3X53x3SE3PCw5IgP8eKydXM12v0pavlhrC/vjE1zVoerVO0i8dqIQle2Y/x2oPNwaD+sr+FjjLKoqokWfkhKVvtb+0pgJWDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776541412; c=relaxed/simple;
	bh=MHowHHLoI0/GpTtPUA0uwEmkI0Ywubf5U9UDZW54dQg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MS8UGvWbz56ND086SsUbCZWxT/spXy2L1e0KyJc7j3VrfdmIjyZucxqDPZuWUIUGJwC6+xPlkh8tduFIyGV72TJNO+NoJCNbM+bkVtZvoXRHp987qRyTnEYhN+ckYLERUs/kS9P2yQkZE2sO+bZMHuZ+pMYURS1rEtcgQyhXbqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=JS3ky5Rn; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="JS3ky5Rn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=UP5xL5uPWKc1S2z9W+2DbSXtveTDHZwvPsVLsUcXwtQ=; t=1776541409;
	x=1777146209; b=JS3ky5RnjpHxzkKTrbV8KefPwEukr0JKCkbq/filfIvitd+lTaeNIJ+3R64a5
	QQUJcTedMq2Mv2MEmvst65OYUtdjlyr5LN0Yu8Frh0yU1d3+F++dta1p8YiGI+7jYbeVYHFyDLtqQ
	DVooSxDNrqKDm+OoYZmJ0u/H4y7x0J0RvHIYm74mJFg7/7eo7CCpD1jrPX5f3YkHO2VZmnKkTxOT8
	y3kzuVjeBx91PSKFX/jaUgVgn3w32sJF0/mhYRlwEKicxdDVE03ImW5+CQFTzI+Gv0dZWBA7l7q4k
	AI116VL1V4nJqHjdcpUysrElwMfL0Q6wYNJ6aqmgKf7ARIvFmg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wEBZa-000000005dx-3UK8; Sat, 18 Apr 2026 21:43:22 +0200
Received: from dynamic-002-245-042-176.2.245.pool.telefonica.de ([2.245.42.176] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wEBZa-00000003Dj0-2Qxa; Sat, 18 Apr 2026 21:43:22 +0200
Message-ID: <d87b5a92d172e94774284cd94d341521940eae1a.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: hp6xx: unset apm_get_power_status on unload
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Artur Rojek <contact@artur-rojek.eu>
Cc: Ahelenia =?UTF-8?Q?Ziemia=C5=84ska?=
 <nabijaczleweli@nabijaczleweli.xyz>,  Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Paul Mundt
 <lethal@linux-sh.org>,  Kristoffer Ericson <Kristoffer.Ericson@gmail.com>,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 18 Apr 2026 21:43:21 +0200
In-Reply-To: <27022f75480a810a204be567b3607e40@artur-rojek.eu>
References: 
	<ydtnrqqjuaz6uifqplujmqwdnpxoe7ma33d5hp4waavekerod2@tarta.nabijaczleweli.xyz>
	 <01d0e84f80124c4ef358bfd1503475856d2aa789.camel@physik.fu-berlin.de>
	 <27022f75480a810a204be567b3607e40@artur-rojek.eu>
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

Hi Artur,

On Sat, 2026-04-18 at 21:20 +0200, Artur Rojek wrote:
> On 2026-04-12 09:30, John Paul Adrian Glaubitz wrote:
> > Hi Ahelenia,
> >=20
> > On Fri, 2025-10-17 at 00:05 +0200, Ahelenia Ziemia=C5=84ska wrote:
> > > The API for apm_get_power_status is "call it if it isn't NULL".
> > > If the module is unloaded and it's not unset,
> > > reading /proc/apm will jump into unloaded kernel memory.
> > >=20
> > > The first commit that added this incompletely refactored
> > > the assigned-to variable in __exit,
> > > the second deleted it instead of fixing it.
> > >=20
> > > Unset it on unload like drivers/macintosh/apm_emu.c.
> > >=20
> > > Fixes: 0a9b0db19262 ("[APM] SH: Convert to use shared APM emulation."=
)
> > > Fixes: 8c8ee8254767 ("sh: hp6xx: APM build fix and new battery=20
> > > values.")
> > > Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczlewel=
i.xyz>
> > > ---
> > >  arch/sh/boards/mach-hp6xx/hp6xx_apm.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >=20
> > > diff --git a/arch/sh/boards/mach-hp6xx/hp6xx_apm.c=20
> > > b/arch/sh/boards/mach-hp6xx/hp6xx_apm.c
> > > index e5c4c7d34139..089eca39c4e6 100644
> > > --- a/arch/sh/boards/mach-hp6xx/hp6xx_apm.c
> > > +++ b/arch/sh/boards/mach-hp6xx/hp6xx_apm.c
> > > @@ -98,6 +98,9 @@ static int __init hp6x0_apm_init(void)
> > >=20
> > >  static void __exit hp6x0_apm_exit(void)
> > >  {
> > > +	if (apm_get_power_status =3D=3D hp6x0_apm_get_power_status)
> > > +		apm_get_power_status =3D NULL;
> > > +
> > >  	free_irq(HP680_BTN_IRQ, 0);
> > >  }
> > >=20
> >=20
> > Let's CC Artur Rojek who has worked on the hp6xx code before and should=
=20
> > give his ACK.
>=20
> This driver can't be built as a module, so this code is never called.
> But since we can't get rid of module_exit(apm_exit):

Isn't hp6x0_apm_exit() called when the device is being shutdown even when
it's not built as a module?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
