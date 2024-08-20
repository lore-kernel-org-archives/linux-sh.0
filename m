Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61947194085
	for <linux-sh@vger.kernel.org>; Tue, 20 Aug 2024 15:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167936; cv=none; b=q70YFtLnTqqdP4HjDfWyUlRcBFHWzNZTOswd7DkwAf7Wu3iD/XspJLCtgSHUnry3WuXGxA1tcgN6lw2pArNilDXhXHQqwfbLjyCigEReJSNjNaSRG6p9j23Gi7ejpH+2xagcs8fC3+8ccxF5YPcVBUXW5lV0PLfRf1Ljac+COeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167936; c=relaxed/simple;
	bh=MiDlbS6ff17tWH6m3MZ6F9tz3FBlacdmGvTetKNSYdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ljo2m8Rlf3OkA8Gm9div/vhtLhwSZ+Ljo6rApDp+B4pUNbbGu2yr85VsOJXPYLOlF8nNMAGM35LS+kuansqqUjwnlI+0pRtkA59T/UY6ljK4UpBmIVaq/vxKOpG+8HaipOGTf6VihfdkcXB7qVgAX7aiFGDqFfe6jFDiWeY1sp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UHYOOkxN; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UHYOOkxN"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7aabb71bb2so617712966b.2
        for <linux-sh@vger.kernel.org>; Tue, 20 Aug 2024 08:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724167932; x=1724772732; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=reG4/g7c03D2ee4fl6pmLF83MA+CK6ivPFyQdUf/2ns=;
        b=UHYOOkxNVXM29kamtryO07bOv8PDGfz6NrY3GUn0HaOsR79Wdv/4EdikNHzwzqmuuf
         2WyVDsWNsLf5e5enYY45o6eRvNlHTjCRnmTo9bSmQQRfznhtX+GTjjjw3CbXiIosGWew
         OmJEgsHyLVBzXKWa+G2/qnm/66SLAMFvq+d1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724167932; x=1724772732;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=reG4/g7c03D2ee4fl6pmLF83MA+CK6ivPFyQdUf/2ns=;
        b=D2GdbcAFj0KwU29MAF8uy9xTaFpbLHe3c0Ciw+B8zqxyeuDi1goNjc+OToIFKZj9dN
         GciMsitZhdXurcjQUqxyIKtT8xbZvaiIlDZb22ILMewsxJv71ETKM6SCBd4y7QUPOb1D
         l5Uc5l+YnUIkIastmN9pPijTm7E+EMoIxpMqeuKrWFq1FFdDD1VyHxvxobtdALU07S0u
         lsVaqDKjaB5YYBcTGbQS0gAYoZjIDGXiVMa+xk8Dsi1taGfRbtDCKXdtbYTH9A/LERmE
         J8nuuWrJ6QUbTbvQuKaqKCVQue4VcD453B2ED2iVJgYaWBDN2uHAFf3KY488xVV7EnQU
         nZRw==
X-Forwarded-Encrypted: i=1; AJvYcCXqjGqgJPm1EHkbSf0gKyVP58Djyg7d9acULPFKvwKoRKTztg0HXytX4/O/b4Mko5oJfXZBh24M+MHh1f7uZ+yaMERH5nw/alU=
X-Gm-Message-State: AOJu0YzuqFjonTcvJtGYHHTGkOc7dk/KzXAtSGh3PhplNm2+vpKjEJ/K
	svRBN7urz4QlGCHP/5Jk5rMWJCUDgCIt5fvKSnB9kBOW8yF0oS0qMMn7+zLxOvvL/qSuB5qzh6l
	EOEojGw==
X-Google-Smtp-Source: AGHT+IF1LP0T5TlygOyFfh/n6OURjo1jWc9HeERK2AcUTiUTu06t2FElX1+fL41meu+dk55rat1Akw==
X-Received: by 2002:a17:907:e204:b0:a7a:c812:36bb with SMTP id a640c23a62f3a-a83928aa084mr1055356966b.8.1724167932162;
        Tue, 20 Aug 2024 08:32:12 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c687csm768897866b.9.2024.08.20.08.32.11
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 08:32:11 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5becc379f3fso4369624a12.3
        for <linux-sh@vger.kernel.org>; Tue, 20 Aug 2024 08:32:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXT4BBQOgpEspkmfwNj3ufstkOIbyjhGtzA+k5RoZ84iERuOIx/IFOII3lAx/9fZme0hpa01pddnoOy+eD89AjgTou1UyTyM60=
X-Received: by 2002:a05:6402:2710:b0:57c:c166:ba6 with SMTP id
 4fb4d7f45d1cf-5beca5c5750mr8152922a12.19.1724167931490; Tue, 20 Aug 2024
 08:32:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812082605.743814-1-mpe@ellerman.id.au> <20240819185253.GA2333884@thelio-3990X>
 <CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com>
 <20240819195120.GA1113263@thelio-3990X> <CAHk-=wgsDJ+sA1T01YT-z5TXs3zxJ54f0VDApkZ1pgcr8T=myQ@mail.gmail.com>
 <CAHk-=wjzYKrwSDK3PFMC1C2x37aKzEuC7dVxg0kGt8h+vjZfjQ@mail.gmail.com> <87y14rso9o.fsf@mail.lhotse>
In-Reply-To: <87y14rso9o.fsf@mail.lhotse>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 20 Aug 2024 08:31:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiS7PMtL6oR6acNgWZr0NN4Ax4PQD_CYJKCiKS0mT=Z7A@mail.gmail.com>
Message-ID: <CAHk-=wiS7PMtL6oR6acNgWZr0NN4Ax4PQD_CYJKCiKS0mT=Z7A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm: Add optional close() to struct vm_special_mapping
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nathan Chancellor <nathan@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org, 
	christophe.leroy@csgroup.eu, jeffxu@google.com, Liam.Howlett@oracle.com, 
	linux-kernel@vger.kernel.org, npiggin@gmail.com, oliver.sang@intel.com, 
	pedro.falcato@gmail.com, linux-um@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon <linux-hexagon@vger.kernel.org>, 
	Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Aug 2024 at 23:26, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> > +static struct vm_special_mapping vdso_mapping = {
> > +     .name = "[vdso]",
> > +     .pages = syscall_pages;
>                               ^
>                               should be ,

Ack. Changed here locally. But I assume you also don't actually test sh...

It would be good to get acks from the architectures that still used
the legacy interface.

              Linus
