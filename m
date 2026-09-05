Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC78367B8E
	for <linux-sh@vger.kernel.org>; Sat,  5 Sep 2026 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788621093; cv=none; b=fsWsB6vlQilTOI7JSG3WTimzyiAqb8iDKLK6cl9qPsqDw1u8PzOYdM7wJv61DrEM6plrIsrSF2/K/7F0+DJ7wOyifjUzIFq8EaSam/jg3hTVnRK0UAPfzeeWP4tMuF3BcU/uRsCSZvLn41DkawI4XPzStAe3zecWMRx6aFJAaLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788621093; c=relaxed/simple;
	bh=GDT7UUknQtT8nekPk6+R0kclksMn0AmE7I9pwNzhWvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTGjCyx4yFHiaaQmtv9VA3xFHO/YoIcs7qPUOxC2aspXgrqRtnCwmIxq8pz0nIFY1VAeK4kp7D6P51QnzrcEC+iVL7LoFds/SNcsCsinjAhsTNZuzwT+AWeJdTzuyfkt7vE+4pb0dL87nj49Z1baIst32avY7klVhElC6NBEmj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oOQPdaCT; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOQPdaCT"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49a97714f5dso17519365e9.0
        for <linux-sh@vger.kernel.org>; Sat, 05 Sep 2026 08:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788621083; x=1789225883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dfnLiQBme8OUrxx+ux5JJjw3nZOjEeBz5dEmyrciEo4=;
        b=oOQPdaCTbghzJnChorBOPHVjnA4W+71P7ks3Cdkt01TvOfZonociP13zy2EtD2uF+M
         NBUXofFG5NEnArqLsRGtMl5ujujZ6n7W+i+LC3dJ1Xiy7Rk5exc75dokDEFicZiBnfg3
         wl8WtdGQ53apUcHXYFK2c/DnUzT3rCZAxNHr9tVpfTdWNBHXHw8exzBwzYMx5+0A4zgP
         JN639nyBhf9Hbc5kAtwpijfTxowea4+THfGOD//XMU4V/Zydt917b7vOmCOb+MQn/ADQ
         +TmHiA1V77GpPNDXy/iLmqasz4O5C1aYr7VUG3Jh2aXyYoOaCDFCrY97MVvr3wN3BKjc
         Bl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788621083; x=1789225883;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dfnLiQBme8OUrxx+ux5JJjw3nZOjEeBz5dEmyrciEo4=;
        b=qIiUIhccVzxjmJJDQbzp0yRfZo9qqdVBmvwRSKVmzS2S0BpmTnYKB9hQkqKFVkVAp/
         jJgn8Jd85aBbn0/zbTst+b91PRERyMyfzVirjRUFDipGh0e8XGcHcn0BpSerEI1FaKKP
         lpMxxOamsVt3+z0h4h8h/ucHX1UHksbMbqLmnf95tn2APPuP0clmx3asSgPZY7pankA2
         2LJoWx060Ri6H34sD8nL+a1YRsKE2IOBmoXXyZnFBhEAUzyfTCU7CAk7YKyw+DEqrUnl
         aQERJnKG/6MPbTkK06H3vIiI8aBNdviOgHGpD5h79faCOEUreHViBS1QSnQhyfbUHHuH
         Iwxg==
X-Gm-Message-State: AFuF++lStiAmDANAzTFhKZAcZIzZgaVi8FWTlMpLGO1/b57Wxd/jV4tK
	v2HQ6j5vKHJC9B4Qn2VntWNIoywZ0tYuLODwaVjOs7rso/Oq/xsX4j9P
X-Gm-Gg: AYBFou0y/Ll0q7USu5TMgsaMqIJvpeDy8VF2mBDv1KmsKvu8RpeHzmRodSx9PHKU7Up
	H34071G+JGYpGQM78W8BT5tUTiTPrvmMHB3ExBI6FUHslFtMKZPcyfjn920zwdvL2DXk2YMLEE/
	T0eSJTJFFfJvcttrdc3sObw+xoA3RG12im2colLAlZvT6BD5XxX2YVzCYEZsD9MDiJhDlWZPWW5
	WpZ3sQetiDJsAuELEqHy5XIZ7NXG/ZESUIMHzovT9qRcQ2cctW98DywIYqb6CS99c7KqA8EmsNX
	AwNSAIkcfGrBqmzrKSmLxASDiOFiwqTLcEc53oAmm3he8OlbwKu3sCSpkXQx5EpcCrCpsHOJ9Fb
	4htmMpfKo89dIbSWmIpLE1EN+hYb6TZcFgvl6d6dU2XsJRyVoMphK629f5YjYxngolBsdz3q7N2
	LzT52SvcjMO0bN8QggZ7ZDYwdFl8KUtJ90x1KRGiMSzlrIz/ig+Pjk9bIkwOqSHJjznkzwvrDfj
	3eBgC/kbkW3vQ4d+NufX8KaKpF5T81I1uRzj2yqopVxiWqPklKNjKck099FqFWqO6w+P5tmYetU
	kU0piR9BesYAC8JlrLq7LLTqguIjYbC7zjSeu5R/GIDQIOrIloix2Uzlua0igfxv
X-Received: by 2002:a05:600c:4713:b0:49c:fa20:cc00 with SMTP id 5b1f17b1804b1-49cfa20cd4dmr111736585e9.23.1788621083285;
        Sat, 05 Sep 2026 08:11:23 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858d312ca0sm12388929f8f.4.2026.09.05.08.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 08:11:22 -0700 (PDT)
Date: Sat, 5 Sep 2026 17:11:21 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/2] sh: Drop the leftovers of the removed
 CONFIG_USB_OHCI_SH
Message-ID: <apww9VaYXL1kS713@gmail.com>
References: <20260905065340.24932-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905065340.24932-1-kmehltretter@gmail.com>

On Sat, Sep 05, 2026 at 08:53:38AM +0100, Karl Mehltretter wrote:
> Commit 4f6dfc2136fb ("usb: remove the dead USB_OHCI_SH option") removed
> the symbol, but four SH board entries still select it and one defconfig
> still sets it. Kconfig silently ignores both, so nothing changes in any
> configuration; the patches only remove the dead lines. Parsed with
> make ARCH=sh allnoconfig and olddefconfig on sh7757lcr_defconfig.
> 
> Karl Mehltretter (2):
>   sh: Drop the selects of the removed CONFIG_USB_OHCI_SH symbol
>   sh: configs: Drop CONFIG_USB_OHCI_SH from sh7757lcr_defconfig
> 
>  arch/sh/Kconfig                     | 4 ----
>  arch/sh/configs/sh7757lcr_defconfig | 1 -
>  2 files changed, 5 deletions(-)
> 
Consider this series dropped, superseded by:

https://lore.kernel.org/r/20260905145225.88518-1-kmehltretter@gmail.com/

Karl
