Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB404C6D;
	Sun, 12 Apr 2026 07:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775978967; cv=none; b=TwB+zHVpcGdJzyyRCysJKatz5EBeC3nCSLkLpilU+OivSoXhb/t/luRYpeyJLsTowj5SZlAzV4Hq7S6gAWT6xAL6LvfKBr4wT9sXhFrsXemNBALqaTGwgg/iXZWyCob7zK1h5cXzZaQgae/Hl4k8vVeMdD7nIjnJUa9v8i4vUj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775978967; c=relaxed/simple;
	bh=HanoFT3Z3FPDbNOir7wpapfrMgIlFvzpiMp9Sh5cPdg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G+Uff1kvikoPrBERnABPGc8KZ4eAMIEfAMxQwlyrzEK2KmumI32BeGJC30ogmhkP/9LhjI2MYqnDT7szvqMnV5gBw73/JaagWMNp7l2U4bcWdCcel5YDoQcH0Z55Gs6tc5uZFqr68nh1wSLLL69YaACHRvgDFVcDWtC0GATBpLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=nq1MfWPB; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="nq1MfWPB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=V33sUnoKggtt4WMgwBQzwc4ZZGgbN6fz6B+dombTtXE=; t=1775978966;
	x=1776583766; b=nq1MfWPB4wdVEjINWVosDhtPdRtV18DtqdvLq7eDiipWudkoiE6Pi/rAd8sC7
	VuC+vlLTSxT5JHcwPYV4sboMtQm0PN9YxORtNnvrzgA81sNnIftYDSS1ECoyoc1l2NJrbfdF8IE/E
	qXh4xIKpWiLk3vR/lm6X/qMR26LZtkO7jhiwS4HgI8aJaCSQCUsnczqRgjiogd0/G4LoSwsyQ576w
	gJB0OyyUB+PpHcwoo9xEvintPjzIJt8THX+8WWmi2FJ3fKMInlfX6E1girB4I3KncLjWzP6bcnAfc
	XgC5SbomP0ZFB342IwJNsOKxOHAX6oLkjo1Awxn5rC8QmugJGw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wBpFz-00000002QYa-3oL4; Sun, 12 Apr 2026 09:29:23 +0200
Received: from dynamic-077-183-202-106.77.183.pool.telefonica.de ([77.183.202.106] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wBpFz-00000001ciD-2qoP; Sun, 12 Apr 2026 09:29:23 +0200
Message-ID: <6b5911738bb7e20d7f156cd0977d359676a18fd9.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: maple: fix empty port handling
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Artur Rojek <contact@artur-rojek.eu>, Florian Fuchs <fuchsfl@gmail.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>, 	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Cercueil	 <paul@crapouillou.net>
Date: Sun, 12 Apr 2026 09:29:22 +0200
In-Reply-To: <d25d9c581f5b4f22c9b94761972aa0fe@artur-rojek.eu>
References: <20251112190444.3631533-1-fuchsfl@gmail.com>
	 <4f70a38490b12d13858f45f3e7a531bf5dc2162d.camel@physik.fu-berlin.de>
	 <999e3970e1580def5ddbf1921a9ef4a4@artur-rojek.eu> <aRUOTfCJtqnNBjU3@lithos>
	 <d25d9c581f5b4f22c9b94761972aa0fe@artur-rojek.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Florian,

On Sun, 2025-11-16 at 13:34 +0100, Artur Rojek wrote:
> On 2025-11-12 23:46, Florian Fuchs wrote:
> > Hi Artur,
> > thank you so much for fixing the DC boot on linux again!
> > Adrian, thank you for looking at it!
> >=20
> > On 12 Nov 22:46, Artur Rojek wrote:
> > > thanks for the patch! Can this be tested with just regular=20
> > > controllers?
> >=20
> > Yes, indeed you can test it with the controller, when you compile with
> > joystick support, like:
> >=20
> > 	CONFIG_MAPLE=3Dy
> > 	CONFIG_INPUT=3Dy
> > 	CONFIG_INPUT_JOYDEV=3Dy
> > 	CONFIG_INPUT_EVDEV=3Dy
> > 	CONFIG_INPUT_JOYSTICK=3Dy
> > 	CONFIG_JOYSTICK_MAPLE=3Dy
> >=20
> > You should not put a VMU in though, as thats currently broken (I have a
> > patch ready).
> >=20
> > Then you can directly read from the evdev and listen for the button
> > presses:
> > 	bash-5.3# cat /dev/input/event2 | xxd
> >=20
> > You need to press a button for 20-30 times, as it seems to buffer the
> > events and outputs it in batches.
> >=20
> > Then, you should see the following outputs for the buttons:
> >=20
> > Button A:
> > 	00000000: 7800 0000 94c3 0d00 0100 3001 0000 0000  x.........0.....
> > Button B:
> > 	000001e0: 7800 0000 94c3 0d00 0100 3101 0100 0000  x.........1....
> > Button X:
> > 	000003b0: 7800 0000 94c3 0d00 0100 3301 0100 0000  x.........3.....
> > Button Y:
> > 	00000900: 7800 0000 94c3 0d00 0100 3401 0100 0000  x.........4.....
> >=20
> > The Joystick should be detected like this:
> > 	/ # dmesg|grep maple
> > 	maple: bus core now registered
> > 	maple (null): detected Dreamcast Controller: function 0x1: at (2, 0)
> > 	maple (null): no driver found
> > 	input: Dreamcast Controller as /devices/maple/2:00.1/input/input2
> >=20
> > Another indicator is the dmesg log for empty ports:
> > 	maple (null): no devices to port 3
> >=20
> > These messages were previously not there, as the empty ports were never
> > detected.
>=20
> Hey Florian,
>=20
> Before applying this patch, no input on a maple port is being registered
> until all 4 maple ports are populated (in my case by four controllers).
> Once all 4 are plugged in, I can register input on either of them by
> cat-ing their respective char devs.
>=20
> After applying the patch, I confirm that input can be read immediately
> for the present devices, even if the other ports are unpopulated.
>=20
> However, this patch also breaks hotplug on maple ports - I can no longer
> plug in additional controllers at runtime and have them show up.
>=20
> I think we need to hold off on this patch until the hotplug issue is
> addressed.
>=20
> >=20
> > btw, I have also a cdi file, that boots for me, although I heard there
> > were issues on the NTSC-U devices, if helpful:
> > https://github.com/foxdrodd/dreamcast-linux/releases/download/6.17.7/li=
nux6177-joystick.cdi
>=20
> Thanks for the cdi. I have no means to burn CDs anymore, so instead
> I quickly built a small buildroot based rootfs, and booted it as
> initramfs over serial line :-)

Do you have any news on this patch?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
