Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B86280A5A;
	Tue, 28 Apr 2026 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393315; cv=none; b=KndBEy4s0TpuIMxu+TI36ZblsYetj8diV/ZuGh7EIbfoSG6QFZ4tCgK453u/5bjVHOLrEhffF+J6/LvHSX+D960Bl3SUyAqCWE3rNpkDcVZmaf01iTehDDOQDFm2TVu6RCuC3WWfUrblwMmaDr2g1fiHeV+Bfw1FfkN3OROv5f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393315; c=relaxed/simple;
	bh=V+wCgw22yJZSNsNEcAk/5z0cZvsWYi9rrVfMrdgTL6g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IwnIt1lFbGZ2c877ya4tvomZYQOrb9Scwb9/Gy9+oaXeh7ISYctkmAACGV8OiLdOWf0QV8H6i4UMbtS+r1JDwf/mESSs6Pwar0oupH9PIvJ6SJSEnLKb65o8FGTXMCc3eBgJdvWKvrMNUJIWFpEGniflHLp3g/vR770IFTLZkh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=IIxN7Q2i; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="IIxN7Q2i"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=Uj7Ufv6jzgwbIerot1ziZWk3Fpm48iGsMCxhlGn3OiI=; t=1777393313;
	x=1777998113; b=IIxN7Q2iloQagmWWyGj7WoflhBCozivw1FgCz4QkRPT1MFlD7qPIZTNxwHIch
	WaFyV+M8AGA7685UufL0FbEcDCtBJhStUCpPPxzunbtLtZcGfSs3RmSj3331UUrHlAOmiKVAE+0dB
	psIyLAeOYLh8OVVIC+KlRZqQIOsiuJ6jzn4HblW4PLhsE9zxF1b52mw7TmCH3GOyayIM45az/q+EV
	YfNl+zGo/Cir6cVFFVaw8dEaDtR77nWL7lcLAkJFd2LwgEA07CegJjHPGgRx6ZhmmYNSHgnswPXJ0
	+llujbqdLjg//QTwoBwa9s7S4MCazCXoqxhQzhkp5P2i1naJ3w==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wHlC0-00000003pGU-3pZU; Tue, 28 Apr 2026 18:21:48 +0200
Received: from p5dc559e1.dip0.t-ipconnect.de ([93.197.89.225] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wHlC0-00000001ngX-2ubo; Tue, 28 Apr 2026 18:21:48 +0200
Message-ID: <fdd60c87a0303a130b0ba28f3fe04b5ad27cf027.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: select legacy gpiolib interface
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 28 Apr 2026 18:21:47 +0200
In-Reply-To: <3529a6c7-401c-4ec3-a63c-5235416e52c5@app.fastmail.com>
References: <20260428155528.3218943-1-arnd@kernel.org>
	 <716fb62be57fd01c68cfed9220da7ebddfa321ae.camel@physik.fu-berlin.de>
	 <3529a6c7-401c-4ec3-a63c-5235416e52c5@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Arnd,

On Tue, 2026-04-28 at 18:20 +0200, Arnd Bergmann wrote:
> On Tue, Apr 28, 2026, at 18:08, John Paul Adrian Glaubitz wrote:
> > On Tue, 2026-04-28 at 17:55 +0200, Arnd Bergmann wrote:
>=20
> > Thanks, this looks reasonable from what I can see. Most boards require =
at least
> > gpio_request() which is now guarded behind CONFIG_GPIOLIB_LEGACY.
> >=20
> > Does this maybe need a Fixes: tag to identify the commit which=20
> > introduced the new
> > config option CONFIG_GPIOLIB_LEGACY?
>=20
> At the moment, CONFIG_GPIOLIB_LEGACY is still enabled
> unconditionally, the idea being to change it to default-off
> after all known users select it. This won't be for at
> least another merged window, so I think you can just merge
> the patch now without any other dependencies, but we can
> also merge it through the gpio tree at the time of that other
> patch.

Makes sense. I'll pick it up for v7.2 then unless you think it's urgent
enough to warrant another pull for v7.1.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
