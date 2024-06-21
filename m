Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646B619479;
	Fri, 21 Jun 2024 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718980228; cv=none; b=cwZh2Iwbhz8DT1ZlVA8/hr+uFu5eTBT1Fb2JSItF9gigGpaTZuAbJoXLJ1NPocPFUdzJTe5eIbVR6UTVtckIQZ2x1a6tfcqjG9ttP/k91/SxWNtw9QdZZ3HYjcaCzE0EuShOniOGCjRGaTDt/it/9sMSs/ZWDBislqGJULSviSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718980228; c=relaxed/simple;
	bh=C9qYOkGelv2XUpeHQ8wIQkxwtn7jroXl2kr91jaYimM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQC+Cs35/bCvtw8xs3b+vXCMBNYXCyigWgwoBX/0Ubfo8IUjUWZLH15mJcEMQSxFH7ZsfrwQaObI6eOPoA3R0nZMKXMC843Utlupl6Wjsb3ZD47uCa0Hvq69r3B72VlrYDfUJBRaOTfN7aAp4/69092l6U3flMrKG875tehY6i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwdbRiwz; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwdbRiwz"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f700e4cb92so18569545ad.2;
        Fri, 21 Jun 2024 07:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718980227; x=1719585027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KdsPqr4pTjdk7OKzEKkqrsHBuqyR7Uqn4Y9WWtRu7DY=;
        b=gwdbRiwzVk/s4WtuBham41qCTok1woEH4DLDktuj6yNbUqVuMfogrJZ7eXp5VRKprn
         0r+cc2mMP0wJeTFF7l4L08PDQ8LSaQaj3eNynr+TTBWuZvMNHXQtbt90ni/ntIg1DYdj
         yiG1H/svYk7hrY/LwQUEOZHIsShuSh7KG/dZ1sN3PUT3DWAhaBD9KPetk7fI7dpUBGHn
         uLwk+TsloLjN6gL4ZMx06Qd/GV9DBR+IEpPM9bM7xtQesyhhzMLcVTLjYDc4xhhzLzBx
         BoTYdyBm5QoUnu+ysI3dgu5OHWnpfvxHlidq2QX5PfycbxSZ30xuDvUwbBk6rRRBo/+V
         cWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718980227; x=1719585027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdsPqr4pTjdk7OKzEKkqrsHBuqyR7Uqn4Y9WWtRu7DY=;
        b=jAIENSTiZO/ff8CO4WYaiyGd89B+nOXp8e3ODWeyaumGAyNzLCDOIvwL1CWqbstQdr
         6SqwT6CIvBLztj9+gUFTwz7m2fN3l2zHnpFLFK3jBiikzpoYE7+WaqByOLiQsz/jsvjS
         gPEAyZrEdxK9SDuyJSAS30hdni2uwpaH+fCztWoDsaM08Lil+rskVgZ5lypi9a1ulF7F
         xDPmQLW/9qGcFfQqomFxeFFe2/jMM+pun4Vcz3bl+Q17Cr12Bx3qrCeau6DSx5gcpOGw
         fX09X5c6J5mxSd/Yv+u/YfDeNmZCNVK79SXeoEQo9i2Z4KU7cixt7pPhk9P+pXZ1ODz4
         BVdA==
X-Forwarded-Encrypted: i=1; AJvYcCURf+hQI5Iv0XLxidWW1FL4vY32AkwdFgXbPyJcT3+FHPqerUqqJIIRCWgBLc4NwxIAa6BYmOllxGqKBREdk63HaxbrZAce/3o=
X-Gm-Message-State: AOJu0Yx15fIFjah7eO23UVE/XFqwTxS4x/mR/EIdyzu3jDmpVJ0FbuxQ
	ah2CIxguKfewrEqgcttkXQHtHqIqLyi/N15F/eVuLIxo+ibASKEJ
X-Google-Smtp-Source: AGHT+IEzh0eQJ1MaaD/+q47vXon+0x0K3sIw+WHNgKvN8TcM1jN1H1kKzTczyA+tCqswDM9nkARGbw==
X-Received: by 2002:a17:902:c103:b0:1eb:fc2:1eed with SMTP id d9443c01a7336-1f9aa41802emr76036295ad.41.1718980226505;
        Fri, 21 Jun 2024 07:30:26 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3c6156sm14660665ad.138.2024.06.21.07.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 07:30:25 -0700 (PDT)
Date: Fri, 21 Jun 2024 07:30:22 -0700
From: Yury Norov <yury.norov@gmail.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-kernel@vger.kernel.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-sh@vger.kernel.org, Alexey Klimov <alexey.klimov@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH v4 33/40] sh: mach-x3proto: optimize ilsel_enable()
Message-ID: <ZnWOfuIdjB5Hhf3M@yury-ThinkPad>
References: <20240620175703.605111-1-yury.norov@gmail.com>
 <20240620175703.605111-34-yury.norov@gmail.com>
 <4bd2e538d70d8acbdc8da7b0fdb05b93e0614e43.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bd2e538d70d8acbdc8da7b0fdb05b93e0614e43.camel@physik.fu-berlin.de>

On Fri, Jun 21, 2024 at 10:48:44AM +0200, John Paul Adrian Glaubitz wrote:
> Hi Yury,
> 
> thanks for your patch!
> 
> On Thu, 2024-06-20 at 10:56 -0700, Yury Norov wrote:
> > Simplify ilsel_enable() by using find_and_set_bit().
> > 
> > Geert also pointed the bug in the old implementation:
> > 
> > 	I don't think the old code worked as intended: the first time
> > 	no free bit is found, bit would have been ILSEL_LEVELS, and
> > 	test_and_set_bit() would have returned false, thus terminating
> > 	the loop, and continuing with an out-of-range bit value? Hence
> > 	to work correctly, bit ILSEL_LEVELS of ilsel_level_map should
> > 	have been initialized to one?  Or am I missing something?
> > 
> > The new code does not have that issue.
> > 
> > CC: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  arch/sh/boards/mach-x3proto/ilsel.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/sh/boards/mach-x3proto/ilsel.c b/arch/sh/boards/mach-x3proto/ilsel.c
> > index f0d5eb41521a..35b585e154f0 100644
> > --- a/arch/sh/boards/mach-x3proto/ilsel.c
> > +++ b/arch/sh/boards/mach-x3proto/ilsel.c
> > @@ -8,6 +8,7 @@
> >   */
> >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >  
> > +#include <linux/find_atomic.h>
> >  #include <linux/init.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> > @@ -99,8 +100,8 @@ int ilsel_enable(ilsel_source_t set)
> >  	}
> >  
> >  	do {
> > -		bit = find_first_zero_bit(&ilsel_level_map, ILSEL_LEVELS);
> > -	} while (test_and_set_bit(bit, &ilsel_level_map));
> > +		bit = find_and_set_bit(&ilsel_level_map, ILSEL_LEVELS);
> > +	} while (bit >= ILSEL_LEVELS);
> >  
> >  	__ilsel_enable(set, bit);
> 
> I will need to take a closer look at the whole code in ilsel_enable() to understand what's
> happening here. If Geert's explanation is correct, it sounds more like you're fixing a bug
> and saying you're optimizing the function in the patch subject would sound more like an
> euphemism.
> 
> Also, I think we should add a Fixes tag if possible in case your patch fixes an actual bug.
> 
> I will have a closer look over the weekend.

Hi John,

The problem is that if the ilsel_level_map if dense, the @bit
will be set to ILSEL_LEVELS. The following test_and_set_bit()
will therefore access a bit beyond the end of bitmap. Which in
turn is undef.

I'm not familiar to the subsystem as whole, so I can't say if it's
ever possible to have the ilsel_level_map all set. If you take a
look that would be great.

If this series will not move, the fix for this code would be:

  do {
          bit = find_first_zero_bit(&ilsel_level_map, ILSEL_LEVELS);
  } while (bit >= ILSEL_LEVELS || test_and_set_bit(bit, &ilsel_level_map));

It would work, but because find_first_zero_bit() is not designed to
work correctly in concurrent environment, it may trigger KCSAN and/or
return something non-relevant. See cover letter on this series for
details.

Thanks,
Yury
