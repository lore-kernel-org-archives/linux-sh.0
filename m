Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B411BF33
	for <linux-sh@vger.kernel.org>; Mon,  3 Aug 2026 06:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785737234; cv=none; b=PUMM0CPlgHaF9vV2NyANqQFGVnQcUlfqVR2Z43u+OLZrvDhx0I6F7Dpgix266Nf4wIxdsR67VIuAhP/4J2D7GQbA+t0tBjbU1WAfWiV/3t0KKGkZgrf3MR3bCfcBE4VzIzKiYUChjKc73XFTuXza6YL36Hwo0zYh4PHuF83A6KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785737234; c=relaxed/simple;
	bh=VpuUzNZIeLkJLIkoXwftqmDNHRolrZYRf8l4gCk8KQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8ssw8tW1NqQ+0hFSK5d2+0mdDd+N79SGr7JydPy83qlQ7MUFHNwxxBhT89VyobZmjm1tOiZ+8mCydufNkzUjoSyGOfHaq0Igoc8e43a3fzONy5gv0qSLYeqsvD/Iay6aDiZohHmqKT6/a6xGHO6FseGE4AfS2sZe7pGKSgPgrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGmmdb9s; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGmmdb9s"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c9ef3e1337fso2108138a12.2
        for <linux-sh@vger.kernel.org>; Sun, 02 Aug 2026 23:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785737233; x=1786342033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=438aZJFh3TYGe28EMm9S/1fNbKwuwZnuyyU/vtthY80=;
        b=MGmmdb9sHhAiNEHrS3RB/K4nJjneUpGLrhBXysxIPEH/hIHQTwTjQt4Qmx40BKl9uW
         PFsojvHCNkxwVJoJB3/BNXz9Tmd9DVo+syMI+ZEKtkjtX0Dca6tMkL/eVIJ/0aPLKlid
         FDKFtxGMsDhKizTyZ+LeOhwnBxyv90x5ZoPjZQuFcCEaFIzXJ47d731GW2DObMc6GHE4
         9Egknpi7lXso3YTlOnoMZFRnv8kgk488802wdG1hX7sBV/POhjaXAmbbxkIPBfu5jxs7
         NIySeFnEh1j3QTv1KCdwMt8JDVy87h8fLVku5pzI798OweoUByCim2hBjfsBCxE9CH7A
         7ceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785737233; x=1786342033;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=438aZJFh3TYGe28EMm9S/1fNbKwuwZnuyyU/vtthY80=;
        b=S0giJ6Yrbc9Ah5Ba5S72Ua3e6ADcurNYiQMhj6l2AvWLr/PZ8Feu2pJghIy5aCKAHS
         vb8PjZk0Ll8CpHm0vbv1hXxjGqms1h5C/+rTchm2yrKeXpop4w9jXSqX5+fxPlxbmCgp
         x7P6spYlGzePdNvKRwnGU5svvYm5nrzfqEeDNzGgv4AScVPb5y2HNyHiqxfuK7hM0hI9
         BnPfylriEv9lF42e16q6sw8KWp2LNlob7JVuohq99QxFtwNiaz505lofBMnK9Bl/vb/4
         8Ffz3+V7L//KVlLd/Y8b8BF0ZMM4klYB0EtVR7sSh5iQGp/l9sJHvmBHS54V84/UVxyP
         tJbQ==
X-Forwarded-Encrypted: i=1; AHgh+RpA1pkbt4Ifkn73LZZX6D5PRLMS1Yx2HSu6d5izFQBzEHw2w1NLDogw3fI3jwetAcugiwom3gNN/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVy3vfZppiYOog3Nw+7bU1HGSoLAGIUcVQD+oQbQaOqivdvAXu
	9xwLIwG8QbXaBDFMKQNIBNjBmbTOeyRmuTdU0qtJXsCfIzZ/byAPO1d4
X-Gm-Gg: AR+sD11oVAjAP3Xg/LRZF/f6kEviKVKtBhDoAaGivrOAw3N0cI2Cb3uv7EsXll6Ueg/
	RoBYg3qM5hC0HP/R0lFqL0N3vAfWiV2b6N9BsHsbC7fW3QsVgQwmBx3VA0rJS6pu4wam2ucwFBa
	kxaN7KflrOjMV9vLaRIBJ2ZuUhJlyQ3EnxzAVNBYDNj/GL8b+utje/qg53ADeXHl6+lur8nMPqr
	OhFrtx/VcHgN/beOrOqFzo/DrHpUXg+HTigInDOmO8DROb5ZG22zB+h4GBsQXGfECLdBHwZTstH
	kLx/ulI+jjIE2JsRdqeM65V1pcbl9ggzoqTMSxTvg6ONF/e5QmJVomvho5FMGMGtZEnbatECEGN
	3sZCkeIw0bwzBmgPzMCxClyVXLZmlGlJt5Jj7J0CMoWDRBUiDnlTVx57Co61rwY0z9R7sCNhVbG
	FDYYzFQSpQcjkAWjgAzWufeN27OnW2NLuDPRLjrfGXc80cPbMgK0mCV8Vv2MBf0CnhAXW0yC2Q5
	PIsx2koVJBTAO18z++pIf7dBiewMw==
X-Received: by 2002:a05:6a21:7a82:b0:3c3:652c:664e with SMTP id adf61e73a8af0-3c92a98f2camr9231223637.69.1785737233015;
        Sun, 02 Aug 2026 23:07:13 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:4fff:876c:cdae:e53c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153db2f911sm37519963eec.0.2026.08.02.23.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 23:07:12 -0700 (PDT)
Date: Sun, 2 Aug 2026 23:07:09 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] sh: mach-rsk: rsk7203: avoid using inline compound
 literals
Message-ID: <anAvJM0u_TIgL4ck@google.com>
References: <20260802-sh-rsk7203-swnode-props-v1-1-7a790cbac9e6@gmail.com>
 <32a0d810bfc56029453aa72cefa49cb40466f64e.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32a0d810bfc56029453aa72cefa49cb40466f64e.camel@physik.fu-berlin.de>

On Mon, Aug 03, 2026 at 07:47:50AM +0200, John Paul Adrian Glaubitz wrote:
> Hello Dmitry,
> 
> On Sun, 2026-08-02 at 16:18 -0700, Dmitry Torokhov wrote:
> > Using inline compound literals for property entries in software node
> > initializers causes older compilers (GCC < 14) to fail with "initializer
> > element is not constant".
> > 
> > Under C11 (6.6/6.7.9), initializers for objects with static storage
> > duration must be constant expressions. Taking the address of an unnamed
> > compound literal nested inside an anonymous compound literal array is
> > not guaranteed by standard C to be a compile-time constant address,
> > causing older GCC versions to reject it.
> > 
> > Fix this by declaring property entry arrays as named static const
> > variables, ensuring their symbols evaluate to unambiguous compile-time
> > address constants.
> > 
> > Fixes: 6905cdac0e51 ("sh: mach-rsk: rsk7203: use static device properties for LEDs and GPIO buttons")
> 
> Isn't that the patch that was forced into the kernel, overriding me
> as the maintainer of arch/sh because Linus Walleij got impatient and
> merged the patch into an immutable tree?

Yes, but incompatibility with older GCCs is not something that you'd
recognize on the spot, would you?

Also, you seem to be hung up on the notion of immutable branch. This is
simply a branch that creator promises not to rewind/rebase so that it
can be easily shared between different subsystems.

While we are at this, there are a few more patch series for SH that I
would like you to take a look at, pretty please...

Thanks.

-- 
Dmitry
