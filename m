Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812712512D0;
	Fri, 28 Feb 2025 08:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740731666; cv=none; b=EuZQvJnI7uPZzqv/DQ/ftsQPhJ9ZrRyG9vIAbglpQXS3pSGUnxirvkFEhUpUWYv5toK14647grSDRAbVSc2HQLFV7GSYhabVpIBobQzbqJqrFMcBunN2BKicoj/5S6FNkvvb5vCUzdHX4gDKOY7pL7QpgPZ9SOdtkx6XVLrZbps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740731666; c=relaxed/simple;
	bh=Rcyr2oHQcfN4gj03aDrV7vFgTIAtr937OuX3/93EK1c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HFSfKhs8EU47Dp/MCsYfJcGKrqapRXIVhGZUSgWbSp0UQIZTs3RwrH/kEWbf++I1gwQufuSg3vrl7szk70jBDSORi0E3pyaevq4fCLHwzdLjHS+41db4f6rnL6DzkYNlb3qGtpwVvrJ4qda1VmShXJupAS32SZmh4vUEy4Hoomk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=B9c8tdfm; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="B9c8tdfm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VJyUwe70EWcDuNOw9uULIYM0SlbmVaOIAguM/j19xNs=; t=1740731663; x=1741336463; 
	b=B9c8tdfm9PJhDh5snQl7X1dmLeCPdRtxYSAWYoQw9mXegKy7nS49Eg0Ftoz8eJWd6H1L80oU/fL
	3EWn/i9zZdXsCPz0fvWgLPYXzFBGU9afNa2C/ciTEMvHvfsc6ca46gqo7fYQNhxZHYSyeidr+0mhi
	SC+CHWzirDw/oyNB92msfZnXui65f1hpc/OtLi6q9AoWthrQVoeitEVf59PGHaV78FwCXJJ5K5awo
	6l1NoerGcXqd4WJvnVHg2J/f067VPayQcOOf1xpyqS6+FxB1hVfC4Lu4oIMsn6rB6LeqaePIMS57e
	H282zJ31ZiYbqJoZi4Mus0PAvigo/dwAWo5Q==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1tnvox-00000000Rho-1QjQ; Fri, 28 Feb 2025 09:34:11 +0100
Received: from p5dc5515a.dip0.t-ipconnect.de ([93.197.81.90] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1tnvox-00000002Dij-0Rf6; Fri, 28 Feb 2025 09:34:11 +0100
Message-ID: <48881e2d8efa9d7df8156f5f81cd662c2286e597.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/2] J2 Turtle Board fixes
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Rob Landley <rob@landley.net>, Artur Rojek <contact@artur-rojek.eu>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 Daniel Lezcano	 <daniel.lezcano@linaro.org>, Thomas Gleixner
 <tglx@linutronix.de>, Uros Bizjak	 <ubizjak@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, "D . Jeff Dionne"
	 <jeff@coresemi.io>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 28 Feb 2025 09:34:10 +0100
In-Reply-To: <1551804b-fc78-4a3f-add8-af693f340a01@landley.net>
References: <20250216175545.35079-1-contact@artur-rojek.eu>
	 <f574808500e2c5fb733c1e5d9b4d17c2884d1b9f.camel@physik.fu-berlin.de>
	 <1551804b-fc78-4a3f-add8-af693f340a01@landley.net>
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

Hi Rob,

On Thu, 2025-02-27 at 21:03 -0600, Rob Landley wrote:
> On 2/27/25 01:52, John Paul Adrian Glaubitz wrote:
> > Hi Artur,
> >=20
> > On Sun, 2025-02-16 at 18:55 +0100, Artur Rojek wrote:
> > > this series fixes boot issues and allows J2 Turtle Board to boot
> > > upstream Linux again.
> > >=20
> > > Patch [1/2] enforces 8-byte alignment for the dtb offset.
> > >=20
> > > Patch [2/2] resolves a problem with PIT interrupts failing to registe=
r.
> >=20
> > I can confirm that this series makes my J2 Turtle Board boot again!
> >=20
> > > Even with the above fixes, Turtle Board is prone to occasional freeze=
s
> > > related to clock source transition from periodic to hrtimers. I howev=
er
> > > decided to send those two patches ahead and debug the third issue at =
a
> > > later time.
> >=20
> > Yep, it just got stuck for me right after these messages at my first bo=
ot attempt:
> >=20
> > clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle=
_ns: 7645041785100000 ns
> > futex hash table entries: 512 (order: 1, 8192 bytes, linear)
> > NET: Registered PF_NETLINK/PF_ROUTE protocol family
> > clocksource: Switched to clocksource jcore_pit_cs
> >=20
> > It boots past these messages on second attempt, although it's now stuck=
 trying to start
> > /init. However, it's still echoing <RETURN> strokes, so it might be an =
issue with Toybox.
>=20
> Which was fixed a year ago, which is why I told you to use the new=20
> toolchain with a current musl-libc:
>=20
> http://lists.landley.net/pipermail/toybox-landley.net/2024-February/03004=
0.html
>=20
> Unless you're hitting the OTHER issue I fixed last year...
>=20
> https://github.com/landley/toybox/commit/0b2d5c2bb3f1

I just downloaded the latest toolchain from:

https://landley.net/bin/toolchains/latest/sh2eb-linux-muslfdpic-cross.tar.x=
z

and the issue still persists.

Am I missing anything?

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
