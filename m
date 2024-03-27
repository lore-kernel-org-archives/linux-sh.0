Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40CA131731
	for <linux-sh@vger.kernel.org>; Wed, 27 Mar 2024 15:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711552908; cv=none; b=n4c2pA1kiNtJCdfzuDyIQGEq2rwSZTIIAvPGnQrKFAkdk53nF7muqcg0kNh2eI/04RaXaDATgSkk2FSw2nz/xcUqhmf94vlRqQMMvKexhdiKmU4bmh00/MJSUJivm+OxiFQ8r/wXYm6nU2rYAbB3dyIhyMhyAduD/QU+oII2pmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711552908; c=relaxed/simple;
	bh=mhfoA8jCv1DDC516BG+AAL5xuYfKBZbFsPJx+Vnzofw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=vEUM6Bfvxy6Af8iGEfjgQaIK/pLfryPk9/g9JODUCjl4c37GmP+qECTZQCNhH8AA2PN/USOwmwBsKza+sd+3nIZayNQkAM2bJnktkM2Ojlm4ZODFB0UTF2BbdrhQcAbwxJAVJuZYCPXfRvONVrSX18GdFyqgMVgRMzXsows6FHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a8VDp2WD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8VDp2WD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711552905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4RJOr7EzuI0DVaYxx+XjeXTwjAi2iT7d0lhMZ/VIsjg=;
	b=a8VDp2WDVgyboA8qBtWpRsUNHVKyVsc8ecB42vWPaCxi7L2I6aLlzUsd12wEni6Bz/IF9e
	0DXN5FhKemqb74DMpAYYLlKJHsHzh215527tymhMbeAWXwr+MxbzPf1WY3DZBqtdywpvhG
	TRGFzUEXQPGmKnzuovOS49QyXr5qhPA=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-3_lTxDshM-SB40vblpUgsw-1; Wed, 27 Mar 2024 11:21:44 -0400
X-MC-Unique: 3_lTxDshM-SB40vblpUgsw-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6dde25ac92fso3181132a34.0
        for <linux-sh@vger.kernel.org>; Wed, 27 Mar 2024 08:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711552903; x=1712157703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RJOr7EzuI0DVaYxx+XjeXTwjAi2iT7d0lhMZ/VIsjg=;
        b=DvPdKwIuRRrUtmehouCKzeNNFxFKBpwA+dk0Qtc1YsMtfJVnI2hbuWDeHh9Jn38owL
         ZhiVI3U4/jzXB8qrxO7kOPsXZUwJWSUVgmJAYkSgff2FEHEV9K5ZFDfZT1g3+UenvfGu
         bgvyXYbeyQ9Tf0l18wXIDSZXKot2l6j6+LKnY9XcRRbiu7fqo2uSLHvFK0KuXcD4Pt4+
         R4Hq6su8y+v+yIwR1fGa+2SjqMHjbJ8p3zOxFwjZ0VgUyUA2P2/BYYIJudlrUdZkP6+a
         8P83X7FVjb0HHIlt3WjJwNdiV/ahlAMRsFhEjU9xORx6qW+s2ozCM/w6/PE90VJAAwo1
         0xEA==
X-Forwarded-Encrypted: i=1; AJvYcCWjfxFZKLkTIBe2bgvYyilEqtIlE8EWdR8SjwB90C7r5t3wVFkDkvLRhkYAG118QRgp2mjYTSXqOjKWwVMfH2zbi76lf5IVUS8=
X-Gm-Message-State: AOJu0Yyi3eb6/sM3ddXfhq9bXI2eIAkDUhIBqYfbhnChhrDvq5fbuXJR
	T6ySIwXD69coI6y1YEoSkIK04ltOEiDs3icbQxA6Ei/7Ul+6rCZ4ABoef5bR4sqnu98SWn4Wtom
	COQfl15sBHahdFVu0+9b6DO+z8g9GmKleqvZVxmTIDve/hTSj3igbSeaj
X-Received: by 2002:a05:6808:128a:b0:3c3:d729:1d56 with SMTP id a10-20020a056808128a00b003c3d7291d56mr316751oiw.0.1711552903441;
        Wed, 27 Mar 2024 08:21:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxT5qAZWntttFMbBHTXwtvywmg90pV0zoL9F4zS7SQ4GsHwDy+Ru4KfcRdtRpsXZfeVg5bqg==
X-Received: by 2002:a05:6808:128a:b0:3c3:d729:1d56 with SMTP id a10-20020a056808128a00b003c3d7291d56mr316719oiw.0.1711552902921;
        Wed, 27 Mar 2024 08:21:42 -0700 (PDT)
Received: from x1n ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id r15-20020a056214212f00b0069698528727sm2350243qvc.90.2024.03.27.08.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 08:21:42 -0700 (PDT)
Date: Wed, 27 Mar 2024 11:21:40 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH RFC 0/3] mm/gup: consistently call it GUP-fast
Message-ID: <ZgQ5hNltQ2DHQXps@x1n>
References: <20240327130538.680256-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240327130538.680256-1-david@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Wed, Mar 27, 2024 at 02:05:35PM +0100, David Hildenbrand wrote:
> Some cleanups around function names, comments and the config option of
> "GUP-fast" -- GUP without "lock" safety belts on.
> 
> With this cleanup it's easy to judge which functions are GUP-fast specific.
> We now consistently call it "GUP-fast", avoiding mixing it with "fast GUP",
> "lockless", or simply "gup" (which I always considered confusing in the
> ode).
> 
> So the magic now happens in functions that contain "gup_fast", whereby
> gup_fast() is the entry point into that magic. Comments consistently
> reference either "GUP-fast" or "gup_fast()".
> 
> Based on mm-unstable from today. I won't CC arch maintainers, but only
> arch mailing lists, to reduce noise.
> 
> Tested on x86_64, cross compiled on a bunch of archs, whereby some of them
> don't properly even compile on mm-unstable anymore in my usual setup
> (alpha, arc, parisc64, sh) ... maybe the cross compilers are outdated,
> but there are no new ones around. Hm.

I'm not sure what config you tried there; as I am doing some build tests
recently, I found turning off CONFIG_SAMPLES + CONFIG_GCC_PLUGINS could
avoid a lot of issues, I think it's due to libc missing.  But maybe not the
case there.

The series makes sense to me, the naming is confusing.  Btw, thanks for
posting this as RFC. This definitely has a conflict with the other gup
series that I had; I'll post v4 of that shortly.

-- 
Peter Xu

