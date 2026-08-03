Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8881F872D
	for <linux-sh@vger.kernel.org>; Mon,  3 Aug 2026 06:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785738237; cv=none; b=pmiinfpO2B9aHADZejEzcxOoLku+umQIsfrO9rBw0oX4SifBZmcnHRPrfka4IErZYpBf+LlMDCNZ5crdjE7khgkvHzbk+5oW9iLFyLJEsWgrUDxAf0CMwmreOx9n+sFooNy13Ge5nGh35T7ud/bu+zlL//mR6teHjYwnSI/fVxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785738237; c=relaxed/simple;
	bh=pMUyTnwdgoFwCVbvZDTlcI8Sr37AGEj6Dh8HL1zcOjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5t7DAPk7k0dbWSfm1Xnzwv9CGLeGGUXVOy9LgAvVS6ciIxlCcPrQfqgO18M9zoUqxYR/q0ALMjST2tXy8j/kdaTC0zeT6s3CWPvYI6fRgaDlrem9hyo7aEc2kLr2FrX+7yqp4nPlvAC8sM4Mp+BRRLNJi4MgoUM5uI+USk2DQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3oPs98y; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3oPs98y"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38fdeaed181so394887a91.1
        for <linux-sh@vger.kernel.org>; Sun, 02 Aug 2026 23:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785738235; x=1786343035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ck3CD6/H81B/49IDvwXO1W+2CpiInIdnGO3PMFsRX/A=;
        b=e3oPs98yFPaBGEhU0MJ1TZu6YrLXjI850sXTcPN8gGDgrguMZDBfUNCpFJSUv4cMlm
         W+ozb1BxO7ClQkl+m8Gan+I4PrK9AxIyHMoKgmb9mwTCTanuG8znQSXjNEJSSdz+CCjS
         tjjUzt7L8oYH/opkRtjMpUjG2DatBfdUdUyQgUe2kbRXUhgTOmZJKbLW6gt5jKlOFa8q
         PvIbNQyuxQxcnzrJBIGBrbez+NgXfoNGZXlfrXoimxlqau2bHPodbWdf7TJMaveMcxUM
         xA06Ek4zaEvai/Vzf3pSl6CWkd2bm+6LrBQJOSfeWr6sNZHcR8gK1FQ/ZbOhpp3FuKkT
         fybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785738235; x=1786343035;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ck3CD6/H81B/49IDvwXO1W+2CpiInIdnGO3PMFsRX/A=;
        b=VJKa2lNF/H1bODfQtb8H8BLpPFOP0IT48VUABDY9J/KRBEUEZVfofbMg5Zs8gl7MmA
         9s82lz4E/hMqzMfibFrtiPzoUhOFFrdPNKeDx1ZL0oGrjDNOw0gqgLa/TdBp9mx98su7
         UvcTQ5nBNxaTjSsRK2K15LNhDpytDdHenlVFH38UpNfrr0ArywBD4/bKbRD7fGs7lS7j
         hGzZpHipPn7pw2saZrwTj3CMNQf5BaygfrBdLqluEESzCoiFweYJz1Lj7IbxaTfjONza
         9EDlmI723KINHi0jBbt45/7/HH9MEE9iypsiaC9RMrV4vqdcMBJ70IX/oKIFZ5WufzV3
         lQvw==
X-Forwarded-Encrypted: i=1; AHgh+RoAWh3pr4RByob50jJrwkqK9brkbMLbBaX+96XwmoSB083OfroAtKQib6HnEVhqp1wugNDuokUt+w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2sfP9mXiOQv7qhA5hahQidbHnyLbHaKPeOEE8XXIWsLJbhCTF
	TVdXT057vii93UyNo7UogBYsgWvNFGuz+Y4yJCUm1FnPYKmC0Nip+lc6
X-Gm-Gg: AR+sD10t1ja/8ex51F8Sfp7Soopy+11G9zI1UviHWgXbYerjuGZYFCh63JZ0TmtqCLa
	QFvHb1yj0yEuvHqRRL8plMotO+cIk3yhpFiLS4ybsITFvpy0U+k7Fhn8wvcXwtf8KUERcxShERS
	8JtqEbzBqJQPZ5nXurRN4mgUE/4VlCXVyqKG3kBws3UZfxHliGZ2Z2W4EjMsLTUx6rVV2VuWZ1D
	zVN6dj9uVUuK9HpDhqeqwA+2oQpIU6oNgKo8qQwXvcZEjv95uPI2XvVM13t9ZzLNlSulSHbUiZb
	kC+t5OSmxPBxGugYfclVW8gqcV++UBjzunfNScnZSp9Dcoa3QzuNCr7OB2X/3ZCfziofsjhcqjf
	tiDH4vntmGPVrC3os1GFczQGLsJR3UibV0sORBV1PdwLldDEvRT6hR+4fv9YZ9kPaNJFA4IwZax
	da9Yw3KuZFX+lsIrDg685ibiPUnE1+HwjSJRaoDE2rr9CIJ9uEF9WGbXIHE68LiX/+pY8SCuKbB
	/ihxCLggBGIZANBCFvb3Tz6KMidsw==
X-Received: by 2002:a17:90b:3b82:b0:38e:57a3:f218 with SMTP id 98e67ed59e1d1-38fbc4832ccmr8663354a91.13.1785738235117;
        Sun, 02 Aug 2026 23:23:55 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:4fff:876c:cdae:e53c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd4e666sm48696264eec.4.2026.08.02.23.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 23:23:54 -0700 (PDT)
Date: Sun, 2 Aug 2026 23:23:51 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] sh: mach-rsk: rsk7203: avoid using inline compound
 literals
Message-ID: <anAzp47FoRtVB_nA@google.com>
References: <20260802-sh-rsk7203-swnode-props-v1-1-7a790cbac9e6@gmail.com>
 <32a0d810bfc56029453aa72cefa49cb40466f64e.camel@physik.fu-berlin.de>
 <anAvJM0u_TIgL4ck@google.com>
 <70cb2e4d8a6fd11cbeb534dbf269f67148a00a8d.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70cb2e4d8a6fd11cbeb534dbf269f67148a00a8d.camel@physik.fu-berlin.de>

On Mon, Aug 03, 2026 at 08:20:24AM +0200, John Paul Adrian Glaubitz wrote:
> Hi Dmitry,
> 
> I apologize for my previous harsh mail, but the way these patches are being
> pushed in really puts me under actual stress. There is a second situation like
> this now where another kernel maintainer is too impatient.
> 
> On Sun, 2026-08-02 at 23:07 -0700, Dmitry Torokhov wrote:
> > > Isn't that the patch that was forced into the kernel, overriding me
> > > as the maintainer of arch/sh because Linus Walleij got impatient and
> > > merged the patch into an immutable tree?
> > 
> > Yes, but incompatibility with older GCCs is not something that you'd
> > recognize on the spot, would you?
> 
> No, I wouldn't. But I would have most likely caught it as I'm building the
> kernel for my J2 board with a GCC 9.x compiler as I don't have any more
> recent GCC version for J2 at the moment.
> 
> > Also, you seem to be hung up on the notion of immutable branch. This is
> > simply a branch that creator promises not to rewind/rebase so that it
> > can be easily shared between different subsystems.
> 
> Well, it sounded to me like he wanted to make a point that there isn't going
> to be any discussion about this anymore which I really thought was not okay.

No, not at all. Again, it is just for ease of sharing and promise that
git will not generate conflicts if multiple trees pull it in.

> 
> > While we are at this, there are a few more patch series for SH that I
> > would like you to take a look at, pretty please...
> 
> Yes, absolutely. I absolutely appreciate the work, I am just asking for a
> little patience. As SuperH maintainer, one of the most important tasks the
> past weeks was to get the GCC backend moved to the new register allocator
> which is finally done now. GCC upstream is pushing to migrate all backends
> to LRA now so it meant that this had highest priority.

I totally understand, and thank you for your work.

Thanks.

-- 
Dmitry
