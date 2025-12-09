Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D329426F2B8;
	Tue,  9 Dec 2025 10:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765277123; cv=none; b=Ts+dgFzJUiR/GxePpCinUhIFjRYeWsBOyCl3YFqzF3DmEIIkmjxkWXRhL7Qj+S9NMpTkdQyCmy7pZjEe7PtT3RQet+H79OMPfhHU1hEdBJ25fv4XXTHgVgfovFgKWxSKiwdAgt/RaFf6ZLA8O87BCTdYkUt6O27yKxKaPGcSIm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765277123; c=relaxed/simple;
	bh=BqS+Wvd6f8X2A+oiqGiE1sknipTqPIJGzDlgX5v7cJI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GQlu9Yi7tIqZqAwCqR1tHTcrybLKrqr8xBybo1CyaOn9Ev9mII7TGIykL55evsT2oTqspt6FE5XDn5/VOuxmTMQ7175p7VFPgRDRUnTvLbKI298alcUhV1j17HgItDC+hepWfQepmHr2hObh7am9xIS59IZaTBLr0luisr5Pgfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=TD2Cgs1A; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="TD2Cgs1A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=V43iKeuXkWEbsOTGyK/7fvOM7cegPuuBRLGvWn7Si9k=; t=1765277120;
	x=1765881920; b=TD2Cgs1A5DnIyk9FV9oJitmoUgbh/8zi5qx2miG2yba2keJmef7pK2soQZolD
	b5pV8o02u0FNGYxN/IN+oA/1Z2P3/o67q1UbPnFvDTUvEv7YoHpB2r8JKIVCW0LxJ/Zfju6eBgtZR
	23YGGb7j/dFNybH8e4ukdbS5wxiZoWsMLaUPk7lFh3qWtIP8MKUpH+bV00xU/MCAUGSpMfJ7KtUdD
	vkC+/Tbql4X+eQgwg8Lbb9SDR4kkTAnDhZYFHaDv6H77+0HRhQEApglJ2D1ZoSI9YuOTvSMhunYXE
	Y4fVmwKAWI5cQmtJr2NBJy+1Stm+E+//dsGyLDLe6FvtZrwFiQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vSvDW-00000000kdw-08Hs; Tue, 09 Dec 2025 11:45:14 +0100
Received: from p5dc55f29.dip0.t-ipconnect.de ([93.197.95.41] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vSvDV-00000000qRg-3H26; Tue, 09 Dec 2025 11:45:13 +0100
Message-ID: <2189d38d368b1b580ee440d1d406bfcd3631213f.camel@physik.fu-berlin.de>
Subject: Re: Kconfig dangling references (BZ 216748)
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Rob Landley <rob@landley.net>, Randy Dunlap <rdunlap@infradead.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, andrew.jones@linux.dev, Alexander
 Shishkin	 <alexander.shishkin@linux.intel.com>,
 "dri-devel@lists.freedesktop.org"	 <dri-devel@lists.freedesktop.org>, Paul
 Kocialkowski <paulk@sys-base.io>, 	chrome-platform@lists.linux.dev, Paul
 Cercueil <paul@crapouillou.net>, 	linux-stm32@st-md-mailman.stormreply.com,
 Srinivas Kandagatla <srini@kernel.org>,  Philipp Zabel
 <p.zabel@pengutronix.de>, Matti Vaittinen <mazziesaccount@gmail.com>,
 Jonathan Cameron	 <jic23@kernel.org>, Vaibhav Hiremath
 <hvaibhav.linux@gmail.com>, 	linux-sh@vger.kernel.org, Max Filippov
 <jcmvbkbc@gmail.com>
Date: Tue, 09 Dec 2025 11:45:12 +0100
In-Reply-To: <f10e135e-14c5-4bc0-8100-1712be3796dd@landley.net>
References: <22b92ddf-6321-41b5-8073-f9c7064d3432@infradead.org>
	 <f10e135e-14c5-4bc0-8100-1712be3796dd@landley.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi,

On Mon, 2025-12-08 at 16:20 -0600, Rob Landley wrote:
> On 12/7/25 20:04, Randy Dunlap wrote:
> > USB_OHCI_SH ---
> > arch/sh/Kconfig:334:	select USB_OHCI_SH if USB_OHCI_HCD
> > arch/sh/Kconfig:344:	select USB_OHCI_SH if USB_OHCI_HCD
> > arch/sh/Kconfig:429:	select USB_OHCI_SH if USB_OHCI_HCD
> > arch/sh/Kconfig:455:	select USB_OHCI_SH if USB_OHCI_HCD
> > arch/sh/configs/sh7757lcr_defconfig:61:CONFIG_USB_OHCI_SH=3Dy
> Commit 231a72e03af6 removed the only user of CONFIG_USB_OHCI_SH (an=20
> #ifdef in drivers/usb/host/ohci-hcd.c), commit f6723b569a67 missed it=20
> cleaning up, then commit 4f6dfc2136fb special case removed the symbol=20
> but not references to it.
>=20
> It can go.

I will take care of this. If someone wants to help, please feel free to
post a patch to the linux-sh mailing list and I will then review it and
pick it up from there into my sh-linux tree.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
