Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94D63AD527
	for <linux-sh@vger.kernel.org>; Wed, 24 Jun 2026 08:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782289263; cv=none; b=l06QrB8sPpVQOX+cmhFaj1WrPOVw7iaFmwCuy5b2XXMvF4qe7TcSG5iaN96mhK7coNgih992LQvkiVw7QMsW+V9qO2gBuUGybjst0wdue4VzIX2NLFbHqd3WiOk/p4Zp1yniVfjLzuDHa9RFh6dVRxijrpw2FQZITcDnk9GjKAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782289263; c=relaxed/simple;
	bh=0PIQXIBwWTblSrwezZsAykJJlzRIu/DvJjLAjGlaniw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q6FPWvbKQN/YQ2jeg87wgo+AjNHtVHZIoFQzKWC9mbuG5jAF4uHF3xADvIh4HDXzsFr8OX0NEixoyVaXSXBp77v5ZwvrHc0uGU/SAuKbBZLTmd5x6aBPDegJXfcygSftREaYAjelYmLfK7UPX3BJT6pvCNGEDb45t4nfoFWti5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-59b074ec7ceso261984e0c.1
        for <linux-sh@vger.kernel.org>; Wed, 24 Jun 2026 01:20:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782289255; x=1782894055;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//lmerhzWsIFojL0vyonPaqb0x3MIW6iIGNJCkIPu7g=;
        b=UT7vOj6P4+0Nrf9D1PiBL1faIPidpgqAuQv0UbikOck5X5vXD9x3GQNGyMZEsAAu5R
         GdpaOyHn6B3jiFwLs6AYe+mKpSlduy2//0nsqKDurOUVmHJqcZJr1OcG+sgfHIcuwzwf
         w7YuXu6rQUS17hm1LYhnm9s/Qeo6YfoThAUgIkaKJUhP6Ms3WISUnfBz9R5T2RG1jsBS
         SLyiJr4HNzgq5pR9GUHRS6Gl2ptYM9YyWy6BFSIpp6G4b4574GpRrsEsyERxKpkv1Abr
         3tYWD9pkCDAxFjk2RxjwZqrNDvtEcRPABpMCxZGBP0giAcRrxpei1gdhe5VJ5l2NI2Qo
         bJpQ==
X-Forwarded-Encrypted: i=1; AFNElJ8agwIY8BgBSZEKFojwqYHmv+umxNyQkFwt28TVJe938GqRdCQRn+/MKQ3F7MR2QGF6SdqboHxlWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0L2l5jHJPsbfP3tkkh2RAJz1GC+aXqlDyzplYi0IrABaIzScG
	tIRd/z6F3kjAMINzxehLfcAdNvWqzppQ4TGPXMg9yWW7eTnHLcRV41HOBJNgKYr8
X-Gm-Gg: AfdE7clvDrctf1TTq05ZDOw2BZB4aCsfDUPHkrLaIccDgY/Kysi090Ycx34GogADEYT
	+uqY9K7bXlJCmRB15Jt0XsLtN23sg0p9wa6P1H98V2kerUJaYYN444Lh3ANkxyOiJctumPMs51l
	Ns0unXqfTfAREPNNxZWKhivmwgkRufwuxjcG9V8ZxtpZnbNanCP62fVyIxO67Bv93cBpWzL0tVW
	2j8uqwy/cNol+SOmWDhKgysONPOmKGzYHdskVvsQhbXlY7UNmcfd+16uOzqiOPvrkVmMW/DltQn
	wklm6bjFVmy8RhSAVc/ubSDZ0Xao7+wVn8f8Iamb4XzWYu/mPC8rHEKvVKl3NZG37Ug8+P+TyO7
	qskWFv+YEuHpKnJsWgDMBmtV2R4O9CQjD/hiTaCpNr7VygOqzocP2DViCZtQtl7qe0WH1G+K1O5
	0onsdLuDpcbkguq3K7v/whBQL6x4oSofQf9RYjTTt3wW04E+5VAg==
X-Received: by 2002:a05:6102:1497:b0:6d3:aad5:6d2d with SMTP id ada2fe7eead31-72fd725d59cmr3637327137.18.1782289255069;
        Wed, 24 Jun 2026 01:20:55 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9670c0e98afsm9652932241.1.2026.06.24.01.20.52
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 01:20:52 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-966801d093aso250546241.2
        for <linux-sh@vger.kernel.org>; Wed, 24 Jun 2026 01:20:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/7qT4a+DAvd2TfIivqFGM2QKL21iQUb4NKWuy+Od9HKoFsP4l2jcg0Ix9wIGlzdPi1o2r8LRxZig==@vger.kernel.org
X-Received: by 2002:a05:6102:2d07:b0:6a2:b2a1:f16a with SMTP id
 ada2fe7eead31-72fd549000bmr3729010137.2.1782289251907; Wed, 24 Jun 2026
 01:20:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623043150.1852957-1-haoxiang_li2024@163.com>
In-Reply-To: <20260623043150.1852957-1-haoxiang_li2024@163.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Jun 2026 10:20:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUDQK6SWjGzycqRvENQK1zJqdHuwdpKCsFD2260F-k-ZA@mail.gmail.com>
X-Gm-Features: AVVi8CeHAa5VJZI1MfSYBsTzrC6B4H3d3_kVNWXraHyNt8sFYhSM_6qd7a0mAHQ
Message-ID: <CAMuHMdUDQK6SWjGzycqRvENQK1zJqdHuwdpKCsFD2260F-k-ZA@mail.gmail.com>
Subject: Re: [PATCH] sh: kfr2r09: Fix serial I2C adapter reference leak
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	lethal@linux-sh.org, damm@igel.co.jp, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Haoxiang,

On Tue, 23 Jun 2026 at 23:16, Haoxiang Li <haoxiang_li2024@163.com> wrote:
> kfr2r09_serial_i2c_setup() gets I2C adapter 0 with i2c_get_adapter(),
> but returns without dropping the reference. Release the adapter with
> i2c_put_adapter() before returning from all paths after i2c_get_adapter()
> succeeds.
>
> Fixes: e6d8460aca63 ("sh: Improve kfr2r09 serial port setup code")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

Thanks for your patch!

Before posting (or better: writing) a patch, please check if it has been
posted before:
"[PATCH 0/2] sh: kfr2r09: fix i2c adapter leaks"
https://lore.kernel.org/20260508120601.426115-1-johan@kernel.org/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
