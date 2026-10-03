Received: from mail-ua2-f41.google.com (mail-ua2-f41.google.com [74.125.226.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566DB41A919
	for <linux-sh@vger.kernel.org>; Sat,  3 Oct 2026 12:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791031979; cv=none; b=haRs0lP8YwFVvnzsZW+jLeEd2NNaptQIVquds0oBSnxzwUc01oWspWhdEt4CTYNf9jTF8ZVBW1Au1OAImPfbHaC2SHmTokbYJo7VusgSL1zIEKeyHjs5yDUouCMpfTGGioN2Td3I6R0O+dgOK3ryXHmsJgwgsCMTzJm5H9TYjZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791031979; c=relaxed/simple;
	bh=v+jwntNOMYJdKRBzEK88YlkJTtdZozXA5YAwPWxDfdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gajtmw+vjrpvV41z3hGKJNxv6uJ62b8OhKYrs+eeoahbV6y413lb9xFx/XwoZTgvuFA555wRCMRR6Dhsno3T9WiVcdopx4GYErLFCLHFFEszpnrawAa9HBhr29dFGnbfxz2X2ZmsQ8Rw9wPJd+AmfWEJaAUomxQ8xS2dF/ukGn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.226.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua2-f41.google.com with SMTP id a1e0cc1a2514c-98a8e9cd8adso115566241.3
        for <linux-sh@vger.kernel.org>; Sat, 03 Oct 2026 05:52:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791031976; x=1791636776;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Wz/vUQeiU0meQrL5M8qbzU31TXMfocPVY9f/7xGtNm4=;
        b=wQMspURPgBwj6XNq7FqiZeEJpyfmaitvJQkBJIRIyEsGWtO5oV0rSsSv53I7YAMUVf
         3dpIElXL0xrICWMN3FBwtmWCexzQko48yU2AHZcjTyHPXOJH+Oy/h53QquvCJeR40v71
         cdDck+OFR1z/EofULZixL/M7U8Ba5D1S1daNipaR4O4cp0+iypGWr9G1dTUntelfD8rA
         3qdrYtaeutkm6IFQ6eTT6L+ASheL7ZO20Otc/uti6PEieSgP98ZDte164b/oXAvd031+
         ugNHUAgvgGM+oyEeXDMsstIsCBKjdmGEXeKbCbv0VyWr4+HFrhLaUU0r7M+dZL0ts3nL
         KzjQ==
X-Forwarded-Encrypted: i=1; AKwUvBzwJ18qRCBgqTO88CGBkyGi6SZtUZfaHX9NRfK+c1goPVHXdaNHC7DbYIyeBvwHtIqZw7D3Sk4o4Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9LRt5DZS6nsTP59fIac+zusoYcxXbAUsSHiqkTVruJQB6czdD
	/M/qFuzWPH+J5onD7j3UelZtUsqGt/aynX17FHWwuYef255yvgEhTeIHat9XX3Tc1xM=
X-Gm-Gg: AYBFou3XHCX1TvVaiPz5QTw1ZdZcEBrPtCTRhxpfTvt/Lgm1S9UB01Kfkd5zYbs46gn
	4qrCvfkpzOJwp+2ZGyG+NYhWQTjQzhzTgkum+A5tWJfuLgYgaqrOnQ5iXVcwUlgMNswL6Vd8QHM
	LfX+iEjB00wLfD8F8uzRh4Kemqjm81OCZDHxM4tTb+5C9TjPc2e4N4qswaOV8wRVQOw7PWsdejx
	aohQgMcbKXQAXRNKNsyuIR9WXjBBf2xDKHlPbSC/Uzy7KzPiVZ2YILE7/hz+kapFFsel3rS5+1o
	xXFU90QrqChRuq7htZ/SgCR7eXGOYjPrFsoF3RSHdOpsXdIKGs1rPV2YxBE2veWA58eLAbdq5Ba
	0UwMkMAODjvjrcsbhte8g1+lwZb7LKo5UrsneHLF5C3x7l2zF9jBc1R44bn497MtdiWrdI7ImCg
	vWAeKEd/BdZMbF9IVKkNCO0NsfH9hdx8uJyigTTyOQg2+emm6jn6GXvl/cnbMyBAzZLKiPpvCR2
	sCL878kilnCgzK1FpRo2EQS93MnwjW6G6Ee
X-Received: by 2002:a05:6102:e0f:b0:7a9:f088:14ef with SMTP id ada2fe7eead31-7c0f46870f9mr1638687137.13.1791031975850;
        Sat, 03 Oct 2026 05:52:55 -0700 (PDT)
Received: from mail-vs2-f38.google.com (mail-vs2-f38.google.com. [74.125.227.38])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7c100238320sm4912656137.11.2026.10.03.05.52.54
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Oct 2026 05:52:54 -0700 (PDT)
Received: by mail-vs2-f38.google.com with SMTP id ada2fe7eead31-7c01969bb37so224275137.0
        for <linux-sh@vger.kernel.org>; Sat, 03 Oct 2026 05:52:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy/ZHGwsXadELG+EvdXGC+IYnnEO7NwJvvD/7EUoc9XVAqJeGnwLdPcxNGsXW+0NG62phorA1oQHQ==@vger.kernel.org
X-Received: by 2002:a05:6102:e0f:b0:7a9:f088:14ef with SMTP id
 ada2fe7eead31-7c0f46870f9mr1638667137.13.1791031974398; Sat, 03 Oct 2026
 05:52:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261003082833.21511-1-kmehltretter@gmail.com>
 <a4dcd9e615dc4e3c98c00e75cdd0c7fdeef02254.camel@physik.fu-berlin.de>
 <e3c88969f18c493859f7c382db7ed2afeb15b4fa.camel@physik.fu-berlin.de> <asDOl5bvtlbauh9x@gmail.com>
In-Reply-To: <asDOl5bvtlbauh9x@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 3 Oct 2026 14:52:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU+Z504HZ3N+oRjAKQWSPiNDVEtEX-wShV-FGbMg+kkYA@mail.gmail.com>
X-Gm-Features: AclHuK__UZnxPIRNyiBJwMilVEAnpSvwJO3EcZnN4TsogOR7Tt7txkrTbZOyzBw
Message-ID: <CAMuHMdU+Z504HZ3N+oRjAKQWSPiNDVEtEX-wShV-FGbMg+kkYA@mail.gmail.com>
Subject: Re: [PATCH] sh: sh7785lcr: register the PCA9564 as I2C bus 0
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yoshinori Sato <yoshinori.sato@nifty.com>, 
	Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Karl,

On Sat, 3 Oct 2026 at 11:51, Karl Mehltretter <kmehltretter@gmail.com> wrote:
> On Sat, Oct 03, 2026 at 11:38:43AM +0100, John Paul Adrian Glaubitz wrote:
> > > Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> >
> > I have to admit though I don't fully understand the description of this
> > patch. Either I don't have enough coffee or it's not precise enough.
>
> Thanks for testing and reviewing! I agree the changelog doesn't explain
> why -1 is wrong and 0 is right for this board very clearly. I'll give it
> a day or so to step back and submit a v2 with your tags and a better
> changelog.

Perhaps something like:

Before commit 44454baa7ca7bb57 ("i2c: Dynamically assign adapter id if
it wasn't explictly specified"), a negative ID was replaced by zero,
and I2C bus zero was instantiated.  Since that commit, a negative ID
is passed verbatim, instantiating an I2C bus with a dynamic number.
As SH boards still use i2c_register_board_info(0, ...) to register I2C
devices, they rely on the I2C bus being bus zero, causing registration to fail.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
