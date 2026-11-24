Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795524294;
	b=inlbyTnVlEPtUQ06KKAejxAsWFe3PDsT2MH+aOLfnZzanYt+oc3+s140IWJecaExWMcL
	 obI5Jyi20yHjBw+3QyTy7vSI6jrKVkPbVz1O0y1lgIc487P2RKu8lXTs/pinFbR5V9Msm
	 GPPe4FAxuGSv/zSu17B95g1VGO82xiFtYfGcSVFt5hNo+2VXhSb+H+QzBT/TD2MUCQDwM
	 U8AfmVTgVtFhY6aaN0Vb0gH5kpG0XJ/igXBH25hjRmYqy6B/YiwWQQGjQ+x0PxzyiqGWL
	 uaGaTPo/BgBRKy0nE/SV4+f+g4jQblCJ5fQy6fc3U6tAZj0AJyb38Y8clUWyHMdZYPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795524294;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=MTqv12l5RlsvRXRZO0+KXT2o6CMP2SkuXhvGZA3SzYY=;
	b=mG6/1BGJr39EPy48GMxkRWylngWPfovf/+xa9ItYX4xBNNx+JDgv9b0tLeOc9skZH1rj
	 UeyXyN+0b4eZE0K37mKrSbb5/tXQNdcxuF84YSJeARiI2eNeYvKOlbc9rT1hlYIvXtezK
	 HfWLs7ED4hUYCqAaes6RiLuesGi2dwD3VKBUr7CtmyXAguLRzG+zz8W8REgCdbJAqSomT
	 rAjUXluBIKyH1ILmmdeawQYkc9GzrBo92vGfCdL7D9pZMxLUAXpjWQeD1Wq7jOsngxe5d
	 9rNsBMiesByQPPBHPsu1Zf/lnLWpXnim6v5FTsv2G8MhHGnW7vaBN0+MVo6TVmQ5+zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="VB/kjJSp";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 39795606A31E;
	Tue, 24 Nov 2026 12:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VB/kjJSp
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1CD651F000C6;
	Tue, 24 Nov 2026 12:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795524294;
	bh=MTqv12l5RlsvRXRZO0+KXT2o6CMP2SkuXhvGZA3SzYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VB/kjJSp7je8PvvhLChk5vK1SerW8G0a7mT3wGC290wsPpBH5fzoYJ/WHgPUVxIMH
	 J3iCXQKfmlZtzTBKjAfaq995Tw2MdAVGpJbndZvddilhVb3Zdmpgs5lTLrzoalBIEX
	 w3ZoGtwTwNWHNE44YpH3+INbTq1/AKq4Dm3gead8/+dXbXqclrOzMyCtp690U9oLzn
	 /wcp4+CmhvW+OhuUnlm7XCzRhRRWW0ohaqglHn1DLCWb6sQukqQwRaVOwEfJdGKOK3
	 zxGDds++r1N5NS6hyVB+L+ul922StJMSaYjifmRtX68LEy7Mr0bGt1IuyxafnHfb1i
	 oW3uoZqMsYgdQ==
Date: Tue, 24 Nov 2026 13:44:49 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Kent Gibson <warthog618@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, 
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 0/2 v8] gpiolib: finish the legacy cleanup
Message-ID: <jdqf7rwmhri4b2hzuq3wbd54xitqsmw7coyx34cqhjepj4njf2@vad7brzfzj5n>
References: <20261123085723.156933-1-arnd@kernel.org>
 <tdc6h325jthjgyik2ne4oistkm563maoc2cpnffqu7hh34tpl7@oscripzv4dwq>
 <qvmy7iaxc7cjy2gkajqkr5ma6b4lwxz5ff64a5zsqrgewkxodr@odbjlv5x3hix>
 <8296a5c2-0aa2-4fc7-b65b-9d336bc4dff6@app.fastmail.com>
 <7dpg3x3gkypkznzhuetjsqmk5fhqwuwkc6kupbs52zqh5mibgx@fjow6eodw4pf>
 <2f25009cbd67a8ee7b417f12b35374b1@gmail.com>
 <7e04f3d1-df93-459c-85c5-9e57dc1c3cde@app.fastmail.com>
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e04f3d1-df93-459c-85c5-9e57dc1c3cde@app.fastmail.com>

On Tue, Nov 24, 2026 at 11:53:40AM +0100, Arnd Bergmann wrote:
> On Tue, Nov 24, 2026, at 02:10, Dmitry Torokhov wrote:
> > Hi Bartosz,
> >
> > On Mon, Nov 23, 2026 at 04:41:32PM +0100, Bartosz Golaszewski wrote:
> >> Can I apply v7 and provide it to the SH maintainers on an immutable
> >> branch?
> >
> > BTW, I have the soc_button_array rework (converting it to software nodes
> > and dropping "select GPIOLIB_LEGACY") on an immutable branch based on
> > v7.4-rc2:
> >
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git 
> > ib/7.4-rc2-soc-button-array
> 
> Nice to see that this is ready.
> 
> > I recommend pulling it into the gpio tree before applying Arnd's work so
> > that x86 builds with INPUT_SOC_BUTTON_ARRAY enabled no longer pull in
> > CONFIG_GPIOLIB_LEGACY either.
> 
> I don't think the order matters, my patch 1/2 just won't have an
> effect on configurations that enable INPUT_SOC_BUTTON_ARRAY until your
> patch is merged.
>

I'm not following something, the conflict is with the SH tree, isn't it?

Bart
