Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894AA3A48F7
	for <linux-sh@vger.kernel.org>; Thu,  8 Oct 2026 06:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791440321; cv=none; b=nioVESNAR+GdQGoeMGNQ9Ji2r6W6xbFq/dewsqUwaEjGFiQz3eO3OXIBpM9sZXGBxbYB1wOCr0xM9KMdae7hBphvZ4IPkMP41kWVjuMpYhaEqxQSk+Z8j8vPzVBeNjEqd6u5OQsYiAWyXTGy0XNs6/tmXtqGNTV4nCAsOza2elA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791440321; c=relaxed/simple;
	bh=WFfQV2nx8dXE7bNI3OJYcwiwD+Zg9ALgEFg6qbUBlH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOKY73d6TTE+6lj0s0dmGSSt4gln/lj6xpPloiAJQtPSkSwiQWNiUBQbymU4eGjloGD4+gOgiFNnB48e2vsbo9Yj7lPd0ffQH3fdbD/WqU1dmpOI8eT0rfEBuU9HkUVknbda4/gYMfXRzXXXMshdaPHtxfvgxbQo3Fjobn9E86M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AnxrPQfC; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnxrPQfC"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a172eb31f0so22508445e9.1
        for <linux-sh@vger.kernel.org>; Wed, 07 Oct 2026 23:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791440318; x=1792045118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j0aYWP1M8Odxq1oNSexxsa21jO6jl297TmiFo20Nq/g=;
        b=AnxrPQfC2+y7QX7rScjPXkMG8K2lboV57Z0ntgYWxT3/fVx07Xj1ve/fPKEXYdFNrw
         ZT6SoCqW9XwVQ+PMxtJr3GDhOH5sCluFG3uuisNJrzVhwFjt4V9a5RG+f/uVcnQSZkp1
         EO+5g0nyHrBS+4S0vvWQAfaQbDWuFZQeFApjVhlgqDactEchzJtYR2n4BBYHB+s5lEMD
         CyVJzSKwuA3fa2kJS/bebEbK/7bN+cBz8ixorO/HOt8xKW+2EPZPkYYjCUYrcjsalUtq
         8w0BHZpl2Zo10mC6lxkmS7o1mdf5pVm/+yGwdUP/jWBo5JmrH5zfO92nb+PGjOts7M+S
         asTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791440318; x=1792045118;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j0aYWP1M8Odxq1oNSexxsa21jO6jl297TmiFo20Nq/g=;
        b=RaKyn/9oVgAIMi1WgxAniU9BEo7WMTaG6v/kafe0LHWIws0exhVz/XlTGeSpTcPuHs
         iHYjH1/wkeAIZcW+r6xDIfptKi769xGMsZhg228pcItuRmjbFLgjKW9+YXB0iLVc02uV
         Q+dosFCtf2jQOtT/qzHbzekUzm883tspeVm+7EZ4uXmHW5P0moGab3KbW5F7cMl3qlvQ
         pgO8kC4G46jowSK1qb5mW9Hha49T07o19cTADhomnJhen58g4hcrIFnI4vl0uS/YsSQV
         MoqKFSRJMT6sbqB+hH8VmYFLptLA5RwOQtwXsv2o/DAeSW4LW5AvsuQkqjEc/Jnlni5j
         YnqQ==
X-Forwarded-Encrypted: i=1; AKwUvBwnKXcFWD9tlOXUg53i9YivNZF3u8+DtWF6MNCSiZbWefVLF2F5sI1uUnSuALiu5HB1dpJtqZR4dQ==@vger.kernel.org
X-Gm-Message-State: AFuF++n4UBHpUWkeaS8SCkCO2ZZUcz+MVt8uxl6gvPEkn/RGFrE/A65i
	sJS4+8PZNDs1IzDWk0md2wWQDHIaen/oc40sD0TIZFz1tCwimpIZxkr6
X-Gm-Gg: AYBFou28il296JtA0aE2ZEyC8xcRe+0hsePaQnOhU8s3rlSjmVV2o63Xrp0XvXlLCdR
	7cu7qfWdT6xS2WpSnxgBmYDRZ+dsKGyIVS8aCaRE/3rEP2Xfla0cOWFdJ2rt+IB7gygFPUmRh8b
	VAs75izXeMfI68Jat2TD/vGTA/5iyd+FiVXytc3LN3VhB08cP3LnqTxVbf6fPN7BViUV2dj1xIR
	OZ7jATpO4ej4QRRz3wo1CeFQXiHXoYjxVda3FsSZBUWlNYaQIrZ5/WBslUyl6QollrJce9caWxq
	engJ3LPQFLXbGUP/IrdcruIKm6dEMRPkezrMvyiL4GHM81DM65nbuo7eGNmsRyRkuNyS/oP4E6e
	F6kSC7S3vHQzziCXE/cklHIN2o/wHD7BjOoy3Q9X8yF1drwmrx1/xtpJi84nb9hYH0PPPY9Ybkw
	BJ2wD+Omz5BYg9MdfYlvnnqSjnY8mbl0sZI9kqf47jlSLMwwC5GKsd9CEDMsQae+AxiBLNVi6qY
	UzKvX0j0bmKCZ2YftQt/JRewo139HqteYPX7dJ1DTAKud9UCAs/phJtPK14Bx701JGlhXS9NeQH
	xhbbfURMROpryDyilcCs1j0c3uizdX++i4dHhPKncbdj0istBaijoXU3cQpZsah5EtGnXaHO0tv
	Fe2WmnG0Y93/EaAg=
X-Received: by 2002:a05:600c:6095:b0:4a0:2835:6fd3 with SMTP id 5b1f17b1804b1-4a18041c519mr79148635e9.17.1791440317478;
        Wed, 07 Oct 2026 23:18:37 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-ad61-5a01-743c-891f-b33c-cae7.310.pool.telefonica.de. [2a02:3100:ad61:5a01:743c:891f:b33c:cae7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1843dbc6bsm50087615e9.11.2026.10.07.23.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 23:18:37 -0700 (PDT)
Date: Thu, 8 Oct 2026 08:18:36 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-usb@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: r8a66597-hcd: fix buffer overflow on odd-length
 FIFO reads
Message-ID: <asczg8KoUgHPxh5n@gmail.com>
References: <20261005212823.55737-1-kmehltretter@gmail.com>
 <2b0a2d9afa8e2dbd1d6e8ea8f88a4627816ae2d6.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b0a2d9afa8e2dbd1d6e8ea8f88a4627816ae2d6.camel@physik.fu-berlin.de>

On Wed, Oct 07, 2026 at 11:12:46AM +0100, John Paul Adrian Glaubitz wrote:
> > Fixes: 5d3043586db4 ("USB: r8a66597-hcd: host controller driver for R8A66597")
> > Cc: stable@vger.kernel.org
> > Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > Closes: https://lore.kernel.org/linux-sh/3bd32eaf159db61ed1d423e1d52a869b3689c682.camel@physik.fu-berlin.de/
> > Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > Assisted-by: LLM
> 
> I was wondering: Would it maybe be better if you disclosed what LLM you used?
> I have seen that many others have done so and I'm not sure if it's actually
> prepared to have the model disclosed.
> 

The generic Assisted-by: LLM format is fairly new. Christian Brauner
proposed simplifying the attribution in July [1], and it is now the
documented format [2]. I expect we may see more patches using it as
people adopt the change.

I prefer the generic Assisted-by: LLM tag. It acknowledges the
assistance without advertising a particular vendor. 

A model name alone also leaves out the harness and settings, and I
sometimes use different models for implementation and review. Tracking
and listing all of that would make the attribution rather cumbersome.

[1] https://lore.kernel.org/r/20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org/
[2] https://docs.kernel.org/process/coding-assistants.html#attribution

Thanks,
Karl
