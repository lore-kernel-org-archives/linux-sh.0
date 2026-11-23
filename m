Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795448497;
	b=Q60zul8z4cr7q+0Cu1d+fpzAnCaOb/e3oarw+O7svylof1v6UGrYY+fqaI5CF48GA256
	 nfPBA12STEFtMZ5uSgX8oiyD0a2XXDBg+8eqSGjl3c2xl8GcXHEqj3YNIiZgwtO789YWx
	 heinHmO5DpC+RJaTpD1TCwto0m7tv5tr52chwUnQBggIa+XNbETIW8ztYiVJy9Ny55qdT
	 EPBPPa6lcoJlh/B8Jiq3nnM7UlzOrscoH5DYt9mpnsbsS2k0KzR8t558h1LK4KhSkcN9u
	 M1P3IlwqCsnC03xAQrJFHeF/olvqFGzYqjvZeUIxRhMGYbmyItOLRS4CLaaCCcVO50A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448497;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=ajq0I1jTHg94BEb2kR+C72Yoj6Dn+cM5m8kty+Pico0=;
	b=aHeJJBXN1+Knb4TqRxXCWgnnaQOpZ+9q3sM/QmCMaEta/QXjK8QPcasCyPMYY5QumsC/
	 38SleuWIDBh6g1smYi7tDMr2Lo7OU4AotNIWQSvfgYRfr4bEY1UPVTkK1L8NCPtTLyCxB
	 sGWuXU7uvI1B85pRghGthzvVIryHeonVOxxqpTc17ZMpjujvGVRpvfRx6Rq6UkBzAdSt/
	 UdR9NQ5R6tkM5KAZztR7umerf0xb5qp8K4ZvgIIektoDEnWlv+KNsPFs1dvKNSD6D+aEY
	 Zg40vrijkTPDvh5m7K4/pD93xZKoROCIN3jbuVIlRS5LKqLAPf9WPLruuDQffZNK7hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=heo5z1JP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 747F8606A33E;
	Mon, 23 Nov 2026 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=heo5z1JP
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B7A601F00A36;
	Mon, 23 Nov 2026 15:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795448496;
	bh=ajq0I1jTHg94BEb2kR+C72Yoj6Dn+cM5m8kty+Pico0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=heo5z1JP8A5yxkIctS+s13VURgxZBYP4NbGicVeLFprLdGRLp4z++VF4P5Ksijb9J
	 19GXOsxzXFHDoK08+NSy4F2C7QAknIiaW+6LkddaRjovaFzj39ZV/dCUB0skHJ1nK5
	 qCq/Z+3ohu5obCI5WdGdDC27j1GmEWrYpKQba9bbqUgBZsulHdXpevCylt16SuslTt
	 Ay1PFtS8BNU9Om11cKrCm51zB0DYk/tYFx9AMtRgSFpEhUgdgy2+sIl5Jc6ExQRhZE
	 MnZnRwc6fw9hE4wPenPq8ZzZACGh9cMfRaKbcboytfz5FUriXvOU7QspbkxuAb3ZDc
	 pcGMAuXy8e+Hw==
Date: Mon, 23 Nov 2026 16:41:32 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Kent Gibson <warthog618@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-sh@vger.kernel.org, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, 
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH 0/2 v8] gpiolib: finish the legacy cleanup
Message-ID: <7dpg3x3gkypkznzhuetjsqmk5fhqwuwkc6kupbs52zqh5mibgx@fjow6eodw4pf>
References: <20261123085723.156933-1-arnd@kernel.org>
 <tdc6h325jthjgyik2ne4oistkm563maoc2cpnffqu7hh34tpl7@oscripzv4dwq>
 <qvmy7iaxc7cjy2gkajqkr5ma6b4lwxz5ff64a5zsqrgewkxodr@odbjlv5x3hix>
 <8296a5c2-0aa2-4fc7-b65b-9d336bc4dff6@app.fastmail.com>
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
In-Reply-To: <8296a5c2-0aa2-4fc7-b65b-9d336bc4dff6@app.fastmail.com>

On Mon, Nov 23, 2026 at 04:24:49PM +0100, Arnd Bergmann wrote:
> On Mon, Nov 23, 2026, at 16:08, Bartosz Golaszewski wrote:
> > On Mon, Nov 23, 2026 at 03:59:24PM +0100, Bartosz Golaszewski wrote:
> >> On Mon, Nov 23, 2026 at 09:57:21AM +0100, Arnd Bergmann wrote:
> >> > 
> >> > This was planned for 7.3 originally[1], but kept conflicting with
> >> > ongoing cleanups for the broken rsk7203 board. I've skipped the
> >> > oneline rsk change now, which will be fixed properly by Dmitry's
> >> > patch [2].
> >> 
> > Sashiko is right:
> >
> >   CC      arch/sh/boards/mach-rsk/devices-rsk7203.o
> > arch/sh/boards/mach-rsk/devices-rsk7203.c: In function 
> > ‘rsk7203_devices_setup’:
> > arch/sh/boards/mach-rsk/devices-rsk7203.c:127:9: error: implicit 
> > declaration of function ‘gpio_request’; did you mean ‘symbol_request’? 
> > [-Wimplicit-function-declaration]
> >   127 |         gpio_request(GPIO_FN_TXD0, NULL);
> >       |         ^~~~~~~~~~~~
> >       |         symbol_request
> 
> Yes, this just seemed the easiest way out to avoid clashing with Dmitry's
> patches again. If you want the version that doesn't break the build,
> you can still apply v7 [1], but that likely means his series has go
> through another revision to undo my change and remove the linux/gpio/legacy.h
> inclusion.
>

Can I apply v7 and provide it to the SH maintainers on an immutable
branch?

Bart
