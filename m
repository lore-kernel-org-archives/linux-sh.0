Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6B35231
	for <linux-sh@vger.kernel.org>; Sat, 30 Mar 2024 02:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711764371; cv=none; b=K1TZS0J7Jqx2UnmXcWZ2jXYKkbIavTnsTwNHopF+Q/qtS9rQMoZpb4tLhJuURDdceJ7ODDdgAqb+ib6cnD0WKiaANgYqH2qXQ5la8FGKQ9c0uc6jENj+vyPA9Pk1K6akM9P1gEXzbOSoNTkiQRl/Bnfl46amN9g5tXH8oSMzdUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711764371; c=relaxed/simple;
	bh=t0Hz0IPe/fb7iYcCk0H6dJUvRpizatFmMMLfnMLxuG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R62nG30BLP1PrJxvfEBicXPJf83WsW3JX30Dn7cR1Km2qUOeTFH1A9OeKwX3ehL3tajpkgKIQrv00iiaKXEUQ8ZTcVtnoRCxNHyDBAHeJiifuG9o7dVG3vIsUMYJiqcJ8JWTrWTOFRqqWxR/TPWIm6MF50oOJXKqYZNJHU1/h/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YwcfqojT; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YwcfqojT"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e6a9e2e2b6so1309820a34.1
        for <linux-sh@vger.kernel.org>; Fri, 29 Mar 2024 19:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711764369; x=1712369169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OZoxhsymi+AEBAv8CEqRs1EG6a56Ts64GeVC5M6dE6M=;
        b=YwcfqojTBmq/j10fo1+5GhvVHns3eg2r44YjY9moRlsTTliqCske+a48shWkooaHTz
         i11c+nQ+d7qNyBUyRLiKl8xUrWB6+KwT0UueYxDq5kW8ksdJ/eIvT47RE5B4T7qJk77Y
         PcILGqYrb44B6nkLfpJeABEYWM3NDSCWn8tTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711764369; x=1712369169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZoxhsymi+AEBAv8CEqRs1EG6a56Ts64GeVC5M6dE6M=;
        b=Q1V+XWGIp8anK4WSYwvKTIYzXXvuzsKOnj/saSoHMReu5Sfko5sfgthhkTb6n5rnm2
         Zs2C/0l4Apd28UqmuS4Ic4QdIb+ZV2TEqBUHzlm1y1pltazNwDW9mMyavQ3VI1O3ehD1
         08FZcUqUF8i7IUIV4n8t7LyLDeVeb/6DwCVgPhx4g8+XzlD5xQ1bRCrZAaSwEYMELU3W
         lZK1SvmYS0F1AhgfJIvaBC79wUCcDocSSCPHGpXeg2doK5sIBzAzdwX1o4aMIBl5dLhc
         Hrv/9BGwlrCab9GaHWRzoF9thUOmBu8qyLUSRQKl1xaDxCd8sOPkV7y2hPGuYN/SmTWN
         aLrg==
X-Forwarded-Encrypted: i=1; AJvYcCXUJ8DSe4vrl+huFCMd54BBeN2ztdAXzXgYORZdWOWi5IO6nyR1sVV+H0FFKEuaH/LnrWfHfykLMIZWXZJKAknKZ/aDl1h8Wss=
X-Gm-Message-State: AOJu0YzfbPbs3A+4DXwtpBoIysrqK+KbJwyrOtFjaQvzFeg6KiF6nlK1
	wGeS+9jgxxCIl5o6HeMFfu03G1zb3Dp4jdwI8739km0KPr90z/M/Q5xSCosMGg==
X-Google-Smtp-Source: AGHT+IHwHlTfLV9GfVQAhEexD8rGmEIWClX4bK7Ct2vKWmplx2znlAy02xAfUSs94N3Wc3qoALt16Q==
X-Received: by 2002:a05:6358:5409:b0:183:4d1d:dcaa with SMTP id u9-20020a056358540900b001834d1ddcaamr4207104rwe.3.1711764369017;
        Fri, 29 Mar 2024 19:06:09 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o11-20020a17090ac70b00b0029bc9c34a39sm5670564pjt.50.2024.03.29.19.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 19:06:08 -0700 (PDT)
Date: Fri, 29 Mar 2024 19:06:07 -0700
From: Kees Cook <keescook@chromium.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <n.schier@avm.de>, linux-sh@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.8 75/98] sh: Fix build with CONFIG_UBSAN=y
Message-ID: <202403291905.7749C8A8@keescook>
References: <20240329123919.3087149-1-sashal@kernel.org>
 <20240329123919.3087149-75-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329123919.3087149-75-sashal@kernel.org>

On Fri, Mar 29, 2024 at 08:37:46AM -0400, Sasha Levin wrote:
> From: Kees Cook <keescook@chromium.org>
> 
> [ Upstream commit e36b70fb8c707a0688960184380bc151390d671b ]
> 
> The early boot stub for sh had UBSan instrumentation present where it is
> not supported. Disable it for this part of the build.
> 
>   sh4-linux-ld: arch/sh/boot/compressed/misc.o: in function `zlib_inflate_table':
>   misc.c:(.text+0x670): undefined reference to `__ubsan_handle_shift_out_of_bounds'
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401310416.s8HLiLnC-lkp@intel.com/
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nicolas Schier <n.schier@avm.de>
> Cc:  <linux-sh@vger.kernel.org>
> Link: https://lore.kernel.org/r/20240130232717.work.088-kees@kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Same as the other:

This is harmless to backport, but doesn't do anything. (The UBSAN
changes needing this are only in Linus's tree.)

-Kees

-- 
Kees Cook
