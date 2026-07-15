Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E7542046B
	for <linux-sh@vger.kernel.org>; Wed, 15 Jul 2026 13:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784120574; cv=none; b=rghpZrEnNvONwqZYkCFqVoOysnK1E6FeGQepdFl8i63grjqXOsL1aUWm/dO3Rr7AjKr23O1+zYUQlXRZIAw8rJFt/AGV3CLlQ050tnU1oOO6Jp/RoOZO1lQjQ8SlaHQPBBFbgGJYwhzDPlW83lw8Fgv6jI5+LhXdpLOmYXPvJrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784120574; c=relaxed/simple;
	bh=Q9WKmmDL5yk2UxjvBFSAMnAXSxxOebkqhlveLXiybOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYGTFAcS0WY5EWdAxZWtB829ZjbncnbzzbodusXHBDwBvL8S++cr3j4KcNuLNdKZvaSxTI2xNnwm8LPCWJeGYkEsJ/seP4gNHJyH+dcJRascrq6hzdvTTJlIohxSH3m4ZPiq4AFArqnow1Fwa3UOcV75x1/rH1qmqTUBb5xcHlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hj1OgcvE; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hj1OgcvE"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493f45e206dso4768445e9.1
        for <linux-sh@vger.kernel.org>; Wed, 15 Jul 2026 06:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784120571; x=1784725371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PSeXq09b81YQhnxUImK3dex3EJoQyqcyo4vK2V62L1c=;
        b=hj1OgcvEN9TI5L1a0osmPYBfZADlNkgv0l5uGAoB9yDaKtpxz35RC3aC5HiTnWN4zQ
         G0WJlPm6WNCeOQGnMzjkv+SfJBxEZwHVB5/UJq3PbaDBZf23O6enlyfWil1k1RvQkygg
         rm4diG/8Ffhk7APcbYzt9dEkqZmVunKPo8RjcxPCDIrqDkwRlJHA7K19yNE0Z3IrnGK+
         nDCPVV4j6fev5+3CbrDdFdkPeta5VJKcowKMfa+fV1BLklyehAN7V3WUt1OtpbSF64/e
         +CQIV5Eceunq+y74PuDnoS5ORFbWJx4I7Sq9zf2bbe8ZOt4GRT/U8HgIDV65JON6jOCU
         s80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784120571; x=1784725371;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PSeXq09b81YQhnxUImK3dex3EJoQyqcyo4vK2V62L1c=;
        b=STWuKKBkXOsaGOZLrhbx9MpdhfrpUfRuw6tXa9YY+n4nY0CCBQUzW3eIOXhPlJ0X2k
         tCSp81YXleAdwY21cpVYxc6C0d7RUkfLRbx8YedmZyH+2N7Vm9FbU4M0dShyYV1tXqrO
         5sjjndHqAb8IMaJYEDF+1W3s2QLCvhhpytvx7SiOUeeaIbJ9rJSzT1oqP3cuPoux10d2
         Rat13ADFhG9xVzwyRYP6jSLB5gV/QVAuzeKl5ZIb7p+bqXNzZEfrslcBL73ycu0oqMbA
         auwtJfN45izuCsec7u1Cel4XEhCpvOwf3pZgXcHUuvWX+tyw3NEvBQQAj4yc6TYCn7UG
         6tBw==
X-Forwarded-Encrypted: i=1; AHgh+RroJJB0pi/vVFru6slyAeR1VwOhncL1zy1D8S5h25EqNj50fJwPXIH+jKe89mMQFfp0V0O4AZTR+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YySHGMGeBu0RDr+RIrzFY0Vzejm51JZ2qNdoeEaD5TZknjS/YrZ
	Vb716DNCf4zbiqYQmRJwyiIk7kfS22SdWNaJIdM0dr5MgROCGYYHKcymt1mbfDg=
X-Gm-Gg: AfdE7cm2SVO/9k+lxoCykxLUwPtqQEcoeTOlYJSLqahCMNXsSVKeYBNhyN0QsNU5p6B
	zDSsqkqebhOmvARWnYKzK3+5y+t++WSha/vsVOhg4iuCWAUXg+MEYwkMOzit0KwTiHCpCQPc2bo
	Cq9Xv8d83YwObehQ5UXPSvwCu5+AXOOXwlaQ37MYQyrfZuvD+uUZ70Kiu/8dyMS2N+/EaKSuaG9
	bezeXv7xutVGY5t3TTpURovAsLRODp9VXyBAlPtzlsvCE4QspNtNKvEXjey0nAqNiR4yVekvMGS
	MPtYTloYOGxY36jUQ7aZUYWOxS7wPugW70q/M7uzT8u+uI5qi+5vj7yFnzvbXVUKyXj4OEXUn8a
	d1x6sTDPUUTKHm1OvgBuXmi2pJMkcmvNm+zbosg2BhrYX5tlrV7LFg/Qmi/yFR5AzKdPHxnktvK
	h1yEkX567TfDoxU5lp7JsxQI9qvThqMkjBn2ADmHNlINdmlFOCVtW0mqbEZH/hK558
X-Received: by 2002:a05:600c:1d0a:b0:493:c991:8e56 with SMTP id 5b1f17b1804b1-493f887bc07mr179081445e9.4.1784120570435;
        Wed, 15 Jul 2026 06:02:50 -0700 (PDT)
Received: from lithos ([2a02:810d:4a94:b300:6674:b120:9a0:79f6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464caeffsm15210239f8f.36.2026.07.15.06.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 06:02:49 -0700 (PDT)
Date: Wed, 15 Jul 2026 15:02:44 +0200
From: Florian Fuchs <fuchsfl@gmail.com>
To: Rob Landley <rob@landley.net>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh <linux-sh@vger.kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: Toybox make root no longer works as expected
Message-ID: <aleE9KPk3XhYj5_E@lithos>
References: <359d107fd9fe92a55e77be84c26d9ac86112fe13.camel@physik.fu-berlin.de>
 <71c6a925c748fb3c9c2af30362387f0e562c0f6f.camel@physik.fu-berlin.de>
 <alXpoJOjg5HrSvhE@lithos>
 <e67d3f91-aa6e-43b1-815c-4ddf35751ddd@landley.net>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e67d3f91-aa6e-43b1-815c-4ddf35751ddd@landley.net>

On 14 Jul 14:32, Rob Landley wrote:
> On 7/14/26 02:47, Florian Fuchs wrote:
> > I also crafted a bit with gcc-17, and my first issue was a duplicate
> > symbols (LPCS0) compiling libgcc like in
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=89012 I could only work
> > around with explicitly using O1 instead of O2 in INTERNAL_CFLAGS of gcc.
> 
> My notes say GCC commit 551935d11817 introduced that failure. Dunno why,
> it's big. The two largest chunks of it are:
> 
>  gcc/gimple-harden-control-flow.cc       | 1488 ++++++++++
>  libgcc/hardcfr.c                        |  300 ++
> 
> > And errors with libbacktrace, I worked around by --enable-languages=c
> 
> I hadn't even made it to that yet...
> 
> > I got gcc to not ICE, but it then fails with invalid assembler thats why
> > I became suspicious about the asm in question.
> 
> Yes, I'd found that failing kernel file, ran it through gcc -E to get a
> standalone one, and then tried to compile it with the sh4eb compiler (rather
> than sh2eb) and got the same ICE. Jeff immediately suspected it was sh2
> #ifdefs in arch/sh/include but unfortunately my usual attempts to strip down
> the test case failed because if you remove much the ICE failed to happen
> (since it's a jump-too-far thing). It's GOTTA be big.
> 
> The commit that introduced the behavior is, of course, adding tens of
> kilobytes of new code to the linux kernel in a syscall you can't configure
> out, because linux-kernel. (Play the katamari damacy theme.)
> 
> https://github.com/torvalds/linux/commit/76b6f5dfb3fd
> 
> > turns out, delcaring the
> > adresses as offsetable, seems to "fix" the ICE and compile and work for
> > fdpic, means it is maybe not necessarily only a GCC issue.
> 
> The gcc issue is terrible error reporting. The assembler swallows some
> assembly inline statements that don't work in context and barfs because
> "that jump can't make it to that label", then can't properly report the
> error back up the stack as anything other than "bad thing happened deep in
> the bowels of the gnu/hairball that RMS explicitly tied together because he
> didn't want people to use gcc's frontend to develop a new backend like llvm
> literally did anyway, ia ia gnu/Stallman ftaghn".
> 
> Seriously, the ICE even happened running "gcc -S" so I couldn't look at the
> assembly output it was telling me about. It complained about error on
> assembly line blah but DIDN'T FLUSH THAT ASSEMBLY TO THE OUTPUT BEFORE
> DYING. Grrr. Maybe a missing fflush(0) in the error exit path?
> 
> > diff --git a/arch/sh/include/asm/uaccess_32.h b/arch/sh/include/asm/uaccess_32.h
> > index 5d7ddc092afd..cef40414bfb1 100644
> > --- a/arch/sh/include/asm/uaccess_32.h
> > +++ b/arch/sh/include/asm/uaccess_32.h
> > @@ -92,7 +92,7 @@ __asm__ __volatile__( \
> >   	".long	1b + 2, 3b\n\t" \
> >   	".previous" \
> >   	:"=&r" (err), "=&r" (x) \
> > -	:"m" (__m(addr)), "i" (-EFAULT), "0" (err)); })
> > +	:"o" (__m(addr)), "i" (-EFAULT), "0" (err)); })
> 
> These are probably actually the correct fix, not a workaround, and maybe
> should get pushed to Linus. (With a commit message referencing how linux
> commit 76b6f5dfb3fd added so much unconditional new code to a single
> translation unit (which could not be disabled by a config symbol) that the
> jump couldn't span it and had to be promoted to a larger type, and gcc gave
> a terrible error message that slowed us down fixing it.)
> 
> Rob
> 
> P.S. Jeff apologized over Signal: he's caught some sort of flu/covid and is
> offline for a few days.

The offending code could be reduced to this testcase via cvise:
(see also godbolt [0]).

    struct __large_struct { unsigned long buf[100]; };
    long long g;
    void f(void)
    {
        __asm__ __volatile__("mov.l     %R0,r0" : : "m"(*(struct __large_struct *)&g));
    }


[0] https://godbolt.org/z/MWT9c6113
