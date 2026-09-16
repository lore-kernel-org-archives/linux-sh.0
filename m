Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE4549B45A;
	Wed, 16 Sep 2026 17:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789578674; cv=none; b=A3zN7QT6/zNKljTd9iab0GR2yYXUMV3sbD9hPlnYlX01NNV4dImAp6ZhDHKhYMmEApKhYOumc0c7KaGxCSPnErUZs1iWga/eXjZNEQgjAaHTk5RZNegj+kKHXragYfwqZE1yx3h81aAF/qegAQ8lQCs0vFeHAJjPFAvRi0u33+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789578674; c=relaxed/simple;
	bh=FVl4jZRAq4po6F02Gpx2eYDptt54Fs0noMsH5nGZugY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EkyEWvvtkFZUD5MVijXYDdSkcIFTFow+xit/WacCabh7jwCCOYvHoVfGUOsH79UJFHqOsqK19grl70tqxPypwMgHwMuHMCdUvtGyHSzX/cPZ5ihwQg0QA/JW0xNKHiKhzfDFxEhidBABRInA38+HIbKrVpkvzXuLyEmdh1uuOKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=YlFwVP5P; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="YlFwVP5P"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=L6SwzphsrreNsIdosvNBrNqsY0SnqqVKbcSjY0NO71M=; t=1789578665;
	x=1790183465; b=YlFwVP5PIwofdsIy+fpvkkfYdFxLuBo+IaZxvtVb/v93Ckt5mM6/kwYsV/BwS
	ku/Wk+Rpe/ZGOIGLTk5touExuUpMRfw6s3lifmuHRmOrZfMqXZRH06dx8COZzDuPYZ6D9HH+wvi95
	hDr+mE2O6+84aQ9tltxElSBUjsOl7K86TlX3hcnP1F8wShouajHI1hWDNPGZr4dLbqPibtoPIu9zL
	42knxwM6MZrLgYCcX59Uyk+KkF0pINPnyO98jLpNhEdERolVawl3Sxcqo65fvKaqGNDzonehYb0je
	TXf7iOeaxD1erqiNtckGRSc12/FNtd7QfbT9SaSwR+8q7B7Wwg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1x6t9m-00000000eCO-0jIA; Wed, 16 Sep 2026 19:10:50 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1x6t9l-00000002liV-3w7V; Wed, 16 Sep 2026 19:10:50 +0200
Message-ID: <76db667b04eefe1a4f3f3af4354f98f0858069eb.camel@physik.fu-berlin.de>
Subject: Re: [RESEND PATCH] sh: ecovec24: use static device properties to
 describe the touchscreen
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Linus Walleij <linusw@kernel.org>, Dmitry Torokhov
	 <dmitry.torokhov@gmail.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>,  Bartosz Golaszewski	 <brgl@kernel.org>, Kuninori
 Morimoto <kuninori.morimoto.gx@renesas.com>,  Mark Brown
 <broonie@kernel.org>, jacopo mondi <jacopo@jmondi.org>,
 linux-sh@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
Date: Wed, 16 Sep 2026 19:10:49 +0200
In-Reply-To: <CAD++jLnAF7c=bBh2ihXEiG55twpj6seEGU-2R2GhWsGfC7NCyw@mail.gmail.com>
References: <alUyZ2zVWCPhyHHX@google.com>
	 <CAD++jLnAF7c=bBh2ihXEiG55twpj6seEGU-2R2GhWsGfC7NCyw@mail.gmail.com>
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

Hi Linus and Dmitry,

On Wed, 2026-09-16 at 19:01 +0200, Linus Walleij wrote:
> On Mon, Jul 13, 2026 at 11:41=E2=80=AFPM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>=20
> > Convert the board to use static device properties instead of platform
> > data to describe the touchscreen, so that support for platform data can
> > be removed from tsc2007 driver (ecovec24 is the last board using this
> > mechanism of describing tsc2007).
> >=20
> > Device properties do not allow custom board methods, so the method for
> > getting "pen down" state was removed (the driver is capable of working
> > without it). If this functionality is needed proper pin control/gpio
> > support needs to be implemented so that the same pin can serve as an
> > input GPIO and an interrupt.
> >=20
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>

Thanks a lot for the review! I'm working on them now.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
