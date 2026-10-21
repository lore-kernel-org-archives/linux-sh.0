Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792544716;
	b=aU8UuOZNG6sWp/8qYyqi1AYcGwt6iBjm8PzBonXnZFumE094ssGkp1HYC5QP6LXaezz9
	 KELGy3CcF0bC16AJdMR/0cg4i5cuJ+MP80cPrDc/CWNpgUBDy9p2DEVDxoHE8DB/CfWQp
	 Rjdf84z8w6I7k+0CTW+lMY9e5SWHKnjvt5lVj55xJAH22JrLSkFXYsajI2hteEKP6VsuC
	 uBb7lJ9oTvoWb345Gz2NkVh8aRXfkCjDPZ/C2FH4XhZKhp4VqklCyQ1xTBmWE4XkuAg1S
	 W3CKzVUmGAsk93OXXW4E4sERmvYn4b4sLyixz5FpVqRur+Z/jX8xSTalIz4ICah8DKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792544716;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=z0hLEERCsjy4axc50ookcdk/sfqny83SF+wLsC++daU=;
	b=XlDrcCUrf9sQ6ujVqxkXUAL6o50HknUZ8NyK6oHYHTno7FTDg5GIHC/dLqmYlM8QX+7D
	 FUKz/GksaX4yQN0dC/RzONYW6Aw/ZAbc44A7cSQ0OA+N7OJ9ryjsl0tbz0hxO9lhDebrV
	 8YW4CqLhQe2GwvD+SkCwSpK3+4agZl1fwonyqdE4BwoU5Txs1TR3e08RK6tvpyvYExNc3
	 6SJRm71T08rgOvGgnWcVVy3FRA4kUQYddaA5FXtvCnalW5cDOgAmnZ9lL6NPq7ttz1fgd
	 Mk1HbEYG2msrY+NsQ32L0cjBvplLDTRXGAowvqapD/K56gAfbR9v3bwFjdMndWMBe7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XpITqnsF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.53
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8F0606A31D
	for <linux-sh@vger.kernel.org>; Wed, 21 Oct 2026 01:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF8F0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XpITqnsF
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-483a66818edso152155fac.0
        for <linux-sh@vger.kernel.org>; Tue, 20 Oct 2026 18:05:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792544714; cv=none;
        d=google.com; s=arc-20260327;
        b=KHxvgoreZ1Zan6XQNuyRUayYlC+ZbEeBXFWqHpIin8ERmvgQg3tK1U3nmcUnbWStfp
         wl/w6zFxBLL8UJhC3MyQ19Uywu+Fp7JSglDxLWK9YXBRnoX7+2rJdKpMTn61uMYtgtj6
         xzuILJYo8/C+7+Dg/4LXU9O9BS2tae32QsvXQNfp7/BbFcrf7bYeDZp4ek8SsKg9XZke
         kIvncJJsQsseM3wRN2dt5kg5L6I+IJ07Q4wwqlvJ55yxxB6O5WnHQ3ZW+15ZVA527Iib
         jOJWMkdn2N1E/ol0Ce4hfAVgLlfNZqA+E3eJVIta6DYAHY0X1MvSMTeML2qDnOQi5LNe
         YupA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=z0hLEERCsjy4axc50ookcdk/sfqny83SF+wLsC++daU=;
        fh=L3auYHJlOASNoShIqe6BMATHx8UXGvq2nPhoWMZG4iM=;
        b=Xy1hihUMxyZhJcnEJWv94tvVgspCHQB4cCf5DV+ZtMlc4DzT5K+SNpHdrdOuoBXCG6
         bzhch1FSN8IsMyGAXTAvTeRav+5hivzU+P6unFlZVsXgULySMW1ngJAS7pqulMSCSlpW
         AruZg9HlJSR29mGBxRnuKkKgen94fXRqo5+jPq7lbZNk28hzN+4zjkfkq3TeKcdC/EPa
         Vdf/RjC8v8ZP/ek6O1VJykBAZ/ftygc0zd1dna+1LhoIZoL+Pi01uQeLOHGXF0zr0ZRw
         FDemfg3r48fm7k41yxBixEH8ReLPuRS8dVNHL6je8fnsdO3XWavIoLNyinM0WsLjXGDA
         7iUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792544714; x=1793149514; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z0hLEERCsjy4axc50ookcdk/sfqny83SF+wLsC++daU=;
        b=XpITqnsFVbmsA65tYcRzfHxyxSBcJK65LXclrQMybNFaokMcv/OBBeyqo0kpkyI1Oz
         UIwPty9tmb3wXk1P3KAZiHvh/Xf8iZOvIWLgxX7ooqdP2YzZOpqRHht9VGAwaKDkipFP
         QKaRzRXaULK+cDuLvOlEAAZ2+hDTdtRyNZMk9+/ln2FT1v6kDPKEsszkJrTCW+zQbp1l
         HlR3EsL8jhTsxuuY38fVH+N16er2bjK6ZsuV2Ik/3Tw3EqsaFHIbQtWgvuCH40rwgS4h
         vgRacjtbDhOpfw07WskUG3JwQBdRTbkI4rRyEj6tkHY3ia90cF7+rhFPiZd2E7idWXUv
         Z3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792544714; x=1793149514;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=z0hLEERCsjy4axc50ookcdk/sfqny83SF+wLsC++daU=;
        b=lgAuNwBH67xABfLoW02MNwNbD7LvV0gmkEMIwF3KQ7Tk85vxxJVby+HOv2T7wqNdnN
         IQssmcu8YM5qrph9iP2jn1+kUJUvpLc9jptp6xMgMU1vgb+ZE6mgDb2ge1gVuT7PN3Av
         jkcc57PCCJAXOPoEGKAjir6t/Nphhm+dG39JzA8sQL76uhZmQdn/75aLKJN3zMi5on5+
         WmR2xvAMiDgFKGQ2pK3Vk+/Rkkwz3sSVBuHaThYy5m41ZWxKnOHPNvIyFJJ+gehvfm2O
         /jaffARRxGY5gGXa+CIsD1YQvRjKGy+DzYktA5P4q36qndGblhESTMvUgtPcp8L86KfK
         fuOg==
X-Forwarded-Encrypted: i=1; AKwUvByVeR3L3O5OJHriOfLSNIh50BwmA6MUDvAPGRcqa0sG7dni9iIupPWBhrNVNc1peTq/o68XH5NC0Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYKb3VakW1tnlhnzsCaw4x8KfBtcE7T80gtgWVyEjQUl48lqTnvN
	IY2EGZJ+hovStoYvhgusD7LhydywAo2Ojz5wYcCijyEdYp5huviuSGg0f8YPPlVw68gAvw21Qte
	t2qjhTABYUYeFcARw0oAGOUbGE7/B2Sw=
X-Gm-Gg: AYBFou3MFlvW0FGePUA+A5jklinpK5NCrhG7XkEEV15sQtyAQeawBQZulfEqakTEs7N
	rnjKyFLBQdfJEAea8PsxRINg4nw0+3v3s/Dik+JKoja5JRttvFlLvuEsyj1cKrpNZzW2qMssJSk
	zuKYDh3vGbtr9YVUgXq2qKrq6xgTPsYaPDNwmuDK2Gwfn2sP2/uj9d3R7sqC4SQMaU5fadABZoI
	60z5AtxxIz015Fal5OPfada8HF7t0BmM4TBQKqcK3V4wc9hpxufbvR9LB0EmU6o2oDIsosFHBxx
	X7TrmQXB3u1Vxkw04S5hpnIJBj0mVmfFMsuimjXw3kMu4UBnkbGYB/9nPUW/LZp0f+2CYDjh4PN
	B6wSpN6HS/ilvbWanaC1H5EJCnrJKGaY617XzuVUSaoF8iWuZZUkAl8knhJ1XcNzu9UAlTNBT
X-Received: by 2002:a05:6808:5147:b0:4d6:9153:295c with SMTP id
 5614622812f47-553596fe6afmr356471b6e.45.1792544714494; Tue, 20 Oct 2026
 18:05:14 -0700 (PDT)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261017041419.311921-1-daniel@0x0f.com>
In-Reply-To: <20261017041419.311921-1-daniel@0x0f.com>
From: Colton Pawielski <colton.pawielski@gmail.com>
Date: Tue, 20 Oct 2026 20:05:03 -0500
X-Gm-Features: AclHuK_WbBRvyFNBUBGOV4aGPihFuEs2qYf6-xkzjASYHC6uPBnvRp4v0utSWw4
Message-ID: <CAJpaz4abKAkDznoi3gczYHNQMF-j5cSajtG07Jws8LkFY9DZFg@mail.gmail.com>
Subject: Re: [PATCH 0/2] sh: Fix IDE on landisk
To: Daniel Palmer <daniel@0x0f.com>
Cc: ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	dlemoal@kernel.org, cassel@kernel.org, linux-sh@vger.kernel.org, 
	linux-ide@vger.kernel.org, geert@linux-m68k.org, linux-kernel@vger.kernel.org, 
	fuchsfl@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Daniel,

This is my first message to the mailing list so please correct me if I've
done anything improper or non-standard.

I tested this series on three I-O DATA LANDISK HDL-U boards (v7.3 +
this series, landisk_defconfig + DEVTMPFS as mentioned by Geert).
All three boot from disk, and the ATP865 is detected as
"PATA max UDMA/100".

I have different drives in each of my LANDISK devices:
- Maxtor 7Y250P0 (native PATA): UDMA/100
- SATA SSD behind a PATA-SATA adapter: UDMA/66 (my adapter
  gives ICRC errors at UDMA/100)
- CF card in a CF-IDE adapter: UDMA/33

lspci from two of them:

00:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8100/8101L/8139 PCI Fast Ethernet Adapter (rev 20)
00:01.0 Mass storage controller: Artop Electronic Corp ATP865 (rev 07)
00:02.0 USB controller: NEC Corporation OHCI USB Controller (rev 43)
00:02.1 USB controller: NEC Corporation OHCI USB Controller (rev 43)
00:02.2 USB controller: NEC Corporation uPD72010x USB 2.0 Controller (rev 04)

The third is identical except for the ATP865 revision:

00:01.0 Mass storage controller: Artop Electronic Corp ATP865 (rev 06)

In testing I could often lock up the board when transferring data over
SSH. I don't believe it's related to this series and am fairly sure it's
in the 8139cp driver. I have a candidate fix that I plan to send in
a couple of days once I've tested it further and there's no more
lockups on my hardware.

Tested-by: Colton Pawielski <colton.pawielski@gmail.com> # 3x LANDISK
HDL-U, ATP865 rev 06/07

Thanks,
Colton
