Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183D816415
	for <linux-sh@vger.kernel.org>; Mon, 29 Apr 2024 07:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714375490; cv=none; b=lCU4IpEySKoBGZIdsqt8t+BF8Wu+lkb+Ue/au9M0X3aaYYwalHQ6T1ycD4Ls50y5T9sevSVdh+kWTFcOq7yU/XMhJI7mfSUivCkb6dAbIpOGn/t7y8nunTn1/LT1gnnu3nOFbEqS2dr77BFoO1R6lMKOtDrRGUyxYj1g8jxPwS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714375490; c=relaxed/simple;
	bh=PkcWPRnMagBTxWA9DDlcNgBj0zUAwT8eVf8EgB8Vn/I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p/zIcIhWtsgx2ToNsd5XwHGSBsIx5xwPMWiRlO94RBkladfwNqoN5JokTZk0FPSuBzCRm8TfrMEJZZviPFvXCJcTLA2EbS/n07sfkCVO3CH8f68RVMa2yXENc4rlnzNDlRirciUGfsSYOUEe/RjLZVKFYmbyM9neTcP8kkz5/lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=nlcyfqFX; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="nlcyfqFX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5LFg4cI/XF3jGTI+K2eUg6zwG8nTwhx0biNdn9Xraz0=; t=1714375486; x=1714980286; 
	b=nlcyfqFXErmY/dKX5q5YxAUQCI/lJ7UVSxxR90U64Z7frt6mP9/8IkK68o89CnkE4N4Iimm2UTQ
	swKd9PakPdqFGydvVzGQFWojYSJSFJE6btTQ9A1+PZn5kstSZJ3G+BX0t4rU4ZXFdqw4JGtW+Aj1t
	QwJnQ7rg0vyEy44kvu0i9eP8seY9V8/R7KMVPWMsqsd9PwJhwW2FVJ86mAz8kDgFToOM2dXMSAzti
	kwf4FiFmRCPtFcx/JDke2UxbAJstsDzcjavgmxtgPULlOUkTp9WIbyOKhRMJnJnV3cTwGrto8Qqo/
	f2C6/XuviX8vBBEVPHftIe7gbmwfo7BnM8tw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s1LNI-00000003EiV-269r; Mon, 29 Apr 2024 09:24:32 +0200
Received: from dynamic-077-191-138-057.77.191.pool.telefonica.de ([77.191.138.57] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s1LNI-000000018Vi-1EJx; Mon, 29 Apr 2024 09:24:32 +0200
Message-ID: <dd9e54809bd03628551552ff953b6416f6464bd9.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: push-switch: Convert to platform remove callback
 returning void
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>,  Duoming Zhou <duoming@zju.edu.cn>,
 kernel@pengutronix.de, Geert Uytterhoeven <geert+renesas@glider.be>, 
 linux-sh@vger.kernel.org
Date: Mon, 29 Apr 2024 09:24:31 +0200
In-Reply-To: <pc2glhr46ei3pyl46a3mb6wfkikzr4z6s7ltjlsdglwwd6aroy@yfvjdcwe4gid>
References: <20240306211947.97103-2-u.kleine-koenig@pengutronix.de>
	 <fwfwlvyuznwzwejg3iqvnvgolxaqfo3aod5gbydgbwpj5l4xmr@y7fuszpv7kry>
	 <293d667c491ab0c2e02a7c6b64ec384aedaa6fb7.camel@physik.fu-berlin.de>
	 <cca269f66f5acb6f38bbe169f7c739f1e65eb0ac.camel@physik.fu-berlin.de>
	 <pc2glhr46ei3pyl46a3mb6wfkikzr4z6s7ltjlsdglwwd6aroy@yfvjdcwe4gid>
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

On Mon, 2024-04-29 at 09:22 +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Thu, Apr 11, 2024 at 09:49:13AM +0200, John Paul Adrian Glaubitz wrote=
:
> > On Thu, 2024-04-11 at 09:47 +0200, John Paul Adrian Glaubitz wrote:
> > > On Thu, 2024-04-11 at 09:18 +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > > Apart from Geert's positive review reply I didn't get any feedback =
on
> > > > this patch and it didn't appear in next yet.
> > >=20
> > > The plan was to get everything approved before merging it for next
> > > as a partial conversion to device tree for SH would probably cause
> > > problems.
> >=20
> > Oops, sorry. I confused patches here.
> >=20
> > I'll pick it up for 6.10.
>=20
> The patch didn't make it into next yet. Is this expected?

Already working on it.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
