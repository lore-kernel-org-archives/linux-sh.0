Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B5C37DE85;
	Fri, 12 Jun 2026 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781279952; cv=none; b=BAf3tG5Np15oOJbDQXM3x11LPsgQZlu6pzJQSpn+A2J4Wbit3gsgK4Bx9tw+GSmWSld29s9JgVUqK7o24hhOSvN+j1nHRk/9sYzDspi55Su1NRQF4La0xocToPsJafdg6DXqEuTIqOjvx6q2+l8SzF9tFoXAcYowc2GRO2rk2f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781279952; c=relaxed/simple;
	bh=Uac8WGihz/i2rbYR0n0l8hkZHS0geZSSisHXwBjacQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtB90pIQ2g2GL5zDqfUgU2hUbN+z4/NxddJneD9aD0cWcUU/dqbYIL7OV1K024EPo/o9wxq8JOVVFR4xRArXdJOxb2VYHBokCuSr/Uwlsk3cKdCeofHjA4m15ibnYkz/rPjsHvpwoOy4TIKSnXtJZ+wft9OsOYSnTIASWN5idGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YF51ldIF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YF51ldIF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F641F000E9;
	Fri, 12 Jun 2026 15:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781279951;
	bh=7DNV6CXqJtNe7ll3MyNP93G+cJoG85DgxsrNPA1adq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YF51ldIFb5K3cx7cehX5LVNoNCxTQGLfuImHqLaLChmYDdjkaALD87nHnErL5GX4D
	 ZqwyGX9vZ2JFTqFoDnIbsqI3/UTqvDB/ERbO0k5JnaSVWVUKzP3kJ8o2hyPUbb8lU8
	 YdjCNEFkQjSlK6O2Pm5LZ6seJQqacQ9oVCGXc0x4DFu1sXqjVbd70iZnSiikJ2KgAO
	 qPw0Oh920GgLTKFYNU7gCt9PMVFoRWJ0+FyhMAI+5h1lSX0OQjIsebNGBs1lzP647e
	 MvsaEIj2F0ES9cP0ghIREZOAJ2nHx45GP3I7Ka0ni2Ho1H0ihMcXeVtZIZmHtTVVFN
	 YuqL9VKJkL5Kg==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wY4Hl-00000002OXQ-2UIn;
	Fri, 12 Jun 2026 17:59:09 +0200
Date: Fri, 12 Jun 2026 17:59:09 +0200
From: Johan Hovold <johan@kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] maple: switch to dynamic root device
Message-ID: <aiwszTsW0RwAELGS@hovoldconsulting.com>
References: <20260424104142.2617115-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424104142.2617115-1-johan@kernel.org>

On Fri, Apr 24, 2026 at 12:41:42PM +0200, Johan Hovold wrote:
> Driver core expects devices to be dynamically allocated and will, for
> example, complain loudly when no release function has been provided.
> 
> Use root_device_register() to allocate and register the root device
> instead of open coding using a static device.
> 
> Note that this also fixes a reference leak in case device_register()
> fails which may be flagged by static checkers.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Can this one be picked up now?

Johan
