Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EB617BD3
	for <linux-sh@vger.kernel.org>; Tue, 20 Aug 2024 01:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724116306; cv=none; b=kQHCRgerLEnmkJmXOIenW8fs6D1uIJOC1e0b9sO/CJtcBiGu/Na9o4IPNmfoiQn3wSXmD12YFsJ3OmnY1oiGGQsojNwN7zcvEg7lZau5o68paRwWqpXkc152tQJiGYiTYlRxZ2VZ6NpuK0Vuj4mCvc4ff/U0SjlQnAeU8StCLAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724116306; c=relaxed/simple;
	bh=UwkZsnmFTogapUcvQLNdDygak09Kfc+DA1y61X4GWs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iIcJ21TjhMkxSKV+4gyF48dB0SwuAAzkMGKgy9GIiGmqsxSTc0P8tf+zTEUIubl4LRkPPK987/8f/yrfxRPcKt4NQP22VgYwM/yjLNeX/mmcI+aQVjpvwkDb1ij1w1WxQmHpxmY3fXafYBPYEBARseP+zCJqo14UeeXBp9cuHoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cczUGS0P; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cczUGS0P"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5bef295a429so2300669a12.2
        for <linux-sh@vger.kernel.org>; Mon, 19 Aug 2024 18:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724116303; x=1724721103; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J5Wu1obaVVIh98VUfFJoSH8iTiA4TVMtHy8zZl6wgS4=;
        b=cczUGS0PQ1YdekV7iQZDZrupLGd8gJ9vUdU+VlYz9RrJTiwOY9pQvBv1+pIfMZcExt
         xf0Ruf54mw20BQMmtO/3WQyv7xzAcSv/uLlFJYD1F8K8bKIEmbfXTBy6vZurkxtKxxOM
         Cq2uWazRamKZCwqiqRoUZaKvApZ2uK3nPlF5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724116303; x=1724721103;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J5Wu1obaVVIh98VUfFJoSH8iTiA4TVMtHy8zZl6wgS4=;
        b=C+tUs5U5mzB/pKsSX+fvEqOCbTgjVQWwFTtGT0qIXtsNlxZvi2bp9sWenOjrqpANzS
         x+AhRbyC9CTu5fep0ksk4c2Z3ZZCa7mzCsJpB8BEz78lP7fvZE+lodgx9G1l4uXfszHE
         j2t0MHkDFHyk/vYz9pesMahKlW2XzY9m/SnFEJd8TVdp5gdg1+zYgHHnUXOGw56i4mmM
         2SImPwKRqVLETl6JqrKHKZ3pQbLgP6RYrSj8/+To3hFpE7fFpXCF78w4QdeGvIfSsnlE
         OHSzdOWUuRnP2PiLDmrP5UANtHM3XOiUJVJElLgTAeedVB76MOB3YC8aVktYXUGfxUhQ
         nOPA==
X-Forwarded-Encrypted: i=1; AJvYcCXpbcf3dvxlO4QASg8YhX4uoh7W7py1OX/64mMh5bsrPVePPSFe0a+5yTpgdis0eZJdkWRv6EPLtXM8q2irgeCflaK+MYDDZA4=
X-Gm-Message-State: AOJu0YxBKd/mHECN4XOlJHuJLKp0CJleCXHVFQRDXiPZW4vZOjIhXguq
	LUQEh09tntsqI5kuKGhFSXjCaspwjQ/iLH4bB70656GCCpWKC2xpOi9rsq/jZ+9t/HmuSgnBpMk
	DK7M8nA==
X-Google-Smtp-Source: AGHT+IHXRJhbWjh+kndVHrHwH+yzwfqa/OvFZIoaIrD0v2HaMbQg76rkREeIIbg1Jj5c3fmKjIFuFA==
X-Received: by 2002:a05:6402:2691:b0:5a1:cab1:fbd0 with SMTP id 4fb4d7f45d1cf-5bf0d172e52mr425283a12.5.1724116302960;
        Mon, 19 Aug 2024 18:11:42 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebc081db4sm6115799a12.88.2024.08.19.18.11.41
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 18:11:42 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5befe420fc2so1955245a12.3
        for <linux-sh@vger.kernel.org>; Mon, 19 Aug 2024 18:11:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXmIULEpATItlBjxm3QtRD4EvURBb20soiLFP5Vd5iMlh9tTCAp3CxeQNrMLMrYzX08+GfQzkXgEwJ2O/iwJP8Lj8zaZQGravA=
X-Received: by 2002:a05:6402:1d50:b0:5b8:f69b:65e8 with SMTP id
 4fb4d7f45d1cf-5bf0cfbca19mr536978a12.0.1724116301657; Mon, 19 Aug 2024
 18:11:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812082605.743814-1-mpe@ellerman.id.au> <20240819185253.GA2333884@thelio-3990X>
 <CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com>
 <20240819195120.GA1113263@thelio-3990X> <CAHk-=wgsDJ+sA1T01YT-z5TXs3zxJ54f0VDApkZ1pgcr8T=myQ@mail.gmail.com>
 <CAHk-=wjzYKrwSDK3PFMC1C2x37aKzEuC7dVxg0kGt8h+vjZfjQ@mail.gmail.com> <20240819180548.9f5dac3ac0bd09a26c0d0948@linux-foundation.org>
In-Reply-To: <20240819180548.9f5dac3ac0bd09a26c0d0948@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 19 Aug 2024 18:11:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiyxQMG7gK5d=_UEcHF2PV3EoCFrENEhRvJH9Qsk7cOeA@mail.gmail.com>
Message-ID: <CAHk-=wiyxQMG7gK5d=_UEcHF2PV3EoCFrENEhRvJH9Qsk7cOeA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm: Add optional close() to struct vm_special_mapping
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu, jeffxu@google.com, 
	Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org, npiggin@gmail.com, 
	oliver.sang@intel.com, pedro.falcato@gmail.com, linux-um@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon <linux-hexagon@vger.kernel.org>, 
	Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Aug 2024 at 18:05, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> >
> > I forgot to actually attach that "this". Here it is. For real, this time.
>
> Thanks.  Do you think your one-liner remains desirable with this fix in
> place?

That patch actually removes the whole 'legacy_special_mapping_vmops'
that my one-liner then removed the '.close' field from, so no - my
one-liner just becomes a non-issue.

NOTE! That patch of mine *will* conflict with Michael's patch series,
since my patch to remove legacy_special_mapping_vmops was done on top
of my current -git tree. But it should be an obvious conflict, in that
it just means that the addition of .close never happens.

               Linus
