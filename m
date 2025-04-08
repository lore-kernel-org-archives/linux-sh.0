Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB0439AD6;
	Tue,  8 Apr 2025 15:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744125849; cv=none; b=UtxOvvELanBF2bQhbOHd1lVThq0qQ33WfZbU1vsmV2yD+B2abh7WSwAQHsC5Ao1D7n0wbatH1qsuYbHrYkTcw2L1V6vOBG4C2wjcb20PkKyNwCsVPRiZjpIseDnnQqieFJ9Zf+DKb/u7HGyOv/4gxMMttZhtS1VqWcioQZ1SHps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744125849; c=relaxed/simple;
	bh=4l2udifujnuvM/3Eti8piApI5uKF7ue1PGu2hSHMYUU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rEHzkYGgbm361I0MsXgFiADEVwpVSdARedkfl54BKnp6ohTKAPpV/N1wmC38nRf60NABVO6IeHI0IYGPjAqEmNKzdjUgN1QrXfOnyFs99iUYmkWpbGcE+4PJFfciHGzuQ5gcFScCIOMTo1wPQWAjKLFT06zBn/fcu62VjIzPxrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=AQpIIuKB; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="AQpIIuKB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KhCrvQERtP5/OPC9o3hPqwIWF9s2Dzuwa3WW9MlKEKI=; t=1744125845; x=1744730645; 
	b=AQpIIuKBs38pFLpSeFsFS3I5otBP9U/p9wISOaApj5YpLe7Oc+VjTZ6U8hlpDn05TrScNB2o1CJ
	nQTW7YyYyX8PctabMQOF4WIS7ZyKub6dWC4NIW/0IcpC6kE40SycqSVFZy8fJte88kIieU52d8c5y
	triZnghclOUtX2m+S5lvHZKuxN+3LrZT5LJw9zvQ+JJMc62aAVQFjBLM1PIyjg6nZSqvsTzJSA4Y8
	SkIL1grbtVTdZvlSmVmZv1LeUAkl+Wr9tMfCGrl115GQferFc4QS95iovjtSt6RjVQHLg3ChXOOJy
	kOVJy12knM3NInvmWf2xLaKXMDwU6Zv4l66Q==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1u2Anu-00000002Xv0-1yiO; Tue, 08 Apr 2025 17:23:58 +0200
Received: from p5dc5515a.dip0.t-ipconnect.de ([93.197.81.90] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1u2Anu-00000003RUc-0uRZ; Tue, 08 Apr 2025 17:23:58 +0200
Message-ID: <afec7233266c6c1fd1e70ac615ff129d9dc3f710.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/2] J2 Turtle Board fixes
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Rob Landley <rob@landley.net>, Artur Rojek <contact@artur-rojek.eu>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 Daniel Lezcano	 <daniel.lezcano@linaro.org>, Thomas Gleixner
 <tglx@linutronix.de>, Uros Bizjak	 <ubizjak@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, "D . Jeff Dionne"
	 <jeff@coresemi.io>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 08 Apr 2025 17:23:57 +0200
In-Reply-To: <9cf43bbe-898f-4b29-bd85-04f5320bce77@landley.net>
References: <20250216175545.35079-1-contact@artur-rojek.eu>
	 <f574808500e2c5fb733c1e5d9b4d17c2884d1b9f.camel@physik.fu-berlin.de>
	 <1551804b-fc78-4a3f-add8-af693f340a01@landley.net>
	 <48881e2d8efa9d7df8156f5f81cd662c2286e597.camel@physik.fu-berlin.de>
	 <9cf43bbe-898f-4b29-bd85-04f5320bce77@landley.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Rob,

On Fri, 2025-02-28 at 16:19 -0600, Rob Landley wrote:
> > > Which was fixed a year ago, which is why I told you to use the new
> > > toolchain with a current musl-libc:
> > >=20
> > > http://lists.landley.net/pipermail/toybox-landley.net/2024-February/0=
30040.html
> > >=20
> > > Unless you're hitting the OTHER issue I fixed last year...
> > >=20
> > > https://github.com/landley/toybox/commit/0b2d5c2bb3f1
> >=20
> > I just downloaded the latest toolchain from:
> >=20
> > https://landley.net/bin/toolchains/latest/sh2eb-linux-muslfdpic-cross.t=
ar.xz
> >=20
> > and the issue still persists.
> >=20
> > Am I missing anything?
>=20
> The march 2024 rebuild was in response to that Feb 2024 bugfix, so it=20
> _should_ have the fix? (I'm waiting for another musl release to rebuild=
=20
> them again...)
>=20
> I just downloaded the toolchain currently at that URL and built mkroot=
=20
> and it worked for me:
>=20
> Run /init as init process
> sntp: time.google.com:123: Try again
> Type exit when done.
> $ cat /proc/version
> Linux version 6.14.0-rc3 (landley@driftwood) (sh2eb-linux-muslfdpic-cc=
=20
> (GCC) 11.2.0, GNU ld (GNU Binutils) 2.33.1) #1 SMP Fri Feb 28 15:47:36=
=20
> CST 2025
>=20
> And the failure _without_ the fix was deterministic rather than=20
> intermittent, so...
>=20
> Keep in mind the init script has a 3 second timeout trying to call sntp=
=20
> to set the clock, which will fail if the ethernet isn't connected (or no=
=20
> driver, or no internet...)

I just gave it another try and it still hangs for me at:

	Run /init as init process

with the latest toolchain, toybox and kernel (v6.15-rc-1).

FWIW, I did not connect an ethernet cable.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
