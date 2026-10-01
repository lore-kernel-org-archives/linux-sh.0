Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1232142BC5E;
	Thu,  1 Oct 2026 13:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859904; cv=none; b=QTbTr7UvvVKhFDSGINLnqeODlMKeBtBl9oclOnBEVxHCqORBARO9ufqV5EULhy3Z0IZegKpTMhChMeR/ruTImXvPyKZRoKwtaJxvLxE8jCtpRVZ26xzh/UHWnfq3O301PiBYgKo6RJ1/Za1ZjBBybz2OTv50bjy0lb5lQU4c4wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859904; c=relaxed/simple;
	bh=FvArX8WPHlxewViLv1Bue4SKfTrgzAHP5maR1Xot8NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAKWTgksDBTQamPSDjtml4b1kQi+CTwNQ2tfGdP34GRvKWlhHvC24gJcEQuVmRgKf0w7oEcfHQzWOOjP4icmPWjJshDPm8pKzr9/zxd9XiAMtwx0pPjUx3iYPkLhz3Dy3mwiFzBl2pPtmRMcawpfXU1EukOed++EXTiJE4cPNaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiNRP0a5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiNRP0a5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916D71F000FF;
	Thu,  1 Oct 2026 13:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790859902;
	bh=ri0TJFnOtW7NOHjjGG6/gDb1crGrE3ofI7EEoUNu6U8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FiNRP0a5Wreg8uLMOskqV97W9BUG1hcR4lUGcEWmLQHZ81CDRZo6zNSkxYxjfZqra
	 VnfvxA5ZZ7IrVGHPTkxmeGb8WOzEBtvo7sNTNQWGLQG9D+/hpqmyROwK2w3n0a8TBg
	 oT1kxL7dD/nTkze6Jf5TbIoNzTcJiHahLP6PZl0evb1khYfevvJWozp5tT16wy8XSQ
	 jw6qEobzdEVZpSrAjXeLw0hwC/Hy16XejAIXVlYYI9jxi2SaRnfFtc5TtAexET1CoE
	 bJqvf+PGZs+RhgnLE0bwzqCLfadgm16M0XmyArgOGjIeCM1eQYbk70a89n6XhomCv9
	 3jmOD5EITEsmQ==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xCGT6-00000008QtQ-2P6G;
	Thu, 01 Oct 2026 15:05:00 +0200
Date: Thu, 1 Oct 2026 15:05:00 +0200
From: Johan Hovold <johan@kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] sh: kfr2r09: fix i2c adapter leaks
Message-ID: <ar5afD7Sx-hBgTxp@hovoldconsulting.com>
References: <20260508120601.426115-1-johan@kernel.org>
 <aiwtIkdGNMFqJmHk@hovoldconsulting.com>
 <06c0871d4999dcb09aeca6bbf6a6eb282147d606.camel@physik.fu-berlin.de>
 <anx_ntq7VbbuQtkF@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anx_ntq7VbbuQtkF@hovoldconsulting.com>

On Wed, Aug 12, 2026 at 04:13:50PM +0200, Johan Hovold wrote:
> On Sat, Jun 13, 2026 at 07:11:02AM +0200, John Paul Adrian Glaubitz wrote:
> > On Fri, 2026-06-12 at 18:00 +0200, Johan Hovold wrote:
> > > On Fri, May 08, 2026 at 02:05:59PM +0200, Johan Hovold wrote:
> > > > The kfr2r09 platform setup code fails to drop the references it acquires
> > > > to the I2C adapter.
> > > 
> > > > Johan Hovold (2):
> > > >   sh: kfr2r09: fix i2c adapter leak on USB gdaget setup
> > > >   sh: kfr2r09: fix i2c adapter leak on serial console setup
> > > 
> > > Can these be picked up now?
> > 
> > I will try to review some patches this weekend.
> 
> Any chance to get these into 7.3?

Can these be picked up now?

Johan
