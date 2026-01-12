Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999BD2D0C92;
	Mon, 12 Jan 2026 12:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768219271; cv=none; b=dS08M3bxCMud+yfKbwpmR6gCKop90UDqBrjnqmJQJUeNZqeWDYipI0caIDTUy2sWgo26QfMk98XM8ps+IE0VmJ3fmzW5tw5pwzQpR5EcvcR3IHrcxrJPBdKpj06cSwk1C2NRpBG1fbLvzFOk30jV21xKQgWniFem+fjOVukKAU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768219271; c=relaxed/simple;
	bh=pvnCiRGbTjvcrXFThHpR1sloVZ4+gCNwm2MPtG1Ewzw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VcTj0haJab+VoiZJR3hbckn6AkEj1gn9U28NXq2yjyvjsmGvPDP7XCLlTX3lcAYnvte4/B3iNxvt349bhA+h/7T1GUcVe1MZdra5VXdao7iiS1D2538O4Tie+bqdtQAnh0sCnjNx69m8L4zpd4osaODtYVtMC3kdB6TYyZd7c+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=QSHNBjaH; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="QSHNBjaH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=uy/Csc951RMs1BGcxDXnMJgcIsvXT1wkN9PLJYeLWvI=; t=1768219269;
	x=1768824069; b=QSHNBjaH+lDbCEgrXa6pHdvRk4NSFs2ccRVNDQFJk2a++bwRrnX+HX59IQaV8
	6YMozl72CmnyFC1lD/f1aHKDQEOnH+gWeXzc3b8yZKH3/cb0IcnBS1DSKSCWeQuK/dUgsrIHzV8k0
	hyPJDUsBiMKHhSyGo+fRw7jpO0tmyC2DdumAMqN1kf+lS0T+/xoePivkObsgXeEjhkn014Avh/tm3
	yFTVIN4PthUYHQSorz3CkFmyKxOyC75vYHgd9y23Vlw/qLXWL5T2MSigEqw7m1s1gJlyUsBnOsH75
	+zmbUpAnVWcUnZcuczfxvfe3RnLzcKya+nFif7tk2dwT9bHAmA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vfGbb-00000001bse-0hi7; Mon, 12 Jan 2026 13:01:07 +0100
Received: from p5dc55f29.dip0.t-ipconnect.de ([93.197.95.41] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vfGba-00000003UM3-3owq; Mon, 12 Jan 2026 13:01:07 +0100
Message-ID: <9dfb01dced05b0efe0dbde22b8470e0b0bbc5b38.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: remove CONFIG_VSYSCALL reference from UAPI
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>,  Arnd Bergmann	 <arnd@arndb.de>,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 12 Jan 2026 13:01:06 +0100
In-Reply-To: <20260112125659-d522ea0c-80a5-4b09-9ab8-76182f94893e@linutronix.de>
References: 
	<20260112-uapi-sh-at-sysinfo-ehdr-v1-1-b01dfe98a66a@linutronix.de>
	 <aacdc1083c37bddfb721b732bdd7019f30b3915c.camel@physik.fu-berlin.de>
	 <20260112125659-d522ea0c-80a5-4b09-9ab8-76182f94893e@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi,

On Mon, 2026-01-12 at 12:58 +0100, Thomas Wei=C3=9Fschuh wrote:
> > Thanks for your patch!
> >=20
> > I don't really know what AT_SYSINFO_EHDR is about. Could you explain th=
e background
> > a little so that I have a better understanding of what I am reviewing?
>=20
> It is the entrypoint to the vDSO. From getauxval(3):
>=20
>  AT_SYSINFO_EHDR
>         The address of a page containing the virtual Dynamic Shared Objec=
t (vDSO) that the kernel creates
>         in order to provide fast implementations of certain system calls.
>=20
>=20
> That UAPI constant needs to be exposed to userspace even if the specific
> kernel does not have a vDSO. This is the current behavior which is preser=
ved.
> Userspace will detect the presence or absence of the vDSO based in the
> auxiliary vector.

Thanks, this explains a lot. I will review the patch later this week.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
