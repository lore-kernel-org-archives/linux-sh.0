Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E04A386C36
	for <linux-sh@vger.kernel.org>; Mon,  6 Jul 2026 18:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783361346; cv=none; b=Twj2ehm/rTzhfZXuNYSgXnlyKWC+F1T5/sC+rHsIDaEryc3WDELetk+//4rSTENSEytqc8d3bsN2ybH8OxU1+dc+P037cm9ElOsujI6zNsgUMdQ+IiIQ1bZ2Jxnh2cpA3N82Hp/HKxoH2kZgOgukajM4ml9rMgaAQzu6HukNkG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783361346; c=relaxed/simple;
	bh=hIJpKmWn3KefUAGdo0LDPdlAvhZwYVBzXAeeKjQ1xm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tftJLfk1O9z9snQfJzDwmonDw2H0se/+Oo4QUyHTBRtzNsyeqmHX8obB8/5QqN2ql9WcOit31LXeOODjKWMoZsIxlAxRoiOgn+Wn25jAOrjE3p7y2XpD2EB6X1yrkb1Gp2hYj3R+ETxw6IxEdUq0eDr+xTx6HEO3tQAUds/BsA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfO4Oqrm; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfO4Oqrm"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493c486f012so14275025e9.3
        for <linux-sh@vger.kernel.org>; Mon, 06 Jul 2026 11:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783361343; x=1783966143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cPaGqcrIwUHb7Vzhi3ZnBUWMwxvshiDblLgHxtklATA=;
        b=hfO4OqrmKcnPZprwHAXc/xN0sN74VO5aLcIFqwlU8naay4MmpD/fcegRfS419sDOvm
         HmPR3aa1NQ4jSyKwWRP/YhfC1Rk5quGkf3OEtBgoBREJpeKHNLzomqmhUAchSSMfAfYg
         6U6zuTTNJvttHUncin4jqJcMpWR5qhqtKDR24HZbiyqFyC2fZ24TGKSGFjZ4245u6EOM
         R1bNqitqDJlc0SNjBRd7RtJnyyl9W+FeddWKvbhK2JlJy6o0voMwQDU0z2zllk3kzDvg
         ITJlCXa4eznXSj6/Ro1B5gmfYSHRYbhUJYvPjETd+qZAOERG98CcgqE88NMJZsMSVj1O
         a/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783361343; x=1783966143;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cPaGqcrIwUHb7Vzhi3ZnBUWMwxvshiDblLgHxtklATA=;
        b=MYUxM1dFKt8Cr2fES/6TSmvunzeqDFUN4f13hhPavb4Xjbcr43ih44rNtSWTTaRoKZ
         OPEE3EceLoNRCvUkFiRZ0Qy5zrpSS2kC7/KTG7i0JMPAk/MTbWPe0SYekh40P/sZQZMb
         zkjAsWKEMoe1qX8fKZSiUSGMzVfAk/reqbw+zeakcfS2V21GEJuI0JP0Wf2og9iG2cfv
         RbHr023dUzXPkH/3Zy+TwzLSr8orxWVeX+FYoKxJJo2JopsZZRL+xE+6A2FqKKt67Fpn
         G6JmaLVllWQSfMS4zTQzBarC+S82DxiALsignERPBjfLfIIehnE9ETEihQvCkdkDOix8
         YVsQ==
X-Forwarded-Encrypted: i=1; AHgh+RrnMx4p7NDQ6R8ARQRzXj8DNqkCFl5KT43y+ufZnXkz9fvmD5CzXIXkqaTTW4POcZDMk57BElqM0g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv6o/vlLZ7aEDLb6pvZx/GJ+fnlQAvzDFuonUnE0ismJyA+kwA
	phi+2VB5CCa4bGz+kErrkzh+ceLOVbKWE6yhI4a26Qg5T1V/DSREgIQ=
X-Gm-Gg: AfdE7ck68B8IZBFYUzXAAbcNG+45EYqUtGcE42CccFFJTvKbEkOMbUH/AVj3p6e/YyU
	OTHasxEsgXEY/0AE1b3W0LPv5pl3/1fbYV4SCHWFkWkbayOlGsWzFKbb5KZEAtK+VsCv/qnbGxf
	eNnaIITxNMrk6PxAo6ecZEOHKKu/tvVZpy5hYikKsBR6Yd61qXwcdHGkngiIeh7uTn/47cJkTlZ
	8ex7vdEmnPUIelBpJFSfabiB/VCRe7eVe9zz6bF3Hy4JNU5h7997z0K8uzz5mScZ8lqZCvTrirb
	wZIjr+FvZxfjVL9Jf1WgF/WLoXYb2e5GOJH9vAVs4QS3mGCBF6DyEPeWdzdIFuZT2IBNU5NmWfv
	l6Y2wc8oaQ92cXfXvb7GHoLsclb3pUenaY0jYCZIfQGlcCIT3Gh8gd0W80HMHE0NRqaYdwq7Y0Y
	FpSszCgb7vGI57T0gX2C1BQKGZSzt3Rtt8aI2T5h7NrYapKLOTuZR+TmT4w2LBmUtHtA==
X-Received: by 2002:a05:600c:4585:b0:493:bc4a:fb55 with SMTP id 5b1f17b1804b1-493df09e3cbmr20223435e9.38.1783361342554;
        Mon, 06 Jul 2026 11:09:02 -0700 (PDT)
Received: from lithos ([2a02:810d:4a94:b300:2d45:3978:fa0d:bf54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e01c00afsm1353555e9.4.2026.07.06.11.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 11:09:02 -0700 (PDT)
Date: Mon, 6 Jul 2026 20:08:56 +0200
From: Florian Fuchs <fuchsfl@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Adrian McMenamin <adrianmcmenamin@gmail.com>,
	linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>,
	linux-input@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-sh@vger.kernel.org
Subject: Re: [PATCH 02/26] Input: maple_keyb - fix key press detection
Message-ID: <akvvOA972XsT9Ifo@lithos>
References: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
 <20260703-b4-maple-cleanup-v1-2-41e424964da5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703-b4-maple-cleanup-v1-2-41e424964da5@gmail.com>

Hi Dmitry,

On 03 Jul 22:57, Dmitry Torokhov wrote:
> The key press detection logic was using ptr instead of !ptr (where ptr is
> the result of memchr searching for the new key in the old keys).
> 
> If ptr is not NULL, it means the key was already pressed in the previous
> report, so it is not a new press. If ptr is NULL, it means the key was
> not pressed before, so it is a new press.
> 
> Using ptr instead of !ptr caused new presses to be ignored in the first
> poll cycle (only reported in the second cycle if still held, because
> then it was in 'old'), and caused redundant press events to be sent
> on every subsequent poll while the key was held.
> 
> Fix this by using !ptr for press detection, matching the release
> detection logic.
> 
> Fixes: b11d2127c489 ("Input: add support for SEGA Dreamcast keyboard")
> Assisted-by: Antigravity:gemini-3.5-flash
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/keyboard/maple_keyb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/maple_keyb.c b/drivers/input/keyboard/maple_keyb.c
> index 3d5538dd4f23..623d7951405b 100644
> --- a/drivers/input/keyboard/maple_keyb.c
> +++ b/drivers/input/keyboard/maple_keyb.c
> @@ -107,7 +107,7 @@ static void dc_scan_kbd(struct dc_kbd *kbd)
>  		}
>  		ptr = memchr(kbd->old + 2, kbd->new[i], 6);
>  		code = kbd->new[i];
> -		if (code > 3 && ptr) {
> +		if (code > 3 && !ptr) {
>  			keycode = kbd->keycode[code];
>  			if (keycode) {
>  				input_event(dev, EV_MSC, MSC_SCAN, code);
> 
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog
> 

For patches 1-17, 21, 22, 24, 25 you can add:
Tested-by: Florian Fuchs <fuchsfl@gmail.com>

I applied the patches without the mutex-related ones, and dropped
the 18, 19 (the mutex ones) and the depending 20, 23, 26 (as didn't
apply then).

The mouse, keyboard, controller is still detected and working like
expected. All buttons, sticks, wheel and knobs work. Patch 2 seems
indeed to make the keyboard feel more reliable while typing.

Thank you,
Regards
Florian
