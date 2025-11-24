Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805CB2D97B7
	for <linux-sh@vger.kernel.org>; Mon, 24 Nov 2025 07:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763969613; cv=none; b=sF1P8iG0ydvmbFsIejQLoNWYOO9daWoEWgKT72LdILdThdt225upwvlWkhA8qtgjnl5JulttNt4yF8oK9utV+hkaC73lUbbVoqXc4oOEeSvvjrv6oHF9J1EMWJdMrIBaOOI+rLg09TvvbwOMpqu2kdsAj5c9HPDVK9IBvjhOXJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763969613; c=relaxed/simple;
	bh=bNguLqXQmyrrD4HwJFr73Ii6YNB6zyHHsIbAjgzAdls=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gBSQ6+/EetUKe7kS+8qldGa/vJkmKU5/QlLz+GIh6jIgQ3ZPRi+Alc7lNe1SLRrkjC1ycKP1zIUT92fMA9C7B9yYxGbgee4rHHZguGX6812ze+kaHZTBx+9pkCk+cbVsuMgD329Gal1oISnWKfFJjRz9yDjmgMOxLRFNDg+Drb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=KAP8M+Nq; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="KAP8M+Nq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=CXWZ7eHX/uVsdXQKAmkDPy7ISULZLvTWwTXUhR/MDWM=; t=1763969609;
	x=1764574409; b=KAP8M+NqrmxAavazKVBQyH3awkV19X7TsoefxWXs7PMsp/5aBLJT5gUqlEEM3
	2UOUWDy56uuUXrV7IwAYAdONtr84+QK+BimrxFk5gEvq57ay/JUwf01DXtP+L0KlFbzLy3k/gk7NM
	aOWwa3lwiQFIqy0RhSUWidn7yXfpvb/upD8UHr4EqsQ/d3NMR1e+bEJMedxCOTdIi+ypUe+E5srQ0
	SOmw0G+52zO6CDQ/bgKQG+FYIWlxLwrg9LaHMMrxbE96T5xc3Vc9fGVh6rnDqtnFaApynRyAnwQMh
	frF4bOax3lP8rjtm9WP7nCEfG5JMSE3dSw4f9X2+0kPuHzhRYQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vNR4S-00000001k4q-0REM; Mon, 24 Nov 2025 08:33:12 +0100
Received: from dynamic-077-011-209-238.77.11.pool.telefonica.de ([77.11.209.238] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vNR4R-00000003YlD-3fpx; Mon, 24 Nov 2025 08:33:12 +0100
Message-ID: <91b74af52f69c360a27269ab3145eeb377ef816a.camel@physik.fu-berlin.de>
Subject: Re: 64mb limitation of qemu-system-sh4 board
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Rob
 Landley <rob@landley.net>, Thorsten Glaser <tg@debian.org>, Michael Tokarev
 <mjt@tls.msk.ru>,  QEMU Developers <qemu-devel@nongnu.org>
Cc: security@debian.org, Debian QEMU Team	
 <pkg-qemu-devel@lists.alioth.debian.org>, debian-ports@lists.debian.org, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 linux-sh@vger.kernel.org
Date: Mon, 24 Nov 2025 08:33:11 +0100
In-Reply-To: <b42433a7-e102-43f7-a7fa-1c9417a21146@linaro.org>
References: <aKi6IWVX2uIlGKnw@seger.debian.org>
	 <Pine.BSM.4.64L.2508230023030.21591@herc.mirbsd.org>
	 <6abe2750-5e2c-43a1-be57-1dc2ccabdd91@tls.msk.ru>
	 <119d5858-52f4-ce1b-9ee7-9615ce2054b9@debian.org>
	 <79f14fef-123f-4938-b069-10f07e7d0405@landley.net>
	 <b42433a7-e102-43f7-a7fa-1c9417a21146@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Philippe,

On Mon, 2025-11-24 at 08:31 +0100, Philippe Mathieu-Daud=C3=A9 wrote:
> On 24/8/25 20:07, Rob Landley wrote:
> > On 8/23/25 09:19, Thorsten Glaser wrote:
> > > > There are no alternatives - qemu is unique in this regard.=C2=A0 An=
d
> > > > it has never been designed for this usage.=C2=A0 What we had for 15=
+
> > > > years, unnoticed, is like `chmod u+s /bin/sh`, which is never
> > > > supposed to be used like this.
> > >=20
> > > Perhaps, but there=E2=80=99s shades in between.
> >=20
> > I find qemu system emulation a LOT less problematic.
> >=20
> > For sh4 I boot qemu-system-sh4 and then use a network block device to=
=20
> > provide swap (so the 64mb limitation of the board isn't a limiting=20
> > factor).
>=20
> The R2D+ board uses a SH7751 SoC, which memory controller can access
> 7 external banks. This board has its boot flash on CS#0, a FPGA on CS#1,
> 64MB of SDRAM on CS#3, a SM501 display on CS#4 and some ISA bus on CS#5;
> leaving CS#2, and CS#6 available. CS#2 can have SDRAM, while CS#6 only
> SRAM (not really a difference in emulation).
>=20
>  From QEMU side, we could fill these empty slots with 2*64MB of RAM, so
> the machine could use up to 192MB. But then it is up to the guest to
> use it.
>=20
> Looking at Linux i.e. it seems to hardcode the RAM base/size in
> arch/sh/include/asm/page.h, so we'd need changes there to use more
> memory, which seems unlikely to get for a such old board...

I'm the upstream kernel maintainer for arch/sh and I would be happy to make
the necessary changes to get the Linux kernel support more than 64 MB in
QEMU.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
