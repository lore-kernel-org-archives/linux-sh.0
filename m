Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCC030FF37;
	Thu, 11 Sep 2025 11:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757590813; cv=none; b=urxvJDQRzCfnMy4H+0yp4Mn5iZYD/DFBN9Hrz2gB0sUj2MifFpZBhE7MLjR1zqhFSmqsFFlRugipCThBHtYRFqnw8x9Q5aQW9WZ69XFUni9BAMSAIbBu1iu5BOi+Jda6D7Gbc/Pf3YSoaUwrBCvTF1gHPlZqfyKiqA5CiUUh8v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757590813; c=relaxed/simple;
	bh=HeA/ldE3WqSwxvdjIfauNmvC1J39cKeRiuVeAQ5DHxc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S/9bh6DwrnT//YPwyFn3B1IcpykNSpxRpxcL8HfGISPYftM4Nm5SgRygixmFjRTE41/B02cguC5QAHxmFwcAy/IEjD6/O+DWmA347a94q55dyJZDyacKV/lfrz+URVfvLbkX315cVY4sOGKB9BrwgtW6HfRD3TFxPznxEEOvxso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=IhIo2/Yn; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="IhIo2/Yn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=s+xmyaZLa2vKOz2hyqmL2oRZcbiA467tYY0hF4MR6uc=; t=1757590809;
	x=1758195609; b=IhIo2/YnbIVQFj+CldMwbXRHQUKByk9Mi8Cn9XzsJt5XV3yVuLbSpMLsXgd/3
	fHJ6U1ZOTjxgh5dP7PffP6GeJnW18tLUMmR2QPU3G+iHvvOR1dl0jD/diehLZtwQYzuBozz9igS8w
	x1J/uKRBQmj03gBurSV+8wucgmsOQlbI/aFoQ2NH+jVxwMWX8y4kZSIhlZDE1l8agQLS+8xWHexuo
	HfCZApJQsqHpxpv7r55A5iFMXWGxmdMrtHB75eExdJ6vHw33Io1zAnRBYW+iH83Y4RhKYRDAQUtlG
	CAIp2wztk7l9ZHTrhCB9w18I+/ECd69dUB863Dr3Nkara9uIIQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uwfeh-00000001Wpf-04KL; Thu, 11 Sep 2025 13:39:59 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uwfeg-00000002WGi-3Jfo; Thu, 11 Sep 2025 13:39:58 +0200
Message-ID: <bccfde5bca138b8f3489f517ea62168ec4658336.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: mach-rsk: rsk7203: use static device properties for
 LEDs and GPIO buttons
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andy Shevchenko
	 <andriy.shevchenko@linux.intel.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>,  Arnd Bergmann <arnd@kernel.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, linux-sh@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Thu, 11 Sep 2025 13:39:58 +0200
In-Reply-To: <kqtaw37b6upcuorurnccs6gqvp2aj33afanxnqye7txkmr5be6@k2omfqynjscv>
References: 
	<jwtdoptatzfo47mbpmmjwhhhjn4mbw6ekp4gtoopca7azbcelo@uvtz4w2ga5qn>
	 <aJyKAQJUG7hmO2pT@smile.fi.intel.com>
	 <kqtaw37b6upcuorurnccs6gqvp2aj33afanxnqye7txkmr5be6@k2omfqynjscv>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Dmitry,

On Mon, 2025-09-08 at 05:27 -0700, Dmitry Torokhov wrote:
> On Wed, Aug 13, 2025 at 03:50:09PM +0300, Andy Shevchenko wrote:
> > On Mon, Aug 11, 2025 at 03:44:57PM -0700, Dmitry Torokhov wrote:
> > > Convert the board to use static device properties instead of platform
> > > data to describe LEDs and GPIO-connected buttons on the board, so
> > > that support for platform data can be removed from gpio-keys and othe=
r
> > > drivers, unifying their behavior.
> >=20
> > ...
> >=20
> > > --- a/arch/sh/boards/mach-rsk/devices-rsk7203.c
> > > +++ b/arch/sh/boards/mach-rsk/devices-rsk7203.c
> >=20
> > >  #include <linux/gpio.h>
> >=20
> > Do we still need this one?
>=20
> Yes, at least this one still uses gpio_request() for configuring some
> GPIOs, so we need to keep it at least for now.
>=20
> >=20
> > Ditto for the rest similar cases.
>=20
> I'll review them to make sure they are still needed.

OK, I'll look forward to your second version of the patch. I might pick it
up for v6.18 provided that we'll manage to squeeze it in in time.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
