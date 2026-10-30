Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793333155;
	b=obszW6F/oCG1bA8/+RQKZ4rrTBVGlubhRuj+US1Mo7CvH6wYKlCauRaGfXIc/FnUnkAW
	 pVU5AB+ADVI5wGL8qO/c2dJzQtqttnjyV9uGJT2xfiFHTmGE72cxPURHC3mFidF5Wk3eO
	 qmFXwinYWZR9VGrU87C1quhXXMzdNSUosChrF5w9J3MHOgGPiSUIitLHJOUPr087dCZ09
	 xLsCrQUsV04l5zKBxeto93MBW79Ut+sm/wlPaxezd/nKpTHx5FQzKeZXIl+zLpY+Ufd+I
	 Q33IVZnS2sDvCQaud01McOOzvbxvUgiHzo2FZItstn3oM3wJ84wc77e/3BxaxDidR9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793333155;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=9CvywPHpjrCT0zo2JhnH11M0JaZbySgNZTi9n8+NQFc=;
	b=NigQwzrCw739n6xukUNGl4989/HpRKi4JCpcwFUhMo3/ArpapMahTlYFbMgqs0mIfOIM
	 9S28STGX6aioyqN4MoGV6X1w5hbbm5/AmBinYC9dK7Qq1kEGtew17m+3yQuxJVJ6MwmEv
	 dTvcz3y8fSa2/lT8fRFPmY/OOq1oQSj6sq06XM20cCQGh93DS/wN6SpvRVWfJ+M0cZiha
	 toTMybbqMfWpyBSC5rVo1oO95GsCj3rnElQW7NmPnT0niJLSv8BDm+v6c3hzW1K8iBUXh
	 tBVqWT0S9Ox8c/5Qpw7bIsRkYfR9+WaSLIHGJkv3E4Ll8Br1HvXFwPkRAZ81S0ezmbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="cZUI88/L";
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9207A606A321
	for <linux-sh@vger.kernel.org>; Fri, 30 Oct 2026 04:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9207A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cZUI88/L
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so519843eec.0
        for <linux-sh@vger.kernel.org>; Thu, 29 Oct 2026 21:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793333154; x=1793937954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9CvywPHpjrCT0zo2JhnH11M0JaZbySgNZTi9n8+NQFc=;
        b=cZUI88/L9F1F6vaHkoJiPubaFvpBx9ZOZoFIH4WzYEl9uT8+1501kBXRQ+iQnW1rG/
         4Fw7u6pK2bhGr83aiABmILWeko3myUezgpD4yxFu1q8ofu7DAw3nd3xwaeMW+dOR7WjW
         fF2I6XSi4uBYslctXHDwkVQCwzAYXH2+VEB4ld4ijUFXCUVYiKPoDWGSOArpmY2b6MgQ
         9ZvnqUJjjMcJdZxPtAbFTkDp6O48lwLVb7JSCvyQcehPpzJbJ6jeHUnZCR3iOiOfxhs1
         cwBXgsfbLoMorO9ZFOLAr33BI+k9rnycgZilL+r2ECnd+fRbSczk3whlomOJkp24wZFS
         GQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793333154; x=1793937954;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9CvywPHpjrCT0zo2JhnH11M0JaZbySgNZTi9n8+NQFc=;
        b=n4Z72v1NqIFEwhSZxDm66V4H19CuiDEmiOJSNialtBMToyL2xAQwdK+ECzWH+aUFUV
         qex3ozLc+qpcfARtqTFWltmVlBFjrlLH4s8h4Rrjp7uJRP3ypgP8QsLx6mjT2QwenK1p
         jhTvQyAZobePIrsb6MHDRaajqCHZvNI6l9JrtwXvQzw5bg7EzdraiZ73n8gJViog/7gE
         5iHTVe9B7BkPRzJ3Njlt0RSgcEL9uFGChrxywltrEPMZPLmr5/TauVapHQaoa7p2jcmO
         2r6C+ZRrWgVUkswzKg00f4inYJzGFD4oKVb/327S5BGHtt8A/9kFr5sSViVxwbYW6jPv
         9DbA==
X-Forwarded-Encrypted: i=1; AKwUvBwdESJQXEO2Go5yEp9deCSDXfUDQ7wRzG0TwK2f88TEFr6Iia9tf5lXp21jNDcjwkqQB7nfE4tY4g==@vger.kernel.org
X-Gm-Message-State: AFq9FYJPHuSdqKO/SaQ8CDB1LfvqhhTvYVZygslFwUoBYPMO0+DaEy3C
	rSoM45TtNhZ+wQg13SgQ4YtjTmud8BjvWDmjpnpqNqEUM4z5568QU03Yb53s080ve5s=
X-Gm-Gg: AYBFou3/R7x4rWpUcNKtfKOLB4mV2gwrjSGnP7Ktq6QmFxpstfVeDVPzZJItDu7VAJf
	buWcMlsmHWOS57JCBeHqmZXMjnaleiaUs5hLws99YkFVhCmfukoXzlMzJ8EpBIQNyQH+fuKSuAX
	PTvHibuwN8T8FmWzj/XB5cM7WsyfckME2SghbPL4JGprnVxww6QuKnbJKVUEVesRSOvKR5im+Ln
	DqBGkC+b9Uq7dkgYtYIhij7BXfDiqVSiIgqWUXvNTsznV7v8LolE0r+uPrgNbxuxGHleO7YYLvq
	oXr2WUwzgjIVzd1/AqY+/fOvnH8UCHFIO6c0TKrN1hEWBY+oGf13+Jg91SjYOCd/HPV3EHa6u5p
	h0o0wpHn5DUgao1yToymsNc84I0BgI6bupiuiW57ze6EUd0qhYIg+koK4lwhZ3OsO7xXCat4+r2
	mVzqR3zhzF/dNG5TrKx41OJPlf0lIyouY3oXeVWE1RP4hBVnXSVu+vI7hGnhLukYYbGbq/p+YQr
	v0rUXpKInUkdEUf9prWEmd7ueM8bUJFJS6h7UpQUbxTmzZDJHFZV0p0CNl3q+XpPX1RoPI8bXPz
	WP3vV5WgtWmfJJ3obUFrE60vTGgYuXY=
X-Received: by 2002:a05:7301:53cb:b0:35c:e696:2d4a with SMTP id 5a478bee46e88-36a423ea99dmr1772736eec.24.1793333153319;
        Thu, 29 Oct 2026 21:05:53 -0700 (PDT)
Received: from localhost ([122.172.82.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4291e38fsm3512579eec.15.2026.10.29.21.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 21:05:52 -0700 (PDT)
Date: Fri, 30 Oct 2026 09:35:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kees Cook <kees@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
	linux-s390@vger.kernel.org, gfs2@lists.linux.dev,
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/9] cpufreq: governor: Initialize kobj_type release
 callback statically
Message-ID: <auQXnep2xKpuNJOF@vireshk-B250M-D3H>
References: <20261027223847.652884-1-irogers@google.com>
 <20261027223847.652884-5-irogers@google.com>
 <CAJZ5v0juvZ2ZVRBkY6FxBM=NhPt9vMA3+yRugXc5u=U1jO9AXg@mail.gmail.com>
 <CAP-5=fWVZ=7-qDRODiEQzRzhpQqribv9Morj=OoAXW_6uaW2dA@mail.gmail.com>
 <CAJZ5v0i0YoOW+ueh_aZJdYVS0etuCqfrf_S0NTKzCE9_6oKxPQ@mail.gmail.com>
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i0YoOW+ueh_aZJdYVS0etuCqfrf_S0NTKzCE9_6oKxPQ@mail.gmail.com>

On 28-10-26, 16:39, Rafael J. Wysocki (Intel) wrote:
> I'd expect the driver core to pick up the series as a whole then, so
> please feel free to add
> 
> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org> # cpufreq

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
