Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795482660;
	b=bMYc7t8VZ1EXTwwt+C2LUsJuQpsdrqiWg/YDlCt4z0mMM+Z0L+IU55VrOku+C72iwqYE
	 h6Xo5pOr/sDmqvJGyLx+pNDDeZn8FrVxKsp3LuTSzN0EazKNR3juL24EPvu3gx62EEKsR
	 4AZjd9n1/KM1Tm4tZEeZaFc/yEl10mb+pOlA82yDuWZ1XJ+oZ9UvdrbBKCRB0av1oHVCd
	 /4WOKTcL1KFEt1+0blYpA3P+7fHjqejQW+pHThSoN3Cw8LN8P1qLHzKfTuAxG0v7ARewv
	 UD0Z0v8AcsqYVFDWvsEHopDoMeMHWfd5yJ4PUz4T4pJlkMNAgFrYm9/nyS43J/78Oqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795482660;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=CwEMPI7Nv8Y4G/uSjVrKaLXUsD6jBVuvooxioPWLmTc=;
	b=rVJtct1l0u/jcaahpGQ9ZJsl9HBRhXRGXdzu/1FDuMO8WOTmvNUkhH7O2dFL3VkBa+hC
	 lU3o7rzERDTl1whKuvsdwA7wVpSwH5m/5LIvcaoc/7/EC1gM4SnGkWo/BetK6KeRUKhFr
	 mk5oZdyA8jvc1hJLox901ptXm9AllYb30vNbiu9HIfNkhwLL2s8l5pZOcZ7L8BUi62XZe
	 cK4D2iviebUKeSrMyeQMvtp5sI+Hf9+4cPpp7XLQsRbhZfTNoG1dtXvRq3Jx4GIR7/b+8
	 7y0VmFsJvtjxqpRm6pMO7FfCFqUE+Mb1h3gk2cN5W0V4O1s7VuHpQXSrr6doMQ9tBXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kKG19Co9;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE75D606A330
	for <linux-sh@vger.kernel.org>; Tue, 24 Nov 2026 01:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE75D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kKG19Co9
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso8475194eec.0
        for <linux-sh@vger.kernel.org>; Mon, 23 Nov 2026 17:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795482659; x=1796087459; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CwEMPI7Nv8Y4G/uSjVrKaLXUsD6jBVuvooxioPWLmTc=;
        b=kKG19Co9tDWF2kSXK9dKvmLlvSosMXN5A+fjtmNUuhQN82VGIHKHSt7hl60KkIuTqu
         OTELZTKud2yzTtGpJ7YssH7XaqMzCZGWMYDkBuT+NcCO6f/J1jqPT0iyZQqXfdWQVo+7
         NpL+BVzS/nn6KT8iZArKwzuxRvPxz7vHEFH6/T2KHs/4S02PCeK1dyecPiT3ra5J0+fQ
         /fgxtsqz+bypFUe4822LHXZAKII+1BrHRYFU9BpYbk+8Uqr0d9LvdyqMqVFfzPKr5ne0
         gjqbIHRdr1UAU+rh9u1Qy9nf2cgwwJCw8nbQvW/s9TlQ/Z33NtjHLWdZggyn3wfRzLHS
         ZRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795482659; x=1796087459;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CwEMPI7Nv8Y4G/uSjVrKaLXUsD6jBVuvooxioPWLmTc=;
        b=Ur6FGfjlwkzGP/fw91PP7d8x5IKZ+8bof5quWDCfNi8wsqVr+kPnYgeQCWEl3Q6YY0
         17ta50EqrsrB7FetVUfdi2hfZxft38S5A3/jiUxfunWMbDWh9iQlcWRj0JYO/emrZBFD
         cGVGyG//MUZlStDZFFrZvXD0gqhTCdKhW0pUVbc2VRwWe9FDnfgzv4NfQlVvB4JYHqQf
         fZmADVzv+pxmkRWgMZzRerPl3bUaGXnJZhsscyKQU6cReWZFNhGG3va+FVa8icUJ8L6f
         1orYnLTw24AD3lTarwyobC734GxcjyNY+/ufdc5J29wc2l2cNOp/EZcyPoncxn01huG/
         yP4A==
X-Forwarded-Encrypted: i=1; AL+hErEKgvPJgj9+G8tTG5S09zNyX/0iclaCX0tv+Hcwzjpx5UTft3bqSf5to4zvj66N/8p2gVw4s8sPRQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/1LmRRuknBP/etFJE67ISIRZqmG4akfaqFSwqTiRta8vVR3KHV
	8lEXjoHW10MnwoTMxd/qCnism4Zsz8P+ACb4fFKi55AkXpxoVCRRYyex
X-Gm-Gg: AZFdTZfSJLsfM5ZOG5xs9MZT9MWjEtcj6yc3tJvYFGGWR6spPvoMLQ34aHO0DQx6Thg
	JrqVbohSyYIqixbNKKsk/y5xIkreGBsBjmEf5ElvQqiDwJIhjDT+GoMklOZA11O9wH4MaG3wzxL
	P3ZbD1OhmO3BQdbztyc4WI2ITXPodMzivEElwp26XYzz/fJn1uze+VF6Z4GXezlJlRDnnSv/pZZ
	ZHLgy5yxArJ5CP805VpneDxmFTFMSYsdMo0rz0SDr7Z2HMfqXVLZL2f69PFE4PRi+d40J3EpxCe
	94H53zP8AA3V+/yDuquqC4dXMinIk1s33m6C3pvv9rxeQUAvYiEBzjfsVK1mBElWGkikStzSLkb
	+UeRhCn9rEWIzvFUAXl0KPFgVhTnFA5s28AmIYVccb1vRJggo389y6qmglCWZgylGL59hrD/NUS
	JcCXUp+8umJ13341LSc4XDR5ZEetS2SK/rqJlUFOPzoYbX/1Sdd+WcAJPR9PAMI3KDluE3HdTfS
	VV4M4UMX7f9yLIw6qBGPRs1IJbWcIqwJpzoYyN8oy6BGMXoOru+cDhuGlbbJJffbg/XBT+6eLqH
	IGt6VQyvl9xCWmp36bmlEKwD0AcdsV2x84F3JX4qmQSsua85LJi+XsRQKLVK9uM0bzQVjg==
X-Received: by 2002:a05:7300:c695:b0:37f:73f9:aee7 with SMTP id 5a478bee46e88-3856c9a6408mr15050898eec.5.1795482658749;
        Mon, 23 Nov 2026 17:10:58 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386aaae4960sm15816977eec.18.2026.11.23.17.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 17:10:57 -0800 (PST)
Date: Mon, 23 Nov 2026 17:10:56 -0800
Message-ID: <2f25009cbd67a8ee7b417f12b35374b1@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Arnd Bergmann <arnd@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Kent Gibson <warthog618@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-sh@vger.kernel.org,
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH 0/2 v8] gpiolib: finish the legacy cleanup
In-Reply-To: <7dpg3x3gkypkznzhuetjsqmk5fhqwuwkc6kupbs52zqh5mibgx@fjow6eodw4pf>
References: <20261123085723.156933-1-arnd@kernel.org> <tdc6h325jthjgyik2ne4oistkm563maoc2cpnffqu7hh34tpl7@oscripzv4dwq> <qvmy7iaxc7cjy2gkajqkr5ma6b4lwxz5ff64a5zsqrgewkxodr@odbjlv5x3hix> <8296a5c2-0aa2-4fc7-b65b-9d336bc4dff6@app.fastmail.com> <7dpg3x3gkypkznzhuetjsqmk5fhqwuwkc6kupbs52zqh5mibgx@fjow6eodw4pf>
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

Hi Bartosz,

On Mon, Nov 23, 2026 at 04:41:32PM +0100, Bartosz Golaszewski wrote:
> Can I apply v7 and provide it to the SH maintainers on an immutable
> branch?

BTW, I have the soc_button_array rework (converting it to software nodes
and dropping "select GPIOLIB_LEGACY") on an immutable branch based on
v7.4-rc2:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git ib/7.4-rc2-soc-button-array

I recommend pulling it into the gpio tree before applying Arnd's work so
that x86 builds with INPUT_SOC_BUTTON_ARRAY enabled no longer pull in
CONFIG_GPIOLIB_LEGACY either.

Thanks.

-- 
Dmitry
