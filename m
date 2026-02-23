Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A2131690A
	for <linux-sh@vger.kernel.org>; Mon, 23 Feb 2026 21:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771881699; cv=none; b=lNEPtzTFlVH6ezpXQ0WSKgO3GtzUFtNr6bumP0gYrqfRd5rSBqJJV+n0diPhmLeAtNE+91wl+cfKAjYo0UA9lKvh/tulrLqbi5sK+j30ZKjtFHWxzq/uWCQFxveKQPQxSGDoRU1cNfK95etRyl2mjnYTTfe9Bz2dvVS1sNyOmWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771881699; c=relaxed/simple;
	bh=H0h11Wv3umDYnT1SzTMPh2kJTqb+zlyxU6wQlXzfl+o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=babzhwwwUn4i16MoA1lSyjwZFVO6bFfrpold8gXdPQY5np9EGfc/vYz2SFLYWAiHqOIn7xJ2kZm8/fWM+P4EDxIeuxwPDRzryT6tPgaJnPnFmt1tj/JKVOQwFbWJrTL7mRk3GfarltU5L3PNoS41t7fvIvbds84UuYWxSqdfd8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Fv+n31cj; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Fv+n31cj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=Qy++e7wivX3g7DsbNvYrcKMqMn2aWM9ohJ91TSnlF/U=; t=1771881695;
	x=1772486495; b=Fv+n31cjNvd7Q/su7XBnnZlMOKroI/IJw1b2Z2r+maLaEUSlryDWjTYTmHXy1
	lWzsjkbYdwZ5YmsgBZ6iOMrPieKBLRM+GsF9l5+FKtcOiQ4xUoEosP2DvY02JpVfD1F5Y37UlvHIV
	5o9vT+ThUGczN8TwKeMe2rtWuc98GfOiwpJvNc5yYZgWAEg+Dqj7uM1+TWHES87PTJ8ikWxZuHn8N
	GcJoIB5LPziuDjLHaakgikbafaV990OsCcMWh4ty2nn/QMEcip+pT6y2frfIEoTVJseDt1ClWUr5J
	dL3VmKivqIJQVOvxbYM2QbFnj+YzQBDe81zSYKTKR2wWU+eJkg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vudMt-00000002Suj-1EAm; Mon, 23 Feb 2026 22:21:27 +0100
Received: from p5dc55f29.dip0.t-ipconnect.de ([93.197.95.41] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vudMt-00000000Me8-0Mxj; Mon, 23 Feb 2026 22:21:27 +0100
Message-ID: <de0cb5ac66b80f2f48eb8c6ebe0349c8c08a763c.camel@physik.fu-berlin.de>
Subject: Re: Did you see my qemu r2d memory patch?
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Rob Landley <rob@landley.net>
Cc: Linux-sh list <linux-sh@vger.kernel.org>
Date: Mon, 23 Feb 2026 22:21:26 +0100
In-Reply-To: <240590ce-7d95-491f-93b0-98abd7c6e17d@landley.net>
References: <240590ce-7d95-491f-93b0-98abd7c6e17d@landley.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Rob,

On Mon, 2026-02-23 at 10:44 -0600, Rob Landley wrote:
> It was in=20
> https://lists.gnu.org/archive/html/qemu-devel/2026-01/msg06318.html and=
=20
> probably needs to be reposted as a separate thing, but with it I booted=
=20
> an sh4 kernel with over 200 megs of memory, enough to act as a=20
> reasonable native build node (especially using the distcc trick). No=20
> kernel patch required, just a .config change setting two symbols it's=20
> already got to different values.

No, I haven't seen that. I got too many things to do at the moment, also
at my regular job such that I don't have too much time for SH at the moment=
.

I will catch up with it the next weeks though.

> I need to port the r2d target over to device tree (well, extend the=20
> turtle device tree stuff to support r2d and its devices) and teach qemu=
=20
> to supply a device tree overlay with the current memory map so you don't=
=20
> have to match kernel with qemu -m layout (the only way to get the extra=
=20
> memory in one contiguous block is to move the START of the memory range,=
=20
> which means moving the initrd and command line string locations which=20
> are relative to start of memory, so the kernel needs to know where to=20
> expect start of memory and thus needs to be recompiled for the different=
=20
> memory amount rather than just autodetecting. Device tree blob location=
=20
> is loaded into a register before kernel init...)
>=20
> Anyway, thought I'd ask what you thought,

I think we should pick up Yoshinori's series for device tree support [1]
and get it into a mergable state.

Adrian

> [1] https://patchwork.kernel.org/project/linux-sh/patch/cover.1716965617.=
git.ysato@users.sourceforge.jp/

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
