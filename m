Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794565755;
	b=jrcL4v8+yp94ojiXhg/FS3zeJUT9MCNi4JIi5ANR4ACh488h0AwLK1wIgkU3bVhFjlQK
	 Ksszr5GsYTkjJXUkSckCNCJdih05LoahMindisL27sLZ52EGgkWXDRJW8CSit2nFbuIAF
	 rtUcRFaBlnjhIhgB1ZYWMSNZKpxAv8LuobwMKEQOuBpNTfRg+n9N0N5o0jEoVMc2fIAlM
	 meq2bJAdKnKdRXT0jOUh1FQL6vG9Z3XPBcacU1rh2qaoyePo9trUujoaRYsb/n0oThJlw
	 oWHfaRyZTs/s/+dJYM6cPCBELCl7TDcG0j44XUkRCYfapsH5CvM0Dy27ROV2OsXVMnA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565755;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cLlqqY0k7diIlhrzv1M1aVJOoeE1a6tJkKZXoZP0rU0=;
	b=NML7wigsquV8vx71CN5hgtmvy+KMpv+UqJ5rKguwqbT6+vBs7tRpkq5xABqR17YVHOQG
	 avT2L/4QieS4r51Bh4tM7t44IenHUWWK009F0AtohQ54UKXAU0KEAP02P/b2NE1f5pZgd
	 24i1HAHeh+8AdYiRYSmhDr8KsOPuMYMyFMXa6uO7Ig33dhnylSYPwmBWHR2UnAiCZYKj2
	 ZwX0H+A56fUOBmxkm8vBhR3TEEFNQofGfUJ9BqKhcyAtjZzKKHn9o3FGT8aQXuop4AIN6
	 2Rz2nXwT1EBPKAIHj3d3oAmTSKWzogVBcLAk5YMTC6tfFw+FOwbm5QSz2PYfbqb8OVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TDvS+YtY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A026606A338
	for <linux-sh@vger.kernel.org>; Fri, 13 Nov 2026 10:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A026606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TDvS+YtY
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-37071c0f42aso1194355eec.0
        for <linux-sh@vger.kernel.org>; Fri, 13 Nov 2026 02:29:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794565754; cv=none;
        d=google.com; s=arc-20260327;
        b=CrMY4n5/EU6X9JSvsF/4fcimLaphnRl9STFx0tSg9alX7AZjR385idWQMROnRTLYm3
         Cy/3O+1IK1GbIB9czHtm5U6+yRabqYOufiRf+QfsK1m9vbhhq2p0PSAmgrMwYanpsFoK
         v3MuKIdnzG7l1HD0wg+SuGQkSP/swxcpi0F1KlD/d5ZsWupGKweiQ/VbdJn/y1XyA+0h
         8LnjKFgYxJxP7hgTjNPz6ez8wAB556DPlGLW6HZa/X3o+UjqlFU2RSSH58E+hiK24uvI
         6+e78igkT2B1673u8F4Xavx+DicJ1rJnKJo/rNSyMc+f5BlKE7th8T6ocwIa/LujZ+vP
         4q8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cLlqqY0k7diIlhrzv1M1aVJOoeE1a6tJkKZXoZP0rU0=;
        fh=TwLT9OXmgIg3B2XG4a6PdrQC3nEL3uDmk3VDomDT2eg=;
        b=Ojb2OTXgBQllP7rWUKDm9bBC4t+ZrQvAMmPqsikpy538+W1T9gMWLc5VLg1WcMq2Qo
         wS05SyMrVl4TTkJ9BYLEQiygf0ELRZoqTl7G/tNj8U27GdfXc9VVM8d8wB2dx0MyuZNs
         M6USqu1Las56wtwwfAUqbn2RN233hMEaxfS2ntFRQ0tWrm6jgopLhytmOeWDWaGFFjNN
         ded0D2LQ1WczvTzwLv3MfcRttwdOFYIhepnm7DScyqPDzClRgDsPX3b7uuHS00hm6RD5
         FOxBXInYsPmkENLwyY8sZQsJ8Uv/jPPVBy6VrL8gZFxIExWP1Xs4LiLqS0Uo+zyddfc2
         1M9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794565754; x=1795170554; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cLlqqY0k7diIlhrzv1M1aVJOoeE1a6tJkKZXoZP0rU0=;
        b=TDvS+YtY1AbTqAyGZ1p120oYrqqEBQUua5EF2onSOkfyB/igjcBk3zHmxtaBIRmn6m
         /cUajT0QY1fRwVR1QGJm3pufwc+P59LwlfISZLTOlcmRjhS6wM21yfW30POC51d0yD53
         nJ5KZJ1F8EvA2NWXMe77ZbSnv1tgaMkch19sjHlswpQF299Po21Exby0G8lgI2WosR+d
         gmJQJphxlR2jQf1/f7DYhhNcHoYeqdSCeM4GbVh8GW7YfM2+U31//1elpRZBJMEElWQi
         6mNISV/+yZ1T1N4f2mmexYBdxnMpxWX/2SD4cLqAXQo4+bR6UIaK+ywFgs749NOO6uLM
         NDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794565754; x=1795170554;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cLlqqY0k7diIlhrzv1M1aVJOoeE1a6tJkKZXoZP0rU0=;
        b=rja2uXvbPZomxnWyW/D1pETna9kDYzV3g+gv0SFUkb47kM46bn9IuSaWbq2kVjwpdK
         62XPE8+0CJvBY04A3+R/r0JyyVegDd7J9inJ2W3niX7DOcZoxAjS3WIYSk5QA5lNrrYY
         a43jMSMiRpW3zOGEc8oFig97UaeoXsHxLs0ctdVT+jJ6lDnay9FYvyIf+PP4BxtKCBiB
         Jq3UZsYAubnRRA43VEjq/Hf5Cdf42R28vhntfJDIUC1heDQP485qMk28eIaDj73w/ung
         OylR4kj8tyw0HnRu1GGD3we60oLa5HrNzamYzKmDj8rV/MtAcjghQBUxTAUhYZR8xCT3
         ttrw==
X-Forwarded-Encrypted: i=1; AL+hErG5YG1YZvaEm+xlaUynqfR7UyC3yNSUfaB/TwzAK2PzW8IDnjxhJMxJxh/Yf0BU1s3Eod0BP+Us2Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z/bUA5kxciqB1SUxDkRBc4P9Bhx8smtoCn7h9sxcpVgIZ/BduWv
	0QBorD4+Cy2phXJ9hQOUAxYcO7Erh4buJWxMwxPe59eYNdacv5UQLohwDDmuVu/pKhCMhD4trRC
	qwCUNDIRLCCBHporsfE0RRK27hjUHrEU61qFS
X-Gm-Gg: AYBFou299xVe0/gJd5dVo2CtLVpnIgmvwEcGN6CCYieXE0qZjGnSLRcmVd5XPhbZi4R
	DBePC8hf8/gbfL9OOQGxpzzgxSeu8w1BHbb5LYIc+TZBPjtRZ3LcMtzYqdsu1aKCIqi3hbzkLDt
	oE2Bq4XmBVJSEm7+JCYSUt1z//zok9rRiDQcrwMfak6e7WVlqncSU0+Wov7cvvpey9JG6OtIo3k
	1pN8nb6yCg3YpajMwmiEzpalX5eSsoMzM9IqXyFXtGufrdk5pyQZqskjffNhK/N6vQba5JFhGJc
	MxTB2hrkmdSUfF5gJJZVcYG8gTx9kJR3VoFhp5n9cZm2oBauNSuW82IJN9v6RGwXcbrzzVIjqhB
	zuf8GZ2vJLslgmT+lG9ucWSDmLSMfkPjeKqiRhffxnHb2P/IK7j91oVGejpnPFLtIN0RAUigq77
	F6kpV1qsY2WJ/odPheugoXorOnrAWINB4=
X-Received: by 2002:a05:693c:8813:20b0:376:77e6:a66 with SMTP id
 5a478bee46e88-37967315a29mr1873378eec.16.1794565754508; Fri, 13 Nov 2026
 02:29:14 -0800 (PST)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112065037.1800467-1-dmitry.torokhov@gmail.com>
 <CAPVz0n25-LyOFFu-h7Sc0iUcjLMk0njOuAAHr-NepQbnZU6gxg@mail.gmail.com> <5e3fbef26b8500de7c4192bd6cb6eb5248496e14.camel@physik.fu-berlin.de>
In-Reply-To: <5e3fbef26b8500de7c4192bd6cb6eb5248496e14.camel@physik.fu-berlin.de>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 13 Nov 2026 12:29:02 +0200
X-Gm-Features: AclHuK-Fxw1Wk4d0-g4CX6-_wsdY0XEuPYGBEZCmvji7RJCYCeNHh-w-hBV3HBw
Message-ID: <CAPVz0n3SU1eJ9=zzXmaB=y_c8faNMFB2HZfUwZQg6jJkNgRSjQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Input: tsc2007 - drop platform data support and cleanups
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "H . Nikolaus Schaller" <hns@goldelico.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, Andreas Kemnade <andreas@kemnade.info>, 
	Johannes Kirchmair <johannes.kirchmair@skidata.com>, Yuki Horii <yuuki198708@gmail.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-input@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 13 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 11:5=
5 John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> On Fri, 2026-11-13 at 11:33 +0200, Svyatoslav Ryhel wrote:
> > =D1=87=D1=82, 12 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE =
08:50 Dmitry Torokhov <dmitry.torokhov@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > Now that all in-tree boards using tsc2007 (including SuperH ecovec24)
> > > have been converted to generic device properties, this series drops
> > > legacy platform data support and its header file, removes redundant
> > > memory barriers, fixes minor coding style issues, skips registering a
> > > non-functional input device when no interrupt is wired (when the chip=
 is
> > > used purely as an IIO ADC), and uses IRQF_NO_AUTOEN when requesting t=
he
> > > threaded interrupt.
> > >
> > > Thanks.
> > >
> > > Dmitry Torokhov (5):
> > >   Input: tsc2007 - drop platform data support
> > >   Input: tsc2007 - remove unneeded memory barriers
> > >   Input: tsc2007 - fix minor coding style issues
> > >   Input: tsc2007 - do not register input device without IRQ
> > >   Input: tsc2007 - use IRQF_NO_AUTOEN when requesting interrupt
> > >
> > >  arch/sh/boards/mach-ecovec24/setup.c     |   1 -
> > >  drivers/input/touchscreen/tsc2007.h      |   5 +-
> > >  drivers/input/touchscreen/tsc2007_core.c | 183 ++++++++-------------=
--
> > >  include/linux/platform_data/tsc2007.h    |  23 ---
> > >  4 files changed, 60 insertions(+), 152 deletions(-)
> > >  delete mode 100644 include/linux/platform_data/tsc2007.h
> > >
> > > --
> > > 2.56.0.567.gdb80ae8cd5-goog
> > >
> >
> > Hello Dmitry!
> >
> > I have tested this series on top of the latest next/master on the LG
> > Optimus Vu P895. My device uses this chip as an ADC for battery
> > temperature measurements.
> >
> > Your patches works as expected. Input device was no longer registered,
> > ADC part was present and worked as intended. Thank you!
> >
> > All series
> >
> > Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # LG P895
>
> Interesting. What kind of device is this? Is this a SuperH-based phone?
>

Quote from wiki:

The LG Optimus Vu (Also known as LG Intuition on Verizon) is an
Android phablet smartphone released in August 2012 and noted for its
4:3 aspect ratio 5.0-inch screen size - between that of conventional
smartphones, and larger tablets (sigh). It is powered by a 1.5 GHz
quad-core Nvidia Tegra 3 CPU with Nvidia ULP GeForce GPU.

> Adrian
>
> --
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer
> `. `'   Physicist
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
