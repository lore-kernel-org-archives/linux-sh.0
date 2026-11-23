Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.133.4.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795421571;
	b=c8K2m2sqIVr8yqhkm8l+0Cb71Y1cKxu7Sa2EFoYo15P+qPBTXFeGBgNcSmJApdqTfKKy
	 ohbYZrp+55ZPU+Gh4dOnQmiYBuu3VbUugtMbrT9gfy5AywiMmC5OOZLUlrhuP7j8Mfcjn
	 6RRrTSKD0Jqcf8inN4e8b/naMeopIEIDdZOAvWWxWn5lKEaIA6apX5RZeoUNCnqomc43O
	 ApEzXnegHB5H5S9DvTAg/5msLoTtYCOtrLfR7BhnGAm5or4ExDmsCN+Bhf4UbLa6G6AQH
	 nfjG1AFTwha3JzUd7AeB2Gvr3qv0J0AwwN22aD8zd0bIaFLccqJ7r7MZnTylPPXHPWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795421571;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-Original-Sender:
	 X-Originating-IP:X-ZEDAT-Hint;
	bh=xThfAToSR6bF3rJ/R8vOcJlYdxkzc5cR2ncMAQ8XHLE=;
	b=r5THsVzq45eSuizJenYEkQoj7ZHtGnFQfUz0LB4mh+lB20oCo1mUg1k8cKewQxWdeo88
	 eZVSgW91goIsGYlSS0bndrcOVZNBC8uIWBP2BN4Flo6EtOVG5pIDskPgJ6mZfJ9F4p9nB
	 o3ROxmG2aG6ye6fPfgwuZmK46DFmrQeHRMw5d5rrZg8uq+N2bzXHjeKOC6zOJ7bZpC4nZ
	 cna6uC/BdcKMy3RrZdcO9OoZPfn3EBZyQiR75Lm2S2Fux2iVTyQkQhK7fF7ojNwsCj3c6
	 20Sqey1MiEsMAsPApohgPVBEJB0cJ0qFni7UEnJ/n608mPqUxwR9I9BmIlMHrYOIUHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=physik.fu-berlin.de;
	spf=pass smtp.mailfrom=zedat.fu-berlin.de;
	dkim=pass header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=BnZVxjmY;
	arc=none smtp.remote-ip=130.133.4.66
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0543D606A31A;
	Mon, 23 Nov 2026 08:12:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0543D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=BnZVxjmY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=xThfAToSR6bF3rJ/R8vOcJlYdxkzc5cR2ncMAQ8XHLE=; t=1795421570;
	x=1796026370; b=BnZVxjmY6t8jarxpDkToo/H8c0fNj7uHqMzrKdezMQEa/HSXTPT/OtuZkQ3iF
	SIjk645HaQlguO2vz4X5xoQAcMq7Kekvox9aQ5/Wv/2Y3y7Peg+KjZm84nlrQkt/cO7uTmKUHCI5G
	rUPSdfuSDhULcJkCdZgXtngzD0f6Qlj+b8BuVkGpr3h+m0+bVxGwnhWH+Tlu/JrQPqRYWz58kESIA
	azCY9UVurEj16zTYUULKfrDesX+idU3fR1aMKwCwDOMOXSM6O4PJnaJDguDFOUOWLmrq9PO0s0ccC
	0Tcqy9nu5/LQbiorjpYiGoUAQ0dmYdjJFjzL8MWFSInDYscE3Q==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xVPAE-0000000107v-2isJ; Mon, 23 Nov 2026 09:12:38 +0100
Received: from p57bd95b5.dip0.t-ipconnect.de ([87.189.149.181] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xVPAE-000000035JX-1XDw; Mon, 23 Nov 2026 09:12:38 +0100
Message-ID: <ce838102be497ee6eab490b4454095b96e16d015.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v3 0/5] sh: mach-rsk: rsk7203: switch to using static
 device property, drop legacy gpio API
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann	
 <arnd@kernel.org>, Rich Felker <dalias@libc.org>, Yoshinori Sato	
 <ysato@users.sourceforge.jp>, Geert Uytterhoeven <geert+renesas@glider.be>,
  Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Bartosz Golaszewski	 <bartosz.golaszewski@oss.qualcomm.com>,
 linux-sh@vger.kernel.org, 	linux-renesas-soc@vger.kernel.org,
 linux-gpio@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 23 Nov 2026 09:12:37 +0100
In-Reply-To: <dea00f90c205f8359baca729d8b0f31a@gmail.com>
References: <20260929-rsk7203-properties-v3-0-02f84aeb8e47@gmail.com>
	 <3a51385d-9649-4bd7-87b3-0caf9e462b2e@app.fastmail.com>
	 <arzKNhmoL6yiGrzH@ashevche-desk.local>
	 <dea00f90c205f8359baca729d8b0f31a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hello Dmitry,

On Sun, 2026-11-22 at 22:44 -0800, Dmitry Torokhov wrote:
> Gentle ping on this series. Will you be applying these patches (possibly
> with Arnd's Kconfig tweak folded in), or would you prefer patches
> removing rsk7203 support altogether since it is not working anyway?

I have been super-busy with CVE fixes but I will try to get into kernel
stuff back again later this week. As I mentioned before, kernel maintenance
is not my primary job, so I cannot act as quickly as people who are getting
paid for it.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
