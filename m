Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE1B2931FB
	for <linux-sh@vger.kernel.org>; Mon,  5 Oct 2026 04:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791174351; cv=none; b=gHLUTcuFrt5esDfWb9zhwnr9mNq/y4KNr848rbGB/qXL+bM0mxlO0T5nr3HJ8ENj61rLXR9l1kGaS2r7CwQn2w7AHB+W7fMNVtMypEdput2Xt2cxYOzCcLnCFqZFBvY4Sh9iYWedjxqMR00lfcscN0J53Nqjdx/b/hXYTfvcCqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791174351; c=relaxed/simple;
	bh=fPZioazYkPzjSMjHIymVpmo3SG9e0aMYWmg3rnmT1X4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mH7fkGjOPFoCgCF+JZj7X+gHn79CbKpSR872jELod1d3E9sr7s1wJPIS2gXxnMBiA7mx4O1K7omvEdcYQ/6XnkqlL1Qf6NGBF3Fq7FNqcnBY1XnfpDtFCZO7e0PQL15ZvWAJnkSUGm1QDV+ppZmiGeF2dg3sOu+2HfiEKvY6MX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfGSFTxp; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfGSFTxp"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a1728d8dfcso3218485e9.1
        for <linux-sh@vger.kernel.org>; Sun, 04 Oct 2026 21:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791174348; x=1791779148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=961ay0gWzbSVe8vqtS0Eg+hS7Wb99URak0c/SwD/AlI=;
        b=TfGSFTxpjxuFoUCBe1JXlOMkq5/qSH1UgON8qN8GHPWG0CY6UOHOGzYWo0B+w6BYvp
         olxZ9GQFhFvsfd8v6WgAjUhGDaeTcmPv1jCV4+FhS7QPUk8mkUFopdgtBDJmlUSxdvGJ
         jylhTYPSv0KzZY3r7NWZYIX3EgVvUALEvkkweRvtrl97yvskyT2yTr4PVSv58amIXqPa
         0H+qAMJG51O/MFy+JyGs94fb8YEpN7lWu/Am2K1HQFepvDUtOSdC9xir4FejVO1CTcv7
         5pSjwh/1eleBsJkgB8Wsa/KpsFniOOTd9ujyWtsGoNh4es8wY+brHF1PyE53+Z0ATP8e
         6+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791174348; x=1791779148;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=961ay0gWzbSVe8vqtS0Eg+hS7Wb99URak0c/SwD/AlI=;
        b=NN6kLN3V+SJI0oHelOiwZwMxXjQzgKu3sSQaJix78bPpzUSmX9mkwbbyl0yLC0+Dn0
         ZFmGqnejP+PnYv2EOwyLvMeYgvsJ6E7BxAZdosaKmauv7SdakHuDCAv/m50rjBA4l9LK
         Eup5A6CvCko8LnCIqcayuBPjC4q/9BEtkWT6HG9QJr3WijkeaSd6qXx9AXX18nicTn/b
         SFwXOsJdawAuzGBDTi+1k2C8EsyQvl4z1IqqhwRf1HRh/7D/Y3/mYp0Zp59WWWxzyF0A
         FTf1cxD7U3fT9ikZCJrodFK2gESIaZwZlxfOu50R8/OwHUIVsi1GBIOSJUKwmr6tV1pH
         +7TQ==
X-Forwarded-Encrypted: i=1; AKwUvBy2TpvpZ1dP30lyASasrtRItzqHnlbfkNH2JWmxEDD8TzpxHMY6xFBIQdFO4bipw7jNhvcQeXsLtw==@vger.kernel.org
X-Gm-Message-State: AFuF++lDoxti23WjjE8NjVHJizO0nH5SrdueJLLC6JyKivbq8JRYQyXW
	XHxDjeH1rnuEHTizHQdetL4x1IMoQy/ACp8wDMWR2Gp4pjVmqxlu8OyH
X-Gm-Gg: AYBFou0bNoEa7BDxQWnBGPFcQvnLp/mcZP/LzPD3Zb46GMCAci2kM0t05ObzoUm2Pok
	FWrnDKdKNUOrbeHnM2Zji1lz5m85S7f3dhuhWsOXhXHbNnAwajV7NOHOBibQFOleQMn3UyZzoSj
	dNT5IPe8o1IhNKDV9B8PEKiln2DNjEzKJ5gYVH9XE16HmxychLDcM1GrvKQVkIlWZ8M6P6fjJWI
	uq/E12ASeRIsfpx52GNQloQgukGDzhdtwffiHM83wa5lK6NvZScqq6XNUVKZdB9cy5V7BJTLOTI
	ld4/zRPeZvgxbCagxJa2BsF9z/EVBucscGojK0M3VgQydpFwW41oQTxg32pVszrtCmHrrBv9ADd
	b/uMtBjFScEJJ2bGSdTsRbLtTjcJzJrMtFcB4OCkOkbFOrXV493lOoQZf84IBUiHhWvu2ucm8wD
	Zi15HzBAy1WwE2Dv6RCpHOpSAbePisIP2Ip+uU6Y3IMAUUHT8J7DkV2MzdX7ZvsENEXxIGvIzIZ
	3Slaace/PCHbtFmmrrmlMyNT1zaCwzoqXEOnb7xQcc31N0vFZQ2zVW0poO9uv86G8yAj5qkcSex
	ZfP+r9srA/iypAVFO1zptVgpsXQVMgq9/CwZ9N0xTntIVvQvIXN+cI5mrmUMM5vWAQ==
X-Received: by 2002:a05:600c:b90:b0:4a1:62b8:9aa1 with SMTP id 5b1f17b1804b1-4a1680b5402mr109857695e9.2.1791174348517;
        Sun, 04 Oct 2026 21:25:48 -0700 (PDT)
Received: from MBP-von-Karl (dynamic-2a02-3100-b305-2001-39fa-3d24-821a-4eae.310.pool.telefonica.de. [2a02:3100:b305:2001:39fa:3d24:821a:4eae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c6227fa65sm869179f8f.16.2026.10.04.21.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 21:25:47 -0700 (PDT)
Date: Mon, 5 Oct 2026 06:25:46 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-usb@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: r8a66597-hcd: fix buffer overflow on odd-length
 FIFO reads
Message-ID: <asMl-yIKQoAbpwzA@gmail.com>
References: <20261002213225.27834-1-kmehltretter@gmail.com>
 <CAMuHMdWEYkBra+3G_+-TfT23BAWPxG5o2KHqGRuHcdp8x0Vskg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWEYkBra+3G_+-TfT23BAWPxG5o2KHqGRuHcdp8x0Vskg@mail.gmail.com>

Hi Geert,

On Sat, Oct 03, 2026 at 02:42:48PM +0100, Geert Uytterhoeven wrote:
> > +               count = len / 2;
> > +               ioread16_rep(fifoaddr, buf, count);
> 
> Or just:
> 
>     ioread16_rep(fifoaddr, buf, len / 2);
> 
> > +
> > +               if (len & 0x00000001) {
> 
> "len & 1"?
> 

Thanks for suggesting that! I will use len / 2 and len & 1, and a
plain byte store instead of the memcpy().

> 
> Seriously: a *_rep() function for a single iteration?
> 

I'd like to keep this one. ioread16_rep() does not byte swap.
ioread16() goes through readw(), which swaps on big endian on most
architectures.

The words before the last one are read with ioread16_rep(), so reading
the last word the same way puts its first FIFO byte first in memory on
every architecture.

Thanks,
Karl
