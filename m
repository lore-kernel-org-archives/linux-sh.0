Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E823333D4EC
	for <linux-sh@vger.kernel.org>; Sat, 11 Jul 2026 07:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783755268; cv=none; b=UMiuDOKBR+vUfqmQ21sx3r1P5B8gnE57DVZ8ZbfbJ8YE/fmtYVvHjLCTyxmRYSZYmyrZNq6CYF/GDPJ2DyhlJ5KUxn9zpkTqujTguNRCHQCUtf5TKs/oCaXwsQSohuoTfeZsmc1FjywrclYYU2ILYGfQ2WypAnMhvZU2kx695Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783755268; c=relaxed/simple;
	bh=gUnPJvqa+6hCH/9HCtTO8STc6X6BWHZ70c5H6AKWsOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tYrLNKk/T4z785UMJLC/Idu5DHXo/5GlML9FO3vW7bbL0wjY3/k0M/ucM2Q/JhVkF15nIwcHvHQSbDzBOJbLgJChitjXILJ5X+JBJWNkB+rVTZz+AdRho7jLtwa12EUuUGMGqI4vDaYA22sXEyFWuQffgV9trJ0KzvsLenrSCtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVUYdWB3; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVUYdWB3"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aeb98460c6so1840104e87.2
        for <linux-sh@vger.kernel.org>; Sat, 11 Jul 2026 00:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783755265; x=1784360065; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aBafLctpeA1AoyzErbEa9EGgxzwRbfKFWoPKc6c7bv4=;
        b=AVUYdWB3WfvWD9/jCidP0U7zRkAI7QnX4kmNcHjB6Nosq4CWaZlW0hNhy2LM6kgpWe
         TWeOEWd21tnxJAl6DPVycHqgm9166I3BafNhzXVO9hS6LEulcv+AlPncKAl7GvVrR03Q
         iCvt2f7qMPGyswDv6RE6LdZAC8T7nBCACNeECjWvasy2/IQ6mcUH99GfG+odlxT5vxDc
         faI4NAbgRuPvGxueHmF2X4sAqU7TBPz2sj2hy41Y3HsZaAYU2w0jJYHYvY8gACqUio0A
         PKN2hjadzNTtEb4X+/A4fXYRXB4crD0SpHGqL5UMuZ2Is9WMaTouNVWbOrjTDz6nyty1
         dqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783755265; x=1784360065;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aBafLctpeA1AoyzErbEa9EGgxzwRbfKFWoPKc6c7bv4=;
        b=rcSjzLAj+w6Z/9PH/S8m6f2jtvCf8vJhRxKqMHJduwMdhNDpzqDB2YPcLDaS0Uma+h
         gOYp3wBVrv3hi1rPjWhYWg8SNWXS7XTeLCMlAvGK90EG2osJeDXY/ELu8CP1NWOO08PR
         Ssub9xVL47ayvwFZVi/tkT+TROp0KAXgvnc3UUQNB5C1kcAT3s8lbGIDUVbkK0I/PiVb
         wb9mPlX5VtgDGQYmtbo8jpO59xCL8QpXLWTjQqwnu1aVr23v3CgWgTJ6x9UppoJ+xWG8
         gROB143C/FYcbvUYpnJlImHW0PqHzhpBBYv+m+GxKNrQAaVJvLBbZmOXa0DIBa1X6AC2
         zIFQ==
X-Forwarded-Encrypted: i=1; AHgh+RqtlVlUADoYQo+z2ADCLHWrnQzzwmk5t/4HIQHNLWoGDzlFSG1OfdPH2qHr1B/vZ+xzQbFQuPF9ag==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnfH+8OcHCSlabCqUBZlIVWqGiTD3hDUWd0I3toTc/i9bMiLCU
	IFDrq3cHnHEDUQBejHrRvJ+8KidRIlUymFtXTWOg6m6ku3wY0+a3ocns
X-Gm-Gg: AfdE7cniRIX4o6ri6yOWfiSmG5c+zp6tKP2HgIlKHXgyk1ekzz5ujK6ClcTn7kxs8WD
	DptlCuis2tufn/u4+dbxrkZ2LQqPII6TqOo23U26aC3zDNYJw8UwTM3Dd2ECH7ssh0lLSD5TYp5
	l39jdYZX8wWonywuKUqKqb604KHiV0Z7VYCuuy+Cqiwh0s9EG9TBPszDSkxjjR6kGDCkHTeWFTT
	pGMHldtzQf7e9nLjhB90HwiQ4G/XRACVQ3ks/6apLxbhh7uZkXIFwX4YBQbf/qI96xb5lTpQGuY
	PEdyPcoBHEzRTdsKFMGNM59de2eeAXb3T///9yB4CKIPVlcn2QVVwoCyIUMDNtr+xSBH1uSreGK
	ZDcT3UBGN4GrBpyikLezeMQhDLxhK65Fg/wgJcjCg9Jjwn0Ur5evCg2i1ZWBSBFXD0sTf+8SfW5
	eZvI1copipRZCgZoGV58hNhcC0x0VMgEMg1cExRRHEFsq/yoneM6yOEQbGaNJruFVBvf6w9A==
X-Received: by 2002:a05:6512:3f8:b0:5ae:bf45:e3be with SMTP id 2adb3069b0e04-5b0236689cdmr321070e87.21.1783755264967;
        Sat, 11 Jul 2026 00:34:24 -0700 (PDT)
Received: from ?IPV6:2a00:1fa0:4322:18e2:4e2b:60a6:4ce2:33fb? ([2a00:1fa0:4322:18e2:4e2b:60a6:4ce2:33fb])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca9dd41sm1117527e87.48.2026.07.11.00.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2026 00:34:23 -0700 (PDT)
Message-ID: <de1d491e-159e-41c2-b145-4d09db091031@gmail.com>
Date: Sat, 11 Jul 2026 10:34:19 +0300
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] ASoC: replace linux/gpio.h inclusions
To: Arnd Bergmann <arnd@kernel.org>, linux-gpio@vger.kernel.org,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Gregory Clement <gregory.clement@bootlin.com>, Frank Li <Frank.Li@nxp.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Krzysztof Kozlowski <krzk@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Hauke Mehrtens <hauke@hauke-m.de>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <zajec5@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, patches@opensource.cirrus.com,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-input@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-phy@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-sound@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
References: <20260710211954.1373336-1-arnd@kernel.org>
 <20260710211954.1373336-7-arnd@kernel.org>
Content-Language: en-US
From: Sergey Shtylyov <sergei.shtylyov@gmail.com>
In-Reply-To: <20260710211954.1373336-7-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/26 12:19 AM, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> linux/gpio.h is going away,s o use linux/gpio/consumer.h instead.

   s/s o/ so/?

> 
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>[...]

MBR, Sergey

