Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64A3823C4
	for <linux-sh@vger.kernel.org>; Thu,  7 Mar 2024 08:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709800883; cv=none; b=DHs9TQMowAaoYyF1rLF1t8YPf5s0BsOFegx4UrH9dBY0D6N8nuJYbJkzEiuFBKyTxjUnPqz8H3OyXL6ogLVNJmYHOXgJBl1H8uErHGMPhyVu+Rma4R7zE1H6A5rkUdv+tbRejtdLQdSKxLltU1/qfZzFPyTvD0MPOAd269hZcUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709800883; c=relaxed/simple;
	bh=dmbcXPAfzjHm0Kb8Ee1YEnxPXSZDi2NYb84yeB30Y1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUdLXqx3ZfFkBX4cTagfn5piugVA/1AL6EtGCNSOFcKQhVOVor+i+rePdyq/j0BIbfVAj/6isKvdTYJYP+vSV9Vxa6ubSDkYGiam83miE3yYoDQpTNyGV4k/Z4NA/cLjYi5mxUkeEttxysbYmlQLOOVpYCdupsTo7RFO6+nmu+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-607c5679842so6310717b3.2
        for <linux-sh@vger.kernel.org>; Thu, 07 Mar 2024 00:41:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709800879; x=1710405679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VnsB0fuBjJ70ccWufOaEQy3EKsLWZhwQxLd7Vrj1NkY=;
        b=ACKwemb1tjzhjcnTnsnP8zAsOVzYH9noaJmcOlC321DOfxcraf/55dENv72YyeAn61
         zljzrW+3Hu/Uyrb8zETRj+GNE8mNnY6YIPUACfJtZB0s0Oz3RYq2GDLFS71Ol1o4ePTH
         egHWvnYoTbxuKKt2N9MTQSBCS9DA9QjkVwCvKAp2RZ+9l+iIojaCOcb8iujIhBbpg9hI
         Cx6u/bkUYSPuoHEJeffzn5NKijLIf284SiYB7zHHUHx5pitT2PL18JPtn/ZXAsC4/0V8
         bwQ6cWRyzlb0Usbu3cV85E4LE1LAmNO6JUkf9AbIfrPwh1Q1xaAzddgf4Q5Bbb8FA+ot
         C1xQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7HPaf/Xz4DomrDLqgxVkVOBhU7aPZw0oZpoNnjeUrLIS2uyaZBTboIFTCnRRiJbAjMHvW9LgY97ZdGnelwMGMaHQMKi/v5U4=
X-Gm-Message-State: AOJu0YxUZ+aBgxb3rqt26cUbh8AdU3KHpCYM9tAI14VrNnKItQi42okN
	3GhM18xqxouGb/YCC6rbsCi9Thf7AChzz8e239BcoIjUsrfrBpLt8Gh4ndkyGt4=
X-Google-Smtp-Source: AGHT+IHI82zm8ZoNBkkpywhvQp+bLQ+91l2kzYLcb7X06apDLV8qo+LjwjWi4AWofn8O+uahKsrvjA==
X-Received: by 2002:a0d:ddcb:0:b0:604:2c8:e49f with SMTP id g194-20020a0dddcb000000b0060402c8e49fmr17238950ywe.50.1709800878816;
        Thu, 07 Mar 2024 00:41:18 -0800 (PST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id n39-20020a81af27000000b0060485f86449sm4058375ywh.69.2024.03.07.00.41.18
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 00:41:18 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc6d8bd612dso615506276.1
        for <linux-sh@vger.kernel.org>; Thu, 07 Mar 2024 00:41:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXRDdKvT880lZ2PGudKfxzVl9tsa73o9w81qrCQXkDdxQVjvEywDe7XKPvQPCXVY2veEDaiPpJ+yEAA2Wiebg9Em4Jz3RLfgrk=
X-Received: by 2002:a5b:748:0:b0:dcf:6122:ccec with SMTP id
 s8-20020a5b0748000000b00dcf6122ccecmr14953419ybq.36.1709800878264; Thu, 07
 Mar 2024 00:41:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306211947.97103-2-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20240306211947.97103-2-u.kleine-koenig@pengutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 7 Mar 2024 09:41:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVa6WZs5xCoQpEgn+Ta=mN4h75DN2dDxm-4eyh4wrrtHg@mail.gmail.com>
Message-ID: <CAMuHMdVa6WZs5xCoQpEgn+Ta=mN4h75DN2dDxm-4eyh4wrrtHg@mail.gmail.com>
Subject: Re: [PATCH] sh: push-switch: Convert to platform remove callback
 returning void
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Duoming Zhou <duoming@zju.edu.cn>, linux-sh@vger.kernel.org, kernel@vpengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 10:20=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

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
