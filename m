Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE8F32695F
	for <linux-sh@vger.kernel.org>; Mon,  6 Apr 2026 09:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775467259; cv=none; b=Suvw51CgbL0SYaeWooUcwWbJyB2BMzjBpth+klTB5EaUFv2MAr6ZccUJy2S8YEVuroSiB3sg8pvSGqeiLwUrxJ8mDEp7EzuycDvE5FR5rMV5mPdH0XiLoyMXV22+CXVrIbm8Pzsbd/sqVrRecR4aaEbSu6HoUL1YK9n7m/+TxXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775467259; c=relaxed/simple;
	bh=IgU3eU4W+sVmA8d7yMm4ZRx1IYybkbdICQHn+KGsYV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDDmgcsRsVHmktqyZ/W6r6I9kN3aI4YeK5Sc2gaGaycbzkoEgViK6yh8CdI4KEbTbOXngPymrbggPFHxpphMoXeXmwf6Asar9CY7Be3SW9nK+/KBoLwQD7iqiU8kN7mGCioQdH5uf6vDeS5at2MsYdPXQDpS13jX5x1vvZDDd3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAb4ek6q; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAb4ek6q"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4887f49ec5aso53056955e9.1
        for <linux-sh@vger.kernel.org>; Mon, 06 Apr 2026 02:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775467257; x=1776072057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hZrGZsmG7g8q8sMfaEj2OQLEbPpdT6Ueoh7ZUf4s8zw=;
        b=eAb4ek6qPqyVPO/rQ3gv1bmRCfZLYF5KLan2vQV49eAO9RLnX3aesjFhEfGAVTrPWP
         RVbEQ6rpzq9LP1bhEmnTHbOpbCYxhho5GRqE1kU5SyIaFDBf18fOZXPkMYIMAUjI3smr
         +Sy+iKG+/oNuosvWoMXn22aFCsXzQadjfv+FTA2fTfZdGywt6x529l6emfL1GFPS1y/7
         /vGzXATnQCO8O/xdfUDOuPMz8WhU5imLdFV4BzZ/nfxfeWi/Hx8WVc26/LpJ7UrjsExU
         os6xYIBNZ2hrXbsXd/L3THPgRtiRRMuzkCxOV6lyjuz/hBgeEN/18PlQGbsVlnsop3CJ
         gfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775467257; x=1776072057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZrGZsmG7g8q8sMfaEj2OQLEbPpdT6Ueoh7ZUf4s8zw=;
        b=s4GZXRmr/HJoL1iC1Bke/iF6LTIwi1mat2w69lVoeXRSkPRvFyfmTePptXIDmmtWBy
         kWfnbAWco/jyI48osBeOwHCeDSw22lFS0XCiNwQmsy6tubr5Jnyl2PWoiTmokN9wnmzR
         T9E2BueMwHIcF+XtAgPewFsd7wgrRzlH17Dna1LNGSJgpwRFst3nvXuRPQLU6Zbi3JiA
         f1H6a9bAXfURx+wClAIvAuhD66rn5laf9FTo3XC4mRngqJ+nnIX6ZxPKeyQvpk/4d0d1
         mohI27NJuEqi+9Z9c7+RxP3ZYXPBP869v1BnrWIsqZhFYq4xLLgtwllX2+fO+gOIh82T
         7zXg==
X-Gm-Message-State: AOJu0YwhQ3+h41r+h1d3eBrJX137SNmDA3CLpT0Js1gDvE5QS5jILEs9
	9DteSnktVgAQA1jHEE7wnsGaojh40UZ62AReRx3jNJrHVo3+l4kXjCw=
X-Gm-Gg: AeBDiet8nQ02buj+nAB+c1DvNsrRTfrLNfNjJORJ4A0RMNG4rIqGq4E0gslnHNTXaNi
	DIMhLV5yP5ABymjK9uic+klOM4VB+OMZQjmcv8fcsFPf13yEvW0OAeiHwucOtcRHMQZ1ZInWpbs
	T/3rrc1YbSOYJyfrMceGiERFeWUBExEopg1t0p+eCZRN3zw6tFEvwAJ3rSRAexIyDDcgBDL8ISi
	5OXzUdBmNgtdrK0fuuLKSM+PNm91d+KnOvkvzVJzWzGa0jLRRpliw6Aqj6bNKfF+zSVGFBdZtDr
	5Gp5zGN+kHVBZwu6RdUIblaAWwSdaOo/FeAJS3o9ksjf4CjDAuSxMBUICXnfzfkrK7HgUUZmixD
	Xa7pLZuSBI/PAQfI7uWmA9FFFooGr7cYgypbD8xrtQcny8suzXILDOSSnY/vc04u8qB1H1OuXG5
	Iun+qnrq51ktLsLzCCQ2o+evD9L8LIS5NYAkPf7t3lDZL5wouMwXqCTbN/bPg4z2FVoo5akWlQA
	Fdw
X-Received: by 2002:a05:600c:3546:b0:487:5c0:671f with SMTP id 5b1f17b1804b1-488996e8774mr175771605e9.9.1775467256768;
        Mon, 06 Apr 2026 02:20:56 -0700 (PDT)
Received: from lithos ([2a02:810d:4a94:b300:aeeb:3bab:9e78:12a6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48897b8f40dsm120374475e9.0.2026.04.06.02.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 02:20:56 -0700 (PDT)
Date: Mon, 6 Apr 2026 11:20:51 +0200
From: Florian Fuchs <fuchsfl@gmail.com>
To: Adrian McMenamin <adrianmcmenamin@gmail.com>
Cc: linux-sh@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Artur Rojek <contact@artur-rojek.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cdrom: gdrom: update gendisk capacity on open
Message-ID: <adN68wCJd6QEZyNW@lithos>
References: <20260405082330.4104672-1-fuchsfl@gmail.com>
 <20260405082330.4104672-3-fuchsfl@gmail.com>
 <CACwZE5Rmy3A0k3tvc32gv0V3T1LL2PaP_+S7N87mwNppLTh=PA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACwZE5Rmy3A0k3tvc32gv0V3T1LL2PaP_+S7N87mwNppLTh=PA@mail.gmail.com>

On 05 Apr 14:24, Adrian McMenamin wrote:
> On Sun, 5 Apr 2026 at 09:23, Florian Fuchs <fuchsfl@gmail.com> wrote:
> >
> > Update the gendisk capacity of the media. Without the capacity, the block
> > reads fail before reaching the request queue, which prevented ISO9660
> > mounts. Refresh the capacity from the TOC leadout in gdrom_bdops_open()
> > so it checks the inserted media.
> >
> ...
> > +
> >  static int gdrom_bdops_open(struct gendisk *disk, blk_mode_t mode)
> >  {
> >         int ret;
> > @@ -492,6 +511,8 @@ static int gdrom_bdops_open(struct gendisk *disk, blk_mode_t mode)
> >
> >         mutex_lock(&gdrom_mutex);
> >         ret = cdrom_open(gd.cd_info, mode);
> > +       if (!ret)
> > +               ret = gdrom_update_capacity();
> >         mutex_unlock(&gdrom_mutex);
> >         return ret;
> >  }
> 
> 
> Will this not reintrocue the potential race condition bug that was
> eliminated here -
> https://github.com/mcmenaminadrian/linux/commit/2bbea6e117357d17842114c65e9a9cf2d13ae8a3
> (not by me, I add)?

You mean, because one of the functions in the call tree of
gdrom_update_capacity() wants to get the mutex gdrom_mutex or s_umount?
I checked the locally called functions, but don't see that one tries to
aquire a lock.

I don't understand the exact potential of the race condition, maybe you
can elaborate, where I should look.

Thank You!
Regards
Florian
