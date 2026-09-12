Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B75386C21;
	Sat, 12 Sep 2026 11:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789211680; cv=none; b=u/UgezX3l2YWSxDhHI6WsFiNfDhUndCgMbAmvva2bjNbReOWnyf2AYeHkZZcXCMcYTu4FKTsCqOSI7fvKI+UWEzK46742ES//NtPfP+7QNX2t+/Q/KWz1mR+EsT9XsqP66iQGbY8LTalpL81Rht3titE+4vXQnX+JSYBeT9V68M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789211680; c=relaxed/simple;
	bh=U+lClmhuzt+gqdwQa1S1c5SuZvBYgc6VErdQaa0P48I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hxyvrZf0yy73mqR1DfK6gbuKLxBGBGSe/vJ64Lp76r7DR3XKOCVNK6KRVGexvPLOv0TUh1JPlyD6ywT71rTzbjLYVV7D8wIGS3+T6bhW/5QrmSLcOg1wjTPDjgcCg4bzNDzsz0uYH+UrztPe0U9DGA5DSoOtVxoyl6IHi/Sg/88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=KfPigndx; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="KfPigndx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=4rmi7EhOu14XDxpWxjmlow07gdhu0OV5ClVfW5zsdpY=; t=1789211677;
	x=1789816477; b=KfPigndx1nnXjGv7aL8ITyu8iKg8lADrfxbjXO2Lux4SMHBYus0y/BQdAplmI
	KC5afdnA7CSN1kc5ZNJUMQtcjAUODa+Mlx1oIU8+AfN94rTyRsnf1TlnVLYH8h0ih4GPzXJvKjPiu
	prB3pagbm/0t36JtR4vHUUY+qi45kvXkP0mCqcL+SOnVCQHnaqtMsgLjTUpv9kHTujSs7p7yMxcsg
	Kf9EMFXXBBtfae9PvzuN64Yc1D4n7SqhRnJbVYMOtpAv7pNou9djtAR/C+qvfu3tpMTPgHrhvChqk
	BhJqnBA65+p4ewQrLhgWsWM4qtQHsWrxUh5puMHVx3eIwgu5Kw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1x5Lgi-000000011Ot-27cZ; Sat, 12 Sep 2026 13:14:28 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1x5Lgi-00000003kIl-1B02; Sat, 12 Sep 2026 13:14:28 +0200
Message-ID: <f0d9374747362835a67ce51b17fb3794553fc692.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/2] sh: mach-x3proto: convert gpio-keys to software
 nodes
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski
 <brgl@kernel.org>,  Arnd Bergmann	 <arnd@arndb.de>,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,  Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Date: Sat, 12 Sep 2026 13:14:27 +0200
In-Reply-To: <299ae94b6fc60cc660b2a5492052ca1375f22001.camel@physik.fu-berlin.de>
References: <20260704-sh-x3proto-swnode-v1-0-0c039549dc46@gmail.com>
		 <aqGP2P3-44dmCyjz@google.com>
	 <299ae94b6fc60cc660b2a5492052ca1375f22001.camel@physik.fu-berlin.de>
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

On Wed, 2026-09-09 at 20:06 +0200, John Paul Adrian Glaubitz wrote:
> Hi Dmitry,
>=20
> On Wed, 2026-09-09 at 10:00 -0700, Dmitry Torokhov wrote:
> > On Sat, Jul 04, 2026 at 10:04:36PM -0700, Dmitry Torokhov wrote:
> > > This series converts the legacy gpio-keys platform device on the SH-X=
3
> > > Prototype board to use software nodes and static properties.
> > >=20
> > > This is part of the ongoing effort to remove platform data support
> > > from the gpio-keys driver, allowing it to rely purely on generic
> > > device properties.
> > >=20
> > > The first patch adds the software node to the GPIO controller, and
> > > the second patch performs the conversion for the gpio-keys device.
> > >=20
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >=20
> > Hi John,
> >=20
> > Could this be applied please or maybe you want me to make some changes?
>=20
> I have reserved the upcoming Saturday for kernel review now.

Correction: I will do that tomorrow (Sunday) as I got an appointment on a s=
hort notice.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
