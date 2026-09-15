Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994F4449B34
	for <linux-sh@vger.kernel.org>; Tue, 15 Sep 2026 19:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789499857; cv=none; b=qhRU8yYUb5PhypH41M/YIDpGBO3L14WNJGMTQIPOKulK20cYVUnhj6HGvmlhk3Ba3vk/IotvB2CSZgt29zLEZfQPHZ/rCzm+9LRv854tYZk/zhWAC4/rW9vJkQCGxc7dVOCHiM6WBJ8XaVGGHOHBLgn/u/AfQ0X+vvIG5o9iKG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789499857; c=relaxed/simple;
	bh=AGk4y8oFpNibhByHKIxcRS7KnQx6z20Q8VC6dFl1tNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RoU6M2HgrNN4Wv141oS/QlQaYE12lWAkd79Sd5c/CdgggQ06xl1A2MYW9OHCSO3AAje1IssuZOl9/j89XVvrb9zLOS43k8j2qqzg+fPZnYpQYbh8rYLvPj+/+/tKk2M7gQ3BEc9Su3lpwjgc0DiugfA20f058xDQAYEzJc0+Qlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=iMYnKJQ2; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iMYnKJQ2"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f15b78so95790e87.2
        for <linux-sh@vger.kernel.org>; Tue, 15 Sep 2026 12:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789499853; x=1790104653; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XFFk9jJtDswBQpA8QWIooO6lLG4HdlvPT/LqykRjG+U=;
        b=iMYnKJQ2DJsJQZ7vpR553EIBKcnom/inNwehKzW8/kiqJovnfjmTQjP/4+JjYo5j0Y
         G6ZqW/Vn+1wRkgZcpph7Iwg9OE91i0I6TH3uZx59IAWw5PTTxpuqsblS5q7eZgL9K1LU
         tX+JCFoTN9mZZLttnVcX6OrOwysTqrsIXa4y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789499853; x=1790104653;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XFFk9jJtDswBQpA8QWIooO6lLG4HdlvPT/LqykRjG+U=;
        b=meUYd905uMbPsVRgcEDTmdAAWMti0VabL/+riFBMl0searffP8T8G0QCGIkM+MaulY
         LCV/Lt6qutn868uFSFHPSI/3Wv66IyCtVMD0DDj/riEgYeCwSQTnIGxWScRd7/3l/UTm
         phZEtVetV9/VUqAwm5s04VLxUMjRSZtAnv/fgGLNj+VfiCUZFjzzVzPWio+tA4+cvs+/
         fEGS3uRjCG9hmB0naJ08MEaqGTP+uqevMXbfJtgkov1wcVUnS1t+OHIwLeAmtIk87za6
         ht6zHRlzeFxE8ryuTIVlg0+sg9rCEr6buir/FbBC31ewFoU240AHJS3Pgcw1bgSaatnG
         8wsA==
X-Forwarded-Encrypted: i=1; AKwUvByclMgfavC/Z7VzUJEPLd8g9k0wst03SPk3pLW/ym+7iTguxYqDkB16drIv7lt9T3ce6oCMQQ/fNA==@vger.kernel.org
X-Gm-Message-State: AFuF++n8lLqN/0qLep7/kvGUxpGkErJR2poL4jLlPYILPz6ubG4lRWxA
	eXO5KlCynJgdKl8Ni/D0rmWgt0V3B5aD+JzKZ5XXZy6eIdDC3jjqYN+I04fO4GbIIl4kX2sQSrS
	tdNraB3R1UoHZ
X-Gm-Gg: AYBFou1V0edhtV3HL6/o3javf/r0crRdhyucVv4D2OVZ3yvvvSRzoP/dboJuInN1Zzn
	YlWfc/tDG1Giy7fXIuoxB7QIjsZZtKVBwQp2vw5WdKxNMXGjCxyKdX8SkJGuM9jawM4M0AUJsHT
	z1xJladwYWjLnFNisde8rDok2IQdt7tfscNxKcApcTPJM1yeS4J4/2b00p2WMiCsQHCbqdBXV3b
	Fg3qHy9ahfQFNSQ1tGjSonuU5aSLhPS/hH0wiRE+9ieceo+pOXZoxyxWfhqstSeU3g3GdMSIyNG
	5RVeiwV0Jk6JezmENJjB/Fw4gKQo/C8PN9ty6xPEui2L6DHHFMrHiET0LBKlyeNrgV4dFzQuu0/
	tEYSpYSgrGNkoLCGoWsepfYjOq7kmd6u2jKl+jPGCCGyPiPfSiH439zWwVxYWClV9t/8/wntDAa
	OUd2ND7182lfb/xuzyPQEdyBsMoekX8tT6ZO8gEaJ2XBrs5ewZdJrbEQb7IViA9SSOLyMq7F4EX
	6b5nyrYkcUMv4ZcrEp/hL0Jj/YVvf3rx0Vx2MJ+F+nTig4DPw==
X-Received: by 2002:a05:6512:39cb:b0:5b7:6ff5:24fc with SMTP id 2adb3069b0e04-5b8ae68bf87mr4916975e87.9.1789499853432;
        Tue, 15 Sep 2026 12:17:33 -0700 (PDT)
Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com. [74.125.229.204])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8b57cc67bsm169614e87.31.2026.09.15.12.17.33
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 12:17:33 -0700 (PDT)
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f15b79so106930e87.1
        for <linux-sh@vger.kernel.org>; Tue, 15 Sep 2026 12:17:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzmb7VSAoBJCcSBVnmokO6T3ohivUrjvyfRXKxRauudvtH7g1qwVqi/Uo6+3K+8FTqo7FxKKRmpnQ==@vger.kernel.org
X-Received: by 2002:a17:906:7309:b0:c25:47a4:fedc with SMTP id
 a640c23a62f3a-c29b839a057mr1176039766b.2.1789499355710; Tue, 15 Sep 2026
 12:09:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
In-Reply-To: <CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 12:08:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi3Kkqgfg6zUTHpQoZNL2VOB4vYqpi6RX0WNO++29UtyQ@mail.gmail.com>
X-Gm-Features: AcwNN1VCm0LMG7z3Jned014oJh6WBcf4uOx0OBk98_hrtHKbrhcQiMMJ_A-fmB0
Message-ID: <CAHk-=wi3Kkqgfg6zUTHpQoZNL2VOB4vYqpi6RX0WNO++29UtyQ@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, 
	David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Sept 2026 at 10:52, Jann Horn <jannh@google.com> wrote:
>
> Is this mainly about stuff like "we installed a file descriptor and
> then the following put_user() failed"? Because if so, I think a nicer
> fix would be to have a policy of "if userspace provides unwritable
> memory to a syscall, just keep going and pretend the access worked",
> and maybe have a sysctl that kills the process when this happens to
> emphasize that userspace should not be doing this.

We've done that before, where we just ignore put_user() errors and the
user gets whatever the user gets.

It is maybe not optimal, but it's fine. You can find quite a lot of
unchecked put_user() calls with a pattern like

        git grep '^[[:space:]]*put_user(.*);'

and some of them are in core code - see the two in kernel/fork.c, for example.

One of them says "if userspace has not set up a proper pointer then
tough luck". The other one doesn't even bother with a comment.

The scheduler has two cases too, although one of them is admittedly
for another error case.

So yes, saying "if you pass bogus arguments, you get what you get" is
a valid model. It's perhaps not the *preferred* model, but it's not
wrong.

It *would* be wrong to take code that already has error handling and
remove the error handling, though.

                  Linus
