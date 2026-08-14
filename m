Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8802544781A
	for <linux-sh@vger.kernel.org>; Fri, 14 Aug 2026 08:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786696369; cv=none; b=atJtndC+jOlDK6YlsFuUohYTsKL7y4lpgnvZjaIwfwlmeRtXD7nAQj9Pb345UY2wLb8PLrViiIDaKcfXH1jKyTAOMnqfN9/BoeuzLRXFwsd6bAfeadf78Wha+dCGMARfwQWJIfFTUXe7KyV2+8n/+pWxItU9TMiKkPezEVocT88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786696369; c=relaxed/simple;
	bh=nSy4YnXDZmEVPM6ByRNEJNzOjITIxUJLPWdIUDhrpyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/UGv/ndeTGOt4GdMG1MZTX2guQE5SGhNKIaaDdh6DFS3Egy8swSPmSrKxYsWJ3Hc8TaEsrs3TguEFhkT7u+am58674pnTf2j72QXeS9fO2j8sPjOJLAHokBvDe/BbZrkh81NYFkawifpVAv3kLVHCsgnHksnaO8nc6Vrc0gjMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5bf83925ddaso238467e0c.1
        for <linux-sh@vger.kernel.org>; Fri, 14 Aug 2026 01:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786696348; x=1787301148;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UhCRzI3TB4j97WDpdASWQlB7pngpUekrwjbWYGiYblQ=;
        b=IMs21o1KPrXxcrIzARlmCTKAjUnp5SgGLXj8D4Uy7JSIh0fBqDIFVUe7hS0d5Poi46
         HMZUX8Usl34uiH7G22gxbot2/eU+gJXm2TEuwRHfCI4ylduQ2b8Q2/lEBG/507O0RrQl
         nfUnbnBVV0VfCHxqKmjTZV9SLiPopMHFVhM4XraTtq34+c5pPkX6+F6u5QKbPaXgu7U/
         SD8QAB9mgLpy1dtkP/fFwSKEK2LkJp/2m+3GjXFcJ70HD03797H8+ybsuh1+1l8l3W9a
         ZBAJs4KWeGWOG2lcvLUtCfvX6sPCSmWqibAUZpuUgGrg8Nx6geLGJHKXzch1oSvsVUUY
         N2AA==
X-Forwarded-Encrypted: i=1; AHgh+RpIodOmzzp7gqJJEAhnR7P9UNMva45Am88rNvGrBP+Wp4llsiovyzdq89NO7ojmve8hymU/CtlHng==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfjR6Cy0YlhlM0P+GACCY3CtGcRsslp9zY5gr2UPYRrh6mDf2c
	oESH6m00U7t54VWFb6HEeqjPgWJmScIRfb8XJIRey6t7qDgkZh10yFD1tcGyftMGA5Q=
X-Gm-Gg: AR+sD10uwlk1XbYZ6bvWyilGGsbvN3+JrFcvuUSdchmIEdY/wDuNt35tzJUdkLQmSMv
	vs1pmESJEubXGi55C4xNNKHrSpzQcKOBm3xgp5OqTuCMQi4Ysl8DoJjfo0y33/8sGvo5krjkbY/
	o+kbkLje2Y4apCkgJ93CwKIhA5QGO/HRxKTCqeSai7Abg8O4VwgZ8dBh1znDIhNIaHnM6hYzQJ/
	s/Evrzq8Q/s015w7gEgZNjM6RqX9aYMbrr+J5RwcCDLL3WyRsVnffrQ1SRgkGTrgnrx1sloWtEn
	gO4M/q9ULKUDKNxONehdB8z/TV+OhRTYUbYu01m9lu248ohg2lbnp0d6WedhgDTImGreq/jeQpi
	UbBVpkcijP7dCaFNqYdnLOlD6mHmRAO1iKkU/ZJeSZRh3Iugpp1685g6Ks+GnUrKgSDsvF3XFcB
	0t2KbIa3wIQyunsqnlCm/Sms1DCVpPGm4g9SassYlOAk8LHYJdXYnMgobmNLGGHjf53y9zNX8Qg
	07aQ4FrRoYPiS3+fKWp2kfrET5XAg==
X-Received: by 2002:a05:6122:f89:b0:5c4:1382:c0b with SMTP id 71dfb90a1353d-5c591c3d911mr784010e0c.2.1786696348175;
        Fri, 14 Aug 2026 01:32:28 -0700 (PDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97bfbd8aa7bsm518444241.8.2026.08.14.01.32.27
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 01:32:27 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5c2c0e261aeso192311e0c.0
        for <linux-sh@vger.kernel.org>; Fri, 14 Aug 2026 01:32:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RomYY4LZTTy3/9CMtVejLE3X9VDHHaY7W/o8EA3GBx5GdJnIf9zBnflXJ/ngBWL/6H1OFNCie2b+w==@vger.kernel.org
X-Received: by 2002:a05:6122:1814:b0:5c4:1f03:a1fe with SMTP id
 71dfb90a1353d-5c591c3ed13mr714902e0c.1.1786696346767; Fri, 14 Aug 2026
 01:32:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814075531.15446-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260814075531.15446-1-pengpeng@iscas.ac.cn>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 14 Aug 2026 10:32:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUZdv6FdhgSB_u5wU4YoqpKFqKmhs8x+bZeGFYyvZ5Puw@mail.gmail.com>
X-Gm-Features: AcwNN1WPLr30kFj8CbzyLORiLfA1whfORh6IrkvKJcdj7IXFdcU0Lq1p7DeCyxE
Message-ID: <CAMuHMdUZdv6FdhgSB_u5wU4YoqpKFqKmhs8x+bZeGFYyvZ5Puw@mail.gmail.com>
Subject: Re: [PATCH v2] sh: defconfig: enable the current M66592 UDC symbol
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-sh@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Aug 2026 at 10:01, Pengpeng Hou <pengpeng@iscas.ac.cn> wrote:
> The M66592 UDC provider is built under CONFIG_USB_M66592. Several
> SuperH defconfigs still enable the removed CONFIG_USB_GADGET_M66592
> symbol.
>
> Replace the stale entries with the current provider symbol.
>
> Assisted-by: Codex:gpt-5
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Fixes: 193ab2a6070039e7 ("usb: gadget: allow multiple gadgets to be built")

> The Kconfig/provider mapping was reviewed statically; no SuperH kernel
> build was performed.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be> # build-tested

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
