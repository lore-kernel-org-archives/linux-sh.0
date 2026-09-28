Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4603128A3;
	Mon, 28 Sep 2026 05:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790574980; cv=none; b=ZKILSX7l5FR0jp1YeGXmb3L6BtdJXMP7XmCqmEjeMjffyB6y91VWIcr2nRlrxOhPa4kypmObDBK49d4zndQr++hrh0+YGmtnWkaEsec2BYZmkuUhxE3MQBekSTOk4TrBykOszmm/CpEdmGBCgTjH4k3yXnr6pxNSqEZlic1fkl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790574980; c=relaxed/simple;
	bh=nQMPpWqP6oKUMSu3d6WiFX4U2GSFGssszVzLQ33CNSY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lh9MyECTejGNNaZomScD5QjLOCJx8fpjFTchkl9CAp97RlIHmxGL7WuWaIAZHJRFySWRrqbOdzOvVrT3hOYUWL4670P3+zw50z1a0Y6Wmd79HcCjaPMk8hbZeHHaF2LS4orSFSFHDQDm8mXCnRRzT11Cv+BaOFLRK7XJBYph0Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=dzYe7xy3; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="dzYe7xy3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=tXrNx1m/iiNSeWJUxlUna+iM//WCZoyeR83r2tjnamg=; t=1790574976;
	x=1791179776; b=dzYe7xy3RvE7Sit6D8r6vsrS1pKv/A0phi9uzXUwgbrOOD+iySUCaJd2hA2ZA
	JRu09GoW9Yxp0xw1RWKgEti/V7FQ3NF5Lob+M0Vd6ni3YY4NhZrcHCZM28zd61Jp4T7W190gmeNuC
	AnSDfXIuhNyehiMr5IObEO5Ensi2HJJrCbAZ3ei7j87RNRgA8pqtfWn5YtyForwm6/9Aaq3N4Q21E
	dZe0hH80tqOpQV4HG5v1DnVQzyBZIwOXsVSE5nyzcYy/7KRmdA6FzXBXHAs9Nx8UUQSvEI/il2eQX
	8v/E0HYZzAvtI9jS8a577g29HadetQWhIw4NpJnPp94Lk72AbA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xB4LV-00000001cbt-3I7a; Mon, 28 Sep 2026 07:56:13 +0200
Received: from dynamic-077-191-243-001.77.191.pool.telefonica.de ([77.191.243.1] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xB4LV-00000004Bo7-2N11; Mon, 28 Sep 2026 07:56:13 +0200
Message-ID: <61edcd485d5f2704a87f208a5d0eec82576a38ae.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 2/2] sh: mach-x3proto: convert gpio-keys to software
 nodes
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>,  Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski
 <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 28 Sep 2026 07:56:12 +0200
In-Reply-To: <arn6r3RohRPJrk0_@google.com>
References: <20260704-sh-x3proto-swnode-v1-0-0c039549dc46@gmail.com>
	 <20260704-sh-x3proto-swnode-v1-2-0c039549dc46@gmail.com>
	 <d3a2875ba34bf10ddae3626b77da071cd4624348.camel@physik.fu-berlin.de>
	 <arn6r3RohRPJrk0_@google.com>
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

On Sun, 2026-09-27 at 22:28 -0700, Dmitry Torokhov wrote:
> Hi John,
>=20
> On Thu, Sep 17, 2026 at 08:49:15PM +0200, John Paul Adrian Glaubitz wrote=
:
> >=20
> > It took me some time to fully grasp the rewrite, but I think this shoul=
d work as expected.
> >=20
> > Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>=20
> Sorry for bothering you but I do not see it in next. Just want to make
> sure this (and others) is not stalled.

Don't worry, I'll merge it today. It's already reviewed, so I just
need to merge and push it. Sorry for not doing it right away.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
