Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3B6296BD2
	for <linux-sh@vger.kernel.org>; Sat, 11 Jul 2026 04:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783745379; cv=none; b=Maaq7c6Hkbdfw7Un+S10OhmqKEhLu1+mfn1GqTYqMXrrI62qX/oiO7W6I7iRgyRLLmLVmdx9tITOJorBT+qHMpEH/eIdSpGZjAwpp91QW7PRYdr+SoVTtTKsEc0YmTxW0rmmjLXFBmqz6sDxBiGYQLH6z/UQWI3chGqq2ClVX2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783745379; c=relaxed/simple;
	bh=S7g5HdrobVHgSI3y7yFITx6ZdgODEA0xXX0TnH33v6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKo/vA+6WTstE+vnzUghLcHTXcTXYPCwwhPESQfaHLcPen3oPqXkgxENGG2qu+1Vmncv1lT3rOYUltgW7PEJBuH627upHnWElzaiC1hkE6xPhMPEeemXh3hytACfwoIFsIoLiCH2BPuBLV2KZb53nvnOG3DtHtv7KcIsompaZ6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrUunfIs; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrUunfIs"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8486ac3f347so1949901b3a.1
        for <linux-sh@vger.kernel.org>; Fri, 10 Jul 2026 21:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783745377; x=1784350177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qesMdHKmyxw3NJ4a67qnIHpz73OEBeBHn6uWkzO1uyM=;
        b=WrUunfIsErXFnQOhWCnUXZ7TKyOqI8TaNmxv25pZRtai9YvHHJ6dlC29g3qtOv+vRE
         xYGb5fhsMMmG+7vkZUZWHTJrvL8kinbikFiRoVPLvRke4dZUuCv6kQy49n5hwBvqeAqk
         xhvFXMk5+PlucjVTUu/1Pu+FLP1RNmVxnd7flmwuS/1jWdtuSE6HgVyff+UYnMkYZU+i
         WKs/DPjTZ9fvAifwp0iUhJX/P1HqglKBU2GvRdGjc3RYGJV1ljbf3KUJ6sjsWI8eM1aC
         hyGezqIdlIEcKo4FcZkkfuig2XwLgIQsIOl/Jt/fuqNsfwuLe67ocz3RFcljSVK89Ybx
         DyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783745377; x=1784350177;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qesMdHKmyxw3NJ4a67qnIHpz73OEBeBHn6uWkzO1uyM=;
        b=PI02EU6OeSnUgJe7xTuqliuVaUw7FZebAkzS/gaIY+1WXIlQmgtF5IMEsIHq8wV2qP
         XDZCQQJCgIk+FLaRpwEJtBKsv95RbN9/thXbq3aLw63wP77YEbCyZYqa4QK1UcntsgiB
         Mpc3y7ZCkjuLq7LwqcsNuYrDPVXt5TZWhTE6xYkab0nxy09dcykqL29xCt1eyJgHrvtF
         daNKw6xlLfdXpid4h0MRRu4ECVVpB0zM04EmUDzef5eEHJla78JtPIFF/MfAEFLimPUm
         ePZFjtyt7GpxP2oGJQJsOfiEfhCf95s629y/JeGjEyy3v9E+XVSOlX2cZpROy9NWA4ys
         +Krw==
X-Forwarded-Encrypted: i=1; AHgh+RovEVHSmrDiFp4v15hTutnWvZQTECNgZ8jslknBB6TYTpHUWGBpaLswriyQnFY7XZ9SEHFeLyDSGw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXOLDMpEGKr81nVXAN0ppE7VKTHlqswankdwEbpYwzeW8ZjWsj
	5qqZDL3RCFrQgqevaOx1alNr8cFOGQzy2dfNO9Mi9rni4X9cdAWNER4s
X-Gm-Gg: AfdE7cmsx5CYGPFWtTgN5J9iuc9YbzGdkaCat+inwYVFbb90lPtpBd7OX0sDPbaANuA
	R4rHFJHuqH03dUTgLbKBGhR6vIqIOsnUnSh9kt3ezIE/Vd5Uxjzs3zOUQHxtd8njrNN7Byuu+0L
	k9zpiauot2nu++d/Ss9+0gPVuNBzStwWt+k1jbcFK8vzB09TKhwK2+qWGsSEORPme/PY9wTcMkY
	k2AYDfWlkWB7g4G84ZCvY8v679Nu0+jmLG2vQ1Ta9Rbpqo++NaktVJCZ5OLKbsor/eYa2g211ay
	rbnYMS1WJcM1z5oacrtozX/Nx3hevv77TzWVSg59xp6LeE1FqKrOsmAy4/9ETFkcFjYjOT7gU1b
	Ol9PxffItFS35XZk7oV9mhR4F3UGjqOvbM8IgHpGrusQqndsrVg2ikAvHFRa4xKeBCQZBjCDKEj
	NqJD0hitzIzZHP0qu0E5MRpT9gAMnK3en81rWNcQjal23uo1cbSuCwfg==
X-Received: by 2002:a05:6a20:734f:b0:3bf:6763:f0d0 with SMTP id adf61e73a8af0-3c0f085657fmr7458822637.4.1783745377459;
        Fri, 10 Jul 2026 21:49:37 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:d42f:71b6:335c:aceb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311a6115e61sm25970082eec.22.2026.07.10.21.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 21:49:36 -0700 (PDT)
Date: Fri, 10 Jul 2026 21:49:31 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-gpio@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andrew Lunn <andrew@lunn.ch>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@bootlin.com>, 
	Frank Li <Frank.Li@nxp.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Hauke Mehrtens <hauke@hauke-m.de>, 
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Dominik Brodowski <linux@dominikbrodowski.net>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, patches@opensource.cirrus.com, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, linux-phy@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-sound@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v2 09/10] Input: matrix_keyboard - replace linux/gpio.h
 inclusion
Message-ID: <alHLK4O77khiKwtW@google.com>
References: <20260710211954.1373336-1-arnd@kernel.org>
 <20260710211954.1373336-10-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710211954.1373336-10-arnd@kernel.org>

On Fri, Jul 10, 2026 at 11:19:54PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> linux/gpio.h is going away, so remove that since the driver already
> includes linux/gpio/consumer.h.
> 
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Adjusted the subject (s/replace/remove) and applied, thank you.

Thanks.

-- 
Dmitry
