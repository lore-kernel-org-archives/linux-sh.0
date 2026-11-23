Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446492;
	b=Nu0d90NYZtapAs9DYrsdpKyhiJYTlPP3ScAsvZkjnsMd71Rrr6CnRAfDV23dkXss4VkK
	 EKY4oHTYpTV2rYvwK2+cIet8w1uImzMQiTv/rpJDjZ4XHqQWDHdWhzPKv8yF7DDcwpckl
	 KWtkBglfe2I6M+ac3AMWTNZqW6gEV4J/ub/NIi/yog8LDgJFNrDfXo7RgXZH8DAcKPRFM
	 UTn+Nh9Jqi5SXRNffgZqNAM1nKm+Nn62Wu8Y0XtlWfgdk/ZbpVs8pNTEcG1+dEQPZEuUB
	 +fdpEKxcafXV1DplDJzKLXpqqG7+T1LrDhSzPl0LThqms1PnN0qy3AGCiX28pUMPoYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446492;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=A+EtuvlodP/OfxPibMpp5TFtARSp3mZ2MpWOkvj9WEM=;
	b=iFneOwZZM3tYmETR96YmWu++teIZ7Y4dbhOD/AO2Pnkf+k9vDTzOLHzowR6wu1+xVaFR
	 +srJJMD0YXzMHLBdu5fTPEC346jA+BaWIC5+MTicVu0Siuz+bNXNwXqAV2eQZLDBBrqRv
	 wddCkduSZ/Fco20YaeP9s+Ys/c+38b676cQwGPtIhXP+cRnf3hg28mG+TLV1ooH01syNY
	 7mSWCIaHynMvFDHPaRxzx9YbTDl43hJu+94aSdOKohSuTg0JE+56IB1u9POHOr6BYUQ5I
	 ZHHnAm0HZ2SYynM2DalNyp3YaaBmDMTGCvfPp/SJWI80DxyvsTWffLCrK7iNJN1gxZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gKlKxsFU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 45CE1606A32C;
	Mon, 23 Nov 2026 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gKlKxsFU
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E61B41F000C0;
	Mon, 23 Nov 2026 15:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795446491;
	bh=A+EtuvlodP/OfxPibMpp5TFtARSp3mZ2MpWOkvj9WEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gKlKxsFU5ncHfRJvkV7QPqtljNACvMmBY6eyn/HU7pT6Q/1yosiwI9PmMZ2Ic340b
	 ye/EQoay002DBrVZons5KqIGogkcpLomNlFaBqxt1JEGlzizIqq2wddUSBHMwHgFjB
	 tDQ/+gxeYrvWkV60wwicp6UjAkgvjycllyuQxKRO1Zs6ZmQjQj+nlPO9v7u5rA9hL4
	 ld1DaAaksPiYUEEYRcyF8i2uOK/IlnZOWTgHd6kgCXZA57d+hwA87uGC6HjgF/kBYV
	 nsOWE6afokAJWJ6L07Uzc7ax4ERjpkbZp183nEVUiQBfSiT0sSg0JNh4wsBUEUIV8P
	 1ByPgnPd3M1Ww==
Date: Mon, 23 Nov 2026 16:08:08 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Kent Gibson <warthog618@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 0/2 v8] gpiolib: finish the legacy cleanup
Message-ID: <qvmy7iaxc7cjy2gkajqkr5ma6b4lwxz5ff64a5zsqrgewkxodr@odbjlv5x3hix>
References: <20261123085723.156933-1-arnd@kernel.org>
 <tdc6h325jthjgyik2ne4oistkm563maoc2cpnffqu7hh34tpl7@oscripzv4dwq>
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tdc6h325jthjgyik2ne4oistkm563maoc2cpnffqu7hh34tpl7@oscripzv4dwq>

On Mon, Nov 23, 2026 at 03:59:24PM +0100, Bartosz Golaszewski wrote:
> On Mon, Nov 23, 2026 at 09:57:21AM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > These two patches are left from my cleanup series, finishing off the
> > work to turn off CONFIG_GPIOLIB_LEGACY by default, and removing the
> > include/linux/gpio.h header.
> > 
> > This was planned for 7.3 originally[1], but kept conflicting with
> > ongoing cleanups for the broken rsk7203 board. I've skipped the
> > oneline rsk change now, which will be fixed properly by Dmitry's
> > patch [2].
> 
> What is the base commit? It doesn't apply on top of linux-next.
>

Scratch that, PEBKAC.

Sashiko is right:

  CC      arch/sh/boards/mach-rsk/devices-rsk7203.o
arch/sh/boards/mach-rsk/devices-rsk7203.c: In function ‘rsk7203_devices_setup’:
arch/sh/boards/mach-rsk/devices-rsk7203.c:127:9: error: implicit declaration of function ‘gpio_request’; did you mean ‘symbol_request’? [-Wimplicit-function-declaration]
  127 |         gpio_request(GPIO_FN_TXD0, NULL);
      |         ^~~~~~~~~~~~
      |         symbol_request
make[5]: *** [scripts/Makefile.build:321: arch/sh/boards/mach-rsk/devices-rsk7203.o] Error 1
make[4]: *** [scripts/Makefile.build:606: arch/sh/boards/mach-rsk] Error 2
make[3]: *** [scripts/Makefile.build:606: arch/sh/boards] Error 2
make[2]: *** [scripts/Makefile.build:606: arch/sh] Error 2
make[1]: *** [/home/brgl/workspace/linux/Makefile:2257: .] Error 2

Bart
