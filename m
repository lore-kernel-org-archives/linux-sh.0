Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792624985;
	b=bC6cD4e3+nhXNcCtP1eI/7E7nD3rpKCJVVuIoW0sqKJqAqX42lz+HCe1kgLLwxOp1ao6
	 r8OmTPfmom0NiplpW6O11loMGQuvHJHu+XNH5fQBz2o+VV8PfJT1hfUCrT6PRv5qqTVti
	 /wzJ+d4bc2/lcirswBxYi3FCmsh7c7VwqojIQ4Zy3AcuVjwCqEayz38GptgqWZOtxNGZ2
	 HEqu+ujMMqR8emT5XmcjYsJZkR1dEbUoQG4sauVoUo9fHA63dZwdyF2vKMD2U7zrDKtWK
	 L76kCt4TvNjHNaRBajFWjz9kWiTZXLqavnrucgJSXYM8dZl11aqBVmne/XtZg+ETutw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792624985;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=UWTtYfkUlWyv+2UbtfIcf2fvliDHTQ0Yu20KCZoeOOA=;
	b=Hho4CCX+NTAePNHabc1jRXHm47LQqBvMzUKbfYCOkkFiNrv4XulUFt5T1eqUGKVI+feU
	 bccGoO7rH7ZqfNUanL5JgUZCq5AkHT6kQwvy9Vx9M6qo/qrlirkEpwqBznbxgYvpoxOSl
	 mzPDvGjXRtxNY4C9+GUKsG0Lke5bLbIu0pX58+AilfaGHwiB5YsuoW+NXEyXouSn2WggZ
	 gMEdG2NHX8glmaoFnveV6/UDv48da747Ae0rQsgssIEayZy0gxz3rftqdBVInOZlo0k+3
	 xodvpPG7xwUAx8G1lAFZEbMtMRDWRc9gtBKh6TgiP5qd4qsRwTQ+CXXd1lNrKaQ7a3g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bswUs7Ka;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.52
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CB9606A31B
	for <linux-sh@vger.kernel.org>; Wed, 21 Oct 2026 23:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46CB9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bswUs7Ka
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-8446af403b5so912683a34.2
        for <linux-sh@vger.kernel.org>; Wed, 21 Oct 2026 16:23:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792624984; cv=none;
        d=google.com; s=arc-20260327;
        b=GSjqdxfRzE5MKwXcNWxcE2gUAbonVEvuZ4LB+4kwB7PVi16E7cfpkjbavo5FTDkqmr
         yyCXPyldEa3qvfAwuPxYixga4INsAYnPrkxpzYSTUqy62D8LMNwsIPZSubJu2Z4cBt0n
         yqZVYvibx1gHUJueUJbgRKIeZskgTXxf+nbJ8LuAyHAIV87irt4ea5sTrCfk6RjlpeDQ
         tFacyDbot3ojfGPVTjx7r/Vw1HbP7yd+G6zwEFOssflliRKES6bVZqHxXpt141pQlKkg
         QdHq7qq0rdVmLLvcfxNHC8bZYvOAdHSvE1Tav8J7DUaADYiI+izE5yGWdAuIeZBBvIeb
         Jo3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UWTtYfkUlWyv+2UbtfIcf2fvliDHTQ0Yu20KCZoeOOA=;
        fh=Wh8Mj4aVfb2evcCN2kEnNAD/ZyMQJN+GUfsooXKhhho=;
        b=j8rjZ5ZmoPGLb3V+2J6E9Od8hGtCL2EA4cA1Jh/Gep7q8VIQRk/1uV8LXXys8WNHba
         rwRFvM9fx0JfwOeE8wPD5hBrgbD5EYy76LC30KO1LTaa62uOB8YI4H+FIu4LoMXwAuGg
         KjyTAz+RfnFR5b1eWLWQU/x9k62y3J41t+zy27/L9KyRqT3EY0UYE3W37SnumqkqXSug
         kH9iMxAGAt+1U5nC1B8PHXo78QJxrhYIs01RG3JYllhNy5QwQJ/SxtGhB55WKtb6t6kv
         zANQNX1udIzgCd9oxM8TOn5uxwvWACvhklx1MQYSRF1arDUfX2xe1MfKL/8TRLK717yt
         WKlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792624984; x=1793229784; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UWTtYfkUlWyv+2UbtfIcf2fvliDHTQ0Yu20KCZoeOOA=;
        b=bswUs7KaQtVDzZeWu+MWiyJboN7ZZsa0rJoQF+iOWuESEO3rl3FcBVgfPYnaN5YGfF
         EjV/Wtawl0coq/Pg0/i3QcsLxYidjtA1LO/2PqcSVzx53rhAN2x/zpMefR+C6/XCMG4G
         N4DQB9V1zjgirP6GQA4xpSSF7D323JQnLliMu4oWg538jz8kCe4Q0j97wkFF0VGG3IZE
         3lJIg4tcXBe1AepcbuLJY+nmSgyZS2Nue5zWy1LFWsKTNrMjhI/4aumhI9ks1qH7swUy
         ZgbY23Nf4w5fpAPVIe1SutVFZyWYhVHgCFu95eR1kXAvAukvnC/ekv1jGMGoZSsbkbbp
         JNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792624984; x=1793229784;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UWTtYfkUlWyv+2UbtfIcf2fvliDHTQ0Yu20KCZoeOOA=;
        b=dlvnjOx1HrhY5gXn0CGR3ygEZAfj1QfA4sINBrHBthNaacC1TlZXOOdXX30ExSXFRP
         nxvrkVHWRBX7Wr20ybzppLZa5PJVDD4pXUh6CRe6uAjV1vcs/kzot9F5daqhVcWDarSx
         s/k3Ph8l50UPK32mepAeqU+/8EjPNtDshMDMUzq4SznDa/cJmqc4A+asnR/YH058pdqU
         TbUeaAZINDzEEhWkYKYb+A3cWkMm+n8/SKGCl9+Ru59nnC27NfAHXstuIOGcfWKla2gc
         X1Lcv6P+o125eGga7ZTDFEEVxqQYL27kKWPp3eU5qxn693/0He7c8DJAmYG8FKN6wvaH
         b1uQ==
X-Forwarded-Encrypted: i=1; AKwUvByFyVD8ADLQK3keDSgGsOO9DScgRdMubxwv+XbDVKiTWq545jjKZwJc5vRU6WmzjQKDCaAZChGI4Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYLgDbQFG9oXMTVkEc2Yogffc47IK6+Vba/LOC6x1qmvbNUlaJ0m
	VF1ix9SCsFXVD/jAXRSRo2SiqzaBD8XDRf1W6dHNxuovPRSqmQccEnbtRZGXN87BsYKcg9BgY+x
	zthLfMe6tfToyCWl6AD4/hLs1pooYg6Q=
X-Gm-Gg: AYBFou3zsdlRNHVDD2KA4V3Q4mOacBZldVUyCgLC62A2Jw5oS3rMubW8Bz7/SKwwNfT
	VQyw3MARaSFWH9EfQtSWSy+hOAEf/FnpTSueXYonWjkIzkMvjzRdebADVx/6Ww04m4eNTgXh8GL
	nJP0wvO/0FRKZY3Q8+jEEpFSmEPKLhCYPOXRkCdoQp04TNaI/bkus9Mc3HrxfO2rOnB70OocL++
	GXsVCphjo8gY05Rz3wrB87GxV0wGPpU1E1xelfHShWTRjG2isNSy8x+lFMDAEYODlgK0nIs9VTA
	xSLzrpilDOb4wxZInpb6C9srbiuSA1An7MOg/gY1aQaTy+oqUTL0jMcaKHxxAIubC2P8eBUnMpB
	5ThH15fnds0H38yoUxfc93Jd8zi8RHCbVUgDNHbmvMEm0b4pxioU=
X-Received: by 2002:a05:6808:1686:b0:4f3:e98f:fa27 with SMTP id
 5614622812f47-55359701a33mr2377377b6e.16.1792624984257; Wed, 21 Oct 2026
 16:23:04 -0700 (PDT)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261017041419.311921-1-daniel@0x0f.com> <CAJpaz4abKAkDznoi3gczYHNQMF-j5cSajtG07Jws8LkFY9DZFg@mail.gmail.com>
 <CAFr9PXmntwx06iMc200d9HPoOeCE7XURpS9jiWhB3ud_+QQggA@mail.gmail.com>
In-Reply-To: <CAFr9PXmntwx06iMc200d9HPoOeCE7XURpS9jiWhB3ud_+QQggA@mail.gmail.com>
From: Colton Pawielski <colton.pawielski@gmail.com>
Date: Wed, 21 Oct 2026 18:22:52 -0500
X-Gm-Features: AclHuK-WfMKMCFvlwQ93fHdyuPOEefr5IORMgFLa-KSGZEsFjPpcPlLkY8bAXbc
Message-ID: <CAJpaz4ZJ-zgcudHS705HSdcM-wiB5hmX=gg00wqzS18NF6fm1g@mail.gmail.com>
Subject: Re: [PATCH 0/2] sh: Fix IDE on landisk
To: Daniel Palmer <daniel@0x0f.com>
Cc: ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	dlemoal@kernel.org, cassel@kernel.org, linux-sh@vger.kernel.org, 
	linux-ide@vger.kernel.org, geert@linux-m68k.org, linux-kernel@vger.kernel.org, 
	fuchsfl@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Daniel,

On Wed, 21 Oct 2026 at 05:55, Daniel Palmer <daniel@0x0f.com> wrote:
> There seems to be two issues: One it interrupts for every packet when
> the 8139cp can hold off and not storm the processor, and there is some
> issue with the chip refusing to send small skbs so the network layer
> starts locking up/timing out. I was planning to send fixes this
> weekend but if your fix is one of those, send your version, cc me and
> I'll test it out.

My fix turned out to be neither of those, so please go ahead and send
yours. It's a race in cp_rx_poll(): napi_complete_done() runs before
cp->lock is taken, so an interrupt in between can leave Rx unmasked
while NAPI is still scheduled, and the level-triggered IRQ then storms
until the board hard-hangs. I've sent it to netdev with you on cc:

https://lore.kernel.org/all/20261021-b4-8139cp-napi-v1-1-c9b683d9564b@gmail.com/

It should be independent of your two fixes. Please cc me when you
send yours and I'll test them on my boards.

Thanks,
Colton
