Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DAD1D2F5B
	for <linux-sh@vger.kernel.org>; Mon,  2 Sep 2024 12:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725278917; cv=none; b=NaYLfzruSZWP7aBF2Q/7qxbDpeOabsdhb7gImsMKyhdkYZJrDNiamBzLqhb7WYOpLOeBrkCjDNXpLO0tKovGFTP4/VBrwra5K4yC+sMGRKAKbDxl3bWUgHhMFSNaDLZcIdW6WpBRr22+6rtzfztBLvnOQahi2DHJjYT8AL74/XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725278917; c=relaxed/simple;
	bh=yTF3GuTjOm4ye+8ootZbyJVMuKCWOPb2Xzj9PzjnGH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GwGKIUSE7gQjVL+SzWTo9eBbW9oVMABIgYpzAJtGnoXqdGEWPtZwTCb4/HCnvlOAGLeNznTMp8UaODpLh7Bu1QPnNL6QEAt4qMmgNL2LH5z+GPlULqx45PTjmnpxz+/hbg0A+j6E3qG+fbMrFtc4GRhTiX8LejY7BBbvF5Pe0II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e1a90780f6dso1936362276.0
        for <linux-sh@vger.kernel.org>; Mon, 02 Sep 2024 05:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725278913; x=1725883713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XpeW1FmNj6saMIMafTjGuYGKtjOEURcsfQk3SJRqJ+U=;
        b=pLMvDGQeGtjnqIQptimqgzbMdBp73cTTRyqDDgryfX+jtaH/NuiFHonS9QRiugH8uH
         nZX7hMfkChFN65AV8PxrKN9312aN6OphfXxYa2KEVvDk9cJ9UQRnzedMpsuuxRd4jgfw
         w3kuGC2D8F2z8kUnp0ewEqqsP8tAttjmaaVd8Sef4kw09vJIE5ncQu+ZPkCTLwZNigqm
         fdGHYXw0EXt2HWl2pxPyNydlRaRjOo5JoVksAADWNLl6H0BCBJGpwkHtww0FvWbSScxB
         HAfHPW8TcCULwzbKqw57Y6chuIOAgtYgHS+5cL06NVeY/pseZoe/zvXQ3Hh7Ba4kQpTl
         k7aQ==
X-Forwarded-Encrypted: i=1; AJvYcCWewOJOYiJ3HkKcrDh0NqEZmsCpemQLu6Qmdkl8zZf6XUYVhdTc5Td8Nne0kN1s3ySuxzDuR00mVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6QV7p/4nYIHqJ1jXNPjE/eDWMBTaeJcBQD8bXIYLs3Yb55ckc
	2xN2KGbhEUs8k3OW4tnyv0Ll/dypHujJcY5j+WTf2pLH/aOXVvLzU38mAfle
X-Google-Smtp-Source: AGHT+IFPanvHP29hzD1Wa2DACXRqIjQK4C3YmvlZklS79/7Q6ZLftiR2RRqFDl1tGJS/olp+b6EX1w==
X-Received: by 2002:a05:6902:2b8e:b0:e11:44b9:6bb9 with SMTP id 3f1490d57ef6-e1a79fe3c48mr10386397276.3.1725278912200;
        Mon, 02 Sep 2024 05:08:32 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1a6266f36fsm1672083276.22.2024.09.02.05.08.31
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 05:08:31 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e1a90780f6dso1936276276.0
        for <linux-sh@vger.kernel.org>; Mon, 02 Sep 2024 05:08:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX6qmV7VjUqtPf6GFYzeDmfBRQAPF60HfO6cW+4gewcdaz7NTkJeK2i09aIQLsmJy+vx/NmP2oC5Q==@vger.kernel.org
X-Received: by 2002:a05:690c:ed3:b0:6cf:8d6f:2bef with SMTP id
 00721157ae682-6da17523a8fmr11891577b3.7.1725278911421; Mon, 02 Sep 2024
 05:08:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902024534.2288168-1-lihongbo22@huawei.com>
In-Reply-To: <20240902024534.2288168-1-lihongbo22@huawei.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 2 Sep 2024 14:08:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW=xCWHOcMnY9pKpxB93V2GqPPBRa7pPH0fOVDh1HH6-A@mail.gmail.com>
Message-ID: <CAMuHMdW=xCWHOcMnY9pKpxB93V2GqPPBRa7pPH0fOVDh1HH6-A@mail.gmail.com>
Subject: Re: [PATCH -next v3] sh: intc: replace simple_strtoul to kstrtoul
To: Hongbo Li <lihongbo22@huawei.com>
Cc: ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 4:37=E2=80=AFAM Hongbo Li <lihongbo22@huawei.com> wr=
ote:
> The function simple_strtoul performs no error checking
> in scenarios where the input value overflows the intended
> output variable.
>
> We can replace the use of the simple_strtoul with the safer
> alternatives kstrtoul. For fail case, we also print the extra
> message.
>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>
> ---
> v3:
>   - Separate declaration and assignment to make it more consistent.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
