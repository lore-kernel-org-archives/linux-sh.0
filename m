Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E416517BB1A
	for <linux-sh@vger.kernel.org>; Wed, 13 Nov 2024 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731486406; cv=none; b=SQwWYWEVDUOXmqaWUi4NlqOsfrC+qh7CGGBd0tz9icd1iqRHFAygyfTMtiStXP5a0lRSW3l6v/wyX196QIIctUz3N0zZVad+gjUPQqAA4kR/9O5+yiW0Bwe1YpUij3nUt+NzycP54ixGC6pACw80Mb9xIpfTWD9x5YQKiXj7Noo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731486406; c=relaxed/simple;
	bh=V4K0Fth2DvsLif9b1PAWj8dDoRZ+IYCH7LCn/BEA1as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sJPblCNRbXifngQXIyiEwD5FV9iQ0q7+Z0UHWcEWegOZ/Dxc180osWP1RLeth9bUSxwoj7/revObW07ivjqugtcgVE6U73xT74zvheGdr763wP8T1hY2vYPcfPsurikBQnmPzgyu3FnXXvLiqwFl/F8XDdygeZdqi5/AEpJt82k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e30d1d97d20so5900210276.2
        for <linux-sh@vger.kernel.org>; Wed, 13 Nov 2024 00:26:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731486402; x=1732091202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zuED7LnH1vnb2oUGl2oqrdDugLLMgkJLvV1LuEM5c80=;
        b=G19LBTeNDdnyZu7BDDDtSqG2PSvvW/ArEYsfTz4DQ8gB8Emll+nPC0dwG3SqHPhpGW
         AegRFaJ4ar27ExmBADfLxwAcGDWK0j16ztFUgizBPvZcmcVwBFsJjeqQ8niwYtz1KdTb
         80fZqnn/nVOY1y9zi4n/7cQT288WvahXUTIJWQuwn+BCLyfOGEvpUszh+ZT9BXIwcp8h
         0fnpgxWFSWCRPSbsXhTIJlQYS2hikq5KX6EGB42KpbddO+hwiuj5yaxzOWBgWRbHF8F8
         8rbDpdWYGvY7EELs/GnQBZO+ypBKP4zYMUR4OHg6B7IJ/x4KQZSsXX/xQaWONJ3YrTQa
         /d5g==
X-Forwarded-Encrypted: i=1; AJvYcCWsR8415fdsgcdt640hJtLyH3+J9dHH0aOxEoxJ6hLY6CJGWIFEUrl8Nnh1TiRPTPWu3qRo3CAiNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyONeIBxZlHTm9O6tn5Z5hKHcoCAf5iXaJHAdZ79Us4DwjQiTQ0
	jUHk20v0CWN2KPCxQf6D/6SZxZ5MywrSpLvDA4TTWrozltT5Rk9wRFjvYLYg
X-Google-Smtp-Source: AGHT+IF2t9CE1K05fip0bhVgvlj90W2tZ8dfZH+tYcSTvUlmlN4KB2Urs8LYqzt5ezld8vylrh/jiQ==
X-Received: by 2002:a05:6902:1684:b0:e33:1486:79e1 with SMTP id 3f1490d57ef6-e337f8fe504mr18929683276.43.1731486401911;
        Wed, 13 Nov 2024 00:26:41 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e336f1ba829sm3183087276.40.2024.11.13.00.26.40
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 00:26:41 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6ea7c9227bfso66662697b3.2
        for <linux-sh@vger.kernel.org>; Wed, 13 Nov 2024 00:26:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUYJ8fTGU9oUchaUZMqD1ygBSWxzSDX0iNBsaMKLVWkOHHCELthhBv3tpNRgoUNJkIZYd0EWcvf2Q==@vger.kernel.org
X-Received: by 2002:a05:690c:6603:b0:652:5838:54ef with SMTP id
 00721157ae682-6eaddfd41ccmr201580587b3.37.1731486400581; Wed, 13 Nov 2024
 00:26:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030060813.1307698-1-chenridong@huaweicloud.com>
In-Reply-To: <20241030060813.1307698-1-chenridong@huaweicloud.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 13 Nov 2024 09:26:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXznLuo7QegG9giQo80HcRmV4MgKh67sWy2WJXd4Pry+Q@mail.gmail.com>
Message-ID: <CAMuHMdXznLuo7QegG9giQo80HcRmV4MgKh67sWy2WJXd4Pry+Q@mail.gmail.com>
Subject: Re: [PATCH] sh: intc: Fix possible UAF in register_intc_controller
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	gregkh@linuxfoundation.org, ricardo@marliere.net, damm@opensource.se, 
	lethal@linux-sh.org, linux-sh@vger.kernel.org, chenridong@huawei.com, 
	wangweiyang2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 7:17=E2=80=AFAM Chen Ridong <chenridong@huaweicloud=
.com> wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> When it goes to error, the 'd' is freed, but 'd->list' was not deleted
> from 'intc_list', which may lead to a UAF.
>
> Fixes: 01e9651a21bc ("sh: add INTC out of memory error handling")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

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
