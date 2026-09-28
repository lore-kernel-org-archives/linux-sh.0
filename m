Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6A84848A8
	for <linux-sh@vger.kernel.org>; Mon, 28 Sep 2026 21:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790630542; cv=none; b=nr/y98H1P3NdbO5rdN5SsSyeu6Pe9iMxjcMW9tv8Kw13zJukz9XySXzpkOC0iKOeNWJEJXFV01c3YhHbePG2bZsuU/UYk/g/nLk7AJXe0faUMkrnkvzm8LmYDX3NAlZ5XIm5wPHToE4OIiCFl0sQ+9Fm/+1XLtjPO1c7HC5LuDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790630542; c=relaxed/simple;
	bh=T07TGuHJAlK2p9Yzp4bsYvgIfDwxKP7tOkd7n3QPAPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDv+P9h6ZAx1YUXkZcya+28FspYSWfVvqiJDbAWWdYeQbFihCGLADh4NDBt3i3EI6tZpCw/wkmRRsKP0T3k/jvCEA4XgnfoksBKaKDCczhbg+vV9j+paMPFArPCyEhEdS19pCc/aoFnLNkVULxnJ4mjAlgrEVB4k6vZDv2WaCFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjGnHjOX; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjGnHjOX"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e721b5503so33392575e9.0
        for <linux-sh@vger.kernel.org>; Mon, 28 Sep 2026 14:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790630539; x=1791235339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=otfVorslIDYiRSzQrsb0HgFi6/0PNH352pFiwpNKL9E=;
        b=KjGnHjOXFLiDVctxo+Sdb2vdk/KsCROYtfc/xDV/JclYG1hZyNkw/9bqbylHbcIYHB
         K788BwTZy+64roQaHgWnnimLYBoz9Kyh/Ke6nevUecRI3Gdqkjn03zYPxpR7l89n1Cjw
         gNlYm0WjIxYVwf4q1QRXlfGEhEuWweNE54ku9UwM5HfumCPTaL22BNy5B7ZFf6ZJQrJT
         a0xY4IKLp7DhpSsmq66iXuHZh9fQIsPUoLA8zuM5dklFwKdfONSCw3/ftFRt7ttNoLRR
         qhYtZB9hKMEUu4pTUj0ZqKExab6PZegOoWOxg89gVLyzNbQQf/KoT/SA+lhPojYYhPxZ
         /vzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790630539; x=1791235339;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=otfVorslIDYiRSzQrsb0HgFi6/0PNH352pFiwpNKL9E=;
        b=mfm5pOD09yg6mLmTg8X/r/PhTGxYbIspg3CcLSk1lX4RCGp0eoO8seWoRGNYw3nRjJ
         6vcwagmgnBUh7WJqp01m+dxJIKTGBbSC2t55pvvL1eYgmqwalstL84c1I7Mt9ot2Eq48
         AAEUpJASk3nNNFFeb9Swv7yRt4uYe7hJMw9YcukyLDZF9l1ruiQOq8cLL7r67qh/HSMn
         xVfbm6+CtmZtbiuvYyuqK0jcTfzgWSoicg4G6gJHQd6O9l1GKkP7c4aEUT/7X+SHrCYm
         Yiqyv/244p99yi4l1JIkkx7kMbU3bmzZrJDaY4Z+/VTdohw7LQQtjGK1zk+KWXYnKSX+
         BIJQ==
X-Forwarded-Encrypted: i=1; AKwUvBzxE9ACdgsj828S1T67xjMtwtxzX8S+iVWnqh1CgLcACHWdSXpwnp6Ag+ieSCTN9qILHaqUVilLdQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kkF6t6RRskLM1X7/u70xqU5oBdRkQ2lCm7OFArOnu6bIoW9RX0
	tMTqBSELqWS2miJjr18sSL4KXxsWDW5mWfN2s1x1Cr3ddovGfhcwDZIqfQ00/DFx
X-Gm-Gg: AYBFou1+DaeY1JnmIFDJaw3pf07zEsaQchSpq5oFG2RaTN3gMl9jJbZxdI0G8+VeU2k
	My4qXWFVac/JDula7usw6Qc/NqTna++hy7PTHLDd8mLMkRYcQZY7ni/OKmE6bFZmDL/yiXRsCmW
	LZJIin9Z7awtrua1sY23G8XREeLpICfyBryKksYss0jappbkD+iLpHmCRbBGGKGqIJBz//Zw1L5
	w2cIgihD7rchBlHxPpiLIrmASegIv6Ikz/oGhCooZrekrnNG2A7zzpcUoulMDtD9RrdjgocObin
	5BuUEz/LaOYkIU7MosBE5JEZvOQgQDptcNdPzmV6SFZ/b/ji5Fge2QdIxgS0D/ua/nJne7UJZHP
	pfcWx9LiIVQQxYOOBFzEhh9tqZw+csgVK41wXz2nWXfdgOpPPgjXtImKET9LtXsPS+wCNZISsyX
	pv4AtQ5Nh6c2cfiLFsIpT0tw1pLtKQxRLHAAf5Zf+3fQF1NxWPaVeo70RoVD8zfhhLMsxvrH7r9
	4HwcdPjJPXidEdiU17a+dN2E/4rWTAqf1xotZZrZEeySEEuBGiCDsQmoKkjnZ9iz0ycahJ9sPTB
	KWnDnj0O8qNfRoGN//7QwyvgbdK1nlimvjeI9f5aAeREF0yELzkaZeao6uz8TEQfAIh30CXfxw=
	=
X-Received: by 2002:a05:600c:4e08:b0:499:8b13:3a98 with SMTP id 5b1f17b1804b1-49fe66c9f6fmr255853995e9.4.1790630538944;
        Mon, 28 Sep 2026 14:22:18 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-acba-a601-4494-3582-465b-0eab.310.pool.telefonica.de. [2a02:3100:acba:a601:4494:3582:465b:eab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cf9b5e2sm34363095e9.8.2026.09.28.14.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 14:22:18 -0700 (PDT)
Date: Mon, 28 Sep 2026 23:22:17 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: intc: sort the prio and sense lists after filling
 them
Message-ID: <arrZ4bFPXPsvjXvb@gmail.com>
References: <20260927191359.6144-1-kmehltretter@gmail.com>
 <d4f35d5001924ef9ff4b28ac412a9d4b6048d789.camel@physik.fu-berlin.de>
 <CAMuHMdVRznzGdRwZOHa3=cxhoDNBh1kJqGUoBHqowgj_nzKCRg@mail.gmail.com>
 <ed4f818f00df446df53a9168054bee1a9a993409.camel@physik.fu-berlin.de>
 <CAMuHMdW=amt+3ej6+i5TMaO6VUKJt3qqYvSWctFtSt8Tttrk2g@mail.gmail.com>
 <cdb4898094f152eb617ea353c0780e7fbb000659.camel@physik.fu-berlin.de>
 <CAMuHMdVw+-V5OKgRugm2Jz+S=0dOD7hi1p-U=Fzmh3piCOkE3Q@mail.gmail.com>
 <a6242d982e0815131fb2436091c77f0e7e545424.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6242d982e0815131fb2436091c77f0e7e545424.camel@physik.fu-berlin.de>

On Mon, Sep 28, 2026 at 09:02:55PM +0100, John Paul Adrian Glaubitz wrote:
> On Mon, 2026-09-28 at 20:34 +0200, Geert Uytterhoeven wrote:
> > > usb reset ; fatload usb 0:1 0x89000000 uImage-git.gz ; pmb ; bootm
> > 
> > Do you have a config for that kernel?
> 
> Here are some known configs:
> 
> https://people.debian.org/~glaubitz/sh7785lcr/configs/

I think it's the config. Your new image loads at 0x8c010000, the working
one at 0x80001000.

0x8c010000 is what an R2D config gives, and config-SH7785LCR-6.5 is one:
CPU_SUBTYPE_SH7751R and SH_RTS7751R2D, 29BIT, MEMORY_START 0x0c000000.
config-SH7785LCR-2024 still has SH7785LCR, 32BIT/PMB and MEMORY_START
0x40000000, which gives 0x80001000.

I tried both on my QEMU model of the SH7785LCR with 7.3: the 2024 config
boots up to the root mount, the 6.5 one prints nothing at all.

So I'd start from config-SH7785LCR-2024 (or sh7785lcr_32bit_defconfig):

  cp config-SH7785LCR-2024 .config make ARCH=sh olddefconfig

and check for "Load Address: 80001000". Keep the intc patch applied, the
overflow crashed v6.5 and v6.6 with SLUB on my QEMU model.

With the right config the kernel may then really be too large: 7.3-rc5
with config-SH7785LCR-2024 uncompresses to 8.2 MiB, and U-Boot's default
CONFIG_SYS_BOOTM_LEN is 8 MiB. U-Boot then prints "Image too large:
increase CONFIG_SYS_BOOTM_LEN". With CONFIG_CC_OPTIMIZE_FOR_SIZE=y it is
7.3 MiB and boots through U-Boot on the model.

On the model I use U-Boot 2019.04 (sh7785lcr_32bit_defconfig, the last
release with the board), with a few local fixes it needs to start at
all. 

Which U-Boot version does your board run ("version" at the
prompt)? Its limit may differ from the 8 MiB default.

Karl
