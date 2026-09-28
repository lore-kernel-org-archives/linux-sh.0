Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1360A4EB846;
	Mon, 28 Sep 2026 17:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616072; cv=none; b=A9VYrScxV2W6sC4M/CcFqvQ+594yHjpaqRE82nT7aEKXncrva2ifrzF3rbYKuBo824lnmzrr1IO0n1Ld7c2faRqxxH0a7xM6SWMjH+p8F903J0GLPdDkKDXhipBsmF7Uj/434IuAf3NAKdrHzGobE3b6PCSs7JjpyCAjye7PaTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616072; c=relaxed/simple;
	bh=Mip8zRPyPNpn06TfsaUHSfycS1YIk3BoTA/TtM8SBm8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mk8/dcHpGSm0DDIn5osL+HAcwoMe1f9q+GdUjXKN8M/sgFlGz04BcLJn/yvxEmkaChm090TIJqKMUKVGjJTWN9nEq/4tPUMwXRfCHxGOB2n4rwDDrzMRPaK8r/qD8DOSucFmyy2DadcaOUAkD48tgslcRaDrldnCNb7M2IFP6v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=hIhYAFWa; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="hIhYAFWa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=UHJAfk3qISeG1NoGf2nv10+jWj+NBJ9UvA4LilWqoOQ=; t=1790616067;
	x=1791220867; b=hIhYAFWarjmc73TR5QHciXSI6I4P2/rdRF1QWMsAFw+iZrBSYzne0SGGrqPgh
	asgacTVmmC+xZUA/gm3vrzIQQUNFP1NvLqXIsyAcMEo8OhVZVTXokw2p7HPR/gwc4h440EO/i1GHM
	0ZLg+czf/8xtjutYMcPbIYVn0AGc5JEaJ2WKJEjAa4/sFEJYBrCL7aHHFA02ugav2llzT2WCAv5A1
	9UKj4rrHvNeNJlLbXWca/LtAYM4py0c2wjJ0godel3+wWTA9sktBm6MOu6ahGtg6kvIfptWCLzW87
	4TZ1uA6W9oc97peqXAX0bXfJxkQtWYa/VTPpzUyVkPekNniggg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xBF2E-00000001CCQ-2W5R; Mon, 28 Sep 2026 19:21:02 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xBF2E-000000031Yc-1Yy5; Mon, 28 Sep 2026 19:21:02 +0200
Message-ID: <cdb4898094f152eb617ea353c0780e7fbb000659.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: intc: sort the prio and sense lists after filling
 them
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, Yoshinori Sato
	 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 28 Sep 2026 19:21:01 +0200
In-Reply-To: <CAMuHMdW=amt+3ej6+i5TMaO6VUKJt3qqYvSWctFtSt8Tttrk2g@mail.gmail.com>
References: <20260927191359.6144-1-kmehltretter@gmail.com>
	 <d4f35d5001924ef9ff4b28ac412a9d4b6048d789.camel@physik.fu-berlin.de>
	 <CAMuHMdVRznzGdRwZOHa3=cxhoDNBh1kJqGUoBHqowgj_nzKCRg@mail.gmail.com>
	 <ed4f818f00df446df53a9168054bee1a9a993409.camel@physik.fu-berlin.de>
	 <CAMuHMdW=amt+3ej6+i5TMaO6VUKJt3qqYvSWctFtSt8Tttrk2g@mail.gmail.com>
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

On Mon, 2026-09-28 at 19:00 +0200, Geert Uytterhoeven wrote:
> Hi Adrian,
>=20
> On Mon, 28 Sept 2026 at 18:46, John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> > On Mon, 2026-09-28 at 18:03 +0200, Geert Uytterhoeven wrote:
> > > On Mon, 28 Sept 2026 at 17:10, John Paul Adrian Glaubitz
> > > <glaubitz@physik.fu-berlin.de> wrote:
> > > > =3D> usb reset; fatload usb 0:1 0x89000000 uImage-7.3.0.gz ; pmb ; =
bootm
> > > > (Re)start USB...
> > > > USB0:   scanning bus 0 for devices... 2 USB Device(s) found
> > > >        scanning usb for storage devices... 1 Storage Device(s) foun=
d
> > > > reading uImage-7.3.0.gz
> > > > 3649306 bytes read in 2074 ms (1.7 MiB/s)
> > > > ## Booting kernel from Legacy Image at 89000000 ...
> > > >    Image Name:   Linux-7.3.0-rc5-00001-g8cd915e93
> > > >    Image Type:   SuperH Linux Kernel Image (gzip compressed)
> > > >    Data Size:    3649242 Bytes =3D 3.5 MiB
> > > >    Load Address: 8c010000
> > > >    Entry Point:  8c011000
> > > >    Verifying Checksum ... OK
> > > >    Uncompressing Kernel Image ... OK
> > > >=20
> > > > I also never understood why the load address I used at the u-boot p=
rompt
> > > > differed from the one that the uImage build process showed at the e=
nd of
> > > > the kernel build:
> > > >=20
> > > >   GZIP    arch/sh/boot/vmlinux.bin.gz
> > > >   UIMAGE  arch/sh/boot/uImage.gz
> > > > Image Name:   Linux-7.3.0-rc5-00002-g02d53450e
> > > > Created:      Mon Sep 28 14:56:15 2026
> > > > Image Type:   SuperH Linux Kernel Image (gzip compressed)
> > > > Data Size:    3649249 Bytes =3D 3563.72 KiB =3D 3.48 MiB
> > > > Load Address: 8c010000
> > > > Entry Point:  8c011000
> > > >   Image arch/sh/boot/uImage is ready
> > > >=20
> > > > Any idea?
> > >=20
> > > 0x89000000 is the address where you load the uImage.
> > > 0x8c010000 is the address where the unpacked kernel image will be
> > > stored.
> > >=20
> > > The latter comes from your kernel config:
> > >=20
> > >     arch/sh/boot/Makefile:UIMAGE_LOADADDR =3D $(KERNEL_LOAD)
> > >     arch/sh/boot/Makefile:UIMAGE_ENTRYADDR =3D $(KERNEL_ENTRY)
> > >=20
> > > It's similar on ARM platforms that (still) use uImage.
> >=20
> > The thing is that it stopped working after 6.5.0 and I never figured
> > out why. I did test all kinds of changes and it just never worked
> > again while pre 6.5.0 kernels work just fine.
>=20
> Have you tried to bisect it?

Yes, I did. I did not manage to find the commit that caused it.

Maybe Karl has an idea. This image is known to work [1]:

glaubitz@suse-laptop:~> file uImage-git.gz
uImage-git.gz: u-boot legacy uImage, Linux-6.5.0-rc2, Linux/SuperH, OS Kern=
el Image (gzip), 4416616 bytes, Mon Jul 17 14:17:35 2023, Load Address: 0X8=
0001000, Entry Point: 0X80002000, Header CRC:
0XBA69203A, Data CRC: 0XD097D603
glaubitz@suse-laptop:~>

It boots fine with:

usb reset ; fatload usb 0:1 0x89000000 uImage-git.gz ; pmb ; bootm

Adrian

> [1] https://people.debian.org/~glaubitz/sh7785lcr/uImage-git.gz

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
