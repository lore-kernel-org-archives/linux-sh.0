Received: from mail-dl2-f33.google.com (mail-dl2-f33.google.com [74.125.229.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE2E34DB6D
	for <linux-sh@vger.kernel.org>; Wed, 30 Sep 2026 05:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790744616; cv=none; b=cM8JFFaCVuwYZwRzd5xhRhga39w+hIkzQ8ARJRZxOliEEilnD6FYFwgXTIyFDgOjU9x9r51tiOYA4Col/Bm/2MOFtvOXf5shetxOtj7RLkrE16pNILX6p/4inz5wuFhg+6oaToTkX4XyTZXDPV9cvx2F4fuC+79Lq3W+WM4LJcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790744616; c=relaxed/simple;
	bh=ZAOkRCY8wOKv81YxWLBl24DeI0DOK+J6kOTG4qojef8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7SUY5HwCJFYlTszbWfHYzrV9KlHE//RwYl6UF6TiCKlftn8psRwYdlZGtEm+XXDyCl+MjjNkgA4YzVt8BWboYXH/ZRMQ6maQWCZYAHiwwZ0mt+K89KL/a0krdwDAfVH7iFi0U4/ANwec9OvC+RO8qY9vXrg87LMsAk9Kwf/SQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2VGCKAF; arc=none smtp.client-ip=74.125.229.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2VGCKAF"
Received: by mail-dl2-f33.google.com with SMTP id a92af1059eb24-1438e88300cso4779038c88.0
        for <linux-sh@vger.kernel.org>; Tue, 29 Sep 2026 22:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790744614; x=1791349414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zGAfoAFOLtOrNepRCLXprN9XZyZC5iWH5UnAhvOD2p0=;
        b=P2VGCKAFCV8yJ0vbi1I/QYKuNdgsegWttnrnUlb3rG7PKtW3M+DKGZ3zoyqyrlCf5a
         ltEB72yZ3VN+McR1oS1vEc3Lei8it/YEbZiUcE5XsSPEBRY8F8E6rWfClJ7J6ErIMRxX
         xTJHoGxQlDqcQcS6nh5ufYxct0fhDloAoa96W8eWbdiQupR1IffenEvJzuoheaQDbyFB
         Pug75kq1bvII81GgnHArtWdIYAEZ7JXcrxZ4uucElub8+b0AS4VnBUBcDw5g6FlWHiP8
         T6w6/N+ZcGJL6gmmsgLq3HR+uMtLrJOAwILM3sNisor7yFKNpreMbdQFm6G1HeO+LCzr
         cOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790744614; x=1791349414;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zGAfoAFOLtOrNepRCLXprN9XZyZC5iWH5UnAhvOD2p0=;
        b=HganuJ9aQK0Y5rLgS9sHgg8bluYCc/ac6/+KnKbFBMuFa+ukDLpvbDDnXdQGgDEE5k
         HwzsUF7fDkC1HQzDrZ4m6171WdbMnq2qw/KdAk79cwVzS+7oKUv8YWzcHWZyIL6gP700
         S2S2FuXqVb6363F4gk/blZStDVPlK1/VRhX7jwmDDfFVn4Jk6Tg/dmHXzgqrxwn3e350
         XoB5jLY18FXXJKvnHHstwTmYWlwRSmirDdh3oVX4xKXQHAF0u4jL7/Npmy6GOIvM3Lt7
         M5uAEsCLC99GSvYxieYlyb9fS9ns0Unvl0q33l4Uju19WHds0qf2Y1vnTPcJxhEUrdq0
         sBrQ==
X-Forwarded-Encrypted: i=1; AKwUvBwAlbR1NLuyDeLxYWGOzhVfxCU+8PnqHyjDGIGjyr8AhXd6/CL6X1BHnwId8fRJscF7yb/Pz6UTzQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lw+ck1qIs+IxstZKAPFApRjZ9Aov3fUoK+aWr12rB+EyiWe+My
	+sNvePgyrVoavdLV8X/Aapg7sXa/UgF8v27hLSKAzoPQGIGzKwNB3srh
X-Gm-Gg: AYBFou0+Gdgy+NnXpmFLTNPkhT4JRdiqpO7MSsNeSb3z3jdYR/HAMLOE8i1G3e8QQAn
	iCNd6AAFs5oNDnjOIqcR4yaqDgZi/QuUGgZitqqDdg+V7gWRJ2OHdd440OByVE9Dc9EPBfEsR+8
	oZQw5A/NhFnxq+MLHvgFuE30YOVxeLAU/3qfXQ5BGqDGXGAQwm8z2GRFt4ns0p8VyqpyXFRu+qz
	I4pvb2bYNdxEOci6vPiZBPJtirodvBZ2NWalSIzKueSwr138DHvW0norO17Nwxpi8FyJ8Qtj9yo
	Cm63j7Rud08tloXHnWvtkHrkqwZfgEIFOKYfewDNe7zX8TX4QnazsybH5h/fwuHxQq0Rvm69JkU
	BCfbbbZ/aQKmKCjdxKyJ98F4jmuJLwEglssg2WTsR3j+OJVUqUU1TJexI28zWkV3iEdO0lkukyW
	vma1/ZxZ5aVXYHYwEKNbOXS4jqhAZddQCib02sPJbedB5JUVVpFN6945pm5gfczdGql7ZE6/WoX
	MTVSR3Rt8aryv71JQos3i5BI31JxP2MY6+P3PpFkQ==
X-Received: by 2002:a05:7022:7f05:b0:143:7dea:f6a with SMTP id a92af1059eb24-14d34ad35dfmr39419c88.32.1790744613793;
        Tue, 29 Sep 2026 22:03:33 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:101a:5ce6:a15e:d8ca])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34cf4a605c2sm680082eec.7.2026.09.29.22.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 22:03:32 -0700 (PDT)
Date: Tue, 29 Sep 2026 22:03:29 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sh: mach-x3proto: convert gpio-keys to software nodes
Message-ID: <aryX1eOmqUw2x09Z@google.com>
References: <20260704-sh-x3proto-swnode-v1-0-0c039549dc46@gmail.com>
 <20260704-sh-x3proto-swnode-v1-2-0c039549dc46@gmail.com>
 <d3a2875ba34bf10ddae3626b77da071cd4624348.camel@physik.fu-berlin.de>
 <arn6r3RohRPJrk0_@google.com>
 <61edcd485d5f2704a87f208a5d0eec82576a38ae.camel@physik.fu-berlin.de>
 <945d56acafd1910b7304903b06f974f41a2a018f.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <945d56acafd1910b7304903b06f974f41a2a018f.camel@physik.fu-berlin.de>

On Tue, Sep 29, 2026 at 09:31:05AM +0200, John Paul Adrian Glaubitz wrote:
> Hi,
> 
> On Mon, 2026-09-28 at 07:56 +0200, John Paul Adrian Glaubitz wrote:
> > Hi Dmitry,
> > 
> > On Sun, 2026-09-27 at 22:28 -0700, Dmitry Torokhov wrote:
> > > Hi John,
> > > 
> > > On Thu, Sep 17, 2026 at 08:49:15PM +0200, John Paul Adrian Glaubitz wrote:
> > > > 
> > > > It took me some time to fully grasp the rewrite, but I think this should work as expected.
> > > > 
> > > > Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > > 
> > > Sorry for bothering you but I do not see it in next. Just want to make
> > > sure this (and others) is not stalled.
> > 
> > Don't worry, I'll merge it today. It's already reviewed, so I just
> > need to merge and push it. Sorry for not doing it right away.
> 
> Pushed now: https://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git/log/?h=for-next

Awesome, thank you Adrian!

I also resent the rsk7203 patches folding the compound literals fixes
into relevant commits. Hope you will have time to take a look at them as
well.

Thanks.

-- 
Dmitry
