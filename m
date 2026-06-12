Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963DE13B58A;
	Fri, 12 Jun 2026 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781280037; cv=none; b=IkxDu3j/qYuifHF33UU/DTE4OZaAPufGeFWHWrbCw5kdmuhd5M+BzikW4/xwRu/PhXdKZPXxJEbrvjl/bvlwIssXAPJJlY7SP0FUUh52ucahpQVAtlHNiYZYhHP4nfZsCcp8d6hPicCWKGAuzd1yOCUm9707GY7LmVxqwz4Q7SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781280037; c=relaxed/simple;
	bh=fJWStwO3DTVJxyMpMxmpCg2xo3Xj6WzGnqMsTAn26p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUFbtZbfKcyK4yeH78nVPuGGE7C6yR8jAGK41p5vrw0PDC3O/x0VPMx70V/mtGhfdz2N+hTSo9M2EqJvrq0ZeOzEar1Xqma+iG1fpBCV8TPFwVXHzURl4z9rITeAsG9L1G1DzMZQOUc21KmeR1BGFGAMwP+w5WxH/vLgCYI4QAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSP6litT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSP6litT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4966D1F000E9;
	Fri, 12 Jun 2026 16:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781280036;
	bh=jwz58cv5mCYeVxhe37X2zWPQvOQVmROqt3nlXucX4WY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PSP6litToBSP5dWECjgy9MRhLsMakM3+iECvlHoDj+Lr6wZ91cflI9fZzG4M5mI7F
	 55dTmaRdhwUSyU2FEcfmVZei7+eutQEPl1p4uW/Z0XsaEZPP9XmPGQEflDtTsfFTiJ
	 k2sYbR60Ds6x2MsFzFXJ6ltPLTtr/XcwTob8br2uEyGkWPyr3hTwKDbJ9XhLj69jf8
	 7AMb5cYlLHaNBSDLEqneb3hpkxgByHpIG75TpL7UZEi+MwEV/S7JGwp5Y0g1S1MirV
	 k5oFyaE2qZGGKPcQ60hHXpFXde35RZ8f+VITT3SBPlAxl9NY0hk2C3+9gPxINBJRKx
	 UCnu1OpxwfChQ==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wY4J8-00000002OZF-0mlM;
	Fri, 12 Jun 2026 18:00:34 +0200
Date: Fri, 12 Jun 2026 18:00:34 +0200
From: Johan Hovold <johan@kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] sh: kfr2r09: fix i2c adapter leaks
Message-ID: <aiwtIkdGNMFqJmHk@hovoldconsulting.com>
References: <20260508120601.426115-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508120601.426115-1-johan@kernel.org>

On Fri, May 08, 2026 at 02:05:59PM +0200, Johan Hovold wrote:
> The kfr2r09 platform setup code fails to drop the references it acquires
> to the I2C adapter.

> Johan Hovold (2):
>   sh: kfr2r09: fix i2c adapter leak on USB gdaget setup
>   sh: kfr2r09: fix i2c adapter leak on serial console setup

Can these be picked up now?

Johan
