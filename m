Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2AA282F12;
	Sat, 13 Jun 2026 05:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781327477; cv=none; b=gx+2Cwu6D2Lx9nRhcgw9IUddWrymLPH/y5w+24Bgu5D8lNyxUj9wdqS71EdDbj51eytLhPVfh2yAlGcOetkKN0/Mk42WAJUSDzOFGK1fxEFVXmQr7N9QtdO0dPymvh180jLXeplXhaHf3OwuGc24xdjCMxdf+bJEW6+BuR5xlqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781327477; c=relaxed/simple;
	bh=aI9MypmHzVjQxRgxKAFlu/56iXGQ6CmqWBTS2W4fLfI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C2DWaN1N4YmuI3c8HODTkDPEBrCxU6Uf3lQpiW/57YlFM5tTM0bCzQOjbESAn4H2t59CSmfryqVorAAMa4a97RDRCMUTH/nfFKXMEK6ArI55sCCZcHoojuL4plPrD7xzVptOxsr1WSJqqVfIvX+OIKGpl5a0FKXGkwGV53FJro8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=gQ7Z6MUA; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="gQ7Z6MUA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=8ec2QSGS1uexXbikYSeRb6CaTm+SqqL/s5eiyFr+ddY=; t=1781327473;
	x=1781932273; b=gQ7Z6MUAI3jt7codJ4zDIdbRgkuI379+Q821km1FasEAkKwHXCB/ObSzJ86JX
	TD5y6qJvW/uSnc4z1KCr3Nex0sRK054b1HnZAh41pM+00SL2boRlzNbI0HYtDkrp2O+ojVUnoa222
	tj/fLY+Ex7Fq5QbLo5p6sVGjq9Xchx5egvhJj39ojwsgTYqUAePyQwr3cNMehpPrZM8VN8aizJmjD
	jrzlemAK9/uvtr32xTIoQWnAj6UfHEPnx0i0AvnU7tNZhXU10IbZc16sJw5/t+iOefu/HLdqFLAus
	i2Ptd0zrHXtDIEa/Egm/ciMVpiqYiLAfOGtRIrsKBe14lIRetA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wYGe9-00000003ynl-1d4d; Sat, 13 Jun 2026 07:11:05 +0200
Received: from pd9f74f36.dip0.t-ipconnect.de ([217.247.79.54] helo=[192.168.178.52])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wYGe9-00000001xhj-0HAn; Sat, 13 Jun 2026 07:11:05 +0200
Message-ID: <06c0871d4999dcb09aeca6bbf6a6eb282147d606.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/2] sh: kfr2r09: fix i2c adapter leaks
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Johan Hovold <johan@kernel.org>, Yoshinori Sato
 <ysato@users.sourceforge.jp>,  Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 13 Jun 2026 07:11:02 +0200
In-Reply-To: <aiwtIkdGNMFqJmHk@hovoldconsulting.com>
References: <20260508120601.426115-1-johan@kernel.org>
	 <aiwtIkdGNMFqJmHk@hovoldconsulting.com>
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

On Fri, 2026-06-12 at 18:00 +0200, Johan Hovold wrote:
> On Fri, May 08, 2026 at 02:05:59PM +0200, Johan Hovold wrote:
> > The kfr2r09 platform setup code fails to drop the references it acquire=
s
> > to the I2C adapter.
>=20
> > Johan Hovold (2):
> >   sh: kfr2r09: fix i2c adapter leak on USB gdaget setup
> >   sh: kfr2r09: fix i2c adapter leak on serial console setup
>=20
> Can these be picked up now?

I will try to review some patches this weekend.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
