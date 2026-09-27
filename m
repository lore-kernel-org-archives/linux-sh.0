Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B5B242D88
	for <linux-sh@vger.kernel.org>; Sun, 27 Sep 2026 18:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790534122; cv=none; b=u3JNg/hmnpkpk6E0Jq1FdR4XfG8FH9eEaJYWyW76m6e0Q1rTp+IT/vVcQC+LdLU2TD8EPjw0YBjgFgZDVt9QVHXip5v2QnBXU+q3WY/TUxWJ8PXpkCOJYnH90Il0Tr5GAthHwMLzFcJ6ueOvhH9LmGU30a0Y2LvTvEtezxFiAGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790534122; c=relaxed/simple;
	bh=EXX7jqvZYLnEQMm8FZbzal6MRrKj4Q6wzO3n8gCmvYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6OlYhT1dHuxw0lyXTjhzUYT88xiVuviLRL+oyNvpqIXWJkoJUOKnWa23VKIZpzL2qoo+EXY0hhRuG/r3mQmhiJ7Rbpcwljh5Lo0wBKGaGs8FJYzWW2U566Q3VVVCYQJkg1kSBEeuP8/LoxVJqoE6SeEotXwggU4FkT7Wc5LhfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jaf/9ODd; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jaf/9ODd"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4887f690df6so1556179f8f.1
        for <linux-sh@vger.kernel.org>; Sun, 27 Sep 2026 11:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790534119; x=1791138919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d3btJEsbUCZDnVE9CRXhr6o73+2IGPLa/zULNpIdkJ4=;
        b=Jaf/9ODd+5ToflEFjmTC7DjCtFGBQXtdJlQKT5EIoQXbZvZMbij7Mrl4emaIuhJfLM
         CeJqNoiH2nQY2LOnsqg8mt83NK/vZBLeP6Jyav3809orvMkfURhphdIvJyJviSHdAj14
         jKeuG9uEOrvStAe9J7rdV4ystmNUvw+OHWefw9m3dbDwM0N17KT3xnagNjFCBvv4KZAu
         Ep8l7HcDc3KcxPdXGitSHJGlKXtZ5NdH/7akZ3xa1lOllw2PMynr3HB12T3Db+dbI8oX
         QUQ1PKNpbQSF5cJ1BUB12rz8kmhz/BaQ6g8ZnAe3opclAuLbzJDncI2U5wWr69BdzHdM
         FkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790534119; x=1791138919;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d3btJEsbUCZDnVE9CRXhr6o73+2IGPLa/zULNpIdkJ4=;
        b=Y47G2hLLoG+SU1Te6QCcdpSRvvLmgfSgN7r2U7OgdmxP1WcYx64qa6g+idMvCLG2xp
         lWYSJu/W1PZj4wCAZ/6yO/E48qoruWv9nS2isdeLjcIee38DnJTnlMNOJQTzMK2AhEc/
         hQSvXjCNpKKuM4jcyr494tWNFKyV3t4BcXkDAw6zs3ZLaatNfqq0Yzm9cLYZhbvoPmec
         jAtAGaZ+jYF1kzbeBo3xtvhlHsX+omLjspLkvwqdYK8V/GaocgzDsLCePdwM8gtZg67O
         h7VYoLcdTa3Z5mcjsfXRO+1W90OA8bbjR/1UlOLULYG3jkTRB4cjcaqxMa4GfX4fzD86
         pTZA==
X-Forwarded-Encrypted: i=1; AKwUvBwpPiqswHTgMhQHqYSahw3HxG6TsXfgf8OtmevNmy2oNA5jaRjSNLT2cX6HhDuAdXsIh16IPJPwsQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKvqlQdLS7IS9q4aWItfn61AhSJGgcOuAK581fVpdBJN+hBChmG
	9HYS9WZ5vPf/3TtcFUwp0kTlTsBoB4wAu4K59fdJou35Fv1PWET7mBuH
X-Gm-Gg: AYBFou2LiWrdGINrkotlcz4iXXYu5mx9+GyeDcKK52TtX9pcZBnU+cC00uCZpM3VaaP
	3qbMYITjXiQhwk7FAkztUomcfI8Q8gi0FzXQMa81f/tzaZtoTifNKWnni2PZjDpo4atzfK4YIXw
	raGp5i5mK85ArMxHToeOl/o6LtjWuzY4x76W7nGSNkm9oZUbwhgh6fGKA4Dexi+/+VrcUe5a7oA
	gZBQnJKEgFUJLxL13Yh0BgGddW0sdHvGgRTyCneo+dgjD0WszGF6Mj9eWhJFl1pxqSAqImEqXsw
	w9uQhnqPI8YNkNv3olG4pr7mGsTARPZGp+z2l0bMX/v4YOflQhAkJnH06EuuUN1FGMAe5EZJUt0
	Amrql8QTRk+Q5RkPRTVjI62fOMYky+RlL9J/RkE2rHGURHF/oeagsa7jDwMfJt0ktUFCe8P1K8B
	o5fpILUwpjDmiwt3TaEnEQi0uaGicXJSTDg0fQpQfCfZEXOS7ptQ/z2CWznwtKw3cEaifzLPkRn
	MToshD2U2DzrMjHD9VsHgggl4XVbzxYAd8U58Cq2wX1zEFBntDssyeGB8bjYdWZV3KM+q6S2T4a
	/iDeKuwPBS0tqCMowPk2XTas47mnwjw1fArOQ6vctFhnwl/JrWOAqDC5cwl4R5Ddan9s7QsxHpa
	ilDA=
X-Received: by 2002:a05:6000:490b:b0:487:27f6:a4ce with SMTP id ffacd0b85a97d-488828c8ad6mr10111964f8f.30.1790534118745;
        Sun, 27 Sep 2026 11:35:18 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-b2e6-5301-2072-0420-f831-ed4e.310.pool.telefonica.de. [2a02:3100:b2e6:5301:2072:420:f831:ed4e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-489bd7b1df0sm1001928f8f.31.2026.09.27.11.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 11:35:18 -0700 (PDT)
Date: Sun, 27 Sep 2026 20:35:16 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] sh: mm: fix hugetlb on SH-4
Message-ID: <arlhcX870kV0DBO2@gmail.com>
References: <20260926183904.76186-1-kmehltretter@gmail.com>
 <9b75aa51e19f9c0f5c97ac02cfc0948ab5bbf279.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b75aa51e19f9c0f5c97ac02cfc0948ab5bbf279.camel@physik.fu-berlin.de>

On Sat, Sep 26, 2026 at 08:43:45PM +0100, John Paul Adrian Glaubitz wrote:
> Thanks for the patch! This should definitely be tested on real hardware
> and I think it's a good reason to test this on my SH7785LCR which wouldn't
> boot on anything newer than 6.5.0.
> 

Hi Adrian,

Testing with real hardware is very cool! Maybe I will get some SH
hardware myself one day. For now you've motivated me to do a QEMU SuperH
fork with more features, with a lot of help from my LLM agent:

https://github.com/kmehltretter82/qemu-superh

I will send some bug fix patches based on it soon, hopefully also fixing
your 6.5 problem. I believe it is an old heap overflow in the SH intc
code that only started to crash when sh7785lcr_defconfig switched from
SLAB to SLUB in 6.5.

Karl
