Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.133.4.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792578413;
	b=Df/8202kHMQDZpPtWagxVNUexrxC/jLifVwK6/+O4YvOzkHvri1c6c2eCOk1Gv26ejj9
	 3U6x1+VfnELzFsUAdBLMEfobWqGEQn7QTkMSz11qOKxbl/40cs/4TClGLqNNpseoBlgON
	 cvBtgTHTdYFLn4ad4n5l5wokaU8rJRmnm30zz5lRqyQ06bmCWOhLIcASIcpFd3JWahXA7
	 YsBp6OjrQrABrZUbBAgKOHb9cG+M2OCBVubGN+2+KbzOsUjUw7z7RXiOe6nPCn9nkJhcj
	 JdPXpdiZFmwiVSfvXVOAjv7AaD7iq85hhCHNCnEz/p1QV8IF2Ecc6CSWFGVD7KJ2yiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792578413;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-Original-Sender:
	 X-Originating-IP:X-ZEDAT-Hint;
	bh=OMM3wojJV7bG/ci11CrefTmLsvm/KaeS5rTkI4y7t4A=;
	b=ogPCRl0d2VJMOcICM5s9u30bB8+4Wh8Euw10cciptojZgo2s4wVOst74UsoJGaKtHwqP
	 D5D2qn6bzeLBISE4qU8muDOsolKZoGM3ShiJwCl3g1Znn+BpRROOgi8dDMiTCjdeuLz3n
	 9z0t2jeN99nopLe6J6sVkt3tuw4MtNBCAMYDhqmlrGDmXoP8F0QPqhewT9IQMdIxmMQB+
	 rFZfeK7XVtZDmc29vemL6G1czuIwa31FPBf6s+XsOfdl2LolEowsc6Brv/wNDsmqRRuZS
	 QfbY9r3387JHbgnqpjdpGks6o1CZhfliozTRAqD+kjZkpLtx5ZKe7YnVNXk0aNsxC7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=physik.fu-berlin.de;
	spf=pass smtp.mailfrom=zedat.fu-berlin.de;
	dkim=pass header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b="dEZm7YM/";
	arc=none smtp.remote-ip=130.133.4.66
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A5B606A319
	for <linux-sh@vger.kernel.org>; Wed, 21 Oct 2026 10:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36A5B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=dEZm7YM/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=OMM3wojJV7bG/ci11CrefTmLsvm/KaeS5rTkI4y7t4A=; t=1792578412;
	x=1793183212; b=dEZm7YM/NAJfLNufYkDMLy+kf8zg8cdYSAVtcjWADWck6RC/Vt8Xoo/I+D8mF
	4Y1CdqprnfTVwf0BQWd9CCtZFeE4ocwlqom57jRmsuCOE+QMpdhpiJc/I/0KwKOv5FZLrktc9UKkl
	q5MA+Ni9D2deA1cddjkWOLtJTtkmTZ8kTjXd/yrw7H4rG7m2d1O6iWD+Z/qsBjfbnhve99cTUYVdl
	di0w6qQJimOTFEy2nLMyu5wyRhIQpbXiCdBoPvGj4FRSj/q6iPlcX99wsuqTK5w873/1bY3t89LeB
	GTEw6MfF1w3ocgmHF/CzCfL02k8ilFsaqarqs2sUnKkSIYCryw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xJTX0-00000002ekQ-0mlS; Wed, 21 Oct 2026 12:26:50 +0200
Received: from p5b13a90a.dip0.t-ipconnect.de ([91.19.169.10] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xJTWz-00000003fpp-42Qg; Wed, 21 Oct 2026 12:26:50 +0200
Message-ID: <63c55c8617829b301e461c32cc55786d0da29898.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2] sh: select BINFMT_FLAT_NO_DATA_START_OFFSET for noMMU
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Waldemar Brodkorb <wbx@openadk.org>
Cc: linux-sh@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, Greg
 Ungerer	 <gerg@linux-m68k.org>, Damien Le Moal <damien.lemoal@wdc.com>
Date: Wed, 21 Oct 2026 12:26:49 +0200
In-Reply-To: <atiJNhV5IDmRSWoT@waldemar-brodkorb.de>
References: <atgBKmRydeRteQ0T@waldemar-brodkorb.de>
	 <843827c5eb85807d4f55a0d8a4cd572811ee3644.camel@physik.fu-berlin.de>
	 <atiFE4oreXlgTzQz@waldemar-brodkorb.de>
	 <c6f6e7da42978b8368c9fcd66ab298dafef4636b.camel@physik.fu-berlin.de>
	 <atiJNhV5IDmRSWoT@waldemar-brodkorb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Waldemar,

On Wed, 2026-10-21 at 11:43 +0200, Waldemar Brodkorb wrote:
> > > They are not. Toybox uses musl C library, which is FDPIC.
> > > I use OpenADK (https://openadk.org) to build a J2 image with
> > > uClibc-ng and FLAT binaries. You could either try OpenADK or just
> > > believe me :).
> > > For OpenADK you need to choose experimental support and uClibc-ng
> > > git version, as there was another bug in uClibc-ng to let it work.
> >=20
> > Thanks for the clarification. Wouldn't your patch then interfere with T=
oybox then?
>=20
> No, because it is BINFMT FLAT specific patch. It does not change
> anything about FDPIC.

OK, thanks! I have no objection against taking this patch for v7.4 then.

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

PS: Please make sure to CC all SH maintainers for future submissions.

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
