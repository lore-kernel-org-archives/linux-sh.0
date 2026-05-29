Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3943238F233
	for <linux-sh@vger.kernel.org>; Fri, 29 May 2026 05:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780033029; cv=none; b=BGeFGoKMjSoMgKflqKljY233wYkxKCDDrbVdWEs72yhJz5mmt6AUtLhk4hATQjeG0N+FDJBQXrd39EMmMN5tijCt2o543dT5Qv4FNduzSQIAhhhTSyGrau1099TYU1X9WwnJGEfx8FsFy8DovLCLKprER4kz0Qk9fAwnWY/QKIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780033029; c=relaxed/simple;
	bh=U/u+I7Fjs+lyPrjV5mTGiCw54swil5vB5IqkaePU3UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKx9UuKwUgzNKwemiWbQpeC5SlgXz/WRIC1Qmv15cLjZmSTMmdB4sEorOFhLcPfH02EZKqx5Mctk3IZPLvlm3u/9u/xWcg4+zPis1NliHyk+slopXANDUe2dn7MPypTvmAeP4qhPhS6FM/YTl3uMHiXcKF1V0wNpCGZRO+DI9bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGrftDdx; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGrftDdx"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1363e78746eso9885034c88.1
        for <linux-sh@vger.kernel.org>; Thu, 28 May 2026 22:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780033026; x=1780637826; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b3mngTSiQ9G4QDQdoy3QdNFGLu5UDTjPqyOy5Rx/Ffg=;
        b=gGrftDdxpBqeEcytuF5cMQivW8TLP4X3skIaFHpeJvM0bkgwWiUxNyfbJQ6N0n9Nnv
         23NhooJzbJjpL3HS//soTiF2H1Jz1hokAV61p6wLnyy7muOB5dVjifRy6Q/vJhGGRQsP
         9od7sc2lJz1LE7pvzI4Cv5Ymik3J5VXURow1bXTxx1meU8D/tMLumKW2voUjQIc58P6B
         xcn00iQe+BNYjmW7eNBTCIqwcBptl1MSod/KdGsU92p1KzWHrmEy/1se9JrHn9cO7F+O
         XVzU0QckkcIitEwwHaQdY1TIGeeEBHjW80XpoGehapMt7ZYnXgQACsnmFxuYbTievMKK
         tNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780033026; x=1780637826;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b3mngTSiQ9G4QDQdoy3QdNFGLu5UDTjPqyOy5Rx/Ffg=;
        b=N4cHV+UvrPbetA3ZsPQ0KmSUeYyWvfdea5r1hV7I7jNtXljCBkBFkyAnZ1nhfsNJXV
         BnJqvbFctZb06NSg3vK92yFFcgWswLWEKuoIHBc2XcbWkvF9HFYFZTfSBry4vVuvzFob
         wGfSoaUf8KVjLTHw1FmOFr4/3o4vvarauXAIWh7IbMl3/US6W6RqZpIDj3JgRhiKEnrr
         dGgInz8fhACCB6yZ+hG+jce/Vt2psRb4odA2PRvG/ZivzsYChNdtP8aatT46RbTGW+3e
         Ufu2DEPjjKiMB/HYpNCH9dMjwa0E5bxEttK22EbClBs2l19YxV95RoBlY6lSQGyQO5Uf
         uySA==
X-Forwarded-Encrypted: i=1; AFNElJ978P898JUrDPwDCchrpoW5amld8xrnef0L9RP5/o/3DU3bJj7aK6/MeAbXUNufxvarLdE9URhFKg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwR0i6E7Sn6IreB+RnMMm8USyIACqUbyvD/EpUKGOA4Q5GdvVLt
	XERv6zCScNDi3AFM4zk0bPBwwJ9FoGRLsuD/fUjZtLNIHsyJYQZeYFBc
X-Gm-Gg: Acq92OF6DOCdtHrqtcFUtQCKFlgkTJsbE+CmIVQGDVcb8XDylGzKoq9QGnFsv2g4V1q
	qLeoqto/UdQKrxGPGJva8fcHfKWDST7p77RgqU+AZlqycttoC71J/DQHHVI/h7mLP9MAhSZ5EYf
	ySOcKofqhY7pr+STOKXZYzTyVY4FklctwXE0CKY4EFZNEqkpFAgXcVjKdhNDfVPvPlWSuTjLt7t
	SBExyIVXbA6Qu30j/s230a9I+ZY//M646vsE9kVuFUOmKoEkGsFdIaBxj8gS8QZWVaCcXTLMuzn
	m8nVqpV89kWJwhMukps/vgw2KZTQmbFt0f7fQnVIftTC/p/g06mIx1HWfew14zi7nAIKNnJuHUW
	ixNwzSjgktRkDxlUuvyD+8wymaVY/GhhcTCwCilDgXYjD8h0EH5RPiypgRmnJt+k1iLoX6W2zmk
	Ps63crG8wMmfylHU+K8crZcFh2fJHI/3F5VXA7Fy3zSQUDRYyUfHAJsC4+Ao2u7IAMAv9j4NwnL
	wM=
X-Received: by 2002:a05:7022:2223:b0:135:d76a:aedc with SMTP id a92af1059eb24-137aeee5faemr536827c88.33.1780033026219;
        Thu, 28 May 2026 22:37:06 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:e169:a62b:d3ca:e8c5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b2d04287sm832719c88.0.2026.05.28.22.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 22:37:05 -0700 (PDT)
Date: Thu, 28 May 2026 22:37:01 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Christian Lamparter <chunkeey@googlemail.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-wireless@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 02/10] [v3] input: gpio-keys: make legacy gpiolib optional
Message-ID: <ahklyAUMaOxy3Z9X@google.com>
References: <20260520183815.2510387-1-arnd@kernel.org>
 <20260520183815.2510387-3-arnd@kernel.org>
 <CAD++jLnYeh3GfEfNXfCYdcdg_j2RAU63TYewwaTx3tm0tM531w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jLnYeh3GfEfNXfCYdcdg_j2RAU63TYewwaTx3tm0tM531w@mail.gmail.com>

On Mon, May 25, 2026 at 10:57:44AM +0200, Linus Walleij wrote:
> On Wed, May 20, 2026 at 8:38 PM Arnd Bergmann <arnd@kernel.org> wrote:
> 
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > Most users of gpio-keys and gpio-keys-polled use modern gpiolib
> > interfaces, but there are still number of ancient sh, arm32 and x86
> > machines that have never been converted.
> >
> > Add an #ifdef block for the parts of the driver that are only used on
> > those legacy machines.
> >
> > The two Rohm PMIC drivers use a gpio-keys device without an actual GPIO,
> > passing an IRQ number instead. In order to keep this working both with
> > and with CONFIG_GPIOLIB_LEGACY, change the gpio-keys driver to ignore
> > the gpio number if an IRQ is passed.
> >
> > Link: https://lore.kernel.org/all/b3c94552-c104-42e3-be15-7e8362e8039e@gmail.com/
> > Link: https://lore.kernel.org/all/afJXG4_rtaj3l2Dk@google.com/
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Reviewed-by: Linus Walleij <linusw@kernel.org>

OK, if Lee Acks MFD changes I can pick this up.

Thanks.

-- 
Dmitry
