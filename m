Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795787883;
	b=tPYm8FTDFKu0bKcQH2gwaCdEUaXyTZPlbRNU17dLmSqFTcQFC2x1DWRJZGIh4Z3lqRji
	 Mxu/9aWmwBlrCqSf6vVANxtFFf1Uuj3PL2bjZc0blp20PShg5YPRdmo9LH2jhmSyqjjpb
	 GAa+rhzUXNcrFyasdWrTUHQcmUs0//XOWX3rISCwQm0iPdOnNacehstyqgkUAUrBkZVZi
	 XPt+yKMpsqLcaLssPvMbSGGotpilb5zXE57eMwFgkNGUAttW1IfatHZgHFXRabdeP5L+E
	 p5Q38MZVPgNRfHrB0cTFExefi682YhzGj0C4najjUJTlLRDTXrjdPI/aKa14pm16S5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787883;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=szVgaibry9oYc6Hb9Fvj7Sr2KhUFb4A0TTjlaHwIMpw=;
	b=uoFjmbEzFtQ6Tq6sX798YB8HkneU6Rm2fPn5TF6imyvVtGgfFJksDaJTIPMo6+V/dqL6
	 ebX+bMDfynxOMpaZnP32aLmbwvEuDGdjGT4Huwa7sDSKv2iWiBEzXdofA3G8VUVrDXQQv
	 HAsoZT+du+suqYKfuTYDlcYfJY1HDa2hYIXmnOVF90sPUXhx4lVtqCLccEsYcblPu25Va
	 bzTDFzcfNPydjC9jJzXFrF7NRLROFv5Jeefyowg9B0cfBOAUTTwgF+Szvso4h2Rm8ON2y
	 ayzTWs3dXvkfcLRIuAwTuC5FhyJ5mqeUZgZITw0R9wZSNL6yh4FU7K7qkTRG5MnEJOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BcABvHmf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FFF606A31E;
	Fri, 27 Nov 2026 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BcABvHmf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AAD1F000C1;
	Fri, 27 Nov 2026 13:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795787882;
	bh=szVgaibry9oYc6Hb9Fvj7Sr2KhUFb4A0TTjlaHwIMpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BcABvHmfza53hkvkRI8sqsQ5thyn9Xowx0/UhTnOWBxZI+NyyLhd2lRlB0ST9OXU7
	 JN6BlRmPb0vEg7DOItyaeqStrryrIyK+WeJIWHHU3Yx/Q0ZHa7N4mj2zxX1ShqxHTU
	 omQUfmk/W/UoUBxkr0xWbT3spinePEW06PAHWj/kbhV1wE/eMNa9uB0O+Ruo8i29Zd
	 DqmBZyxrmPs32IkL+HrDOxNzRaSk10bZOxns/IAdPFAi7P3UBPZKPSwheYLl+53L9v
	 FiAod6ycSu12u4e0MZPXbthsxCOVTpYv+qKa5Z1nKEzaJ3LxwOhjtd7oKvkIcS8wMx
	 zxK7tu+ww4aCQ==
Received: from johan by xi.lan with local (Exim 4.100.2)
	(envelope-from <johan@kernel.org>)
	id 1xWwSe-00000002Cl8-0VUQ;
	Fri, 27 Nov 2026 14:58:00 +0100
Date: Fri, 27 Nov 2026 14:58:00 +0100
From: Johan Hovold <johan@kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] sh: kfr2r09: fix i2c adapter leaks
Message-ID: <awmMaPr3TCrM2Qz7@hovoldconsulting.com>
References: <20260508120601.426115-1-johan@kernel.org>
 <aiwtIkdGNMFqJmHk@hovoldconsulting.com>
 <06c0871d4999dcb09aeca6bbf6a6eb282147d606.camel@physik.fu-berlin.de>
 <anx_ntq7VbbuQtkF@hovoldconsulting.com>
 <ar5afD7Sx-hBgTxp@hovoldconsulting.com>
 <7e991a2c3cc33696ea8d15734b89b67c8bb46f5d.camel@physik.fu-berlin.de>
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e991a2c3cc33696ea8d15734b89b67c8bb46f5d.camel@physik.fu-berlin.de>

On Thu, Oct 01, 2026 at 06:41:02PM +0200, John Paul Adrian Glaubitz wrote:
> On Thu, 2026-10-01 at 15:05 +0200, Johan Hovold wrote:
> > On Wed, Aug 12, 2026 at 04:13:50PM +0200, Johan Hovold wrote:
> > > On Sat, Jun 13, 2026 at 07:11:02AM +0200, John Paul Adrian Glaubitz wrote:
> > > > On Fri, 2026-06-12 at 18:00 +0200, Johan Hovold wrote:
> > > > > On Fri, May 08, 2026 at 02:05:59PM +0200, Johan Hovold wrote:
> > > > > > The kfr2r09 platform setup code fails to drop the references it acquires
> > > > > > to the I2C adapter.
> > > > > 
> > > > > > Johan Hovold (2):
> > > > > >   sh: kfr2r09: fix i2c adapter leak on USB gdaget setup
> > > > > >   sh: kfr2r09: fix i2c adapter leak on serial console setup
> > > > > 
> > > > > Can these be picked up now?
> > > > 
> > > > I will try to review some patches this weekend.
> > > 
> > > Any chance to get these into 7.3?
> > 
> > Can these be picked up now?
> 
> Yes, I'll pick them up for v7.4. I have already reviewed and merged
> some patches for v7.4. I need to perform some more tests but yours
> should go in with v7.4 as well.

They apparently did not make it into 7.4. How about 7.5?

Can also pick this one up along with these?

	https://lore.kernel.org/all/20260812142636.55563-1-johan@kernel.org/

Johan
