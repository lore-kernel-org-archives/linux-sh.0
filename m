Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7436204098
	for <linux-sh@vger.kernel.org>; Tue,  1 Apr 2025 20:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743538941; cv=none; b=d0gSlGUtGTFIjtJ/xDk9sLBoFr+NvuiOMMdk3RnhawWhrdfzsTxjoMTHMuMl6Ovp1hI20UPY3WPlhMGev4QWGK8vusZ+mkT28/zIclw5UUJtjaGMP+c5TPcxt0way1fBNPycF/aj0Gr9X3xb7rLgeVTH65iJrMwnActtIZFgxbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743538941; c=relaxed/simple;
	bh=rCf3bDyxY58BOm01nYuBCK39Kinll0Tyg1ZI/wLGIcY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FIJEyrsHD+jEAikJqc5QzxSCk8uebe7/AO7UdxIcN8KmfQJdy6GS+VhaTGN+FK/06/aowlxmeB8SmTPCFI9/Lkjq0LG6U01apRObZzAUNcd1AZLmKg26JQnia9jyLD5foQzGvPCoE2XITGCh4+/aR76I2BJ0BVAPH6PpiNmPgvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=jYsEbomD; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="jYsEbomD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Tl2H9jmwBvi6915z80gZmGKeotzh+DUILIakc7ZSn+s=; t=1743538938; x=1744143738; 
	b=jYsEbomDZRhRZk//5MtWdytdrFU7dWfod3C3R4JUlnuCUVRReQZLR+kaLu2kL9nM9cCDQWp+MEe
	hzk7BI5Kz96jyewPhpNU0vciP8u0tSpMYsC6sps4ZmfRLPWft5T3z1x4+6QgZnftlPKNxVXwp/GWK
	eDpEaEhu/bDOl6FKwYsMyNouCkdui80F4+dMPExLrI6oDkC8TtBy2BeZbwbd2DgztYLrV5vabdiZt
	Sfkj7ip83b0h9oawambF4X8M7KDd8iTmuvK7aWJQbC0AiuzRhPNLkFednU+kZT5HWKhPc51xx8lcr
	bgy3GpTLgwkY1i4sMks63gTPrUvqmNirULYA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1tzi7d-00000001qg3-31qX; Tue, 01 Apr 2025 22:22:09 +0200
Received: from p5dc5515a.dip0.t-ipconnect.de ([93.197.81.90] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1tzi7d-000000049CL-21yV; Tue, 01 Apr 2025 22:22:09 +0200
Message-ID: <034795475781c8ccd10b553ebe8517eaf1f01bbc.camel@physik.fu-berlin.de>
Subject: Re: Did I ever post my sh fdpic-on-mmu patch here?
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Rob Landley <rob@landley.net>
Cc: linux-sh@vger.kernel.org
Date: Tue, 01 Apr 2025 22:22:08 +0200
In-Reply-To: <11c0bf9e-0918-4739-8245-41a8bfa2bf1a@landley.net>
References: <11c0bf9e-0918-4739-8245-41a8bfa2bf1a@landley.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Rob,

On Tue, 2025-04-01 at 11:21 -0500, Rob Landley wrote:
> I've been using=20
> https://landley.net/bin/mkroot/0.8.11/linux-patches/0002-sh4-fdpic.patch=
=20
> to test my sh2eb fdpic nommu userspace under vanilla qemu-system-sh4eb=
=20
> with an sh4eb mmu kernel for a year now (since=20
> https://landley.net/notes-2024.html#28-03-2024) but don't remember if I=
=20
> ever sent it here?
>=20
> In case it's relevant:
>=20
> Signed-off-by: Rob Landley <rob@landley.net
>=20
> Just confirmed it still works against 6.14. You can grab the sh2eb fdpic=
=20
> compiler I'm using from=20
> https://landley.net/bin/toolchains/25-03-2024/sh2eb-linux-muslfdpic-cross=
.tar.xz=20
> if you don't want to build it yourself, and I just test booted qemu with:
>=20
> qemu-system-sh4eb -M r2d -serial null -serial mon:stdio -m 256=20
> -nographic -no-reboot -kernel linux-kernel -initrd=20
> ../sh2eb/docs/initramfs.cpio.gz -append "host=3Dsh4eb console=3DttySC1 no=
iotrap"

Could you post the patch with git-send-email so that it's inline and can be
reviewed on the list? This makes it easier for review and pick up with the
b4 utility and it's easily accessible though patchwork.

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
