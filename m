Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3272415665C;
	Wed, 30 Sep 2026 05:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790746462; cv=none; b=rTlozyei57riu3RvBk/2N3rdukwyzCwEYI+Vrtp7/kMZz29lb69feS5F7IyyIQ7rn0eRnERtXv2wleBLMb9A4dDJz8EGgT7hfoxNyb/iMl2epOw/gLzlto5sthiIs7soLFhA+UVPWtg1dN7xAAr9lAY11pgpJ1AbhGeCUHtJf+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790746462; c=relaxed/simple;
	bh=m7klIzOCCxik8g5u4yYWC7x+ksbAsNoEwmsGQxQ29uI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dy2E5yofw5PO+XGkpS32Ya4FJ6MvC2TlGWaNFSANTLBeaI1YtylNGer15Oa5eoNYRy89vu2Q+x2hYtqP0pB57E5ljPU0s+9OczyxnY2A+d5MKzC9s+H4YivZwJAX8ARN9dfTKuQmCnkjNuqohrb9MMeluhYwcPkIXJuBjzpN/NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=aGtiHdK7; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="aGtiHdK7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=4WFj5RlG0eoXnfPuFIfjh+oxW9zqw9UkP92X9uAmUso=; t=1790746458;
	x=1791351258; b=aGtiHdK78UA+4zTW9wST15GIKbb2biVbDIjlbM20MHr6IMA0lMWyOPo0Z41no
	sj3Ot7xJLna/lg3BstYRN458vAMLM1FrOCB7i153a+GgcVAAJ9Pe1tTlTKmNmc7LdbLXiR4g9m+3f
	fF9beG+nIjREsY1phQPMjNgx0ZYlf8bvxagfb+I4aaGh9gNl+y/7YlVlFyfXiWVxwJz+RZQdER2SV
	PBJ56sC/OabLqcmhPuejlZyptGFUKnSmXFI/1sNhwMgdJEoSjYzxgMwZPRnsrRiA8sSgc2usCL0Md
	7QS7EpEsEmEhSzudW6gAyDBi7yG7Ib04PYb9Oq9JDhRcvwCMJg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xBmxF-000000012js-1jLt; Wed, 30 Sep 2026 07:34:09 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xBmxF-00000002NST-0cIG; Wed, 30 Sep 2026 07:34:09 +0200
Message-ID: <db64c4ac5e0ff7a9a10444052d1d23254c923de7.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 2/2] sh: mach-x3proto: convert gpio-keys to software
 nodes
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>,  Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski
 <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 30 Sep 2026 07:34:08 +0200
In-Reply-To: <aryX1eOmqUw2x09Z@google.com>
References: <20260704-sh-x3proto-swnode-v1-0-0c039549dc46@gmail.com>
	 <20260704-sh-x3proto-swnode-v1-2-0c039549dc46@gmail.com>
	 <d3a2875ba34bf10ddae3626b77da071cd4624348.camel@physik.fu-berlin.de>
	 <arn6r3RohRPJrk0_@google.com>
	 <61edcd485d5f2704a87f208a5d0eec82576a38ae.camel@physik.fu-berlin.de>
	 <945d56acafd1910b7304903b06f974f41a2a018f.camel@physik.fu-berlin.de>
	 <aryX1eOmqUw2x09Z@google.com>
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

Hi Dmitry,

On Tue, 2026-09-29 at 22:03 -0700, Dmitry Torokhov wrote:
> On Tue, Sep 29, 2026 at 09:31:05AM +0200, John Paul Adrian Glaubitz wrote=
:
> > Hi,
> >=20
> > On Mon, 2026-09-28 at 07:56 +0200, John Paul Adrian Glaubitz wrote:
> > > Hi Dmitry,
> > >=20
> > > On Sun, 2026-09-27 at 22:28 -0700, Dmitry Torokhov wrote:
> > > > Hi John,
> > > >=20
> > > > On Thu, Sep 17, 2026 at 08:49:15PM +0200, John Paul Adrian Glaubitz=
 wrote:
> > > > >=20
> > > > > It took me some time to fully grasp the rewrite, but I think this=
 should work as expected.
> > > > >=20
> > > > > Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin=
.de>
> > > >=20
> > > > Sorry for bothering you but I do not see it in next. Just want to m=
ake
> > > > sure this (and others) is not stalled.
> > >=20
> > > Don't worry, I'll merge it today. It's already reviewed, so I just
> > > need to merge and push it. Sorry for not doing it right away.
> >=20
> > Pushed now: https://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh=
-linux.git/log/?h=3Dfor-next
>=20
> Awesome, thank you Adrian!

You're welcome, apologies for the delay.

> I also resent the rsk7203 patches folding the compound literals fixes
> into relevant commits. Hope you will have time to take a look at them as
> well.

Just saw that, thank you. I will try to review them as quickly as possible
but it can take a few days as I also got many other patches this cycle whic=
h
address important issues and even helped me unbreak the kernel on my SH-778=
5LCR
board.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
