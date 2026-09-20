Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4149F43E9C6;
	Sun, 20 Sep 2026 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789909092; cv=none; b=AA2Kd3Yubvoul93th7WDDk2NVxZVUqOzBwmjxi0qYo6uDxb1xwAwIU8K9UQ0aXGVlPvjinugJSk6/Qo3LHzMQXkjNe53ETVkGXdCyiO+7iasBo4AWW00TEBpLavxr1s0viN2XCyZrmQ0z1b3tPiFEKQO/gWKNFnhHw39RNK2Uyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789909092; c=relaxed/simple;
	bh=zRGuhwaLxr07uMLeGbtCH5fzlwb0yOlWC3n/NJw1RXg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=geAyBXM/FtkzeNeLFMUjezRgTUm/OXFVdKTG/PMXhiG6irVDZwazMb6q1rgECoNBWjQk/FaFAS5BN96UQzkvcpoxLNDanBwshWKgCaffKbXPVn6XV6jzpKS3sil6xrSjJv2yffpI7n3NE1oRfTwbG9BRAZDnLcmxT5aYmSDpDKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=L/eajstT; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="L/eajstT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=fCv/ozP2Ag2A+cPYDDGej/LdxuVPvk4yVrJwO9TVk6M=; t=1789909082;
	x=1790513882; b=L/eajstTWBYE+0gmITeQfVryvcOh2NzCK7BN12kY0OuvPBIVzStF26OMjB0XW
	zUHZR26IVbjYvjcgLqHS40nSFjedNguiV9budWN0ZObAdvvPAPA4iY4ohBJO0qJNvaMEhu9MXOpVK
	q7jrvHO1m5PIZrPvpU7qPgx0waYGrTdmCl9BU8J2X0t9yWa0qT0k4KcB4CQFlkT7RvUElYzefheHK
	/uKIc6rA/2YrBdn6BMNCbPemyHRlTovifZAUd5zr/n7SzraZ2DKaM37LBHFjuJp3vl93rsRf4y+Pg
	ptQeJpSYT+G4rlXKnLnQGxQzQtqteAhxKRRfD8N8LRSiUw0OsQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1x8H75-00000002tCg-0DaN; Sun, 20 Sep 2026 14:57:47 +0200
Received: from dynamic-093-128-159-008.93.128.pool.telefonica.de ([93.128.159.8] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1x8H74-000000020FX-3K31; Sun, 20 Sep 2026 14:57:46 +0200
Message-ID: <2ccce813ce4d615af2ca880da19501deaa562c22.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: Use generic OHCI platform provider symbol
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Pengpeng Hou <hppiscas@163.com>, geert@linux-m68k.org
Cc: ysato@users.sourceforge.jp, dalias@libc.org, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Sun, 20 Sep 2026 14:57:46 +0200
In-Reply-To: <20260920031112.98903-1-hppiscas@163.com>
References: 
	<CAMuHMdVkL629ps2mmD3XRXM-BYWXZ-6GQGM7tKf6vEvhK--LBg@mail.gmail.com>
	 <20260920031112.98903-1-hppiscas@163.com>
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

Hi Pengpeng,

On Sun, 2026-09-20 at 11:11 +0800, Pengpeng Hou wrote:
> Hi Geert,
>=20
> I checked the removal of USB_OHCI_SH. Please include the tag you supplied=
:
>=20
> Fixes: 4f6dfc2136fb ("usb: remove the dead USB_OHCI_SH option")
>=20
> The current SH subtype selections and sh7757lcr_defconfig still name the
> removed symbol. The patch switches those users to USB_OHCI_HCD_PLATFORM;
> there is no additional code change for this metadata update.

Shall I use the v2 by Karl or are you going to send another one?

I am currently collecting patches which I am going to send to Linus
for v7.4.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
