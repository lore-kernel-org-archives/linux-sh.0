Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0A9390618
	for <linux-sh@vger.kernel.org>; Tue,  2 Jun 2026 23:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444362; cv=none; b=R17oVHiX7WHKDu6bO3a0V6S/hFRsHVdVGuYgRoTevRL0msgf+wAXmTFqirpoiXRbC+Yql/xGrMunam+6k5llPpW5QAT6JsI/eaq/bo6o7t161mTY1dWd0/J4P/KZU7e7Yv/bNjJrYZYHnwIuCVR/CrWGzwY2sCheuH3cxBVpvmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444362; c=relaxed/simple;
	bh=DIOSLPNBW69lrRHH5x5amd/IZx2BHF033Uckz1NfcS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZ8uC9yyqx+XOZfZeyq2CD2Clr4y2XmITY3G9qeH6rmDfYnYvY3hZFndcC5Ae8X7zI4QWS3Nj4HG8OUNgs18FhQTr1OMenGBNF+9FOPCxqoZcn5H89xNPlBMaqjTfPjTJCG+rvQs525ZvfBTtz+9RRl+rYL6rlgKnlDLb3z4I2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEJLZDiq; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEJLZDiq"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-304ec41197bso5099472eec.1
        for <linux-sh@vger.kernel.org>; Tue, 02 Jun 2026 16:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780444361; x=1781049161; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iUBmAXGMJtpetlgRRPvXQnMJB+mGBvoOosal8pF9SxE=;
        b=iEJLZDiqvccKOE/Q1Ki0SjqZuspJenASKkDnz68A5Oz9r38JlwuhgAvaU44eoj/aZF
         iEBgguYTC6xwOnJP2bmzbnIJ2zxJxFBhP0BOVvKr4Ag0Hl1gOdWgKPLn54sW0hWYxC87
         Lzi4jRfEBlx+QKv1RtTsBPCWALqmJnglB4DMttEC9JFMnb7tr/CUeGV2kZTzaRnnmOrA
         vYi7Qa9245cbLc7w7vkAOuOp2mTLhsp8aR5MsSVcweTOSM8SxxvhjetLF2tvuywDQ6nG
         L7xknRtdAPCW4YMNeEmpf+oyrS8mveSM7A4WHOyHxB2ISJ+W7KPW6VHrgXuGfYuf4jDF
         DN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780444361; x=1781049161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUBmAXGMJtpetlgRRPvXQnMJB+mGBvoOosal8pF9SxE=;
        b=nQ4sm7tYIiy1KPxEbt+bglU+ezcv4r6gaqxj86lFh9qUbNmLS3OM2yM3qjZHCmpGvc
         cIvvA+4yzQQMg27BOijjWxlDuKe6Cvb3wMDtZXIQrNL5SrjdMkuaTRYdtTBOQYni4eWc
         HZyOH1CCY3Rpwpt6ciS/y+teMt0YX6lYggpc2nIJXC2xkmA/sYNtrMLDpWAOJu3mg6rr
         3YMvT0Kj7jB97EJlr3qhaatU+G5dPtctpXLxF10LUzAcm2kxv1bFVaKJ/npx9oksf4Lc
         g/hmBIbnAZBBThPg+CrJuOQ4qT3LNyG4VRMTiYCWdhZzinP56asE34i5Nj4zzswEZ1C5
         PR3w==
X-Forwarded-Encrypted: i=1; AFNElJ8d+4qAfKoqcw4NIMpmAJWUi1kjFDXRACVYaLskqsPAqixcM0ebVHu9eJlXezOba3IF1xVLGhTV7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ9yyFjqKWNIzqnYIjdPKq8PDeeaMML+4ZlQ9b3X397kPz9Eni
	Mi8RfUrAzTVZHFQYRXJKEy+u4Lhs+lNauwUlycYtWytyuLpn7LHHq8ie
X-Gm-Gg: Acq92OG7QmsUIV7GLH7QFKTYqPlB2Hq4MCdNIF0yvLWTg6FTnwIGuFc+U5ZLR41dfdb
	eEu829cV9bV/6ln86JBLmEkS43BFlKaSMzH/lqg0hZawT5tr2oL3awTA1nVcaguSwoLpTEu1Utb
	h17u7xMlS2kmQm7g5sh2eYENDebZIoAYdE/DrAKdIeHcurUMa3CxKubGaglZAYP7QNxhAToWKJ/
	N7Flk1Slz6P7IpAGO5jXgMKi3n3s6l+k8rfekUaRgkgInUltL8RiVhDSyrckuCmD/C0lTyFzkPr
	ra03zn5S5JxqDLnbU26kDYhNGZEGlru5j4lr/YSmwAUs+WpDHy7g3IrcFLmjwjBuap201vDQHej
	Pex5FOE/XD/NPsYw2xVEBFhe6KjvmJYdENOK5FX7w54rFswC205QUmWkijObqvtxRZgxciTSQvV
	in6tdKu9q4HMlyHr27HiNrhWpVeX3/IhZ4jp2rpipYXe84O0Rp1qHBQ4BiaaGTwgLP3GCkpOJ08
	QU=
X-Received: by 2002:a05:7300:bc03:b0:304:562c:2338 with SMTP id 5a478bee46e88-3074fa8d4d0mr552498eec.14.1780444360805;
        Tue, 02 Jun 2026 16:52:40 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:c4f4:520b:1304:b259])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dcbe995sm1165076eec.13.2026.06.02.16.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 16:52:40 -0700 (PDT)
Date: Tue, 2 Jun 2026 16:52:37 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@kernel.org>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 3/5] sh: mach-rsk: rsk7203: use static device
 properties for LEDs and GPIO buttons
Message-ID: <ah9rmXIlZZUHAgag@google.com>
References: <20260520-rsk7203-properties-v2-0-465f3308021b@gmail.com>
 <20260520-rsk7203-properties-v2-3-465f3308021b@gmail.com>
 <ah9TEJ_jrfcJwrb9@ashevche-desk.local>
 <ah9TXCcBPNh77Ut5@google.com>
 <ah9rHgAvprCTwEed@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah9rHgAvprCTwEed@ashevche-desk.local>

On Wed, Jun 03, 2026 at 02:45:34AM +0300, Andy Shevchenko wrote:
> On Tue, Jun 02, 2026 at 03:06:14PM -0700, Dmitry Torokhov wrote:
> > On Wed, Jun 03, 2026 at 01:02:56AM +0300, Andy Shevchenko wrote:
> > > On Wed, May 20, 2026 at 10:13:19PM -0700, Dmitry Torokhov wrote:
> 
> ...
> 
> > > > +	for (i = 0; i < ARRAY_SIZE(rsk7203_devices); i++) {
> > > 
> > > 	for (unsigned int i = 0; i < ARRAY_SIZE(rsk7203_devices); i++) {
> > > 
> > > ...and drop the above definition of i.
> > 
> > Why? I do not see coding style suggesting this. 
> 
> Linus Torvalds.

Context matters.

If you want this to be a universal requirement work on adding this to
coding style and to checkpatch. Otherwise declaring loop iterator inside
the loop can be beneficial but in many cases it does not really matter
and can be left to the code author and the revealing style for the
affected code area.

Thanks.

-- 
Dmitry
