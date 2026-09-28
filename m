Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDE8355814;
	Mon, 28 Sep 2026 19:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790622182; cv=none; b=KcBDl54it9Y1bjSaTndWp5r3f36O7DXr9yo9Fg3P8JqwcngNqmUHBY3n1+qvb6CtuFLG0/cEEX2ZCHDBNkrwosSJ6cYoVk06aIePoSU3zv7TzO92m5HUvnq7iYw5QuEPCtNnAc/U+endmvSq6+y4RAd8oXeH+CcxL7/dkxkUJqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790622182; c=relaxed/simple;
	bh=sBRZ/A/mD7iUakyQmtgiRT6k8R5104zm3LEma7BMULw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YZuDzmeFx7nrgt2rtqqwzkVy79xepKNUmmXqOIApEilHu5tz1hanSZAeMRdzqQJUduC6Ia04GoQGAIVCfFaFf9ch+1epwmYt0fVhfD+gySCjEi+MTqBzfUzmVxO3RDT8vYsUDPgReehaVdQJIJASyuE0gmhhPILCRxP1pEGx1R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=UHDYmLPa; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="UHDYmLPa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=Z6VBottvTPYW+qs/CVgOezfBsPAXrTN4IL71LWKUV20=; t=1790622179;
	x=1791226979; b=UHDYmLPa2tXCxP+n25/botuVPrts14PlguR2m7zr06OXmloMXxk02Bjfrld+Z
	TA4PqGFenkw85AHou+XJzoD7M+br3ZWr3npDigOejgWL+Uy2XXfLQdGcf9+uPyvfsG7PIz6xKM9EA
	wGVTuGgvLgQyP235fR8wIUcXtSEiLC/SqhqegWupGHZuEY4NfbLwS2IJZGp9g0u2r79yjBNdugImE
	cIKLriiZVHWxPkKcU4C33EslSLjYsJXXAi2/ZnfgXu42gatPUmiTvI5WAVu5i5gx3C8Ib62mKe+qO
	bKx7bQgDM/tbjxzIclHAX9LL2fhIAiSOWRlceoYhr4+T3Dl54w==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xBGcq-00000001Zvm-1Ze8; Mon, 28 Sep 2026 21:02:56 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xBGcq-00000003KZ4-0dl0; Mon, 28 Sep 2026 21:02:56 +0200
Message-ID: <a6242d982e0815131fb2436091c77f0e7e545424.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: intc: sort the prio and sense lists after filling
 them
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, Yoshinori Sato
	 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 28 Sep 2026 21:02:55 +0200
In-Reply-To: <CAMuHMdVw+-V5OKgRugm2Jz+S=0dOD7hi1p-U=Fzmh3piCOkE3Q@mail.gmail.com>
References: <20260927191359.6144-1-kmehltretter@gmail.com>
	 <d4f35d5001924ef9ff4b28ac412a9d4b6048d789.camel@physik.fu-berlin.de>
	 <CAMuHMdVRznzGdRwZOHa3=cxhoDNBh1kJqGUoBHqowgj_nzKCRg@mail.gmail.com>
	 <ed4f818f00df446df53a9168054bee1a9a993409.camel@physik.fu-berlin.de>
	 <CAMuHMdW=amt+3ej6+i5TMaO6VUKJt3qqYvSWctFtSt8Tttrk2g@mail.gmail.com>
	 <cdb4898094f152eb617ea353c0780e7fbb000659.camel@physik.fu-berlin.de>
	 <CAMuHMdVw+-V5OKgRugm2Jz+S=0dOD7hi1p-U=Fzmh3piCOkE3Q@mail.gmail.com>
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

On Mon, 2026-09-28 at 20:34 +0200, Geert Uytterhoeven wrote:
> Perhaps a size limitation? Your kernel image is flirting with 4 MiB.
> Perhaps a config issue? The safest way to preserve your config for
> bisection is:
>=20
>     cp .config arch/sh/configs/bisect_defconfig
>=20
> and to run "make bisect_defconfig" in each bisection step.
>=20
> > Maybe Karl has an idea. This image is known to work [1]:
> >=20
> > glaubitz@suse-laptop:~> file uImage-git.gz
> > uImage-git.gz: u-boot legacy uImage, Linux-6.5.0-rc2, Linux/SuperH, OS =
Kernel Image (gzip), 4416616 bytes, Mon Jul 17 14:17:35 2023, Load Address:=
 0X80001000, Entry Point: 0X80002000, Header CRC:
> > 0XBA69203A, Data CRC: 0XD097D603
> > glaubitz@suse-laptop:~>
> >=20
> > It boots fine with:
> >=20
> > usb reset ; fatload usb 0:1 0x89000000 uImage-git.gz ; pmb ; bootm
>=20
> Do you have a config for that kernel?

Here are some known configs:

https://people.debian.org/~glaubitz/sh7785lcr/configs/

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
