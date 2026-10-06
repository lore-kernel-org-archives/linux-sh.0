Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102324A5C41
	for <linux-sh@vger.kernel.org>; Tue,  6 Oct 2026 18:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791311602; cv=none; b=sQaRruzDFyPLddoycEWTp2ngVCSUyrtTQrf4rPegF+9k2VbwidZgsAsFws/7t7ovBVoMbRA8P7vX2ZLcOIAqH+OBUjKXlmnbZ+oeTMB/wGH3QB8uDVdjJJ2ficVc+/+HbkTs580Ihak8BNRL6fnzZVRvNrOrOjBJ8R3APV2XbBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791311602; c=relaxed/simple;
	bh=zSjwMrhpQy0gdO4THn+5z3rARqPugiKEYMi5sHySdqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3ZXNmqeN3yTM6xX2qQF9y16QzoEeXDd2615dzkXJEanCKO3F9z6VbjgHu5qgFjj566lB5jAgA1OEAT5kO4wQbHWkVirhBMxjB6IOMP9DJO2ADFV10e1KlB58n8rB4CdvS1drTGAl+k9xgB2XHPdRAgIRGzhA4OrIN7gZ5AfZ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqVRhRRc; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqVRhRRc"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a1698ea378so8536415e9.2
        for <linux-sh@vger.kernel.org>; Tue, 06 Oct 2026 11:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791311599; x=1791916399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iL7IcH9O1zz5fUcz180g3RzsepryNL5OFkSsRSiDAvI=;
        b=aqVRhRRcwUdaRWL90B0O+MRiZHc5xjZqJBbWVT8iuuS/RoUaJaimlnMG4a4YlmCBCC
         /FILERz2tPeu2uuZKCHbWv2uBofvaBNdQ9NjVa/XjYNkk+cOTd9MCXqZptkmMW+zOxzg
         sNFbt6n/KZ7dt4M/3qXCbTxJCjOYOzzgNIvPCbj8oYQ8AsWomH7/2LArf8N4K/GO6bAO
         xjxR4vxkedZjvX1Q8ayxDRuTzxRF6P66aBZDHZ8u1aV7+8ACZi4kOLxw2HfBBlK5Ax5r
         yn8RYx4DWqJNa0aPyk4NuQzz1l9Wbyzo//uN2P816cxsZC91rel0jZh6AcolqcDmOReF
         b7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791311599; x=1791916399;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iL7IcH9O1zz5fUcz180g3RzsepryNL5OFkSsRSiDAvI=;
        b=vskdStYvKp1iuBUZGKQY5jiHzpjd3tK60NMXYXAPCdyePeB6joohkHPzTb321FbJvM
         8FvGWKgxc92XrjADb894uOij97LUbpO43nufzESphgg8LSi9CyCkRoRJ6RSBuHBpk9AO
         mZie50YROQFe6WKwgtI9W0pDcrM/7706FJCudUwr167GGaw/4AQqMhISdw1MjQaXZQcH
         PE5VU7msWynMvTfld9qadeKGLCB/MsqUxOUP7PHVvDbONlEnxONHuycp3Op5aG1juNsz
         i1b8i5/XHXBBpjsklE7jzG7mMKvHkW71LhtgvhVyv8WtJFpNeSIH2SRzNXenIpYWXZTX
         4Czg==
X-Forwarded-Encrypted: i=1; AKwUvBwu/5A38I9VrdMgrcYaSL563FDTuVtFV4QqiKWJ6aRAr5Bt47eeJYNnj4hQM+JJz7NNrAhGH2mZoQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nnxgSq6z9HJcoSVbNTyou7hjnfbmLmpI4j+iIGOrRB7+dpMFuu
	ImWxAdhT0AKXpJe7txlTAUsQRwcXJ+xaH+UmODqEUVw5eJWM1D8NhC8=
X-Gm-Gg: AYBFou16EHIZCvbiuDjbfKU/dE9II0PicF2nG0yJCK1ysYJYO62UWlOaJf+xdxaBHLk
	FZrNr89oNumu9MiK0lX0PTUA5s3JZUYqPnnWRTtpbq/X4EdiYsXZ0r7QgLY1EIy+z/lseioew/b
	1oCikMqAxlDe2b5+z9SHIzgjVBZCLvcOsvbKClBSdKHEY/iCMgCTGwBGo+DxC84SesR9SfSbRe1
	y/n8CwqshgIuvfvI+DHai29JDSyB2zSVpQSDS64gScougusBxKnIW3+QqR/wSfJ61KxrCGHaGSE
	GOvsX12+GCfND1540MmBar4BruuHhFRrE8yWt0w6boSJapj/ueEsygNU3tMb25k3B9zWm1jyJx9
	M9RBeHyG1+eEhRoa4rrhT3lWIOcZhq2g/zN3vqEO+Ni4xz58OJ+kwNVWF3uZ/bzZff6fOxYJ7xe
	06CK/BjMPJNQfCbO1UcH36XyJVrsoCFA42rC0TMDwqQch8YrjEgCuNH1EGSipGYvlMHX7eEKdjc
	yOB2kcaIdij2iGJAWfQdvKZP3PhVTqN5C6nCkvVmBP0B28V+g==
X-Received: by 2002:a05:600c:4f4c:b0:49d:1fd8:b874 with SMTP id 5b1f17b1804b1-4a17b53c623mr45024235e9.19.1791311599064;
        Tue, 06 Oct 2026 11:33:19 -0700 (PDT)
Received: from lithos ([2a02:810d:4a94:b300:d1f6:bf6:35f2:f07c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d1fec3sm1102411f8f.37.2026.10.06.11.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 11:33:18 -0700 (PDT)
Date: Tue, 6 Oct 2026 20:33:13 +0200
From: Florian Fuchs <fuchsfl@gmail.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yoshinori Sato <yoshinori.sato@nifty.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: lib: Restore r4 in shift helpers
Message-ID: <asU-6UBmN4OjNsLV@lithos>
References: <20260714104147.2016549-1-fuchsfl@gmail.com>
 <85c4e0b40ec4b52b73c1525c2340cdaf31fd7d6a.camel@physik.fu-berlin.de>
 <e2d4c042a53eddc1ea8d800e171e6c59c9d3f7e1.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2d4c042a53eddc1ea8d800e171e6c59c9d3f7e1.camel@physik.fu-berlin.de>

On 06 Oct 07:41, John Paul Adrian Glaubitz wrote:
> > Please correct me if I'm wrong, but after reading the code in [1], it looks
> > to me as your patch doesn't preserve r4 but it's actually storing it into
> > r0 to be used by the selected shift sequence.

Yes, the value is copied to r0 for the shift sequence to use, but only after
the r4 original value has been popped back into r4.

The shift sequence themselfs only operate on r0 and then rts, so nothing
touches r4 after this point.

So the caller gets the original r4 back, which is what GCC expects.

> > With the previous code, r4 is pushed onto the stack first but not restored
> > before the shift sequence is jumped to, so what your patch does not make sure
> > that r4 is restored across the complete call of the shift helper but rather
> > restore the input value in r4 from the stack before calling the jump sequence.

Yes, it needs the selected shift sequence to not touch r4 as well.

> Could you comment on this and maybe rephrase your commit message if you agree
> with my analysis? The patch itself is fine, but I think the description is
> somewhat inaccurate.

I think your analysis is correct. The selected shift sequences don't touch 
other register beside r0, so I think it is currently not necessary to make
sure that r4 survives the complete call, even if the selected sequence would
touch r4.

Is it more accurate or which aspect would need a better message, or do
you dislike the "across the whole call" aspect? While the patch doesn't
really make sure r4 is always preserved, it reflects the behaviour after
the patch.

	Commit 940d4113f330 ("sh: New gcc support") reuses r4 as scratch for
	the jump table offset and pops the saved value into r0 in the jmp
	delay slot, so the helpers return with r4 still holding the table
	byte. GCC can keep a live value in r4 across the call, which leads to
	runtime data corruption.

	GCC calls __ashlsi3, __ashrsi3 and __lshrsi3 with a special convention:
	value in r4, result in r0, and only r0 and T clobbered.

	Pop the saved value back into r4 before the jmp and copy it to r0 in
	the delay slot. The shift sequences only operate on r0, so r4 is now
	preserved across the whole call.

Regards
Florian
