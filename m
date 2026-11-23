Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795416292;
	b=ujvp2vLpbmYhS+xn6LG33KgNlPEf+9MDZJ5ef45L983YrykDl7Wz1gjKnKS07vRwzEw/
	 04UgjSJtIMOkf/Kq3aqAGlz+GGABqDqIC8bg6TQ4TcYBbwXbIIW3gcVKYOZMUUU9FoCkV
	 1BnUKRlPeF9xUpO2yDlCptOR56gvBiCQO/dM1AwA4kQC7rmrVwGvDzRI8DP7cnOcYIrXA
	 YLv9EPpFyYbO1hmpdTXz1slBVIh12a5DMPZzJ9DMm3PIoImr2l4YNb/oaG2V1yJ45QveL
	 PlFZ1DBnaIq6fYoQH9g8MTFKtjz9/3ZzruyNC921K/523M2qTLH+VOmMZBxOfD4EaqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795416292;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=2SjRi5DA6EPs4N724PY/ZYwEORsvpZ9R0IBDl0iZ0NE=;
	b=q1mga7GjAK6Q+h73krJtnvtJbsnN94xQ5B2VhJfcVDpscYo6GSeFSMT2iqW2bESJAeZg
	 SLX4qbhkbAKhrtKeoZSRkFJ1E4n7Zmy2L3ahq+TljiOoUXmx9vll/dDE/UUXeq6YWNz9W
	 9+axBiZInEKNFq/AAsQ48xogI+VJHZyYp6uQmRef6mnkDhY3nIs5oN/rtKCFSUR9sUGIK
	 F8KtXUBI4+ioc9HT+MQd175BAInL0yoD+KPOfIEk7DXqyy9hL1K5/LWIrObHQiTY9YVDy
	 Qj3Tnn5i97k0rX96lL2aRv7cgE1p9oQHgubfdcLwX3Et/UY+63vtXbjZ30kLBNM9s9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j4o2xYsG;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B03606A31E
	for <linux-sh@vger.kernel.org>; Mon, 23 Nov 2026 06:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1B03606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j4o2xYsG
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b4021b572dso1854411a91.2
        for <linux-sh@vger.kernel.org>; Sun, 22 Nov 2026 22:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795416291; x=1796021091; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2SjRi5DA6EPs4N724PY/ZYwEORsvpZ9R0IBDl0iZ0NE=;
        b=j4o2xYsGh3WF/JUZQQOuj/v67/PWJ7hBi2FsjvLLsZtbm29aHoYdH0NO+RcHpADiGL
         2dvXRLuk5oNLY5e3J5y6E54Umcm0YyNsO+tBVTYSYc8Xa+Jk/uS8g20d6XOSmM85q7Mv
         OOvTfnX7Egw7qPncqmwIy1jdpRDl0/Prkna0hyc/JYVrKiNwRkwjCwV3C6XJAL+vV7E7
         rmefry0U/PqpRQnG2xXtfNfXYUkv1b7CidqpNSjO077yuGBXMab68jiF244vxAbttmAO
         b74JQzwV1UZI8H2QsIDxvyqmNgfBnWyrqPslKLrBAFY8wGlBVH7Oxyb80w9pFsfby4Ex
         UGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795416291; x=1796021091;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2SjRi5DA6EPs4N724PY/ZYwEORsvpZ9R0IBDl0iZ0NE=;
        b=Kg/VGCe6LGyOuRoUBzWE0Xnyo9JYVxXAA3cwHBrGmCZWdJqohR/zJL8BTiEscVWrwQ
         YKr2mNfarOSQaQ0prwIfY9kna7zWNN6xbLFtGgTFrzk1BAQslezHV3fOKe+0XG6CjHOD
         T77K20jnXRfS3hnnwL+kB5uvU4loYtmNsd+mzc9ENJytd359cH8Lnn+hlCKMLq94MzAl
         8Lnojn/IJ4UOmxjYufqXbNS/fTJs5DMh2iIqusAFdLRXDeTExLvA1zWrbHp/dgNiwnPp
         /pjNEw1xusJ7yijVMZzUo203tlZw6TuyMkrEMtb1mJkVsV54v96HDI6vO5SJ/PHjYa9v
         P1gw==
X-Forwarded-Encrypted: i=1; AL+hErFNxj5ACLUJnaaeeYFfYtHoqfFQ1JYBLlS4hLK1pPXzBn80Z0lHJRq00fjE66hwxH+cdK/wz20XhA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8Vqr0qf/YA11M1w1+zX6NCxblPzLy0Gsnvs3DYDHIprRcgRhTO
	iB7/RC+KrmGvw6t+ut/lohbOM7kR9erbkkkHX957/t2cvzbdXREx3oZe
X-Gm-Gg: AZFdTZfDmi6XQeZEZFxsLaxiVP8QUWViEet0eUdXiA05VoKsddfqFMVFkPQpRlVwSK6
	bBaBS+RlMsgKcuTd2cl8tUqicbYWPFmnDZWhgVQTq3zNIrxrHII7ATrBSuCaEFZDWCQ4s94HjGo
	yx4hrqmcc94Ww9XYr3V9kNcnuQr6yuZMi3ae/+gn+PvWLi78oy8/c5QcApHca8muvlUtdMCQRpj
	lWxIzZ6zjFc4D+T2EuMePEXKRvrCGqmmfkF0MrwWEfkYXCigWKhuS8fTfEWccEAq00FeZ0E8d9A
	w8Kk6HbjMsQgTOFo4A0IDmfkBe68BCD+RhAnR3l1907XWz/NxeWXlLHyIUq4GmHAe9sQJINkjV3
	IdzBJ9y/quPK3pUHCAyEvBd/L2wHYkLzKkd/hQUrkCtvavi43Idoq4NLtlAOoLBDLrgLFKNy/Gk
	6DAsjjOQ3HteujMgfkNl3Lqj1V0i5k+0KukUtcUraA7ezH1Sp/l3d2TE3YOT9dGPHSyWePySojO
	3VfSpCyoMbtCRdZx3YJwm2+3Gc5uGKHNUNq+c3GP+zlw8KP9HR20FScvxlm5/jLu8d7gqt04LBj
	eeVvocmhlqIhOLivOZvV2SqK/hw2dn1zcocTav/1t0wQT8BOzNqdFl7NNSrho5L2RKux3w==
X-Received: by 2002:a17:90b:224e:b0:3b4:f92:ade8 with SMTP id 98e67ed59e1d1-3b41c7e1174mr10446536a91.7.1795416291007;
        Sun, 22 Nov 2026 22:44:51 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0b52dsm17835023a91.5.2026.11.22.22.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 22:44:50 -0800 (PST)
Date: Sun, 22 Nov 2026 22:44:49 -0800
Message-ID: <dea00f90c205f8359baca729d8b0f31a@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Rich Felker <dalias@libc.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	linux-sh@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] sh: mach-rsk: rsk7203: switch to using static device property, drop legacy gpio API
In-Reply-To: <arzKNhmoL6yiGrzH@ashevche-desk.local>
References: <20260929-rsk7203-properties-v3-0-02f84aeb8e47@gmail.com> <3a51385d-9649-4bd7-87b3-0caf9e462b2e@app.fastmail.com> <arzKNhmoL6yiGrzH@ashevche-desk.local>
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
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Adrian,

On Wed, Sep 30, 2026 at 11:37:10AM +0300, Andy Shevchenko wrote:
> On Wed, Sep 30, 2026 at 09:23:21AM +0200, Arnd Bergmann wrote:
...
> > The patches look good to me. I have build-tested this with the snippet
> > below and my series from
> > https://lore.kernel.org/all/20260907090956.2825703-2-arnd@kernel.org/
> > to check that no use of the legacy interfaces remain.
> > You can probably fold my one-liner into your last patch.
...
> > I would guess even with access to hardware testing is going to be
> > challenging, I noticed that the defconfig kernel does not fit on the
> > 4MB flash any more (even without rootfs), and the USB support was
> > never added for rsk7203, only for 7264/7269.
>
> ...which induces a practical question, shouldn't we just drop the whole thing
> for good?

Gentle ping on this series. Will you be applying these patches (possibly
with Arnd's Kconfig tweak folded in), or would you prefer patches
removing rsk7203 support altogether since it is not working anyway?

Thanks.

-- 
Dmitry
