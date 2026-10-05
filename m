Received: from mail-ej2-f41.google.com (mail-ej2-f41.google.com [74.125.228.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8134921B5
	for <linux-sh@vger.kernel.org>; Mon,  5 Oct 2026 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208681; cv=none; b=AQv5e5aKNKosFhsIiTVDoOUlnTMvmCCPqg44XXGwHiJOhTTcSgCEdGnvglDQZ5xUTmkyZ5POakSdDJLUXsej1ulWaNXpHmdg3iTgJgnDThsGl4BNer6RQgkMRqf795NIdO+JRnjSCQH3kPIYtUoV573ykX0FiiNdgsur+9D2bMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208681; c=relaxed/simple;
	bh=n+s9MtbJbIy61EhMnMIaXeqKdaN3Tu+2CnCfvkOu8JQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IgeMPjBbP9oGIdX6GtsEdG3tZY1kq247oMfiLzyO/7/r7e3zjADOuvjI0SAcCnxa6VM7NN9TGYfZNLd0BwLgCgnVK5KaBZ4I//cnUrRcQb9ZKoaRK9IHmrEHw7mek4B+6B4n2jVgbHFIp7oeKybg0912g5CNuEWKfeMJFOSqTeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.228.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej2-f41.google.com with SMTP id a640c23a62f3a-c2e3f641442so302087366b.0
        for <linux-sh@vger.kernel.org>; Mon, 05 Oct 2026 06:57:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791208678; x=1791813478;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h3WcaI+0O8lHZ4mIArK0RHYpnuN1stMSjlAmB+AjH/Q=;
        b=HGBPW/ZSSFDZgA5QaiV7snp2bRhqKmLtx5FD8/02k/vuZ1wEOu8w5q6aP2kgrFGcDQ
         lnlrhxu0jzgeU5nfCGe9LzAsRP3J8DQyK/TuOZrMR7FFyT33NwktPQAN8zSKzhNqBr9w
         o7FcpRyVeqBdGyCnc3xZNq12GuGFkXbbrjPm0o3mcPC4mWpnvu06ICb+psldn3FQSiK3
         8LzVnNTqBP9KDHVC3k0tzHUtdohr29f183f05rO2lKnHF5UxsLISpu9rgNXo11hcTwKU
         Go/yan7vX3wtRH2NunEkRTLynX2/VXxQqhzdGmyaj+JPPtrH92OrlYGn1PUDtcmpzGH/
         lpwQ==
X-Forwarded-Encrypted: i=1; AKwUvByvTPAcA3z9rRuJQycqzpog4c5ubcXHz76tfy0w9m2cL+WJ5haQkXB5ymJ14vwtQsi7lf8yRasPrQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJRUGgwNSBtCHtKCLLnWYq09YKmvh5Encl0qzY3EB970pJiAW20
	Bc+3vBB0l90kO7b0WsZf39KiPojDL1OZrqTPcw+y6ZjlLTDbHFAvTXrXz35eC5RdoUg=
X-Gm-Gg: AYBFou154WFj+eKY12MtGWvNOed0buyu98uzKJ++Pu09J6jauQMNE9j9TljTmtWB+Qn
	In6FoaVOIqL6UP1I1C9EgDBGXjfPKWELrH7XpHBg4pXIU8QZxPzC3Ck0b0miAAG9ltsFCYUQ2Me
	uZyhxcssodgzJJUWC/hAWDotcy7tnX8m7TySZ00OEj2moby+c9Elu3Gq9AGdrM2KaLJKwy0F5EY
	gTybWtssBwwJ7L7E6k5/7kdcB2VkuJHRycj2LV9l7rZQSZYZYh75U/nNjEGk/vmIZA/niHQUh4z
	PqMzbsQ3fg78y3dwA0Ztj8zB47IxOi57LbEvG04T7EjxQ/NQVAMJMIEPPpxhBh43zJ6PXJIEqKT
	PZiKrWZbwKT4UpR7z1d9VdHYgEbaQOZDEizkwZZ72cy89F+f/CbAv2JP0Nsptql8bu4GvnKqe4k
	vrrEg5A2YsQ3c9iycxoegtz9Zpj5XYtJh387oqo6Q7lldmxnpcIUBxh0gX5kLDXO1sb/QPbNvVU
	5/bUIW/5sOHjCVI5iy0LaTO6gr/ZfTHoSOG
X-Received: by 2002:a17:907:3d52:b0:c2a:46a2:5b57 with SMTP id a640c23a62f3a-c2e4ad568c9mr865346666b.10.1791208677700;
        Mon, 05 Oct 2026 06:57:57 -0700 (PDT)
Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com. [74.125.228.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3156333b0fsm88276966b.62.2026.10.05.06.57.56
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 06:57:56 -0700 (PDT)
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a605c198fdso2480009a12.2
        for <linux-sh@vger.kernel.org>; Mon, 05 Oct 2026 06:57:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwjAUcwupHOlaBtN1yTCzwP/yoRRyASQTFukGHWerMpJYbZsFjBHua+/jTFs4XJwUPnAiwUcaDUig==@vger.kernel.org
X-Received: by 2002:a05:6402:4028:b0:6ac:686f:91db with SMTP id
 4fb4d7f45d1cf-6af9e2eea4dmr10193022a12.11.1791208676370; Mon, 05 Oct 2026
 06:57:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002213225.27834-1-kmehltretter@gmail.com>
 <CAMuHMdWEYkBra+3G_+-TfT23BAWPxG5o2KHqGRuHcdp8x0Vskg@mail.gmail.com> <asMl-yIKQoAbpwzA@gmail.com>
In-Reply-To: <asMl-yIKQoAbpwzA@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 5 Oct 2026 15:57:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUqcwZ_YPRB3BZW+=iBHAreDVquWahFn01Z9yoF=yzj4Q@mail.gmail.com>
X-Gm-Features: AclHuK_eb-aU_a3fauOPMQV8VM9j8pv8zjLDNlDNjrpr-8Ij6r8nOCNKtC-t2O0
Message-ID: <CAMuHMdUqcwZ_YPRB3BZW+=iBHAreDVquWahFn01Z9yoF=yzj4Q@mail.gmail.com>
Subject: Re: [PATCH] usb: r8a66597-hcd: fix buffer overflow on odd-length FIFO reads
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-usb@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Karl,

On Mon, 5 Oct 2026 at 06:25, Karl Mehltretter <kmehltretter@gmail.com> wrote:
> > Seriously: a *_rep() function for a single iteration?
>
> I'd like to keep this one. ioread16_rep() does not byte swap.
> ioread16() goes through readw(), which swaps on big endian on most
> architectures.
>
> The words before the last one are read with ioread16_rep(), so reading
> the last word the same way puts its first FIFO byte first in memory on
> every architecture.

Hmm, the version in drivers/usb/gadget/udc/r8a66597-udc.h does use
a single ioread16() or ioread32().

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
