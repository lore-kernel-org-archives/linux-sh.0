Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F8349A3DD;
	Wed, 16 Sep 2026 19:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789585335; cv=none; b=iiOLq4u4txt+14vaHU7vD2dp8BGcYIQcwIIwUrx2EplQZbswYKlFqB7Fzz5L326TcqJmsZN8Rf0QdbSw3SNjJHr9dyLnZO0shh2E+4tDLfyKK1s4dcxbuzMsEQLduqzi3Mj5qQ8zKCiuk2cZMJtoUf0N1yKIeshl75uQCOHHykU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789585335; c=relaxed/simple;
	bh=EI8ULIbBrDvRXrJW5Q2Smr4/pWyac6UYfVhBkBYaouY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rPk4dBK7at7RR7D/xB4O1psRJyD89lyfY4jIZx84V2mssPTQpVKP5O+uxenSdi4rfqZMJ76K5gGjHNdbpPPyp31/weNngDbz6Bp3tQ8NzbDBhNq6hAZwAQZLtfpgWBBAKhD6Ups1T/oh5vUR3FQzbA0BPsxSS0qlVYbuds6r30g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=MVkXWlzo; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="MVkXWlzo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=Qljgg2HuwrDs6FB5Z7besedOOauzUgeW51ZsZoEhveQ=; t=1789585329;
	x=1790190129; b=MVkXWlzownt6DqBM7DPADbbwqiDGNVqerMeHL9+8tynYYOAMYDrt7pUSjQNFF
	zPwT1vPb+oCaZ6NNBOjxCbcovWBV4y32ql18b5w5pkLrzGWPXiPQrHJUPBi9DPjOsdudWJAiDpBAx
	5ReH3cvFGYueeaShA2oluPaYz0Uc6XhxjSRbOM+wQx37rcHYbFZ49BJAP0nFBzYIiBGAU9ueJWI0o
	hdjeM8B05+2ApBDtOW37p/cDwPRdJ70shyK7Qdbm9MZpYRxD7oBxJMOIB37GlLuFhQYhLoAL8kPI2
	CLmh8ffZ6GE7Od24MQ0MajKLtlBfO5HyiMQRlt0LD/PgeeNqZQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1x6utQ-0000000192f-04Al; Wed, 16 Sep 2026 21:02:04 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1x6utP-0000000324a-3KcW; Wed, 16 Sep 2026 21:02:03 +0200
Message-ID: <84a0f85161d26174f47965b3ae760dc3b9beee2a.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2] sh: defconfig: enable the current M66592 UDC symbol
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Pengpeng Hou
	 <pengpeng@iscas.ac.cn>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-sh@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 16 Sep 2026 21:02:03 +0200
In-Reply-To: <CAMuHMdUZdv6FdhgSB_u5wU4YoqpKFqKmhs8x+bZeGFYyvZ5Puw@mail.gmail.com>
References: <20260814075531.15446-1-pengpeng@iscas.ac.cn>
	 <CAMuHMdUZdv6FdhgSB_u5wU4YoqpKFqKmhs8x+bZeGFYyvZ5Puw@mail.gmail.com>
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

Hi Geert,

On Fri, 2026-08-14 at 10:32 +0200, Geert Uytterhoeven wrote:
> On Fri, 14 Aug 2026 at 10:01, Pengpeng Hou <pengpeng@iscas.ac.cn> wrote:
> > The M66592 UDC provider is built under CONFIG_USB_M66592. Several
> > SuperH defconfigs still enable the removed CONFIG_USB_GADGET_M66592
> > symbol.
> >=20
> > Replace the stale entries with the current provider symbol.
> >=20
> > Assisted-by: Codex:gpt-5
> > Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
>=20
> Fixes: 193ab2a6070039e7 ("usb: gadget: allow multiple gadgets to be built=
")
>=20
> > The Kconfig/provider mapping was reviewed statically; no SuperH kernel
> > build was performed.
>=20
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be> # build-tested

Thanks, I'll pick up this patch and add the Fixes tag manually if b4 doesn'=
t
do it automatically when downloading the series.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
