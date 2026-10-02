Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBCB361DA7
	for <linux-sh@vger.kernel.org>; Fri,  2 Oct 2026 21:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790978300; cv=none; b=Y9W6z0aHmmIHJMDXgbI3Z1OJRmDLGY/1FjfpigU6wfeEXq2NS4yO7o/EX5dxscvtiFkuTvBWENwH2H7I/tYJNxjc0l8DOJH1Od7BkWenoxeZbfidNHkJsMgrncimUF52EkDg/i7BIVCbW5HkVseIt2VSREV9McxJLGDJPvKgqh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790978300; c=relaxed/simple;
	bh=IrlpGamxvY47LrJzjSi4FPT/Dc5GHOnfyc0578uNYcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exvCL0Ferw5CzA7M54G9mgadCSbkAYxjlWqc8froXObJV7cA7LOo945CbV6zbiXiULLrbw/eQBSKd+VFkurTY/hoaDkIZreeE2u9bNWv0f3em23D0IpvKlLpcXDLteAn4dn+7kVEKmmnUdMHNinL6w25EYztolZsguCdUwf4UJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtZHYnmM; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtZHYnmM"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b6so1929205e9.0
        for <linux-sh@vger.kernel.org>; Fri, 02 Oct 2026 14:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790978297; x=1791583097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GMnh9nYpaVJY0QctaXPIQ7WvaFNDN6p1P1QAh2BjACU=;
        b=PtZHYnmM6WZ1pQLz2rUO1gjTGyCycjkk84vv6MQozPEAIzVDfdWJEm/4WcRtPox9xi
         iTay/Bt59jI4qCTpqomgOYxphZACOdyDr8Igj/2W4iYQuixoT5HAX9uxJOaBiuYzwRkO
         clkKdMKRwyAiPo9RZ15w6FMo5QSOn04SdcicF/RpIwNUOQ4iDOPRBAZyKWKZtfMyylHD
         3NqcPLaGn0bvBuLiJJ6Tea9dWoD4QsgPrj1stl3QDv195oeNDjowjWEgoCg+EDlOCLur
         1nwfAH/Gzv2u9pO27K4D/yr1qT80UsaPuN3A5tTNFzEx8yYwT5AnH7bRXJkvDy+oNhoo
         QAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790978297; x=1791583097;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GMnh9nYpaVJY0QctaXPIQ7WvaFNDN6p1P1QAh2BjACU=;
        b=D4ZyKcWUTCEXVHQ1sGKVzhgvI+Mu7UjURT1ErVju8plN5m3rQMth8/QDe7vZ2XC8h3
         ao2dCyHdyV2lwsSrrB+cEvKaK/PBwlVyyr+GBURysStKqksPTdCtDrXxfZMo+KFT1jSl
         rjPYptbITeZH1czK9Ufi4BYF9c+Lvw7y1NGCRXFzgAt06XBC7fcT6kEAzGil9eLSe2DS
         PIg92sBUQSW7clyZxo4J+F2JoICth3cmiGeNg2SjtPRL8TD3/eUsHxzYeOoHW8xb7ZlD
         VXZqlYW/pYh15pAII5GZnlcCyxruBgbxXXv1oOpnMSC53tSXZwNh73Q8/NXyBDoE8lex
         KlVg==
X-Forwarded-Encrypted: i=1; AKwUvBwJD8MxSeCSe/KVMf5rzAlEK9IsN2pJUz0N5sBwVCEsUGnbh7FCiBOGsx16EQU+CBE1l9Z7ltCTOg==@vger.kernel.org
X-Gm-Message-State: AFuF++lk0Y5yOlZTLq9x9b9+i5mIp4ABJjPDHjodvhZ1byZ/8b6EWaC0
	ZA23jOBdWSe4MUcNoab8n/UY0OYusXlv1jwcWHeCDXDX50qK4Pu9vXCMPMPN0Ga4
X-Gm-Gg: AYBFou2Wa9LINYBcqNDbHLDmAJ7A9TUiEwRuSLz+ja2jr/XqBK24C4V+LEUu+5cN1Bo
	5Ealont0fNnCpjLfZmF3HaHt7DWcWifhCCX+BVhZav+IhKrWAGtDEtDWIxCIWHlA3g6/OWmvt5M
	VMT95OrAbhBnSkF3DyJRk1bC6bsK7raAX+SeeEVngy2/xTrzcRPT9U+l8/24BPU0ph2b1xGO+3q
	VKHdY9TFogfdZmCwrabkmdBFj2UX0Kmc9hoFOkkpxP9apoP+V/vFhKIGQLn8T9HsdXIJ48nrqya
	5sT0wh3Q2PEiYVUo/xNniqhMKLx//LR8DWe1vuBlYwH2/0lCb4ZqyHw5vvySxEoqFnooTzY2AIs
	grHI0uyE3usMnADmv5Lxq5I0bmJ82AaO17P9WId/ImgVdjg+YUhPXtB1JSl7e52quB6bvZgxnNK
	PJuuENZVw/yeiJxlPX66RUbrAS1DHaoCIIv9TT2Us8O/nQ8sxEZ/eW8B+Q+UbIDezEAez4gD9z7
	m6Gws3/lkgj2jMBLCwKfwJazcSyWZ3XNHgx8rW4wrQ1OWSv8RgW4TzDPUwap3Ed+sHsnL5KAbV7
	rxMh8XA2UsxIGPl0YemZW/RwRzUPldRhbPnB9qIxNLmmqeUdzL5LH21P5LD0MWwYyq++yLLGgkz
	2GKJU7C6MM+E=
X-Received: by 2002:a05:600c:138b:b0:49f:ce78:3562 with SMTP id 5b1f17b1804b1-4a02759b46fmr71998765e9.19.1790978296761;
        Fri, 02 Oct 2026 14:58:16 -0700 (PDT)
Received: from MacBook-Pro-von-Karl (dynamic-2a02-3100-af35-1901-81da-eee8-c2d0-ee3b.310.pool.telefonica.de. [2a02:3100:af35:1901:81da:eee8:c2d0:ee3b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280c6597sm120987985e9.9.2026.10.02.14.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 14:58:15 -0700 (PDT)
Date: Fri, 2 Oct 2026 23:58:14 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: intc: sort the prio and sense lists after filling
 them
Message-ID: <asAk-lpM0rBnQTT3@gmail.com>
References: <20260927191359.6144-1-kmehltretter@gmail.com>
 <3bd32eaf159db61ed1d423e1d52a869b3689c682.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bd32eaf159db61ed1d423e1d52a869b3689c682.camel@physik.fu-berlin.de>

On Fri, Oct 02, 2026 at 06:57:19AM +0100, John Paul Adrian Glaubitz wrote:
> I just booted the kernel with slub_debug=FZPU on my SH-7785LCR EVB and
> I'm getting the following "kmalloc Redzone overwritten" warning in both
> cases.
> 

Hi Adrian,

thanks for testing. A cold reboot is not needed. The reported object was
allocated by usb_get_configuration(), so this warning is unrelated to the
INTC patch.

I sent a fix for the USB R8A66597 bug and copied you:

https://lore.kernel.org/r/20261002213225.27834-1-kmehltretter@gmail.com/

> Are you sure your patch actually fixes this problem?
> 
> Or do I maybe need a cold reboot?

A cold reboot is not needed.

The INTC allocation remains live after boot, so SLUB does not necessarily
check its redzone automatically. To check it explicitly after boot, run:

  echo 1 > /sys/kernel/slab/kmalloc-32/validate

Could you please test once with only the USB patch and once with both
patches, using slub_debug=FZPU and running that command after each boot?

Thanks,
Karl
