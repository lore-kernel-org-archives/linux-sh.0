Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690AC374E60;
	Wed,  9 Sep 2026 18:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788977200; cv=none; b=nQdYO2Vh6hoCQ9/o3hhytqD6SuKLyoJ6zxUA9kHD1qNXD8q3+ujfGOqfa+2rwogWVrbaRvky+Bo3aZRlIiui0SOFKHDWr/i+PbBp8vuzd6gsykJjsvepCW0+YoIMfEjLMc+YmPgCVP2cp+wYyhx4vWEA3ZVSKu6TLYpUqMNSRQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788977200; c=relaxed/simple;
	bh=l0m3Ux5xZ0vuhSpFRUUWmk714VYfYDaSZlcTIzFt8Ok=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wu84tHwHi60VMQTh6ZMqrpCMx6BwiCHY1o44VILhyaovNIhOdR8dFEn2JQd5c0rebipQbn0IxeON6kD6204TpZ/Gfyhy5yQCHimFmJgn/A8Sn/jtPE0hMs3OycL2R+74Hv4cx3Uveb/jcJ8R8OTSW4Tacw5iyq807xlOF8DqOo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=ZHSodg0P; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="ZHSodg0P"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=OpboOaOWUbhlwyhTIuDYmVK+kuJNqamu/RLlaR+oHOQ=; t=1788977196;
	x=1789581996; b=ZHSodg0P9IM3XigihLz34mQ+sh9FfvEN7vgVRgq9Sx0ZV4i2Bw4k3cp3gyyVm
	RkU0c5KNy8vI4zop66wL9RvV0HBQQSvyjGIOQYFnlWreElOSzNpbUyTmb5OBmSX6EFyYuXKdY1XHH
	UlawXOaLQZ7LwOR5rNZr2fDsCaxNyDd5JvLv8PsVj6pVUMs2+wjdf3nGRB/He9TthXTqdZPTg2+cm
	kD0W88U1ytIAwIToqnTCtOu5fnsMQ71Wsc0z0bvdv/kjsjYE4xER7hZO1PRlZJn7Gd9pwj3JmJBXk
	sPik4Pz5C/CKuzW6MZ4CisEZrkIc4JAhmWupaiSk7ep/Ypl4wQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1x4Mgl-00000000HDV-1cU5; Wed, 09 Sep 2026 20:06:27 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1x4Mgl-00000001qN6-0Yx8; Wed, 09 Sep 2026 20:06:27 +0200
Message-ID: <299ae94b6fc60cc660b2a5492052ca1375f22001.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/2] sh: mach-x3proto: convert gpio-keys to software
 nodes
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski
 <brgl@kernel.org>,  Arnd Bergmann	 <arnd@arndb.de>,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,  Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Date: Wed, 09 Sep 2026 20:06:26 +0200
In-Reply-To: <aqGP2P3-44dmCyjz@google.com>
References: <20260704-sh-x3proto-swnode-v1-0-0c039549dc46@gmail.com>
	 <aqGP2P3-44dmCyjz@google.com>
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

On Wed, 2026-09-09 at 10:00 -0700, Dmitry Torokhov wrote:
> On Sat, Jul 04, 2026 at 10:04:36PM -0700, Dmitry Torokhov wrote:
> > This series converts the legacy gpio-keys platform device on the SH-X3
> > Prototype board to use software nodes and static properties.
> >=20
> > This is part of the ongoing effort to remove platform data support
> > from the gpio-keys driver, allowing it to rely purely on generic
> > device properties.
> >=20
> > The first patch adds the software node to the GPIO controller, and
> > the second patch performs the conversion for the gpio-keys device.
> >=20
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>=20
> Hi John,
>=20
> Could this be applied please or maybe you want me to make some changes?

I have reserved the upcoming Saturday for kernel review now.

If I find anything, I'll let you know.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
