Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCE013E04A
	for <linux-sh@vger.kernel.org>; Thu, 11 Apr 2024 07:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821759; cv=none; b=dy3uKPp+PtZmzBBMAusU/3EGSZT8vweOfRW+nC23Vs9E+IDo8eWOXpmMU2uJjxNhbAzayCdbeuA8sN6lHFSlDsawcz9OVGh2yh/hddk5D7g+dirb97KUbXNkTA5b+wsPRWqHQEvd1afaUWE3iaHXyiHSYlAe0hAz7u6NtUBSfW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821759; c=relaxed/simple;
	bh=15b2dti6RiuucuRsqHU8rP3/9exG1w4ESCBKLySLqjs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lPMNExhqC+V41n4zuHQtslDqX1OniqrBB7UxED/0JUr6vBkxPSm7Y/eu+fGV8gw7mxaPKm/Cz3nfDPcD25JwQ9/X/iTFChp2DH9JeQxPLb4mcA2m9MUgAUVvv+jEHFNWCDw2XNn78NR7GgB5WZnrC4MQsbRDV+nHa57mJ09pDEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=APPBN9tJ; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="APPBN9tJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9pV1nrMfy3E0LNGc5SBoitV2OSn8AQf0D9r0ElwfztA=; t=1712821757; x=1713426557; 
	b=APPBN9tJT4b037gOmvNBJg7Q8LXLNTUByd716ZxJKetCiQX/O+3j1/dCmpXqKv9QDzcGDB6mQLK
	loVyX3kwE4cNbEa8H1HBlpbCdEpI0UikNzsW3ygRwZ44ViY0Vp+I3sgnJGeVmCh3R7hzO48eNaRxb
	/EdHsaJjfq3tf4YsG7dhpJmVpCUZ8MGLW6YEY/yhy2KTY4i7X5+kxjhRouKUv85FvgTI8un4SdMbb
	Z3Y4Fh24SdMEv3hp/5WhvpnK0hNWeWIsrOrVessbvgKtqpF2KvOyPQBqSrCkFSoyoO8QMdc+y+e9X
	bGYBScWOEl2ke6kkCk26nny9oJEbT8S62d+w==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1rupBJ-000000035Jw-3aeH; Thu, 11 Apr 2024 09:49:13 +0200
Received: from p5b13a9fd.dip0.t-ipconnect.de ([91.19.169.253] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1rupBJ-00000002aTy-2gnM; Thu, 11 Apr 2024 09:49:13 +0200
Message-ID: <cca269f66f5acb6f38bbe169f7c739f1e65eb0ac.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: push-switch: Convert to platform remove callback
 returning void
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Duoming Zhou
	 <duoming@zju.edu.cn>, linux-sh@vger.kernel.org, kernel@pengutronix.de
Date: Thu, 11 Apr 2024 09:49:13 +0200
In-Reply-To: <293d667c491ab0c2e02a7c6b64ec384aedaa6fb7.camel@physik.fu-berlin.de>
References: <20240306211947.97103-2-u.kleine-koenig@pengutronix.de>
	 <fwfwlvyuznwzwejg3iqvnvgolxaqfo3aod5gbydgbwpj5l4xmr@y7fuszpv7kry>
	 <293d667c491ab0c2e02a7c6b64ec384aedaa6fb7.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On Thu, 2024-04-11 at 09:47 +0200, John Paul Adrian Glaubitz wrote:
> On Thu, 2024-04-11 at 09:18 +0200, Uwe Kleine-K=C3=B6nig wrote:
> > Apart from Geert's positive review reply I didn't get any feedback on
> > this patch and it didn't appear in next yet.
>=20
> The plan was to get everything approved before merging it for next
> as a partial conversion to device tree for SH would probably cause
> problems.

Oops, sorry. I confused patches here.

I'll pick it up for 6.10.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
