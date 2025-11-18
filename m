Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07BE2FB0A1;
	Tue, 18 Nov 2025 07:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763451100; cv=none; b=BypppRYmab1VFdXVR/hv3TUSffSk8w1FhH6DDcUSNJoZ1jMQbfXi6dUGWKwcmloPNuRilzSOzP4jd7ahFTPv5I10DGCcqKLW9MCt7FvvY9QVBJ/wV9xotLKI23bc75VxUiOZKcH40PwIVakVKRxpXCwawTd1H5SpexTWUuySUaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763451100; c=relaxed/simple;
	bh=WJyHUSvyeIIZK7kY2jKhM2q3B5Komdy+g4lESDlVIGM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AeddBXcs7Q7fJaHXyP7bZlFq6Le2neL4Nf3vahfrlhdx777uqfhFFuWk6hH2g/i78x1Ef5cJs89rexTp/0TgTnRz5cYErlINMGyf+aAzO5mupsJjg3yqutp2L7aBIsGf4STQZb3ZXBhBw528GDzutbVxs/ciCrY0mrXCa8HCnYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=JCIlYiuY; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="JCIlYiuY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=gbR/pSrpPdQnCy3o6uUWzPGyYQA0J47Ic/sF8Ai7qyc=; t=1763451096;
	x=1764055896; b=JCIlYiuYzA27Fjk1/Fl5tBKtNeoDeKxg7NtnC6Z1IEIvYq6+EyyW51gZddR88
	Airj4WRZEr8dYUplnxOz1iplND3xh+Feo2ae5PWh0J0EKlZ8nRH6R2JGDPf3yumFJBXfj31kVnTrl
	ZT97L7KJPXXZasmdZZhjw9jX1mXkSC2Odqk6woMJvrPqAXpIYxF8BDvc3cm+hAtxbPxNWaYeViId5
	An5vu7xVGCmp87BEMoX2mHKeC3zfGLDmrQfKKhZNqu8HdvHNLpBWVo2hyOTStwNnIHx8F+odKJ3/C
	ohXLudVrGs6yHCK7DqOpi6yguc9G7ARSnLY3N54jMD8jwjSasw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vLGBQ-00000001Qib-0YKK; Tue, 18 Nov 2025 08:31:24 +0100
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vLGBP-00000002GbE-3d0W; Tue, 18 Nov 2025 08:31:24 +0100
Message-ID: <6e2e9edcd9247c216bfe1ba637629a9a838f9fed.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/3] mtd: maps: vmu-flash: Fix build and runtime errors
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Florian Fuchs <fuchsfl@gmail.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>,  Richard Weinberger	 <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, 	linux-mtd@lists.infradead.org
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Rich Felker
	 <dalias@libc.org>, Artur Rojek <contact@artur-rojek.eu>
Date: Tue, 18 Nov 2025 08:31:22 +0100
In-Reply-To: <20251117224408.498449-1-fuchsfl@gmail.com>
References: <20251117224408.498449-1-fuchsfl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Florian,

On Mon, 2025-11-17 at 23:44 +0100, Florian Fuchs wrote:
> This small series fixes build and runtime errors in the vmu-flash driver
> (enabled by CONFIG_MTD_VMU) and the included maple.h. These changes were
> verified on real Dreamcast hardware with a physical VMU. The VMU can now
> be successfully probed, read and written with MTD tools like mtd_info and
> mtd_debug. Previously, the driver failed to build or crashed during
> probing.
>=20
> 	bash-5.3# mtdinfo /dev/mtd0
> 	mtd0
> 	Name:                           vmu2.1.0
> 	Type:                           mlc-nand
> 	Eraseblock size:                512 bytes
> 	Amount of eraseblocks:          256 (131072 bytes, 128.0 KiB)
> 	Minimum input/output unit size: 512 bytes
> 	Sub-page size:                  512 bytes
> 	Character device major/minor:   90:0
> 	Bad blocks are allowed:         true
> 	Device is writable:             true

Thanks again for this series. Before this can be picked up, I would like ag=
ain
Artur Rojek to test it on his Dreamcast, so let's loop him in.

If he confirms the functionality, I'll pick it up. I'll try to get it revie=
wed
later this week.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
