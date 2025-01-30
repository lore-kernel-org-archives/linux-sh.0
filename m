Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558991547C9;
	Thu, 30 Jan 2025 08:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738225452; cv=none; b=fR2st5ufJiRln7G6bEHGKqcp/yPNYwqMtbqVSfMRP9o0qoajTW5UXOZSwsVIkiHZow3FDwwL3rcl9G/zwwxQbAf5H9Ss/YV77YwONoKehOqGRWC2bLBYtQEyj6snRSDErEfqugw4FZJnRIvgWqCZql6EyY1LKBWgWfz05//RVvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738225452; c=relaxed/simple;
	bh=XMsYQxx1st3PcRVZZG8wVoCL5T3+oTFhfHlIgyGlPfo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W2uRCFhSBN+iX90tQEvXGhlkox26bo9nxvAy5Erpg0wIK6PsGYyQ6u7UmL4Ee8k1BBgCVBenLVQb1WEE0ym+AgP2DNXkuQ8p2Da84ljjjj/i7UGrIGIi1xfNisAj49yh8zd6qhJtgHp+KIbfVZCLFWu3jmZlm9HXMppQIyYI0Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=OMDyH/KF; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="OMDyH/KF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3h6yZcqdv4m2JbAUENLW8cE3fvB7R3CJBmiZ8dYaFXs=; t=1738225449; x=1738830249; 
	b=OMDyH/KFaWonAcjQ5OoLgqwm5m70dHPwgIgU932agob/goeiTZpWOpATp/i6sMdKTm8sH1mf2r4
	sdGdm0u+BWIdYKHceg09cFfZ7IuRXHxeOtGRBR0tGSZyTIqp+arRDIMapT5dMMCOwZ8FIE+WMCvpg
	JH0krWZjTF6lKChyaLltKTzJIN+qb0xdhCgK9ljInLwjQWCw6QiXgk+xRGX6EY0YdHSU8i9UHQcLp
	iH7gcHQ6KNT1sd36Le7tN+xWOsZvXXNN0+hDAxeiCFE7qo/vhgE92EfUV6frcyjimi4ION02Aol+V
	/Me0XB8Ip1+KHglIBBOowdlvqnfy+deutphA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1tdPqF-0000000097i-48q7; Thu, 30 Jan 2025 09:24:04 +0100
Received: from p5dc55198.dip0.t-ipconnect.de ([93.197.81.152] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1tdPqF-00000001iSk-3Ef2; Thu, 30 Jan 2025 09:24:03 +0100
Message-ID: <4c37eb9306b9eef2a93720947817d5838ee48dbc.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: pci: Fix the wrong format specifier
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>, liujing
	 <liujing@cmss.chinamobile.com>
Cc: ysato@users.sourceforge.jp, dalias@libc.org, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 30 Jan 2025 09:24:03 +0100
In-Reply-To: <CAMuHMdXu04CFhkc3E=cA9wi_eigc1q88azb8k5N4UeyMAgKOkw@mail.gmail.com>
References: <20241204110706.6776-1-liujing@cmss.chinamobile.com>
	 <CAMuHMdXu04CFhkc3E=cA9wi_eigc1q88azb8k5N4UeyMAgKOkw@mail.gmail.com>
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

Hi Liujing,

On Wed, 2024-12-04 at 13:35 +0100, Geert Uytterhoeven wrote:
> Hi Liujing,
>=20
> On Wed, Dec 4, 2024 at 12:10=E2=80=AFPM liujing <liujing@cmss.chinamobile=
.com> wrote:
> > Make a minor change to eliminate a static checker warning. The type
> > of port->index is unsigned int, so the correct format specifier should =
be
> > %u instead of %d.
> >=20
> > Signed-off-by: liujing <liujing@cmss.chinamobile.com>
>=20
> Thanks for your patch!
>=20
> > --- a/arch/sh/drivers/pci/pcie-sh7786.c
> > +++ b/arch/sh/drivers/pci/pcie-sh7786.c
> > @@ -219,7 +219,7 @@ static int __init pcie_clk_init(struct sh7786_pcie_=
port *port)
> >          * on. clock lookups don't help us much at this point, since no
> >          * dev_id is available this early. Lame.
> >          */
> > -       snprintf(fclk_name, sizeof(fclk_name), "pcie%d_fck", port->inde=
x);
> > +       snprintf(fclk_name, sizeof(fclk_name), "pcie%u_fck", port->inde=
x);
> >=20
> >         port->fclk =3D clk_get(NULL, fclk_name);
> >         if (IS_ERR(port->fclk)) {
>=20
> LGTM, but there are several more cases to fix in this file.
> Please fix all of them in a single patch.

Could you send a V2 of your patch and make the changes recommended by Geert=
?

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
