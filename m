Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7813009D6
	for <linux-sh@vger.kernel.org>; Fri,  3 Jul 2026 05:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783057589; cv=none; b=DHplSCGPfn5oXr+pqxL6uWiNJ6WYRvasO+3D+aij/7U1sHAFTFetVkrRzBJRszmGVXp3c2DsQNPnH7zh0EUU29meNvR/Yozfh9zNaglbKlK3x23U/lZo4BNnELbIn9sIWF5u//hWhmL8UW0aEhjmE9xFNsWNKeBBQgbXLqPF0N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783057589; c=relaxed/simple;
	bh=Dv8Nw2p67ddP0dKnVf9qrd2Us/sMLgUELm4HJzxUUzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnuwYvBDjPMcA1ZbjURq+a2rapw1IB/in7G8xcZDfK6rV3Ewo4h7T5wtLkYKlhQqBL3mjyNt6BQgPCMJqK9d7LjCcKNSdf4oBWEPpJFbqJsjxeO4N3N+vopiiljmhext2BUslM2gWkfkboczLcd7N5JuRIfduFVuCdN1iXpuxLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/n0NoZy; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/n0NoZy"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38005a36edbso153316a91.1
        for <linux-sh@vger.kernel.org>; Thu, 02 Jul 2026 22:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783057587; x=1783662387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VgOfL6jUNL98zK671Fx4+N1S0EFaelQIFQrG9658iRA=;
        b=f/n0NoZyGOYbidIDRCCijapdeR1GIX21MOTutFMpKSov8YCYrTYhqwKBCCc/4D0a97
         jczXjqQ1QGL7HK3C8g46uBOM1qGWIvGb0QSoJiVQtSP5AoMjYVch+HGkcq07qLQSoyb0
         X0H9Ct4L9fA4/PvYyRuhUtcQGRnbARFQXe5m5RG1jDPtCk/IPl8z4U4vdM2H6MGXy8k/
         p5IMBmMKPwiSv9oOQERvHQ370iLa8qyN/BotnBGwwc/aBN9JB2490sVU6/yaBRJJe5hd
         TzwMR8rvF/5HS/OapwKS9EOqDmVJcZmXYTM/K4qHTGxJD1pQiO3p4wvN04Dbwbq3vtdl
         EjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783057587; x=1783662387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VgOfL6jUNL98zK671Fx4+N1S0EFaelQIFQrG9658iRA=;
        b=nSzebfjG8jbvyg7Nx5SAjNIJeBvdmCzB/R5wONVt6rjBo7flIfPzQ4GEqLeyzYmBDy
         VrpqqWC3Ke7MeANKuA6ZIAOdypAWOR0feLNAas3kFqKOW0PX/w3t16CcqO3x3/A06Lrw
         2Jhee8kASfuyNVkkp503G12ama7q1xGFFwZsBGlnJU+6my7nfKej1Ln0ebYzTP8FKj+T
         PErhrdnkJIDDvTrAvzueFMcgyPs8vwqpZSF+PjgvLy0tH5jBQNbQ4cegLcXpFhOYuX7o
         LI5tDvMakgnmTEHKHTw3YDu8WFitwzQAm3jfme2Qq0riNtLHotCZeH7I15fgL0J3GFVq
         NMkQ==
X-Forwarded-Encrypted: i=1; AFNElJ8EmgRKYUUmfC93TeQ0zo4X5v0vx26Nm4n1LGa/2KRP8UvAzW89KNsUR6cLO2pGoC36kzG/q5kFXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpV/AW4GlEOzEhnRR3ur5NaBFrN0cuzWZUMGdSl+z5UC6+ec2c
	0oHKCtJxJQGmsGwIFNED3siUzcAfiL6pWMUNCBjCGQQ9VlsqF3leirH/c3q5zg==
X-Gm-Gg: AfdE7ckoyZ91TkVacescJ8WJ7eLbnTKr+5A1o4pk5sMMLgytKP4mGY+6zZIyTePFyvv
	aqZSn8/An7N8zMT0osCzxBO7o875UGfdjp8LNtXCR7CkMvmiUHQgFSk817ywqLMFL93JHujAIxa
	h8EY7ZqjB/BCd8gz2fICo4RIZiYvH1EQz8oK4To4OsCFjHbNURcWTNh9bI9dH0ocO4t7+n5++Uk
	Rj7C245LeHTpTSEKgFyIlDzOUzifJysgyq+WCfaldb/Yew8A94jMdL8kAwggpwgpRPYbzhsSs8V
	9dQ2FS0cm+8MgN3GrpyH59DjKOI8dqALeDCgXLpdujcgW+fo8heghEq03v+t2ABim82utfRLjKy
	z5qSxXjMWBZq30KZGgq/rJ2rHE4lpZplfu/C42yBRPj+Ixc9jcnqi3ijSAA4YxaiI4ckwAgYo9z
	l9JCTQFqyBkW8eT8umkcKllSfpu6w1dnunN1wpeJweRamdvwMqjWRcPA==
X-Received: by 2002:a05:6a21:3987:b0:3bf:ae43:4d26 with SMTP id adf61e73a8af0-3bfed0e1385mr11025011637.5.1783057587300;
        Thu, 02 Jul 2026 22:46:27 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:66dd:f357:cb25:7bd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b85de12sm16655180eec.12.2026.07.02.22.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 22:46:26 -0700 (PDT)
Date: Thu, 2 Jul 2026 22:46:23 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Florian Fuchs <fuchsfl@gmail.com>
Cc: linux-input@vger.kernel.org, linux-sh@vger.kernel.org, 
	Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: maplemouse - fix NULL pointer dereference in
 open()
Message-ID: <akNZDbI4UoGxfuzq@google.com>
References: <20260628230715.2982552-1-fuchsfl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628230715.2982552-1-fuchsfl@gmail.com>

Hi Florian,

On Mon, Jun 29, 2026 at 01:07:15AM +0200, Florian Fuchs wrote:
> Commit 555c765b0cc2 ("Input: mouse - drop unnecessary calls to
> input_set_drvdata") dropped the input_set_drvdata() call in probe
> because the data appeared to be unused. However, dc_mouse_open() and
> dc_mouse_close() were using maple_get_drvdata(to_maple_dev(&dev->dev)).
> This actually retrieves driver data from the input device's embedded
> struct device. After input_set_drvdata() was removed, that lookup started
> returning NULL and opening the input device dereferences mse->mdev.
> 
> Restore input_set_drvdata() and convert open() and close() to use
> input_get_drvdata() so the dependency is no longer hidden.

Thank you for the patch. While the patch itself is correct I believe the
main culprit is actually 6b3480855aad ("maple: input: fix up maple mouse driver")
that introduced incorrect use of
maple_get_drvdata() and to_maple_dev() on instance of input_dev instead
of maple_device.

I added another Fixes: tag and applied.

Thanks.

-- 
Dmitry
