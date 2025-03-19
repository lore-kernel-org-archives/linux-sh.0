Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E913253B76
	for <linux-sh@vger.kernel.org>; Wed, 19 Mar 2025 10:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742379619; cv=none; b=ZN8WHqLc7GH8P8NyKHzAEGjzNruF5JBMFziQUsrhexj1dWgz0f19Uj5qRyhf/W2FlGgJtBuXrjGsVWTI79RrZ24wuwzh670UQ/qzljG3lWcfmvJg7sXbgGsbX+o6etz/VRjuBafC9Cw8slxpefMqaRUBCaoja19t40OKtJ7xTxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742379619; c=relaxed/simple;
	bh=tK60PvB18wBvxWYt9lvP7XZvyX62+1Eh/q18fiab6Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsWkz+FhJYqGIW5KsH1IsYVXjOebR15cvMZDMpYE1mugLLmL+MdIyy4Jt2JOw58fT3F5CrHS57i1YTGoDsGmehFgNYYVD/6vauCEE83e5sGCv1Wm7DEZp4smWwQbSKt7X1WdeeHVytxccVn/XxBbdrFwdHSF2a9+iYZLuVwGDNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cqzk+EdP; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cqzk+EdP"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3914a5def6bso3645427f8f.1
        for <linux-sh@vger.kernel.org>; Wed, 19 Mar 2025 03:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742379616; x=1742984416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWxtYxkS3ZmfTDBR3Ubow/eGPhpGRxs9B2tOpbPHly4=;
        b=Cqzk+EdPpIhDnCwd4eZQhRJmj37M2X58h2HO5uNqgSIH22V9OW14Iab3Ju3v2/JBGK
         FkBh+Vl+ywlPDXLek56OVX9eR8guijL21wCkGBOrgCBDqWVTlUyF3Y3fKKCO3l7SLWUk
         jOEddmM13XNbr2OwEDURPTNxBfXb5OlBEi/oxCUifpl1mr3whqiOhSu0CRKjMMNuUjh9
         9slN6j9TtWAO77QjCTesk6z9yRW7BBsUpTsypOZ+aWphqBGd+J7kGPNlXEE96Wdpk08M
         GbHQt7vH+zR/MLbHBv0S8POfgt0v5joJzok+xCZjw6r4elUMOvJEV4DVk/8Cg1gP+Ack
         KKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742379616; x=1742984416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWxtYxkS3ZmfTDBR3Ubow/eGPhpGRxs9B2tOpbPHly4=;
        b=vnH8lPaZsxNfelxH6B+5qpY+LWxbB0bKWQQW+e9HvugIvAmIfWB7XZH8cByyaBkgxT
         znsuGK+A0fgfY7En9yFX/W7V9BZT/70WRa+5gNT63WZaRUpcljUa3/YXuy84Pbu2VXyG
         U9Vuq91sIYXUT0jf/Md5Yhg9xRvW8S22QiFa6i4je/Wf/3ZkQy/vfaCNcQ+nY0u1xWbn
         CkkRwD97eclhpJxCqhAkNj7shfzcKjzjTPW3UFmfdlC5bmwejyAHMXC5B4tX+rB+t0bN
         iHlrmkqa7cB+RP4mrz6BGCahtW6F+LZIRFg9CvwWvjFzG1G0z6vXK1sq7XavNwSZ46iw
         Q7uA==
X-Forwarded-Encrypted: i=1; AJvYcCWeeV4F167mgekn3105BL5HUkIQ1QXP9/pIULj6QElrUhjjvQPUaZL7gLo8JZVRSU+SF3amDEQRlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YysyeHwza4ymlPnP4W7N5P35FUUN1vOTb7nZRxAf2rz9QMIKQVz
	OXiyI3X7vCJjPlmi45lqEnKjYggeRQhAmPqlpfK/EVcIaJXnMSVcPGB96mT0lr4=
X-Gm-Gg: ASbGncsMRVCiw7NSAoEBlJV6RKXTdLaxiQAiQrEOIZM6dIeb/PGHkptE0/nST1M5GSR
	e2GU9bkt8MinWxQ6/OiF6HDehYoPmEq+SBO/qJrPmJ/rHdYYnqs5KTubovysm4EcSWODbIJddgs
	zKCj7n2NkKNl8lg0Ki2lGk6cUw5dacSnuXHEXFYObjw0eh2X0O6u8+koegX16TtW/i7CQnpOQXh
	mfsRIuy0Yq18Trsm8yYXXWlY6S8QKQWP0keQNiZV7NVZN/iSiKVHQycGgKMePMbObj8My0pDH1W
	nKNMD3tGSLNVG3bovbEzOo2uc5ROWVyywCZnrUwn3q077Avm4w==
X-Google-Smtp-Source: AGHT+IHjcG6/IeV2BOfDblPqcpvGjw3L7kajd7hg9EDti/4DwNoU0L0nZRG8X9Tat0FLH2nt55nwLg==
X-Received: by 2002:a05:6000:1541:b0:390:e655:f998 with SMTP id ffacd0b85a97d-399739ca2a8mr1441536f8f.26.1742379615798;
        Wed, 19 Mar 2025 03:20:15 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-395c7df3506sm21189338f8f.11.2025.03.19.03.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 03:20:15 -0700 (PDT)
Date: Wed, 19 Mar 2025 13:20:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Will Deacon <will@kernel.org>,
	Alessandro Carminati <acarmina@redhat.com>,
	linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Kees Cook <keescook@chromium.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, loongarch@lists.linux.dev, x86@kernel.org,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v4 07/14] arm64: Add support for suppressing warning
 backtraces
Message-ID: <fc197abf-e65a-439f-9d35-83f4665519f3@stanley.mountain>
References: <20250313114329.284104-1-acarmina@redhat.com>
 <20250313114329.284104-8-acarmina@redhat.com>
 <20250313122503.GA7438@willie-the-truck>
 <CAGegRW5r3V2-_44-X353vS-GZwDYG=SVwc6MzSGE8GdFQuFoKA@mail.gmail.com>
 <20250318155946.GC13829@willie-the-truck>
 <a64bf821-ea90-4fd9-92ec-13bf7b7a3067@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a64bf821-ea90-4fd9-92ec-13bf7b7a3067@csgroup.eu>

On Wed, Mar 19, 2025 at 09:05:27AM +0100, Christophe Leroy wrote:
> 
> Doesn't sparse and/or checkpatch complain about 0 being used in lieu of NULL
> ?

Sparse does have a "Using plain integer as NULL pointer" warning, yes.

I can't apply this patchset and I haven't been following the conversation
closely (plus I'm pretty stupid as well) so I'm not sure if it will
trigger here...

regards,
dan carpenter

