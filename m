Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D722FE575;
	Mon,  8 Sep 2025 12:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757334477; cv=none; b=NdNHxQJaVzmj2PtIFi5bs8Yj/7ncxOGt96pQPPsY90fRCyND+7CIAPbkeBZtn15jhS6WcEPdfEwLEGIifZkXv6MLLPyGvZ5iZ5QXT7GXoNiJpOe5uLsvQA2bVCb6bBsz6uDSkfTgQN5me8wdsvegxZTLF7cHwCXH6M01Yg/T74I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757334477; c=relaxed/simple;
	bh=CobATCIuufkdh2CoPh7fRJFuTf8ycBoABXNqnaHC3Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M79jUC2IajmyBIGZEx5P4TTZU4RamcTbuu2JOBzOUL/p1jivjM/RIEYP697a08Y3PqVwm67O0PcCa1Nior/+HRLf26Dbfh1qG71Zie+eXGBRXavedncVOjviDKPevN/KTTRoMMZmQjmUoorwqh0mbKsOdGXc67/k/hfpgcK2T5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyS4ZI6W; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyS4ZI6W"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32b70820360so3292631a91.2;
        Mon, 08 Sep 2025 05:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757334475; x=1757939275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pAG530hlqAV9LUfzwpa6dHzQZK5LxCu86gjBzDFlS0Y=;
        b=NyS4ZI6WE0XbjJZgZIzNGaNNzH/ftaqp9xsYuVoOYXHIzoRYbx1w6gHQE5580aD50S
         YAMGF1ElDI96p+xMUI4vwlN5kj0GU3M7ltlxN7HnFw8AmZKCjsz08Q0RXvDxZhWJR8BY
         oW0GccY78PioiYYkglcXrbjDd9wJmcwsX50Iw6bYRWdpkU8aVJG5ymzGDHfdWb8sXlR5
         tS0CjwPRJg2SoWT2Sa+HNLQyEVOMnauVXhYeZ9WFwVLODeFbSY2LvVnHdt5iOaAFdiDV
         rNlcmqZRtyr2+OV2w+pO7s0fNKEx4Raa8QjhzjmhTIeO+3MvxXmVrv7TBjy/SAdr97Zj
         Z7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757334475; x=1757939275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAG530hlqAV9LUfzwpa6dHzQZK5LxCu86gjBzDFlS0Y=;
        b=BJEFuwdMlblBbw5KXgqlXnpuPNVkdjyc18MA9IFezJJY3U0ihBui33ATC0Ny8o/ObU
         JcdcyfF56KrPrbwrzOUlOQHEtvJ2vqzH1haf/c2CIWADyz/9EBqX4QdQhySL6vvPwaI7
         E6pdSsuFRGK6lDIlIVbVJwNA+JLlRFOYUVVp3ln3uK+0gm5c+fkki6RiVL/0VTYHQBBT
         8d1QUBeKE3+ONCtZMCsQYoim97BBRYrvbjs27wLSfk6PJ6inhApjAPKRkxyK0bhH+KWP
         UrcxsKFskkTpfvawl8Xv9sJWWeNxw0ucUetGQs/QF5ATiltai1pNb3yP+BgDMr6S8cyg
         5KXA==
X-Forwarded-Encrypted: i=1; AJvYcCW2Ja3ZmWHrQXHZcQ3+lvO0cTdGPfWPheNwprTZBo6kMSCKy1tcchfnk00F8K9Y33wov/sFz0tMYX12WEI=@vger.kernel.org, AJvYcCWaLXOgRShDTShd4474YBm8XwDC2uFd7KG8ri7euKzk4nMSHg/25kUwIbRtBY8HHOgs6MVQc5GK5ZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFsaRBdWIIf+pbnAkJsSkJlPI8ZussPwX/XVVVWGTv66paaCZ+
	Qnz/KgjfQwdIgIGmsf84K96W/0wrxK+GkqneZwW6BIAE1qMrej+fG9M2
X-Gm-Gg: ASbGncvyCaW/VZSsKZW2QN8rlOGCUaND80WJG9lb1vUyd2yATMDMRHrKIwWYQhkvMWM
	CUt1AM2jBS8GYKdXMgMz+jZF5HPK5W5TSXdNFbKoXXUXcSLut1Xf5HMj0PrxTx/cGRnxPDM3DmW
	nNhjZBsJHPQeYVNMIvtiWQ1KS3lSJXlIXv44DGLomfumlXlrbWa3OcYgCmXUL/MXrout0AP3qvt
	0Pfy+vJNHN07Injp7FJPVi6w+IdI37YCaDvvGZ1bOrlj0AXWAjrjGLZyVumoFOumufCgHYtBh6r
	6TpTclvrmj9OYetF3owvYH/pTU9/PkgO+W/IWb16tMGwMdxkpjrf+yYni7O0KOB3rgQDnkrSFtt
	OPUoviZZjaH8tFgW/i6LfOAjPtU2+HA9H
X-Google-Smtp-Source: AGHT+IFjsnS8sjk91bGluYQIOQF1ofRZQZ9BwTJ/cXao0DgbRFnoyp+4oSbDtzaL2lqb0cIZdN5Lwg==
X-Received: by 2002:a17:90b:280a:b0:32d:8eb1:4e26 with SMTP id 98e67ed59e1d1-32d8eb14e6amr2946278a91.30.1757334475210;
        Mon, 08 Sep 2025 05:27:55 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:6e8a:c590:dac:fd95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32b95d31976sm12822229a91.22.2025.09.08.05.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 05:27:54 -0700 (PDT)
Date: Mon, 8 Sep 2025 05:27:51 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Arnd Bergmann <arnd@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: mach-rsk: rsk7203: use static device properties for
 LEDs and GPIO buttons
Message-ID: <kqtaw37b6upcuorurnccs6gqvp2aj33afanxnqye7txkmr5be6@k2omfqynjscv>
References: <jwtdoptatzfo47mbpmmjwhhhjn4mbw6ekp4gtoopca7azbcelo@uvtz4w2ga5qn>
 <aJyKAQJUG7hmO2pT@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJyKAQJUG7hmO2pT@smile.fi.intel.com>

On Wed, Aug 13, 2025 at 03:50:09PM +0300, Andy Shevchenko wrote:
> On Mon, Aug 11, 2025 at 03:44:57PM -0700, Dmitry Torokhov wrote:
> > Convert the board to use static device properties instead of platform
> > data to describe LEDs and GPIO-connected buttons on the board, so
> > that support for platform data can be removed from gpio-keys and other
> > drivers, unifying their behavior.
> 
> ...
> 
> > --- a/arch/sh/boards/mach-rsk/devices-rsk7203.c
> > +++ b/arch/sh/boards/mach-rsk/devices-rsk7203.c
> 
> >  #include <linux/gpio.h>
> 
> Do we still need this one?

Yes, at least this one still uses gpio_request() for configuring some
GPIOs, so we need to keep it at least for now.

> 
> Ditto for the rest similar cases.

I'll review them to make sure they are still needed.

Thanks.

-- 
Dmitry
