Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D331FB1
	for <linux-sh@vger.kernel.org>; Fri,  9 Jan 2026 07:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767943714; cv=none; b=KLaQYal9z51zC/dAVDr1dVqoqffveMziirTA6G+rRnLnOiWTqHcApdA2Y+gZarISvU4k+09r7gUc3b3/FIJ3zbN466TleumG4CsVkAM2ZKc7c0+aCFX9RBqWIdVEXUtthRITbgrZuDHvVadvUNkpXr1ITB+O4pc2AEjVz/xROr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767943714; c=relaxed/simple;
	bh=z4zdMgkF80Daz5JaXcAIXXKM0qk/WNZUzdY7NnN+H2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eW2DOamMRzY+NPGhSCV9QhDe7u6qbK62rJnyElHJdOiVfiqafPjIzrkqWckTG77+z0uv4AO+LIKsozvOWdxWqyPY4ML1eueDKazMezrQ/KRehGLnCqRlWT0HEopWYw+cuWbyL+RuEfyVJoYAlatG3Td8gFOXJz4YKORDenS7m60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=VIMvIf/9; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="VIMvIf/9"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34c93e0269cso1631357a91.1
        for <linux-sh@vger.kernel.org>; Thu, 08 Jan 2026 23:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1767943712; x=1768548512; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z4zdMgkF80Daz5JaXcAIXXKM0qk/WNZUzdY7NnN+H2A=;
        b=VIMvIf/9a1Di+luyFshfRYvDSMPSL+R0cEJEibjB9+XykGjE6/f+ZF3mGYyDIFlD/3
         ysvYeeIw2xMnV0QY4ulq7lwDOG5vGkfwKfkxRluKcEmvInepZccDuT6L3dRU3F1TSn//
         6Re9wlvyi9lYQLRVKjOOidKcKe19Acvo7DwRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767943712; x=1768548512;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4zdMgkF80Daz5JaXcAIXXKM0qk/WNZUzdY7NnN+H2A=;
        b=DJS/ziPfFo0IlByRGbDq7n4+kZxdPfOCyogG3JXsxolZ/h5x0lbZxw0abRP2762PUj
         4v74O0EJkGta4Jq7jvLNjrvWJVwdddX1sUU6u36GLV7PFnMW9WsuiVcPSF2EnSZJOFza
         4Ywb7UMqu8qBilz2HirL5UfZuLlMsOM56Py/vLORdHpRFOCRE44rqU/hYP9qLt3zvVfi
         U5CGOdCtkgl9hQbD00aRsOmb8ZNS7gAOtJ+ZlEg/e11KH1mlEdstnlV4iI4crI4IIYOh
         rtJ5s/MeDiGOsONRgJacKdA9OUZVAs/kvQNWu20T+REI7k+bFheu0XjSW9NmP3eSJKe5
         1Svg==
X-Forwarded-Encrypted: i=1; AJvYcCVtaAMCPMTQTXIoq0unB7dCRNMPbEGjR0Oi3Uid0ir2u2kv2DiLubG5Z3W1LImJLSIKEzrTYuHZEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDtY5/04aInm9+1/vGbc68VBqdGIsmdWhxvx5SQW+gPcdgjg+Q
	k1OyWkF36qgy9qGFLFmK25zrgqYTODxI2betx4/idmxayjX6NmlVczvSITwzCoz8paKmTo9rD0T
	Yxd6+Rnwsqw3YMs7qA2PoHxUl3EP2vrrqLQYSGIK0KA==
X-Gm-Gg: AY/fxX7qlIBi58qKhnSSmEFVo5ASr/ZDd9W1VNMh0UVSj4pkGXizDAmdaQ+HNkJsr67
	FSotKKb1gjXgE429o03HzikorHp9jruNVU3P/kQvtrnYBwlbEQxLqmsw/DWZHSXYfIcmhRlk9oX
	5TeJK6+ZHuTCC5GUrKHFlrtUcCsO5Ex7rWyuDxMQygWWs+J11BDqYsitiiuWcO6TZlIkzEIKf0i
	sjx2Xw1eUfLntnkewfaRTdBT3KPpmD2BchySJOWO2Sq6K3ns1N+6HO1SEp/1AuPXyp/aOFLiR28
	EAt5Xao=
X-Google-Smtp-Source: AGHT+IGhY024567WzIfV7SQyZniYkmhCoMDXSKq8EUCc6rVKifO3Af8TaSrLk2X1FvkcDFG9K8f9sjPRQu55hlxX9Jc=
X-Received: by 2002:a17:90b:4c0c:b0:34a:be93:72ee with SMTP id
 98e67ed59e1d1-34f68b64e1fmr8314764a91.8.1767943712031; Thu, 08 Jan 2026
 23:28:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108-custom-logo-v3-0-5a7aada7a6d4@kernel.org> <20260108-custom-logo-v3-6-5a7aada7a6d4@kernel.org>
In-Reply-To: <20260108-custom-logo-v3-6-5a7aada7a6d4@kernel.org>
From: Daniel Palmer <daniel@0x0f.com>
Date: Fri, 9 Jan 2026 16:28:21 +0900
X-Gm-Features: AQt7F2qucaTCcxw87Ptbiuf4h1j-D8sMO9Oi1oo6s6YL0yzRkC93FMC01A59Z3s
Message-ID: <CAFr9PXkbkxKzT=p7xrz3Ti9+1S5B=qfNanw31hs9rbNuOZb=jA@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] video/logo: remove logo_mac_clut224
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"

Hi Vincent,

On Fri, 9 Jan 2026 at 04:08, Vincent Mailhol <mailhol@kernel.org> wrote:
> Considering that the logo_mac_clut224 is only used by the Macintosh
> 68k, a machine whose sales ended some thirty years ago and which thus
> represents a very small user base

I guess I'm one of the few people that has actually seen that logo on
real hardware in a long time...
This change seems fine to me.

Bit off-topic but despite the 68k mac not being sold for 30 years
there is still a very active following around it.
This year might be the year of a 100MHz 68060 powered classic mac[0].

0 - https://68kmla.org/bb/threads/new-project-prodigy-040-060-card.51381/
