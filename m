Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183CB3ACA5A
	for <linux-sh@vger.kernel.org>; Tue,  6 Oct 2026 10:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791283300; cv=none; b=OxLrH2IdLz3nm4pWGkYi+sqiasP2y8OCOXUuCR/+ysWc2dtrm/PGPIZ7zFLlA4SoGEtY8CZfImvaFUdAXMVY2oMVCIECO+1qLTVcRAalvY+zGe3beP9PuRaXzosGVRP3OLlAfXZAL5/0Nk2WAWnGTgO5zO5MpU+UVYd12d3uJoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791283300; c=relaxed/simple;
	bh=zGfqUCx6jXAzT6zCCJ7NiL3kT8DKVER0oBryCp4Dxcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=js893XaMW/vYBJiYR/HmhVQYOKjWUBcIoCJ/1dMakWVpvKStHWIwLw5xh4DPCQe9+m4fdtWkZj3FFc67L1MRMatqACier535FnfZbRamRmcqqVe6XNIa9HCn8ceUEzhdlqWkLlBPKB0EWwvsFuOa+t16mKbrSFXqIou5jdeNBSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiGJzJG5; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiGJzJG5"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-487049569b6so391127f8f.1
        for <linux-sh@vger.kernel.org>; Tue, 06 Oct 2026 03:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791283297; x=1791888097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u9EgTKWvY83NOreoEpihq3C4uu+WwUDt2rznQTC8D2g=;
        b=RiGJzJG5n0Z9tkkWW7q5OVVdQFwdMvdu+B6c2pZTXH1iwDGUgdO3b8B7KhDcaUbklp
         SKsBPoiSn58rLdkGnYH/02aMimAfPT67yOsv99OZ52ZMpIbcfVAIAQtF77EN+vj2Tasi
         BiFj7fneJnlFUfnyNB9scjz1o/ACOrXOZTsCW/ONz47k6KL79ocllOEDynh2hFF7KYD0
         YLmhJYYDwVbtaNesv6EhF9Ofxbho94LWWIhpYt8jidhWhxZiHQyX+RAlllHPA9i2HlKC
         A6n6WkvufLuhIZsHCNFP9MrrKfDY215t2WPG/smIebLumLZuQlT4xxBAf5h2FK7/Mf+D
         Lu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791283297; x=1791888097;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u9EgTKWvY83NOreoEpihq3C4uu+WwUDt2rznQTC8D2g=;
        b=cKKQUbDPnkXVypd94T+nUgye8KxYCuNo5SDQRdR0U+lm20OMlnPNCpkHV+fiATKc1R
         fdo/So7QTVnlqS2DbdKiFj6ZCoHkVbbOXMl0fUWCw5p6ng6B0CljrC2Ln2iiHMY29w7G
         1WmepA72opI3MK+JxwOAKVVcX/1+s/7YQQaoThrXm7xf+vTFHueFjKyRHbuLCLkTnRFQ
         CaPMvMPIGCyrhQHxVL6NpIugMjz8INPlT62C+Tk5ZZFJmNFkTB0EZ+2R75fxhDaylp47
         Iz8EgLd/F/Q/qsdbK5Gc1O+DrRCANcQ/tA2yAK2qQW5zN+qnUYCy3R/a6m+dESJvgTEf
         T4kQ==
X-Forwarded-Encrypted: i=1; AKwUvBxhZbDHauv3acfPEWo99/TKvnzyLbs7Md+OeuEJ063p+EHTzaKTIZZQHwcigDrunBSL3FhqlvvMJg==@vger.kernel.org
X-Gm-Message-State: AFq9FYL9xJD19ZYQX4simJbfcKQYXjN2nMPb6D52o8cC1c06yLV2VUmu
	Ub+rdn+ejLXdt0M4NY8+yuwwF4J7qPWHgDCIfApUuOApX2J0i1L/rWwavdOUIgI=
X-Gm-Gg: AYBFou3DmjJdw9SE3EeXmY38NNudvmGj2O7uJa7JKFAXAf5NNqbL8DXJ3mofJKnxkce
	a730c5mnwTfQZ5s9pdq/DYr1I1GsIDGUMYQ1N3Nqv3w1aTDkJLmt63YMKPLnQnU1UMBEJVboq3m
	BFszn8CMbWojh8Nz0Eurg4NWdmGDsPvoATwEc+NwJo01usOP4VwXWdlh/ZtpJ0zbRuBU5SEY0eZ
	XgGBeJESDlGUBZSTHpu9VwAnnwK+oVTvAPI6n/UhvujExxyk8BWj6weLSOXyzxfWR2vSHJ53MVg
	dDkbN/r0AIsuax77ij4rKGURQuyKaHEURHNFjVMJwfv8CwoQ1R0XDnQ+8REZdMT0b2KQW5jWeIT
	qmXAebLWo09XLbT27b+hfe1qpo2nKgLBEqm5vgocnNjBtyU5kqQ/XqvDxZRNejGaE5o4hyHidCi
	V9+WAgaoWceh8E5eLKbOgnrvL4yIeHWqGkkw4kSX29OCrB27Iw3QmZ8kP+gBBAaxYzHeHjn7BdI
	YLa5WUe2/S+Rl7qggkvuhS68YbyUDrxGsSoU78K+zcSgH+vIg==
X-Received: by 2002:a05:6000:2dc7:b0:48c:41c2:46d6 with SMTP id ffacd0b85a97d-48c6d1c1c1amr2258645f8f.35.1791283296969;
        Tue, 06 Oct 2026 03:41:36 -0700 (PDT)
Received: from lithos ([2a02:810d:4a94:b300:d1f6:bf6:35f2:f07c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c622704a5sm22046834f8f.15.2026.10.06.03.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:41:36 -0700 (PDT)
Date: Tue, 6 Oct 2026 12:41:31 +0200
From: Florian Fuchs <fuchsfl@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Adrian McMenamin <adrianmcmenamin@gmail.com>,
	linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>,
	linux-input@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-sh@vger.kernel.org
Subject: Re: [PATCH 02/26] Input: maple_keyb - fix key press detection
Message-ID: <asTQW0F2nqp2Kj86@lithos>
References: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
 <20260703-b4-maple-cleanup-v1-2-41e424964da5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703-b4-maple-cleanup-v1-2-41e424964da5@gmail.com>

On 03 Jul 22:57, Dmitry Torokhov wrote:
> The key press detection logic was using ptr instead of !ptr (where ptr is
> the result of memchr searching for the new key in the old keys).
> 
> If ptr is not NULL, it means the key was already pressed in the previous
> report, so it is not a new press. If ptr is NULL, it means the key was
> not pressed before, so it is a new press.
> 
> Using ptr instead of !ptr caused new presses to be ignored in the first
> poll cycle (only reported in the second cycle if still held, because
> then it was in 'old'), and caused redundant press events to be sent
> on every subsequent poll while the key was held.
> 
> Fix this by using !ptr for press detection, matching the release
> detection logic.
> 
> Fixes: b11d2127c489 ("Input: add support for SEGA Dreamcast keyboard")
> Assisted-by: Antigravity:gemini-3.5-flash
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/keyboard/maple_keyb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/maple_keyb.c b/drivers/input/keyboard/maple_keyb.c
> index 3d5538dd4f23..623d7951405b 100644
> --- a/drivers/input/keyboard/maple_keyb.c
> +++ b/drivers/input/keyboard/maple_keyb.c
> @@ -107,7 +107,7 @@ static void dc_scan_kbd(struct dc_kbd *kbd)
>  		}
>  		ptr = memchr(kbd->old + 2, kbd->new[i], 6);
>  		code = kbd->new[i];
> -		if (code > 3 && ptr) {
> +		if (code > 3 && !ptr) {
>  			keycode = kbd->keycode[code];
>  			if (keycode) {
>  				input_event(dev, EV_MSC, MSC_SCAN, code);
> 
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog
> 

Hi Dmitry,
do you want to pick this patch as well? It improves key press detection,
so would be nice.

Tested-By: Florian Fuchs <fuchsfl@gmail.com>


Regards
Florian
