Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76F83F1643
	for <linux-sh@vger.kernel.org>; Wed, 30 Sep 2026 07:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751956; cv=none; b=a67Pm0xJ2yrOHrJQn/QtAJRqG1Q8yx9Ku/5xjq0611RjxfIdD2HybCzOUmo7OD316JrVZXTCbfMvJBQLOrIndONqsbVem46nmGtX2cpOhNlGv6H84khv2Fyshi9t0mMJX5JfOI+soccR1NjvfLPyVxcbKDusO5cdrMSDGJgmYhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751956; c=relaxed/simple;
	bh=6x6zUfX3HAgCXeFMP5IQJ8hlZ04cJus+Y81jg3rYM3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LAHvF40otPZuYy505dkcau57htf/1SXLlk5Es81esnU621Y9043UyfxL6d4lQawj/ic9Lf8tP8VZNPwYSE9Bw43KOC5jZSY1fmFQh54pOXdMeWZonigr97eBZxaPpNOyb96C73GEc+RzdXa8XdLWbgfI6CcQcvJO2CvHQUcE7uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5d16918738cso1705434e0c.1
        for <linux-sh@vger.kernel.org>; Wed, 30 Sep 2026 00:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790751950; x=1791356750;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KRLyqaFR+2tvKEVGCS6TXPlesufaQZLklH2Mpn/Gp60=;
        b=PDwkCBuop+CqxShkPkcUbLocglFk07RwdZccpoSmlYTDInCErIXc0gxIBrpiKzMia9
         EfSC4FzZkJtqtO4a7DSoqI467GOQcgTLekJ5y2AOJE8QeSVxDYt+hPq2kOM9eB85IYuL
         Vh3+4GN/fEU7t8K4mJGthWasLiPwxEjHtYUvRNkN3U+JUTVCEoDsLgJWsb3F8rq24Fvp
         mp9JTQR0cOmelRFHlDCGISWqZ/f3qp3cfXuNJi0+iSaz1c7LnbJXNOmT+zmnVv7xzNjS
         pweBMfZWO6raKUUpdzsIH7L2hmJrs8zzqfUt5xO1+Miv2cQ43PD/yJLpAMgr5/C6xEBb
         IJxw==
X-Forwarded-Encrypted: i=1; AKwUvBwmobKwc6VOtl2pFr9YiggRMRpyS+lrguWHNPzWe5NzwIISibz9TfSd418CzLRPVmsmnG27z6pZgw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0mI4KcHV0LUxQrZenuoXVt2zuHToXaZMSyHLRXKS4kkW1TFwV
	H4E/VhEFTr+i+OBaZ6viDBQ40HSCBAOOpmW7bGfoEJRv5FTMyuRq8uL+XlLTomGL
X-Gm-Gg: AYBFou0DzIkf99v1dkT3ZW7eh2llK05DREQGVVGmhkBLzQuu/jQXFyVpuBj6kAjcrJE
	1MckO4n83iFZAcWBH9ZajlbgpjTT6mLsr5S3McgBIHCUG/no11GWuF6o6VjVzDc6J+JQP/IbpPn
	ny/obo93QtLK8tZrowyjzrl+SAvsMmC5LSWYZ3DsA8t24hgZ/ptXczrs955jkkkBCy+GPV6UV89
	0Wrt6B6sQ7Xl2o0RVP512zZAnzMvb+w7xGsrqbZF0Qibib/cPL+QCMZ4cgZdC9tit4gMU6CzgQ4
	vFI5XYaAQi9oMBFb7GmEbYg8P+SuPqWwGXTqzINm3bhOEZAiRkkdfzq7MA2QVNvsLJTdunS0imv
	eYULABCQ2ot7VMwrOZ3BbKd9aTBptjYVJ+w1tustDdSCCnSFoYX2m33deKvJAg1m+hWdl9RoUNE
	odF5TllGB35kRi8PxFE5Pq8J/BU6slU09iUJZPzcZrb69Q3YZF8kYRo1TnNOxX0n0eTXuWuVGy2
	C36mmTbL/KX3oWrGYb4+d4vDAN8x6SeRcPtzdX0DBqdV+o=
X-Received: by 2002:a05:6123:4cc:20b0:5cf:3c9d:47a0 with SMTP id 71dfb90a1353d-5d67b75471emr43979e0c.16.1790751950103;
        Wed, 30 Sep 2026 00:05:50 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5d614d6f9b1sm880994e0c.18.2026.09.30.00.05.48
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 00:05:49 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-78fb1fb9508so1182856137.1
        for <linux-sh@vger.kernel.org>; Wed, 30 Sep 2026 00:05:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxoTszLbPe4nqHn1qj9bCTfkOyFxcKhh/s0c6DteOCE9mUWbguHZCZRa+FqComuSs0Hn2gLCZIjKw==@vger.kernel.org
X-Received: by 2002:a05:6102:6112:10b0:7ab:9152:1c6e with SMTP id
 ada2fe7eead31-7be733a556emr39198137.27.1790751948220; Wed, 30 Sep 2026
 00:05:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929-rsk7203-properties-v3-0-02f84aeb8e47@gmail.com> <20260929-rsk7203-properties-v3-1-02f84aeb8e47@gmail.com>
In-Reply-To: <20260929-rsk7203-properties-v3-1-02f84aeb8e47@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 30 Sep 2026 09:05:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVpevoQLHepf06K1=YLRr+BUF9s3W_zaQkO24qiY2_DOg@mail.gmail.com>
X-Gm-Features: AclHuK9T_GF3rRYO4h8sYrJYvPsih0XtUnox4vMWY5UxSoWqqC_FxwtdTdbQ_M0
Message-ID: <CAMuHMdVpevoQLHepf06K1=YLRr+BUF9s3W_zaQkO24qiY2_DOg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] pinctrl: renesas: gpio: isolate function gpiochip
 from parent fwnode
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@kernel.org>, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Sept 2026 at 06:58, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> The sh-pfc driver registers two separate gpiochip instances: one for
> real GPIOs and another for function GPIOs. Since both share the same
> parent platform device, gpiolib's fallback logic causes both chips to
> share the same firmware node (fwnode).
>
> This causes ambiguity when using software nodes to describe GPIOs, as
> gpiolib may apply hogs meant for one chip to the other if they share the
> same node.
>
> Explicitly set gc->fwnode to ERR_PTR(-ENODEV) for the function GPIO
> chip. This satisfies gpiolib's check for an existing fwnode and prevents
> it from falling back to the parent device's node, while ensuring that no
> actual properties or hogs are found on the function chip unless
> explicitly assigned later.
>
> Assisted-by: LLM
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> --- a/drivers/pinctrl/renesas/gpio.c
> +++ b/drivers/pinctrl/renesas/gpio.c
> @@ -278,6 +278,12 @@ static int gpio_function_setup(struct sh_pfc_chip *chip)

As this function is only used on SH:
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
