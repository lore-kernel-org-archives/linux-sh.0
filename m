Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B3D194C6F
	for <linux-sh@vger.kernel.org>; Thu,  7 Nov 2024 07:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730965164; cv=none; b=QuaZE5uOav/gHV2oFjcsKsXpS63iOdn2yPaTGk26LCEkNdQI2hiuNVizkVqidKrzUivAJEcZqT1YbOLjS9hUQWO3x8C0iNoS2uMAC3pXhB+0Pt5OC5SOHRL/bzBqCPlIRzOgZPQORNVjVvYDVD9YPe669G3ckBixcjsjXdyLXCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730965164; c=relaxed/simple;
	bh=5rT8vigREa0MlwFmmJN2gOrHHpogEwryE9EBhze/5zM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l0O++m4Ar0BuVjB3T9KPbRgAFa0Wm51KuEKDy5BoRjWmFI1rEWWVqEwBdfLzX7QUDJa6FN27cW1W3wuEeRIwiBIkPMBzEg8OWwRHCEXAWaQWA+AAGwFdwhIMKBjaGRKebNHtUnwYgFfSmc+DJZOS3Vnm+GBq5BpnjcBTh8NU3Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=SlHVg8/D; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="SlHVg8/D"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wzvYfcUyN/+rCU34UW/CPjKUg9vb69sU10lfSlLkDK0=; t=1730965159; x=1731569959; 
	b=SlHVg8/D2EKWOKshtmkleTaJUb3j93ftPZfebwFZyx3PsPPdlP6Zij9gAnooguIpq7cMSCdeRWd
	xG2t2ydf226Lu5/su29B01Lu4rXK460IUeNqlPgeyhPAfciL2RFrTVoaIrPpqQoPLPjhvdSv1caql
	zjW5xLi8vU34qAnFsohp8Wb2aXT2aGpr+RA9w/Nh/h7HB4efO89RcarfLEFGldcd31YeGQULe+L1c
	Y/Ray3S4+dsLscnt3OndPSv/k9wY6FfZ3BkGMi7IamfdiT9LEcFvUhQz4h6uoWJ5Y+LruD4D/rxu/
	/Mv/sJkQXaYZiKsY24mTg+hq8a7lQMX0hGMA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1t8x3U-00000000Mix-0Iud; Thu, 07 Nov 2024 08:35:48 +0100
Received: from p57bd904e.dip0.t-ipconnect.de ([87.189.144.78] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1t8x3T-00000002Nn7-3ZUx; Thu, 07 Nov 2024 08:35:48 +0100
Message-ID: <cf281c9e0d04483d7cafd89aeb25b55878e81385.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: intc: Fix possible UAF in register_intc_controller
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Chen Ridong <chenridong@huaweicloud.com>, ysato@users.sourceforge.jp, 
	dalias@libc.org, gregkh@linuxfoundation.org, ricardo@marliere.net, 
	damm@opensource.se, lethal@linux-sh.org
Cc: linux-sh@vger.kernel.org, wangweiyang2@huawei.com
Date: Thu, 07 Nov 2024 08:35:47 +0100
In-Reply-To: <e1792bb5-6212-4452-9c1d-c372204c3348@huaweicloud.com>
References: <20241030060813.1307698-1-chenridong@huaweicloud.com>
	 <e1792bb5-6212-4452-9c1d-c372204c3348@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Chen,

On Thu, 2024-11-07 at 08:57 +0800, Chen Ridong wrote:
>=20
> On 2024/10/30 14:08, Chen Ridong wrote:
> > From: Chen Ridong <chenridong@huawei.com>
> >=20
> > When it goes to error, the 'd' is freed, but 'd->list' was not deleted
> > from 'intc_list', which may lead to a UAF.
> >=20
> > Fixes: 01e9651a21bc ("sh: add INTC out of memory error handling")
> > Signed-off-by: Chen Ridong <chenridong@huawei.com>
> > ---
> >  drivers/sh/intc/core.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
> > index 74350b5871dc..a30d205e7a43 100644
> > --- a/drivers/sh/intc/core.c
> > +++ b/drivers/sh/intc/core.c
> > @@ -387,6 +387,7 @@ int __init register_intc_controller(struct intc_des=
c *desc)
> > =20
> >  	kfree(d->window);
> >  err1:
> > +	list_del(&d->list);
> >  	kfree(d);
> >  err0:
> >  	pr_err("unable to allocate INTC memory\n");
>=20
> Friendly ping

I have seen your patch. I will try to review it on the weekend. I have been=
 very busy
with lots of other work, unfortunately. I usually have one day where I do a=
ll the review
and merge the patches for SH.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
