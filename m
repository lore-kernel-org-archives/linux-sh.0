Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A4539CD10;
	Tue, 29 Sep 2026 07:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790667083; cv=none; b=RSE0cbximPsBUOPI1HygmVSDnnUrQRWFVx+b79VNjmD2BYFqSbRyvlhUGVrAggHwD5tBp0aoEEZETF0Jl4tiBq95/Zc8qpkvuLLcJnf/4Xkg/4FHY8dIny1OgfJHHbdsI7dPE9RSME2MEhogZ9uukBq8UEBS165R6+z82o4o21A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790667083; c=relaxed/simple;
	bh=X0KiB60PQn6jocjiDWepXnCdBKGY+5lRgpOVwWzyxlg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YrIqulwtYp0GLZcYV1dXqku2uVNT0k09bbJyPkoqlsw+oxPrUXfJQDABNoP5C0Q7h8mnioiRkcj0ocet6whWi+VvLnylYgsbWmvshKh86F1rsx8r31vsyVoIqRRjjyv5SdNIz/k8bqvuu5jCEUnZeKQgsnDucDL2DxEKsZ2kQ/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=P60QrM41; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="P60QrM41"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=OSsCg9QWZ7N1mHCoIBgRwfzw3CqUL4f9p8643Ukw+O0=; t=1790667080;
	x=1791271880; b=P60QrM41RU+DBiRWWLA/GJlKa9HNsZAKXF1xFhc7Am93dXfvlEuzFHx2H+ui0
	ISdGE+sG/R3EtmccGMjyIEBIM5Jfq+fd7YJE4n+Stiucf5nMNQm94US112f930+8HJ1Ln5SVkzUr7
	bUCX2iZegSjeNaZrsV2+ODm8Sa2Ckv+V2i/3gjLsQDD5pOgVAfua4yp1lN9s1VJil/DjyTcIs49n1
	mmrqmp7Fp9jb57VsPVogzo8I/F3glp6KeZSoPSgk54k05qlEEEaneQrnmviYVRvrgkLZU2mBl1dJM
	PC6gAFeAx40nb9o0GjSFob55k3eTagtspC0kAQLiZDv7A71hnQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xBSIs-00000003nTu-3ei9; Tue, 29 Sep 2026 09:31:06 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xBSIs-00000001IOU-2hGh; Tue, 29 Sep 2026 09:31:06 +0200
Message-ID: <945d56acafd1910b7304903b06f974f41a2a018f.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 2/2] sh: mach-x3proto: convert gpio-keys to software
 nodes
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>,  Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski
 <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 29 Sep 2026 09:31:05 +0200
In-Reply-To: <61edcd485d5f2704a87f208a5d0eec82576a38ae.camel@physik.fu-berlin.de>
References: <20260704-sh-x3proto-swnode-v1-0-0c039549dc46@gmail.com>
		 <20260704-sh-x3proto-swnode-v1-2-0c039549dc46@gmail.com>
		 <d3a2875ba34bf10ddae3626b77da071cd4624348.camel@physik.fu-berlin.de>
		 <arn6r3RohRPJrk0_@google.com>
	 <61edcd485d5f2704a87f208a5d0eec82576a38ae.camel@physik.fu-berlin.de>
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

Hi,

On Mon, 2026-09-28 at 07:56 +0200, John Paul Adrian Glaubitz wrote:
> Hi Dmitry,
>=20
> On Sun, 2026-09-27 at 22:28 -0700, Dmitry Torokhov wrote:
> > Hi John,
> >=20
> > On Thu, Sep 17, 2026 at 08:49:15PM +0200, John Paul Adrian Glaubitz wro=
te:
> > >=20
> > > It took me some time to fully grasp the rewrite, but I think this sho=
uld work as expected.
> > >=20
> > > Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> >=20
> > Sorry for bothering you but I do not see it in next. Just want to make
> > sure this (and others) is not stalled.
>=20
> Don't worry, I'll merge it today. It's already reviewed, so I just
> need to merge and push it. Sorry for not doing it right away.

Pushed now: https://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-lin=
ux.git/log/?h=3Dfor-next

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
