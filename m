Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EE63A4F50;
	Sat,  3 Oct 2026 08:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791017632; cv=none; b=W4ycXgng67v5Z+PFQXiGuMAPEzcVUo8FDILCrGLa7PvHm2SrKMnLEkO6REg5Odlc0qA+IEcRXrtSUZT/Xd7IcCxVC2BjqtrJfI8BDxaSuMzPxPctj5xntpVxDKsQrtzLxNStDXzx6sMVSZaxFuA3h8bDZ0QQKSWEf1MZL8hNJDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791017632; c=relaxed/simple;
	bh=l9yOrwUQwa1kahhZ4uoHOBtoTUip6UP/zX9CjBVxwGQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RB/RyQcJ7wSsAkiH1sGE1vSsJjwFdPJfAQ1KkpfM6qRJ3E5soxvpZmntcwEBhO/NxGBiQkmtG6o8PogzJo90qH+uCZwvcYTJDKIEbHBJqAvHr2DaZLSxPZ9b++o1/Vok7SuwzT8AV16JeU1i57rN7IL24kLEJv5/DH0ZK0TOdDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=g8UzVbF/; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="g8UzVbF/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=Ek8sebA4wDNg6owjr1i3CVz8Hmrfi5DwpWvnKKIok0g=; t=1791017629;
	x=1791622429; b=g8UzVbF/MJvML/dRGuNVhp10RZIPFhU1ys4sti3MLoOgKEd3GR6eYRgBFwIWx
	ORCw6BKtkaQAZZZmOjSuPbL06fG719CMSvbqUnibFyVrhKf9zw6LqqXXUQMV+Li+vba9tCDUlFbIe
	ieEaDVyhKB9K3O1ZY6fIoUlubUC0P7/F8id73UfrpS2TetP75R84uUD0kFhPAw3Br3utm3FfDuj9P
	yMWM5EXYcMyMVi8De/J5ICwWoFKCOLVQbCUa+HiAA8Uu7q3BznxjEAeKsbNtvlrBOoT7YDbx/Ueyb
	JK9tJkOUDWy3Gpj9J+Pz9E4TdTzVj3kMp8lsOCZu0RtKWgBIrA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xCvV4-000000034fo-00nm; Sat, 03 Oct 2026 10:53:46 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xCvV3-00000002VqD-3Hck; Sat, 03 Oct 2026 10:53:45 +0200
Message-ID: <93b5e35ce1ebf5447f2034ead9d1d20da8cb40f0.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: sh7785lcr: register the PCA9564 as I2C bus 0
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Karl Mehltretter <kmehltretter@gmail.com>, Yoshinori Sato
	 <yoshinori.sato@nifty.com>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 03 Oct 2026 10:53:45 +0200
In-Reply-To: <20261003082833.21511-1-kmehltretter@gmail.com>
References: <20261003082833.21511-1-kmehltretter@gmail.com>
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

Hello Karl,

On Sat, 2026-10-03 at 10:28 +0200, Karl Mehltretter wrote:
> The R2025S/D board information is registered on I2C bus 0. Commit
> 44454baa7ca7 ("i2c: Dynamically assign adapter id if it wasn't explictly
> specified") changed the PCA9564 platform driver to pass negative platform
> device IDs to the I2C core. The SH7785LCR device uses ID -1, so the core
> assigns it a dynamic bus number. Reserving bus 0 for the board informatio=
n
> makes i2c-1 the first dynamic bus, and the RTC is never instantiated.
>=20
> Set the platform device ID to 0 so the adapter is registered as i2c-0 and
> the RTC board information matches it.
>=20
> Fixes: 44454baa7ca7 ("i2c: Dynamically assign adapter id if it wasn't exp=
lictly specified")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>=20
> Tested with 29-bit and 32-bit kernels on a custom QEMU model of the
> SH7785LCR. Both registered the controller as i2c-0 and the R2025S/D as
> rtc0.
> Testing on real hardware is welcome.
>=20
>  arch/sh/boards/board-sh7785lcr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/sh/boards/board-sh7785lcr.c b/arch/sh/boards/board-sh77=
85lcr.c
> index 25c4968f0d8b..b93423df582f 100644
> --- a/arch/sh/boards/board-sh7785lcr.c
> +++ b/arch/sh/boards/board-sh7785lcr.c
> @@ -256,7 +256,7 @@ static struct i2c_pca9564_pf_platform_data i2c_platfo=
rm_data =3D {
> =20
>  static struct platform_device i2c_device =3D {
>  	.name		=3D "i2c-pca-platform",
> -	.id		=3D -1,
> +	.id		=3D 0,
>  	.dev		=3D {
>  		.platform_data	=3D &i2c_platform_data,
>  	},

Without the patch, the rtc is not detected during boot and trying to read i=
t out
with the hwclock utility fails:

root@tirpitz:~> hwclock
hwclock: Cannot access the Hardware Clock via any known method.
hwclock: Use the --verbose option to see the details of our search for an a=
ccess method.
root@tirpitz:~> hwclock --verbose
hwclock from util-linux 2.41.3
System Time: 1791016681.183560
Trying to open: /dev/rtc0
Trying to open: /dev/rtc
Trying to open: /dev/misc/rtc
No usable clock interface found.
hwclock: Cannot access the Hardware Clock via any known method.
root@tirpitz:~>

With the patch, the rtc is detected during boot:

[    4.048000] rtc-rs5c372 0-0032: r2025sd found, 24hr
[    4.056000] rtc-rs5c372 0-0032: rtc oscillator interruption detected. Pl=
ease reset the rtc clock.
[    4.072000] rtc-rs5c372 0-0032: registered as rtc0
[    4.080000] rtc-rs5c372 0-0032: rtc oscillator interruption detected. Pl=
ease reset the rtc clock.
[    4.088000] rtc-rs5c372 0-0032: hctosys: unable to read the hardware clo=
ck

And can be read out with hwclock:

root@tirpitz:~> hwclock --verbose
hwclock from util-linux 2.41.3
System Time: 1791017592.121448
Trying to open: /dev/rtc0
Using the rtc interface to the clock.
Last drift adjustment done at 0 seconds after 1969
Last calibration done at 0 seconds after 1969
Hardware clock is on UTC time
Assuming hardware clock is kept in UTC time.
Waiting for clock tick...
ioctl(4, RTC_UIE_ON, 0): Invalid argument
Waiting in loop for time from /dev/rtc0 to change
...got clock tick
Time read from Hardware Clock: 2026/10/03 08:53:13
Hw clock time : 2026/10/03 08:53:13 =3D 1791017593 seconds since 1969
Time since last adjustment is 1791017593 seconds
Calculated Hardware Clock drift is 0.000000 seconds
2026-10-03 10:53:12.109057+02:00
root@tirpitz:~>

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
