Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAF42E7BB4
	for <linux-sh@vger.kernel.org>; Thu, 30 Oct 2025 11:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761823142; cv=none; b=u+NQdt6rZI3GP1NuxuLLmULZ7Cj+4geiSqDOVqZyjbE7mIaWnHmo3UJU+2ieuVY10M6qLhhprSEJ1499wK9/7tWiIW1wL1oq4irVW4U/xWc31sV59udUoMRRmtuVSyBZ50dH+ex1ka0UX1MXaalQkCSkVJf75xfH4jzg3/kmjtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761823142; c=relaxed/simple;
	bh=dMWeVsXlPYq+6w66BT5t7sFQftyp1w+uf3dD7WEW+Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNpXMfbtEBVShe7vemEt6FIKpbPNYgCcJCMWDp7e0taU043k9QyENXaGHXtmRwfZI/XflR2l8SvNlhq+7tj3TxgkbaZ5pCINj2AR0KxjKErcAfmr2cXC2gMS/hOZkH85Wjgkks/rsjuu0Tv65VviwFmqn5v3qfI92ekS8MGFXv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUMpsPNY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUMpsPNY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087A0C4CEF8;
	Thu, 30 Oct 2025 11:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761823141;
	bh=dMWeVsXlPYq+6w66BT5t7sFQftyp1w+uf3dD7WEW+Wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TUMpsPNY2Avx+CEsJhbuUOTzE6D0vmcukFqQ3brKymX1bSoe2y/32milLkW7nFxpj
	 q5Z82zTpvPttyrM//kUS6S6vjBoeO7qhSCBvRpaDTGwXBe6m8+jNpQb/Q/W2YlpOVz
	 /w0tRON0ru5SGJ2mlOObIDUiYoPmhgkdDduQSbfLSnAx816lOpXXVtOgolbrCE46n7
	 KLpQzkf51qrGwsY8YJMOgs5mh0TM41wmZw87u3fLw8XoW5qoMngAQ5hhC0Uj5xWP6+
	 W3eBFNiRQMH6zm8tGxiAmVpFb8hXfeqzDdNFQxSunEXwFx52w9EEoBJFLEHvOL8B9P
	 UoB0Xs/gV1EEw==
Date: Thu, 30 Oct 2025 11:20:03 +0000
From: Daniel Thompson <danielt@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: ysato@users.sourceforge.jp, dalias@libc.org,
	glaubitz@physik.fu-berlin.de, lee@kernel.org,
	simona.vetter@ffwll.ch, linux-sh@vger.kernel.org,
	dri-devel@lists.freedesktop.org, kernel test robot <lkp@intel.com>,
	Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH] arch: sh: Include <linux/io.h> in dac.h
Message-ID: <aQNJ4xZzMps_OLD8@aspen.lan>
References: <20251028170913.16711-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028170913.16711-1-tzimmermann@suse.de>

On Tue, Oct 28, 2025 at 06:07:55PM +0100, Thomas Zimmermann wrote:
> Include <linux/io.h> to avoid depending on <linux/backlight.h> for
> including it. Declares __raw_readb() and __raw_writeb().
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202510282206.wI0HrqcK-lkp@intel.com/
> Fixes: 243ce64b2b37 ("backlight: Do not include <linux/fb.h> in header file")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Daniel Thompson (RISCstar) <danielt@kernel.org>
> Cc: Simona Vetter <simona.vetter@ffwll.ch>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Daniel Thompson <danielt@kernel.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: dri-devel@lists.freedesktop.org

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
