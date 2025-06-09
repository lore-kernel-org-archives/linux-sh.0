Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E6FEAC7;
	Mon,  9 Jun 2025 10:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749463315; cv=none; b=iwZ7hiOnrkwfcJoVjmA64D/3wRSCpMqQbVkM/jPAlaCJX3FB9vCN+sUJ+A7qKLMZoOD4Pz9Itv1PJ0vsOZ1RzEHQ+c+EB05bMy+tYgzS/V4QpGCEjjb1nDC0egyGJ8y3v2u3hlBPbcGJ/feYzloIjzCmHol3mp8kJ3Oa02zedHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749463315; c=relaxed/simple;
	bh=5qSJNAm4/Ny/t3mUHX1wN1H2URz9Qj+7geapReS5IeY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=keaZOghAiEaSJWXbc7lzR1ihRx2wFWDMmvs3Fx9Kx4lAsQByXoKa+amAx4QGpSRkIjVkFYPvikXN2Biz6m9c0RiFrFqOwcwE6o5iWXKezmO7WCxakYcJX08fZ5A2fdGvMRUeX/oP49V+PVXT8TB96xuTp4TdcZ/GFUiMK57ExQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=ToLcTe3G; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="ToLcTe3G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VEEvCxPb4unqjkYtpzeZ9XWFsp8Trhg9VvA0I/cqVDw=; t=1749463313; x=1750068113; 
	b=ToLcTe3G+NEmy0Q5qjJ102x7RRgWdNy6tx83LooRrAbODzTfSGLxRyamtS9Wd1kMg/8GX0+AHOR
	7Y3GxetGjJ9rF3xgxInAEhcMpofgr522h5M3cesWMSx53vOoYqkh2KZETh856wGFm7R8EXwtfGeid
	TGbQAZCg4RYwwTj1By2Bajuf4Y4m5KhrQsaSCbDBrn4glAAC7hAhkAJoj/37tmnXXFfiUTgXl+8Xh
	gfjhhMcsPZs32+Y9CYEWnI7SH7kDJ9TS5JksJL3GfL608XCUl2NzQQ0i+suKadtR7T9GLGQmiWGvz
	/Tf0hZ77xLuXYIFe2Da/csUQ1E87jK2MTe9A==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uOZK7-00000000sFi-3gtj; Mon, 09 Jun 2025 12:01:47 +0200
Received: from p57bd96d0.dip0.t-ipconnect.de ([87.189.150.208] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uOZK7-00000001Ar7-2gdG; Mon, 09 Jun 2025 12:01:47 +0200
Message-ID: <7f12f4e2ccdf1da4096e980923fd88203f0b1d49.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/2] J2 Turtle Board fixes
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Rob Landley <rob@landley.net>, Artur Rojek <contact@artur-rojek.eu>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 Daniel Lezcano	 <daniel.lezcano@linaro.org>, Thomas Gleixner
 <tglx@linutronix.de>, Uros Bizjak	 <ubizjak@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, "D . Jeff Dionne"
	 <jeff@coresemi.io>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 09 Jun 2025 12:01:46 +0200
In-Reply-To: <5656d614-c851-4600-a79c-92edebc9c55e@landley.net>
References: <20250216175545.35079-1-contact@artur-rojek.eu>
	 <f574808500e2c5fb733c1e5d9b4d17c2884d1b9f.camel@physik.fu-berlin.de>
	 <1551804b-fc78-4a3f-add8-af693f340a01@landley.net>
	 <48881e2d8efa9d7df8156f5f81cd662c2286e597.camel@physik.fu-berlin.de>
	 <9cf43bbe-898f-4b29-bd85-04f5320bce77@landley.net>
	 <afec7233266c6c1fd1e70ac615ff129d9dc3f710.camel@physik.fu-berlin.de>
	 <5656d614-c851-4600-a79c-92edebc9c55e@landley.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Rob,

On Fri, 2025-04-11 at 06:25 -0500, Rob Landley wrote:
> > I just gave it another try and it still hangs for me at:
> >=20
> > 	Run /init as init process
> >=20
> > with the latest toolchain, toybox and kernel (v6.15-rc-1).
>=20
> FYI I reproduced this but haven't tracked it down yet.

I have updated to the latest git revision now with the result that it
fails executing /init now. Can you confirm this error?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
