Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525D32EACF2;
	Mon, 28 Sep 2026 06:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790577734; cv=none; b=ZJ2+abydEySkrH32uVtl0viqNK7Q0kr0lW9Z+e4LKHMk5+S03ycCMFzM/nKBvHW2b79DWgrRnBS9PDK3WJVBcRtYGQdTW/O0qbbfk6mxa/ijD/ca4HDKLhlIquZ4bwXkTP9OoMR2/vObhAs/ORB5FP/K7DTKVcliKAaeTaZysMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790577734; c=relaxed/simple;
	bh=lLkiN83lwJscCWCDl7gGCvO3zdp2rm3C0Lti9kyzHU8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SC4A/xxjp3+W1W7t0k3yibZs0WL97dhGac7aQXLaOs6NhvtAyhdR1BwcgpdNagRhrBqKvDZSgwR4EpTlbtJZ8I6sXK3sqEH5jeipI1VcAQT1u8J8xzaoCuGqvtBwQUc0ZUH9u9ES3xDEhZufuo+IjFlDkxC4YXEDfBoJLIHttgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=GOxnU/DR; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="GOxnU/DR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=z35LzkNIGCjBSfuCeGUlTaZGUzEw3nyTGW9JYYN0gXQ=; t=1790577732;
	x=1791182532; b=GOxnU/DRAf+/yVQzhqODYLb47tQsvFsYRGfChcsOwfY30xaAslapm3Xsdo58j
	SSVyhqHNpmwgklQT83+iNAYasUCu8NL3wYve4FO3lHhxCzkeFc+AW7eqv/O5Nk4+v18iKs0X+OCNj
	r9NlySlmuAxYAFTPL6m3Oighg7qt8F+PtwgHyMW9K8Zbj0cOy/hfLKKUEzQlkb7IYftbrry2hDRht
	TdUugpqCM2L0UZqKzo1We6hVrldZVMZSvIj4SxUSX4O1BThsULBWvYbF90cHjlFqQ7xp7lYDVErRY
	VZp2p4YL0NkjY4QSIJ6Ld3OQL/GYmk8s3aSrJqOqI9bREhlH5w==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xB53x-00000001mtL-3wNb; Mon, 28 Sep 2026 08:42:09 +0200
Received: from dynamic-077-191-243-001.77.191.pool.telefonica.de ([77.191.243.1] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xB53x-00000000F7T-2zoR; Mon, 28 Sep 2026 08:42:09 +0200
Message-ID: <38ed243fefebd11cbb2a02fefa394d0766a0bfbe.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] irqchip/jcore-aic: Fix lost IPIs on SMP
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Marc Zyngier <maz@kernel.org>, Radu
 Rendec <radu@rendec.net>, Artur Rojek <contact@artur-rojek.eu>, Rich Felker
 <dalias@libc.org>, 	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
 Florian Fuchs	 <fuchsfl@gmail.com>
Date: Mon, 28 Sep 2026 08:42:09 +0200
In-Reply-To: <aroDuGZBLsAw7tMS@gmail.com>
References: <20260928035408.25871-1-kmehltretter@gmail.com>
	 <92e110eef6dac0c6ddceb6ddda1658aeeaf1f0ec.camel@physik.fu-berlin.de>
	 <aroDuGZBLsAw7tMS@gmail.com>
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

Hi Karl,

On Mon, 2026-09-28 at 08:07 +0200, Karl Mehltretter wrote:
> On Mon, Sep 28, 2026 at 07:57:27AM +0100, John Paul Adrian Glaubitz wrote=
:
> > Can you tell me what toolchain you used to build the kernel for J2?
> >=20
> > Last time I tried to use the one provided by Rob Landley, the build
> > failed due to an internal compiler error so I couldn't actually build
> > a kernel to test it on my J2 Turtleboard.
> >=20
>=20
> musl.cc's sh2eb-linux-muslfdpic toolchain (GCC 11.2.1, binutils 2.37):
>=20
>   https://musl.cc/sh2eb-linux-muslfdpic-cross.tgz
>=20
> Your ICE is probably the one in kernel/nstree.c. Since listns() went in
> (v6.19), every GCC I tried ICEs there with j2_defconfig. The 64-bit
> put_user() asm prints %T (address + 4) of an "m" operand, and GCC can
> pick an indexed address that cannot be offset. The asm needs "o".
> GCC should still error out instead of crashing, so I filed a GCC bug
> too:
>=20
>   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D127639
>=20
> Fix below, formal patch follows. With it, j2_defconfig with SMP=3Dy
> builds fine with the musl.cc toolchain.

Oh, I think Florian (CC'ed) already sent a patch for that. I will
look into that one today and pick it up for 7.4 if it fixes the
problem.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
