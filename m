Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC27E368282;
	Thu,  8 Oct 2026 06:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791440892; cv=none; b=Rwzl6iR9cyOiyabUGKrmEsQ81CUq252iwsh+isg2GwQaIiBDeK8L6p35T3Yr7Y9q5iYz5noIrV8hgHiGMhBvLmFeDAtCfQM0hP1dfwkna2lYxLjdjlmLqJwkxsK0S4OMVNGGLbGVk0jBvYRiTU27KywRtL4YjmvPpqqc4CvdVLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791440892; c=relaxed/simple;
	bh=zTYaorVqpDZVRSBHQpiGDpd/RYncOIrYwqk7xiRWPVk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O3q9HyholeaXK1qIu6WHRlETQISFIOTE3SB0TrSBFZyGYrGPa/DBLzSdSltnj/Kafoo1dyhlm80kT/WQQbLRt2zQm8RMx8hOQY7vjowOAYrhuck1SgP29Bkpf03XkAs7JPhWihRxZXmbyd89uSbAl+1JAdkhgGOu9/jquIbTlSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=nfbFYvOc; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="nfbFYvOc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=Co9AgbxhkiI6mzNZ6AS0VQicZ94aXmFCEL1DZWFMKo0=; t=1791440889;
	x=1792045689; b=nfbFYvOc3uKeuNTSC8wN3LEHv/leAixFCna3gFMxKjS9p2IEmXoUiqRUxS5W8
	X8IzWZdKIvco/cR/7ETXWIX4fGH/0qnWUs2pIt/y5gkBtVk6VpnF/vRtJ5rBiA4BAbnEAS68lpU8q
	/Fyb+1KSyo8H41gVR+rYxPWyKPfx7jsU0korILcjS9u90yMIPK0wV5GY3PabaY6H9e0Z+2D2qbMcD
	8USmQ94309/Q1aBSB5GJN6tZbLdJMps4jjSHNdUrHcpMalW0BuO2f3P1SAC+XenGZV6UfF/Z8Pwer
	Wya1VemfkD4f9wayq0JcEOTveX+jUTN28hXHodThn86XPfINjw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xEhbq-00000001pou-2avf; Thu, 08 Oct 2026 08:28:06 +0200
Received: from p5b13a90a.dip0.t-ipconnect.de ([91.19.169.10] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xEhbq-00000000yTs-1a90; Thu, 08 Oct 2026 08:28:06 +0200
Message-ID: <45b1d55a0c46934c96c7ed85e30a706d7270d9ac.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2] usb: r8a66597-hcd: fix buffer overflow on odd-length
 FIFO reads
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geert Uytterhoeven	
 <geert@linux-m68k.org>, linux-usb@vger.kernel.org,
 linux-sh@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Thu, 08 Oct 2026 08:28:05 +0200
In-Reply-To: <asczg8KoUgHPxh5n@gmail.com>
References: <20261005212823.55737-1-kmehltretter@gmail.com>
	 <2b0a2d9afa8e2dbd1d6e8ea8f88a4627816ae2d6.camel@physik.fu-berlin.de>
	 <asczg8KoUgHPxh5n@gmail.com>
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

On Thu, 2026-10-08 at 08:18 +0200, Karl Mehltretter wrote:
> On Wed, Oct 07, 2026 at 11:12:46AM +0100, John Paul Adrian Glaubitz wrote=
:
> > > Fixes: 5d3043586db4 ("USB: r8a66597-hcd: host controller driver for R=
8A66597")
> > > Cc: stable@vger.kernel.org
> > > Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > > Closes: https://lore.kernel.org/linux-sh/3bd32eaf159db61ed1d423e1d52a=
869b3689c682.camel@physik.fu-berlin.de/
> > > Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > > Assisted-by: LLM
> >=20
> > I was wondering: Would it maybe be better if you disclosed what LLM you=
 used?
> > I have seen that many others have done so and I'm not sure if it's actu=
ally
> > prepared to have the model disclosed.
> >=20
>=20
> The generic Assisted-by: LLM format is fairly new. Christian Brauner
> proposed simplifying the attribution in July [1], and it is now the
> documented format [2]. I expect we may see more patches using it as
> people adopt the change.
>=20
> I prefer the generic Assisted-by: LLM tag. It acknowledges the
> assistance without advertising a particular vendor.=20
>=20
> A model name alone also leaves out the harness and settings, and I
> sometimes use different models for implementation and review. Tracking
> and listing all of that would make the attribution rather cumbersome.
>=20
> [1] https://lore.kernel.org/r/20260701-work-coding-assistants-v1-1-a20a94=
d1d606@kernel.org/
> [2] https://docs.kernel.org/process/coding-assistants.html#attribution

Thanks a lot for the pointer! I will read this thread and unless I find
anything speaking against the proposal, I'll adopt it and continue with
the reviews.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
