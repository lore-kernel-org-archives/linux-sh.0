Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397544AE8B6
	for <linux-sh@vger.kernel.org>; Mon,  5 Oct 2026 20:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791231693; cv=none; b=Kz9ghz7ikQITwjaIE7eh2vOJCBn9HC2tiNhhNqqPcEWblYgCsxFLRLfVPGMYr/z+m4CJBA/DKIKy3OYptJAhvhE6n0C0f16bKssOQRFvFuS2u5JOIU1barBfI2z+fvwFTKrVh9oz33Ow/TYqAGbPuPeAcjVwCsi7Gkrm+bVme30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791231693; c=relaxed/simple;
	bh=PUcIwL3sxWUwjUkEHic7gqrYUOt1jLTq7TaXf5gQV1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNUkws++QEJAGoTvwpOIlYYWdZ18bpsGO7pTbwT3cuLqRr+ZvRAg9FkopZekhM+ZmNQkEDTAFwBVzbkQvmUIb1ZgN4A2mGaOv/QMXhv0+wrNAm01Seoz1YlBsN1eWzi8TdMubbqsy+Sp18GiLTrMq+Tv/4Spy/M87hlXZsNG8W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1z4OWK3; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1z4OWK3"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48b08452cafso1502471f8f.3
        for <linux-sh@vger.kernel.org>; Mon, 05 Oct 2026 13:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791231690; x=1791836490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/oCVDgOpACssiVJGI1HFqtgCbfd9PUTK46z2UhBdQ0c=;
        b=H1z4OWK3EBJF0tGgoc80OzzvXkSXH7Wjh/+NIdl65GWZHT0B8QPkWl9GnUAW+JqT8U
         LKMDKRUvXG2ytTjDV+m0DxwKYP9fyAneEc8i8atmhZchqTwD5C+jQyHomNkQGDz+MLK9
         a10N/DHxK4f3c48jw7/tjHjZnZfskCqaK9tEX/Gqg9CJihl7POJiyGWcJh0dCX+a/Q2F
         4KlGEouQf5XHN25mTX6zB67uvLwPZyZWeH+RErM5JMl5WkIM2rbSF+jzE4BO/KcZg2bk
         22EtbO41HbWaLJKYW/BGQ8mhkX++hj9vW1yyLawIlrdvegBKIoZTBB4dMUjGtvvDFsrM
         h7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791231690; x=1791836490;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/oCVDgOpACssiVJGI1HFqtgCbfd9PUTK46z2UhBdQ0c=;
        b=oJaZgl5gNywn3JBQTBlX/YOo0UerFqToY0ljbNZrc6RqHQMqicZhXi5yk5M9x2JtyE
         eykvpDZBa2aoX9kc3Myl/wyLIImuTK/uq0gKT0yk0wgw1d593xzVqN3Rk0dPWQqeW2O3
         1Rm5lBqizmE3ZZroA0EGzGRC8xm3HUjscB9AkEVSMC97IpzmlcNzpi77MNzqG2rA+L1s
         G8MjHAhM1tsmXUVFVDgH67z7zyGwgB7OpvcEuDsiv2mGEKmqbvE07OHtgyTsdJAIK+JZ
         C+7cdoCEBItLPlF9PIQrHKZrA8c7B7datTNbLaVQyJL4yA548iTEw7fbFOIQMJ18RQmi
         EIng==
X-Forwarded-Encrypted: i=1; AKwUvBxrWIOH6pI2rBkc7dIR6FERTm81IQlxWPYz/wbn6JaM+xNyWDbaFZkoCBbW7Z0jb041dfwIguYJGw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJtN8dx4MqFIkoswQQO3yJ4Omhu8PwaQgWm+Gv9/QemYJVhtdDz
	xoLtAJscFUrBPgwy8ecOVzWWSiMyK4ZquAvZnLJTSPjmrGMZv3CV0OBX
X-Gm-Gg: AYBFou3wOhssDZPeHKOngCd12CAtxmKryMpGgAClxXpoKQgpdRJdjrDZMU6ePe2HbgC
	l2A9ONULUMFWJ8U1QiDECw8pIe8rtegOxiGfjLLttkKHu6JcU2D7ZdEDqcRdY+mSRuGhqOhQ2ha
	hHlf9E66yvMlAJhKPFdIrrEEcXM+nq/Ae+8+TvJhkV5L7R5W0zGdeC8pqZB2xuwgiQ9ChnEIU5C
	tKlNlInu3qW2DOC4a6c+mHFHXSilL9ff+1EQ6WVVBPuqMPmfUnwt0pzoCpntag8jhGpyp61xWE2
	f1kK3q+MUBXoz68+XEquLbVRDM52ffRYd0Qlzg53LiopqxeRHgRl1v9rc/L4Ql+e9PnEGtwXZ2T
	RhPiGYuc3Wcb8/+eulapdzIYj5PJMQPZnobZhIgAon29WV4jXEFJJFV8SPAMG2zHe3CYZwmU72g
	u0uAs8jLukUeB5haYkWWb+TMEAHWk+E5ki15TEyWvnVUWbk7lHJF+YzVaRp8CpokTMx3ZxWno7l
	ic2p1TqKapz0GoGtg7+52LdJyAMKLVqDebDzVajTHG/V37RVoFmXvcTZrGwUoRWUv3ikEUMyaYL
	PSkgfN4lPTot9okIbr/uj0/Hxt76U3sz17elJ68LMZIfDlKHxOLvudwgJOJto7ASVD2OAhXik/8
	=
X-Received: by 2002:a05:6000:186c:b0:48b:910:3598 with SMTP id ffacd0b85a97d-48b12712e23mr24557006f8f.22.1791231690251;
        Mon, 05 Oct 2026 13:21:30 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-b305-2001-39fa-3d24-821a-4eae.310.pool.telefonica.de. [2a02:3100:b305:2001:39fa:3d24:821a:4eae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c63550d1esm5541308f8f.18.2026.10.05.13.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 13:21:29 -0700 (PDT)
Date: Mon, 5 Oct 2026 22:21:27 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-usb@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: r8a66597-hcd: fix buffer overflow on odd-length
 FIFO reads
Message-ID: <asQGIQndPhFVaTNX@gmail.com>
References: <20261002213225.27834-1-kmehltretter@gmail.com>
 <CAMuHMdWEYkBra+3G_+-TfT23BAWPxG5o2KHqGRuHcdp8x0Vskg@mail.gmail.com>
 <asMl-yIKQoAbpwzA@gmail.com>
 <CAMuHMdUqcwZ_YPRB3BZW+=iBHAreDVquWahFn01Z9yoF=yzj4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUqcwZ_YPRB3BZW+=iBHAreDVquWahFn01Z9yoF=yzj4Q@mail.gmail.com>

On Mon, Oct 05, 2026 at 03:57:42PM +0100, Geert Uytterhoeven wrote:
> > The words before the last one are read with ioread16_rep(), so reading
> > the last word the same way puts its first FIFO byte first in memory on
> > every architecture.
> 
> Hmm, the version in drivers/usb/gadget/udc/r8a66597-udc.h does use
> a single ioread16() or ioread32().
> 

That version takes the low byte of the ioread16() value, which is the
first FIFO byte only when readw() swaps on big endian. On sh it does not
swap without SWAP_IO_SPACE. The boards with an external R8A66597 are all
little endian, so nobody hits that.

ata_sff_data_xfer() also uses ioread16_rep() with a count of 1 for its
trailing byte, and i3c_readl_fifo() uses readsl() that way since
d6ddd9beb1a5 ("i3c: fix big-endian FIFO transfers").

Thanks,
Karl
