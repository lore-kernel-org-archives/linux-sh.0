Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1EA73510;
	Tue,  7 May 2024 22:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715121720; cv=none; b=cBzk/jzkEzZhNIlVXU5OCIJFFTD2HF6LMHu8NHZoDVyOOzq+okPVh24UJTCwZR2VlzZAF0vLhz3cKM1JHaz6CeYu5XyjSdOn8UX8C7zhYMlHdzape7cqLSX7RLGz89iTuA+78Wmz50r1eun6C5mn75AKkRRL/NSryNcM6xqN2Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715121720; c=relaxed/simple;
	bh=DlF72aNoWnI+I29HMbJyrxd1JPc+IdE64n/tjVPJy2k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YLkJTjMJVRZ4EN7Qu0oGt6+jKyT0vWuMIcE1QDPPQ+DKBQ7KGodcuAj6u2qGEdrgeO1cWaGtVwL0umUl0X9Tq4tAZtQbNvFJtdc/yBv/J2MhK0nGgu+3YmFgPYTHPxsvr9dvJFcprhIB9qQrGwV5hYxT3cpvqwklimOVWnw3oSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Ej1+mjhd; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Ej1+mjhd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=E73UWdnh4Zk0uZ4Q+UlTqMddoGmIq8H/EynXEbweHIA=; t=1715121716; x=1715726516; 
	b=Ej1+mjhddjL1ijf2haELRkEi3jMHMfn/FK27XWHGohfKY8fNcU/bOoItbi+0GZMqwvOXfNDGCno
	nOl8tx4VwuaTxtWhdFd+OqraelW9eKURAWG3uzyFOBhwdHrCnCQeH8NTO+4LJvDEmO/qljhQYx9sx
	FKrpM562SZiHkcfGJI8cJdKeAVjEdvUtvPFxcwrDjCEs8wcGX6lHMvRTFj7HQ+67wNJeYgsaTjwDA
	cg00nFhVnlmZlfMWsgoySncheSs1NjS4n2MyIasxStuwzhhSzrblWb7AsQ4/AmEt4ETz4OhEz6M3P
	ZaKyamGACHllJeoYSMC7zwcQYJlVMzPYYsbw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s4TVK-00000000jKY-1Qhd; Wed, 08 May 2024 00:41:46 +0200
Received: from p57bd90e8.dip0.t-ipconnect.de ([87.189.144.232] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s4TVK-00000001D7P-0SVG; Wed, 08 May 2024 00:41:46 +0200
Message-ID: <0e813c8498bf3d9ed5d8fd5b171ac9980dc2999c.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2] sh: Call paging_init() earlier in the init sequence
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>, 
	ysato@users.sourceforge.jp, dalias@libc.org
Cc: akpm@linux-foundation.org, linux-sh@vger.kernel.org, 
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, kernel@quicinc.com, Rob
 Herring <robh@kernel.org>, Rob Landley <rob@landley.net>
Date: Wed, 08 May 2024 00:41:45 +0200
In-Reply-To: <ec5f3194-7e9e-4cc9-86b9-02a204649246@quicinc.com>
References: <20240423233150.74302-1-quic_obabatun@quicinc.com>
	 <72ec7831604326e852eb228072b1d817bab829fb.camel@physik.fu-berlin.de>
	 <b00e0adc72815e465cf32fc5505445cfceeeca84.camel@physik.fu-berlin.de>
	 <ec5f3194-7e9e-4cc9-86b9-02a204649246@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hello Oreoluwa,

On Tue, 2024-05-07 at 14:42 -0700, Oreoluwa Babatunde wrote:
> memblock_alloc() marks all its allocations as reserved by calling
> memblock_reserve().
> https://elixir.bootlin.com/linux/latest/source/mm/memblock.c#L1463
>=20
> This should normally stop other users from allocating from within that
> region of memory.
>=20
> But in this case, since all the free memory regions have already been
> transferred over to the bootmem framework by paging_init(), I am not
> sure if that logic will still hold for the unflatten_deivcetree allocated=
 memory.
>=20
> The main goal of this patch is to make sure that the reserved memory
> regions defined in the DT are set aside before any memblock allocations
> are done (which includes the allocation done by unflatten_devicetree).
>=20
> Hence, I can restructure the patch to only remove the portion of code tha=
t is
> is responsible for setting aside the DT defined reserved memory regions f=
rom
> within paging_init(), and move it above the unflatten_devicetree() call.
> https://elixir.bootlin.com/linux/latest/source/arch/sh/mm/init.c#L292
>=20
> I will explore further and possibly restructure this patch based on my fi=
ndings.

OK, sounds like a plan. In the meantime, I have set up my J2 Turtle Board a=
nd
I am actually now able to test patches for this target, so that I would be
able to verify that your patch didn't break anything.

However, I think for v6.10 I think the ship has sailed.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
