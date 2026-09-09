Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B55330307
	for <linux-sh@vger.kernel.org>; Wed,  9 Sep 2026 17:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973214; cv=none; b=pbHmDdPCIjrOZDUjNxh0Y0lmjgNDvbhUHWHUMc5jn7PZJEO7rgvx6jUr/ImzDYiyjqMcja02e6t57804rmF4i8X2eC+EmN1e1jxPDm3hkkN/Juj97Rj/eI15vxfwY1xY4DuxWR1Ljr90996IqEHCuBqUXmF4/dGgim+FwjwvD+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973214; c=relaxed/simple;
	bh=VQZ4jsBa8FVHwKruCaLxhLSbNMbUQztOQATnNRIP7Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DavZt+ktwQz8u/H4ylnUDQ1swtz3mPpIl1y9fGb2mbtjw0l1zzzguC51AmbsLoAa64HCWUScD4M8tNVPQaT1oDRZlVGn1jelz07YfjEagyAdqbfKUQdEXd6CPqWNuLo6y5Co/p6l7QkwmrBZpksQKbK6js5whfzbzdIrZhNzm6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJY+qKNx; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJY+qKNx"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d560775ca2so43949675ad.1
        for <linux-sh@vger.kernel.org>; Wed, 09 Sep 2026 10:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788973212; x=1789578012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N0kE2fYX+bPteq4jCJ9uTER06a1j6FkCAt9SyCELrpU=;
        b=NJY+qKNxsc2mu92pRo8eZXg7/EsjVWwiDx4l6HIXviOSDP8EXjUrVF8evks3AuoN9O
         XjdQccA8ARgztNiwxg0DKANEn7fkFxzP23Y+kLsuEeveBXecRw5Yf18kuPLDapnEagw9
         TUNFmRXGVpP+KIuFwfFITi1e1B9bXO+86GTwQPGQ+aNILpSThUwFdanAf0MawsHo21Re
         4OarcX2RstVHsOd3GgnQj0XPC7UvmpK6GzMkwP+EAufX4CiP/cg/YMVdysIPWbna5LgR
         gpQRwZ7oVSWSg0TAyO9vX7c5rOhHvMGisgWbu8koUK9N/zsAF33BqNAdnSZkVozQoB7N
         eR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788973212; x=1789578012;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N0kE2fYX+bPteq4jCJ9uTER06a1j6FkCAt9SyCELrpU=;
        b=SHkR6dm8xKSEY05L5dracbXiZ8C8Ou6BFth+euDTBsk52+Nv1CPMQyRKwXz3Hy+8ab
         vASSKsM1+GnAlmUsYjRUuCU5TrsoOh4hnL9fipRAo2qhaUEfeeOFQqd1q6Ijw6hmyC62
         IlIfMQxRyQXeqXqEPcpggtDaiGOVlqM1CWFCJbOzgDXaUcMA24wxL33sOwePrjYxqWGE
         M6zJVb86hS8CU6ERhRSs83e6uUmVmgFG8oZe6E7mKZz9vUp36kimnPZv9w7fB7nJPY6M
         0lHDl3wSPdLgZq9e+HvoUZG8w9rol4vNqk//jecoNMi3VJOkhu0x3lUP6msOivj4TGeg
         /IeQ==
X-Forwarded-Encrypted: i=1; AKwUvBz/7YMdTI7lJrEESHa75Jc2MIW99uFug+xc4DAinfnZzkCLEH4qTcCVtlivn+XIs6OnEBxvd84Ixg==@vger.kernel.org
X-Gm-Message-State: AFuF++kwdmj8BmCfqDbMXSVpo/eFBH5cB793Jqa/3vwFQ4Fz02cg9g/r
	2YqjoNBgbEGW2Ma6HumJ0mYiIfFNQJT2o9PhkqjbgL3K/Ih9RRB1rjdWAilQDQ==
X-Gm-Gg: AYBFou0/PrYQ8Wjf3eRSi7u2w1N2v1QIFDHhPn63wLLH5Jts8hnD9B22gnAOu0ItoXb
	JJxQjPm+qMJ6JR2GvdK3KI0C0Ib1Tps10aA8iK/vt3n17AJJOmpMXI4FqS5XpfV0MQGIRGE9qAY
	UhFbAIdI+5DYSZ841R7jUrA+YQqRzSN7/XeHeG+LlgrV7QIkC/DoFCHhpdmdpKz2uwMgWVwLYbg
	loPqgXOZJ1+TRexPh3WrjwiU0Okq0YFXvdC6DnzSrp2ali3YJ8WRRzU7lc88GK4pN817olAM4RX
	3xceUXbupbl4deKTHh6ViPIflLtH8i5up0Dqvb7oCoIjQ1c7K4M2xpRDUkVTFrtfP0x0e8ev0J5
	Ga/jD1tITRDz2FYSV2nXtJSE5iSgncE1DXTJ8nHslPjF9GxNI5waje7auxVMYe7M9mtF+KL6H4g
	JrACxaqyzTBcrsgKoC9OmACSKHyy8iBMsCkst6Es0OfbvoxPYxI6MFfY20LrGoyoWl4EEbiQsEe
	Oo10QHafI+PsqEav62wckPOi2Vro4ODiL2KP82H
X-Received: by 2002:a17:903:40c9:b0:2d6:f6ba:263d with SMTP id d9443c01a7336-2db124b451cmr504321585ad.7.1788973212122;
        Wed, 09 Sep 2026 10:00:12 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:2d43:5153:5c50:643e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3397d6d1c16sm7323636eec.13.2026.09.09.10.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 10:00:11 -0700 (PDT)
Date: Wed, 9 Sep 2026 10:00:08 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>
Subject: Re: [PATCH 0/2] sh: mach-x3proto: convert gpio-keys to software nodes
Message-ID: <aqGP2P3-44dmCyjz@google.com>
References: <20260704-sh-x3proto-swnode-v1-0-0c039549dc46@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704-sh-x3proto-swnode-v1-0-0c039549dc46@gmail.com>

On Sat, Jul 04, 2026 at 10:04:36PM -0700, Dmitry Torokhov wrote:
> This series converts the legacy gpio-keys platform device on the SH-X3
> Prototype board to use software nodes and static properties.
> 
> This is part of the ongoing effort to remove platform data support
> from the gpio-keys driver, allowing it to rely purely on generic
> device properties.
> 
> The first patch adds the software node to the GPIO controller, and
> the second patch performs the conversion for the gpio-keys device.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi John,

Could this be applied please or maybe you want me to make some changes?

Thanks.

-- 
Dmitry
