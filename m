Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82EB290F;
	Thu, 26 Sep 2024 12:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727354517; cv=none; b=gUY+1OtWZ2t/tqlGZDZwFlrJ2VzILeAvVsxBXHPq03yW5kuTRyPzmN5DXfAjamnSVdSYtI44/Ti8iThNGmwnqjVBTuv/TyziHxV0WPA56kSctLNIt4+kWJE0VRkCSf1/I3lFzuXz5fvIU2413sydsuFArSkYlDfZiTpQJJ9eK6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727354517; c=relaxed/simple;
	bh=4K2IsJ8rjbaXAvDqXcJoz2LYjMzTtpjqNX+d2lF1RLo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D4orQpt62Qm9cyoEddmO/nVDFU86PPdCo2mD35OB4IOgiChTWIeURj1FnJ2B63Abu7xgN0SkTUqqR1V1BIfyRi0gphwc3K+ifL1225cQoZYAZX4ZnWwetPTRvtDoPwr0hivtzSEUOhaLccllmj5hhK11mijuSboqREhrvxQRWMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=RTJoNsOK; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="RTJoNsOK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zMWpMqYSUWO3WcNbImNeHQ05wRolpzxmvjv4f8syXi4=; t=1727354514; x=1727959314; 
	b=RTJoNsOKYV+CdtVFUdl0g5gTtJDvpgifiYPHpG+g2KrHASjVFHHsk6TFzcZn4wXVIPZ/pTXPOnr
	A+M6W12FfMsBhN4Hwova+BNGbtLcBczk64ziV8xfURHD3j+kckLRUG6QVRP+ejk/u0eI7KmtCgIZT
	M4Y/tElDF8OgT9WztZOPwTx1R6eSj5p2GJ+3AGVTwxyvwnVVXRKCkZhvaU6Ew1blg3jRs6b9ZtMNm
	JYSI2vnKPiJu0AMoUW1pKH+RNE7KUeH4BQy5XR1IvXMXiFfgWIroMlC5+/zf0fZe/RAFD+6c0tmcQ
	TcVh9tnuS+m8OZDQzGQFItiAUuqayBvdpwDw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1stnod-00000001nHo-3CA8; Thu, 26 Sep 2024 14:41:51 +0200
Received: from p57bd904e.dip0.t-ipconnect.de ([87.189.144.78] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1stnod-00000003KSH-2GyN; Thu, 26 Sep 2024 14:41:51 +0200
Message-ID: <fbc596f7ad7ec4b08a5f50da8dcc0a1ce908793d.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v5 0/2] sh: Restructure setup code to reserve memory
 regions earlier
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>, dalias@libc.org, 
	ysato@users.sourceforge.jp
Cc: kernel@quicinc.com, linux-kernel@vger.kernel.org,
 linux-sh@vger.kernel.org,  robh+dt@kernel.org, Artur Rojek
 <contact@artur-rojek.eu>, Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 26 Sep 2024 14:41:50 +0200
In-Reply-To: <20240718021822.1545976-1-quic_obabatun@quicinc.com>
References: <20240718021822.1545976-1-quic_obabatun@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Oreoluwa,

On Wed, 2024-07-17 at 19:18 -0700, Oreoluwa Babatunde wrote:
> The unflatten_devicetree() function allocates memory from memblock
> before the system gets a chance to set aside the regions of memory that
> are meant to be reserved.
> This means that there is a possibility for memblock to allocate from
> these regions, thereby preventing them from being reserved.
>=20
> This series makes changes to the arch specific setup code to call the
> functions responsible for setting aside the reserved memory regions
> earlier in the init sequence.
>=20
> Hence, by the time memblock starts being used to allocate memory, the
> memory regions that are meant to be carved out would already be set aside=
.
>=20
> Oreoluwa Babatunde (2):
>   sh: Restructure call site for early_reserve_mem()
>   sh: Restructure setup code to reserve memory regions earlier
>=20
>  arch/sh/include/asm/mmu.h |  1 +
>  arch/sh/kernel/setup.c    |  3 +++
>  arch/sh/mm/init.c         | 20 +++++++++-----------
>  3 files changed, 13 insertions(+), 11 deletions(-)

Apologies for the long silence. Both Artur and Geert (CC'ed) now also own a
J2 Turtleboard and I would like to have at least either of them test and
review your changes to make sure nothing breaks.

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
