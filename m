Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2784C3570AD
	for <linux-sh@vger.kernel.org>; Sun,  5 Jul 2026 20:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783283203; cv=none; b=j3izHotheZbZVxurcRj9enRixodSjb4Inl2py9BlIBca0ZwFojKAdM/XOifBhBbMp++ocwiXS6nQLFjMmFCqzc5S48THkfJwhEjVzUqvmIYYf80yjJzvA6Pbmh+roGBw6ewSgYuA7oBfgY1iKdeBKyXMmhfWM9Ncw1wXZtgxvXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783283203; c=relaxed/simple;
	bh=cOeJsDEtRMNDJCLsBLMsRmiTuNsQyfI3SUCZYl6u/WI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRXHGzJEP9dUyv1+NvCjwj9eDdj8m8LHMa3bObsU9KcawQsBm8Y4wETAiB3SDgHFeR8UuexRYQYM4JxIjwHqgMy6FMAyeUQOTCgMcjWW9wocRcZUsH5ze6GtzOEWrLTyAZMKr/h+bcS5uWb5QPqdCui0iHu0ywpdNuYPhxtIb3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLrDSVOL; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLrDSVOL"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-37e0a189b0bso1389922a91.1
        for <linux-sh@vger.kernel.org>; Sun, 05 Jul 2026 13:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783283200; x=1783888000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GsgfJZ0NjzP8ZPKGtPWCLANSMMngsdofAxBSh+8zVRQ=;
        b=PLrDSVOL+4Xc66iOiaOn5TYFsx78Abc5ssdEQ6yvuYzzUNpldHMK+Le+AJuPYhTHMK
         vvxC3arm1OaRVZi3iobzr7gL4DrKGBy4kmC0tNsgokfOz7nOj4xHhwYz0y8wrQLq2AFL
         wmHEcVm4tlst+mIKGPMoWyR6xmAKC1VGx0Uulm4QtlZMCFESsGoYeWxaJm9pHnq3Cfm+
         PYqls55968ljKZDpUHrcI26/rDhYu5VO2SxaJZpinLH+tpsidaPhBGXbcdXQlqKkZTT2
         NcrZglNcjq67Xame///L/rlENNXnbrpq9cl5jp5PqnLoRL8nd5ZZAC4Gt1fhzM6viqS+
         b2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783283200; x=1783888000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GsgfJZ0NjzP8ZPKGtPWCLANSMMngsdofAxBSh+8zVRQ=;
        b=WwJCL7QU0KRHVoEhJeB3CSTRtKcbTZc16dreR8mhTs8O5/JsieVikGTXxR2pr1tlqi
         ml95ji7dwmq1Vdif4Jd+W8971aLSbqnY90ZdTTstjJ4g9H8LeKE3pMkNetzNG9mc5GUP
         T8FifLQ9AlUwEZvemci83kTSZb6k7git2DlSLmSvv+yHACsWik7Q7SPqPNvTRDcYQOtS
         015cBbxG68OEBuiYSE51voMn8BoYIqdmNvpxCANgMvkNdYvR4pCezicRjtQ4D4nFiPtm
         YMVv6gtAUJI6Uqt+aX+eU6zJ9HxxrCT/7o6p0QLfSP7gxqGRw0oNNBLbalB7hxsf93Yn
         YwFw==
X-Forwarded-Encrypted: i=1; AHgh+RrEsKquuKr3iltFG80jkXfdC3SUUfQPQ/XC55Lvcqhd/NZEUTs+Ar17hn/Ecxv1tl0tX5NHUD5xuA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzU5Wx2Hg+vV1qItSQNG8geAyYbAU4ZR55CHM7MKQ0AGKYK9qXS
	85dhk08Y+8d9kcgY5jYfCnNrZXdyyFXbIerLZgkW4sRu7hExhAPHjQLw
X-Gm-Gg: AfdE7cmqI0p8pYu+a7ztXy8RY2gVNRzXPZDbccq2au2NSgZBPwvPeOgfzZaEdzWSqOt
	flZEVSmiUKNHQqoXWyS1yEXSfy3OJwpRZyoUvH6PURyPfQle86fkWRm0lZgkSWKu1NWMzfN5qu4
	iJ/OkCZUleqe3NzvVC+Ts2IsyeqOcVL2/7UTlus+1tUbk4sP8761x08+fXSHgM09W/NC9oBpujN
	wa2fgLavIcczyYcegIPEObCZVRxrKoDNVSUepfdAVlrONh7d5pXw9Ypq7G6lG2Qxy5jISkSxTN2
	nEfQLdO3Bup6wkYObxpvRtFYECKX0wV2RadNb6pRXqX3NwH2elyslTBKZ8aruLjFRQNsSODCL/3
	gjK+ZFo0hLNzEiiqZAq4tHwdkHhZxEjbERQozEXvO9FksUTp3fcmJj/psHikokMWqdQkiIidAj7
	Dmd1q+oMtTjfsOnsmgrjeCiXrWh+vIl8ZzEXcNwDrVrjIIJb075wfBaw==
X-Received: by 2002:a17:90b:1c81:b0:37f:9cdf:f03a with SMTP id 98e67ed59e1d1-3829f4e8836mr6779812a91.29.1783283200446;
        Sun, 05 Jul 2026 13:26:40 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:480e:1643:32ae:124b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f38ee1333sm29592829eec.24.2026.07.05.13.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 13:26:39 -0700 (PDT)
Date: Sun, 5 Jul 2026 13:26:36 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Adrian McMenamin <adrianmcmenamin@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Florian Fuchs <fuchsfl@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org
Subject: Re: [PATCH 25/26] Input: maplecontrol - fix style issues
Message-ID: <akq9m7oDV0y_sWzx@google.com>
References: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
 <20260703-b4-maple-cleanup-v1-25-41e424964da5@gmail.com>
 <CACwZE5RfhwhOoVSPqibM9+XaPJCf-TdnJxi_UT7Dgv71OJPsFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACwZE5RfhwhOoVSPqibM9+XaPJCf-TdnJxi_UT7Dgv71OJPsFQ@mail.gmail.com>

On Sun, Jul 05, 2026 at 08:28:39PM +0100, Adrian McMenamin wrote:
> On Sat, 4 Jul 2026 at 06:58, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> >
> > Fix coding style and formatting issues reported by checkpatch.pl and
> > switch to using BIT(). When reporting D-PAD events avoid conditionals.
> >
> > Assisted-by: Antigravity:gemini-3.5-flash
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/input/joystick/maplecontrol.c | 25 ++++++++++++-------------
> >  1 file changed, 12 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/input/joystick/maplecontrol.c b/drivers/input/joystick/maplecontrol.c
> > index 3ef6652d40cb..457a73d91239 100644
> > --- a/drivers/input/joystick/maplecontrol.c
> > +++ b/drivers/input/joystick/maplecontrol.c
> > @@ -35,22 +35,22 @@ static void dc_pad_callback(struct mapleq *mq)
> >         buttons = ~le16_to_cpup((__le16 *)(res + 8));
> >
> >         input_report_abs(dev, ABS_HAT0Y,
> > -               (buttons & 0x0010 ? -1 : 0) + (buttons & 0x0020 ? 1 : 0));
> > +                        !!(buttons & BIT(5)) - !!(buttons & BIT(4)));
> >         input_report_abs(dev, ABS_HAT0X,
> > -               (buttons & 0x0040 ? -1 : 0) + (buttons & 0x0080 ? 1 : 0));
> > +                        !!(buttons & BIT(7)) - !!(buttons & BIT(6)));
> 
> 
> Maybe I have missed something but what is this !! operator?

Double negation to coerce the value to [0, 1] range avoiding
conditional/branching?

-- 
Dmitry
