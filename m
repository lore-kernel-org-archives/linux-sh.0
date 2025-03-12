Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A61238D22;
	Wed, 12 Mar 2025 08:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741769062; cv=none; b=Cqae4w24ZkRvUpOyBTNm4Fgv0W4J9gV0ZwKCTBWZSXuLwJKxHh4zZ1Xk5XPqWb61BTNIK58ZhN6XOTtmK5gefJzU9/+btybxCNQf2PtbJJ2VGDwNWz45mtFfySuip9zfzuxJ0xSMqWridJUS5Ono59u+r+1nMW7k+76xcLKfhz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741769062; c=relaxed/simple;
	bh=qiUyzG1nRoqPbOfzzsBkMtLAkyTfe2mGpYrCiMsw3sc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cZWQFlPvYR1tlXQk0GC5//ACpglgoy/8jxetSf6zzbb9KhU0ZsW2Y+xo7aCVjnf0Nvef1ebxOaljGXSc4Y1Lnl0COC0wfwYYSQHZG/6N3feHpt5g/JVbFgXbyL2NOCuDoBuD6g9/FoNtSudnSOp/bdA7vTV7APCDrlJzetK39dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=MwFldcri; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="MwFldcri"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Cfv0QxFiB3W/Bade4/QPKcyAHhzjEJaybofyUrxnTEQ=; t=1741769059; x=1742373859; 
	b=MwFldcriGoo+mJZy5hGfEIPnyHl5sElUTVe10hg3nJoYNgvFCnyUSBv6mCQnONkMW978JSHlLWH
	VlkMcYbTbCc0hW0Oxem0p1Q+iVuHpXtpzVH9wPT2hotszEdghbNwvfyTLYzzd0NjTkxNXz6MkxCeP
	LLb38gSNOGtR7Fq7Gg+mBfqqrDnU+633kVeBd0HvQaOxVA+7ynhf5IkU79cpRDhSrc3j6ZVvuFRuf
	kCAZHl8s2fbKsaGV6bCSoexKAiln/+5lCzFiZU3CkzUOtTk3D8yBdo3Wn15eY4ck7ArMZUIpWV2wB
	/C+5iztHKkt0vjiA83Udcqw9TBH441cnvDOw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1tsHhG-00000002lbC-2xRo; Wed, 12 Mar 2025 09:44:14 +0100
Received: from p5dc5515a.dip0.t-ipconnect.de ([93.197.81.90] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1tsHhG-00000000G7J-1pqs; Wed, 12 Mar 2025 09:44:14 +0100
Message-ID: <c80e0fb60f9b8b13c39215e0418d32244102ece2.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 1/2] sh: align .bss section padding to 8-byte boundary
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Artur Rojek <contact@artur-rojek.eu>, Yoshinori Sato	
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Daniel Lezcano
	 <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Geert
 Uytterhoeven <geert+renesas@glider.be>, "D . Jeff Dionne"
 <jeff@coresemi.io>, Rob Landley <rob@landley.net>, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 12 Mar 2025 09:44:13 +0100
In-Reply-To: <CAFULd4b8+HsmJC2XkW50pxtw=fHNrL9gH1_WM90jh+rfLCbSHw@mail.gmail.com>
References: <20250216175545.35079-1-contact@artur-rojek.eu>
	 <20250216175545.35079-2-contact@artur-rojek.eu>
	 <5365422a9715376c76a89e255c978fc39064e243.camel@physik.fu-berlin.de>
	 <433bc8a0732bf8a63c64c4bf0e6ad4a7@artur-rojek.eu>
	 <967e29681c8bc39edfdd9c645d943f17d341c2ae.camel@physik.fu-berlin.de>
	 <CAFULd4b8+HsmJC2XkW50pxtw=fHNrL9gH1_WM90jh+rfLCbSHw@mail.gmail.com>
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

Hi Uros,

On Wed, 2025-03-12 at 09:32 +0100, Uros Bizjak wrote:
> > OK. FWIW, do you understand what SBSS is for? I couldn't find any expla=
nation
> > for it.
>=20
> Small BSS section. The compiler can put data objects under a certain
> size threshold to the .sbss section. Looking at GCC sh config, sh does
> not use this section.

Thank you, that helps me understand what's going a bit more!

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
