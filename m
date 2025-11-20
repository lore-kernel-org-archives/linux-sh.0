Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8E6288C34;
	Thu, 20 Nov 2025 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763629796; cv=none; b=OHjWqLF56WfCLtojb7brR3GIqdqthKZtEjGO4tqx6sLapfWb7isFbeOZwgc78aHHZh4N8/2B7mxsHHMOCJ25P0pRA3uscMXch8zTME264azr7n+Bhp14WgxxmoGGIbC9MuO0NA6ZhXBzEHSPhSMOeSq0x8EgtzCvVhkW7AykKUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763629796; c=relaxed/simple;
	bh=oRTV+ZH/eHAZ0gDtWxXmQBP1nFyMfxn0qZB40RgSzTg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tJwsyK0sfoS9OBjUe8/ErZywLCIxHkOD+qgD6kVsmhgCLDF4L5hWBZN4GzI0u6uLv95t81Ja0RktQsLRbwYvKwvAtsi2a/AnS/IIVqipTnC9be/JOYzIUZ1aBn4EJd4gVHsXatbmkdBi9Lf8l0Pue30TwhaRHLvkGv0bjFf7ytw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=MDdiie/a; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="MDdiie/a"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=MIkMyymAp0Jp7wym9tGsnnLHss4tCJVvVVCKNCnFAKM=; t=1763629792;
	x=1764234592; b=MDdiie/aHg3aGFVLqrjdeNv2V4cQWK4VPgbUeSaQGN7c8mYjOQ1iYkD/LqCb3
	FOTK9nm6LH8V4Qo8zNJgbEhO177caPYuFSzOedZ9UXcwJm1Mv2zoKQcB6I5Et6Yk5UnZNQAJsh/Fe
	Dg0Kxqrf3g3s6hG+qQ/Xr043Oo/TAdK969W+R/IPP5BOyM1AWq4pmlMs277RTdETEFbvLrYVUQXhm
	C2c6tX598mslbdMxd5jrmR8pL2Y3UvQiGI7zGoPeTaxKfhNxZFBu5tPMmzmTnyKitQb6ITH3N3u0c
	FrMz0JAoMVV5xG/AI8+0/05tDwrQQA8pMkgq6eB4Te2F9tpgJg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vM0fZ-00000000lIM-2RK3; Thu, 20 Nov 2025 10:09:37 +0100
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vM0fZ-00000001mug-1Jxq; Thu, 20 Nov 2025 10:09:37 +0100
Message-ID: <1c738766a6a7de25276b5d249398d4b891380655.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/3] mtd: maps: vmu-flash: Fix build and runtime errors
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Florian Fuchs <fuchsfl@gmail.com>, Artur Rojek <contact@artur-rojek.eu>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger
	 <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Rich Felker <dalias@libc.org>, Paul Cercueil
	 <paul@crapouillou.net>
Date: Thu, 20 Nov 2025 10:09:36 +0100
In-Reply-To: <aR7Wvxzy0aiosDYK@lithos>
References: <20251117224408.498449-1-fuchsfl@gmail.com>
	 <6e2e9edcd9247c216bfe1ba637629a9a838f9fed.camel@physik.fu-berlin.de>
	 <5a4f8f1d543ef90aae3299b0f8803fb3@artur-rojek.eu> <aR46Kw5n4hIAZCcn@lithos>
	 <b5aa220dee9d7dcecea398ec0e33b4cf@artur-rojek.eu> <aR7Wvxzy0aiosDYK@lithos>
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

On Thu, 2025-11-20 at 09:52 +0100, Florian Fuchs wrote:
> I mean, I guess it's ok, as the code is like this for a long time, so it
> should be alright, when it keeps like this for a few weeks now, until an
> extensive fix. I just sent it now for a gradual improvement, in my
> opinion, as I need to invest a bit more debugging for the maple
> misbehaviour than for the obvious build breakage.

Thank you for your patience. I hope that you don't read Artur's recommendat=
ion
as a general dismissal of your work because it's not meant that way.

It's highly appreciated that you are stepping up to work on the Dreamcast c=
ode
and I will absolutely be happy to pick up your patches once the runtime che=
cks
are positive and Artur is satisfied as well.

It's perfectly normal that some patch series can take several rounds until
everyone is happy. But it's usually worth the effort and you will also be
able to learn from others.

> Thank you for your kind words, I don't take them for granted!
> And I will certainly hang around in #linux-sh as I have a few other
> things there to debug were I really need some additional input.

Really looking forward to this! A warm welcome to the SH community ;-).

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
