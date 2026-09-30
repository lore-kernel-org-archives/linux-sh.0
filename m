Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A064582D3
	for <linux-sh@vger.kernel.org>; Wed, 30 Sep 2026 07:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751992; cv=none; b=AvPKjWeTigOB+2YLT9Ku5XAPqqYqA7fMMACtDbHrK7MU4E22buVLUjQYcWM/DL9ozZb20Ts+rdIYAHFJLV3QnpBNsT+tNrX4KUsahQi0lCV6CHjXsUJkiDvmcXqBSZLX8MF7pGc87wgjIPwCRxzITBZdr0jO4hFZXRsCnTVaFF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751992; c=relaxed/simple;
	bh=wch8nfNOZ3yz6W478LNk2PKlIPZ2op/sL1/5uWaDjYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LnWn5zA8oYgEMweVi42shkRRNQjY7dGNsZAefgAvr6V5iVnaa2fwrdHKE2hieOfo0IQvQl0l8teZuIXHQrzRYLQJeRE/bUieZf5DxHj+9am+Tlbws8wYB8NxzNwba75gk+3lJ7zR967OXTCUIMDC21CPp2YjL8ONgbONa3fJ7/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f43.google.com with SMTP id ada2fe7eead31-7b42996ae72so742509137.0
        for <linux-sh@vger.kernel.org>; Wed, 30 Sep 2026 00:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790751986; x=1791356786;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XVZnJOotlaaUATBE8LN5Zb2VdzLY7iJmIqLqFopSb08=;
        b=lfLb0h4vshThPlZg0xRgurwO1M5wGn/XAaKJKdLYVzON3u5XLLKmeezaNZQZ84LLm7
         Jru8yUwMlmuBlN3O13agj24qJAAv7MnJJY/KXWe7SZMz0sz2p1+wpV0XUVv0JxvQAdjI
         2pyUW18zRWPlueK0RkhqEZS/Fy8Q4IC/goIAR6FlN9AEUaQECbFcTdWLEnRsrv1WuJUt
         LobDAn7si/3jIEdkoadpe0GSyOH9ajGz+4RbrN02bIIE5uYjs37jY8CAM8lit+NDjsev
         CBJ67fi2Th0HlOq8mdP+j57ghwI3mNEtZ/mfgrJMGSyVKqRvDV3Pk5XFtas4h0zPhB2f
         9LHQ==
X-Forwarded-Encrypted: i=1; AKwUvBwnuvBR2AAqhikAtYJOwJ0JrLgIHfaH+dWZ9VqCnTaFoHQWCk9HC7ehqxr5eWgxnrD9llsPPqMSOg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLePY4PGF+KELUh3Eb9eLSAYHWw6eAY8pFLdrJI8Sd+QtjQfqZa
	zKq33JG+HPqQDsoQ07dR386vRBJjeVNprExieti4aUceaZgqi8y+63uh93VF6GoF
X-Gm-Gg: AYBFou0PnSmpQDM+0+QZprHRvvQV3fujxVbXdgbQVlSQMdYFPtXK8MMEc+qudI/QI6a
	/FFw+/1o3ZwrrcC3q/P013QrZwF86q41vH5D7o5OZaMY06gCdu25O3xS6idr+CtDr2xVePVdJ3Y
	x7EtHFGgkOBdg2z5bpn/e+md6bhfsZWnuOK97TvF0CPvMK5WDYgMi19URmjoiZ2dB5Z8WTzdZhz
	wHjgpnVj3qa6CU6f8PxWFtiZv6DJi7/kTdU8ripzknRwlt17TNFGlhGakNzwy3zpbgYZyaFXK3F
	saHR4iFKqahx+EFs9G1S2pNFXw6Hn58XS+h4RJO7F6Oq87O3UcBcsUjDsH7xzSZwlQJdcv3eEPV
	VTHLy01xLlFla6+g3TjnQ10E8hHV3yGG2laLNDRgb+6iIi/5+HZipy6G0/FBhgqskpvhWTQV/Rr
	uBR7TVxOju+ytp8J2cdLdh8HTF7Aq4E8OGewAr760fxJ1nPvabaj7lrogB0YCohv3ahKzkRqBED
	CthbPsKWrPA2BknyQ95ONTMnshlqPSzxFiVDA==
X-Received: by 2002:a05:6102:6448:b0:7b5:b51:63cb with SMTP id ada2fe7eead31-7be724b88a2mr55500137.11.1790751986097;
        Wed, 30 Sep 2026 00:06:26 -0700 (PDT)
Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com. [74.125.226.204])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7be1413e108sm478261137.8.2026.09.30.00.06.24
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 00:06:25 -0700 (PDT)
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e7c72bfe9so1458524241.2
        for <linux-sh@vger.kernel.org>; Wed, 30 Sep 2026 00:06:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzb5BhkJ4T256jtvI2+qS0FBzl28j1ie3a0K9HcdPr4ll7YM4Bq5QMpJEvMI90yf5emeDdoWUBsMA==@vger.kernel.org
X-Received: by 2002:a05:6102:3e8d:b0:7a7:3485:33ea with SMTP id
 ada2fe7eead31-7be72ca2a93mr42702137.19.1790751984641; Wed, 30 Sep 2026
 00:06:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929-rsk7203-properties-v3-0-02f84aeb8e47@gmail.com> <20260929-rsk7203-properties-v3-4-02f84aeb8e47@gmail.com>
In-Reply-To: <20260929-rsk7203-properties-v3-4-02f84aeb8e47@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 30 Sep 2026 09:06:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXwVWhPhn=vH-FbDX41Hnshg7V6S+pg8kreOHpTgRWeHA@mail.gmail.com>
X-Gm-Features: AclHuK9VR6aoLpU0Amx9qCakt-f_1gjDC5BvwgyzYKux3uxlHlNiLggGev2T8tA
Message-ID: <CAMuHMdXwVWhPhn=vH-FbDX41Hnshg7V6S+pg8kreOHpTgRWeHA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] pinctrl: renesas: gpio: support software nodes for
 function GPIOs
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Arnd Bergmann <arnd@kernel.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Sept 2026 at 06:58, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> This patch extends the sh-pfc GPIO driver to support software-node-based
> configuration for the secondary 'function' GPIO chip.
>
> While the primary GPIO chip typically uses the firmware node attached to
> the parent platform device, the secondary chip should target a specific
> child node to avoid ambiguity when defining GPIO hogs or properties.
>
> Update gpio_function_setup() to look for a child node named 'functions',
> but only when the parent is a software node. This ensures the behavior
> is restricted to legacy platforms being migrated to software nodes.
>
> Assisted-by: LLM
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/pinctrl/renesas/gpio.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pinctrl/renesas/gpio.c b/drivers/pinctrl/renesas/gpio.c
> index 4e59dadb7364..b49a3e14da91 100644
> --- a/drivers/pinctrl/renesas/gpio.c
> +++ b/drivers/pinctrl/renesas/gpio.c
> @@ -271,18 +271,40 @@ static int gpio_function_request(struct gpio_chip *gc, unsigned offset)
>         return ret;
>  }
>
> +static void sh_pfc_fwnode_put(void *data)
> +{
> +       fwnode_handle_put(data);
> +}
> +
>  static int gpio_function_setup(struct sh_pfc_chip *chip)
>  {

As these function are only used on SH:
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
