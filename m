Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEDE36B076
	for <linux-sh@vger.kernel.org>; Thu, 21 May 2026 09:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779354875; cv=none; b=kIa0/M49v4JIFTXW3kyL15Z8HVAUUJrVjpO0BhN9pk+mq1p39zf2SeBwCg5X/pofS9wa0L1Oj4EcTMlCIJSmuXyg4Nyoi0mA2nusl8JHH9mqOacuxmJ51IgkAFXBxYid43P7fW3TZB+L7t7+GM3tmTJ5APKUjHsZPQmD7egNSJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779354875; c=relaxed/simple;
	bh=jNuoxjZvMo6Jgup5tnUJClP0fblgmtv3uErnOkOncoM=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+9zOUotu3v6VGTclNybJjjjEych8xD2KkECVjJ97tm62cgmsj4t18tpzCDKdCqrUBoRt2kqJ4GCzMvMBH6AZj3KsJzCfXsfVrUL+xLQPnfeHqMgPauXA17M4O0d0yweT+0rJsaHEa74kqcYEoIQXqjSQ+s01Zqe5Vrh6/t6Mtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLEdXnq4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLEdXnq4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2511F00A3C
	for <linux-sh@vger.kernel.org>; Thu, 21 May 2026 09:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779354874;
	bh=jNuoxjZvMo6Jgup5tnUJClP0fblgmtv3uErnOkOncoM=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=WLEdXnq4LDRPugD2bO0y7jP15932dsl0wpWEzrHK9+asoVQIKjkdvkJwK7eDdpw+4
	 9gF0yqHeQLcxxiv3BLmznHzy3QDiweMQsl67zZA28nwjS/ORK49XaFrf5OmVrr+z+5
	 azBY4KAri4Jek1mA8U4b02oGvACYCJ8D2PA9/EKJAem+IYPXcyIYiNqLZOMpe5z/Vs
	 5JTntsoHApwaTO2ge1XUb4COaO2cuNIEj5HzIDt7mwBF0/foWm5rlO6+4gt0xs8Ppf
	 KAgCmFKA96VX0tMyqGBJ1/SapbBAvmFao2c8T8ueDw8CCdu7zDLwn2+tJ6/MckoZeI
	 SdD+qSTUAs9MQ==
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1329fc4bf77so2887787c88.1
        for <linux-sh@vger.kernel.org>; Thu, 21 May 2026 02:14:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8zYB8Un1w0pSjSfVvTWSOb8zxSd6o0yd1ELPv6ZMFr0cvFB6KtC6A1QElhe3PaUYtO8vHJOTv07Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw586q8+gvs7Qp2lQSOrtoLB2Z85CDAdxyC7eFgjq77LiwCMsu6
	PQCzEPHKgq6KiS1KrDCpqFf4WLkxhf+SlcdAzs/LejzsIRKkt0DhNlieb7++4HGqJswwlSqKgkF
	lPM9a0AdSEuaErnNh0WWvloRAqTNS3JUVyRygaoKCmg==
X-Received: by 2002:a05:7022:f312:b0:12b:fc21:874d with SMTP id
 a92af1059eb24-13632d44123mr623001c88.19.1779354873386; Thu, 21 May 2026
 02:14:33 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 21 May 2026 09:14:27 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 21 May 2026 09:14:27 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260520-rsk7203-properties-v2-5-465f3308021b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520-rsk7203-properties-v2-0-465f3308021b@gmail.com> <20260520-rsk7203-properties-v2-5-465f3308021b@gmail.com>
Date: Thu, 21 May 2026 09:14:27 +0000
X-Gmail-Original-Message-ID: <CAMRc=MfFDeFqo2n44VLZEEFhFOzfKX0bdO3DR08uiNC8LBZLXw@mail.gmail.com>
X-Gm-Features: AVHnY4LoATEnodB_zt-b1si7q7FaQdB8dn4GF6c9ZIQaby5NHH8SRjLCl2kmz7M
Message-ID: <CAMRc=MfFDeFqo2n44VLZEEFhFOzfKX0bdO3DR08uiNC8LBZLXw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] sh: mach-rsk: rsk7203: convert pin configuration
 to using software nodes
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Arnd Bergmann <arnd@kernel.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 May 2026 07:13:21 +0200, Dmitry Torokhov
<dmitry.torokhov@gmail.com> said:
> Replace legacy gpio_request() calls used to configure function pins
> (SCIF0 TXD/RXD and LAN9118 IRQ) with software nodes describing GPIO
> hogs. These hogs are attached to the PFC gpiochip node, allowing the
> GPIO subsystem to automatically configure these pins when the driver is
> registered.
>
> Assisted-by: Gemini:gemini-3.1-pro
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
