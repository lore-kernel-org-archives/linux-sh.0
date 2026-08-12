Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E653E5585;
	Wed, 12 Aug 2026 14:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786544034; cv=none; b=fTXKWm+UX8UaiT4AzIGXPN6bzowfzpeMDpH49lyqAp0nxIWfsycPBX8uOFXgMMeOg7YgnHM86Y3I+enmEPjK71cNYZDAcGeFShtIxF7CSXCcosXa8gWpJQ5IAxXEnPqUSjoD0MAfNFYr2wR35eNnS2V6NM+tMuoA7rLzrPm+BCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786544034; c=relaxed/simple;
	bh=YZWSU+5+a1EI+03Q/c+K43v/d3ZaqcxQdiHq4PWSK6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEoDx4040anrwIh6e4/qTJ7zlfhlA1x9K1xoPeqjhTP/Cuf4gwz7udYZJmkt1aYkD8pXvle27MW5y6QfaC6C7mhQJ4orSbQTJ3BTkHTIRU/6YXqDXEpV7/oQaJBcyPnyLXa0t14wxe3/z5psc06dvTjBU6928eNCjW0y/pW3l7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Al7mWqVs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Al7mWqVs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDEC1F000E9;
	Wed, 12 Aug 2026 14:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786544033;
	bh=BgXO7IVszk3bAMhxlnhm2uT6hDWvgzwS+xuMi4pdSgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Al7mWqVssSp94vfE14DrYao3o96L4qWrfpOIuIKVxsZDCQm/w9xulnxcKNADI6JXz
	 c+s3DAe78YHNMEye2kh2X48zO8iZlyomsvHNp8TRV4YelqORPaLvzQEriUewP7Q775
	 y2BWgG7/4MiigwNR/k4ZJP8UpdKwjDCW7XQXvcsvRtIMzrYaGToCP4rl7phj55jgRD
	 ysc5PBRvykoLDpYlrtB/tvcdLw4RH6/CUmmBavYrRNt8AMuoPaO6ZCgJkrqlZf7ebh
	 nG/xzJu1B7ipkARKkJ8+3oN39cZl1+FslXY6IQlkL6ouTfinuYlQdGzBEJl5DSScWZ
	 zuJFMjg3MC75w==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wu9iI-00000000EFG-3xgP;
	Wed, 12 Aug 2026 16:13:50 +0200
Date: Wed, 12 Aug 2026 16:13:50 +0200
From: Johan Hovold <johan@kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] sh: kfr2r09: fix i2c adapter leaks
Message-ID: <anx_ntq7VbbuQtkF@hovoldconsulting.com>
References: <20260508120601.426115-1-johan@kernel.org>
 <aiwtIkdGNMFqJmHk@hovoldconsulting.com>
 <06c0871d4999dcb09aeca6bbf6a6eb282147d606.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06c0871d4999dcb09aeca6bbf6a6eb282147d606.camel@physik.fu-berlin.de>

On Sat, Jun 13, 2026 at 07:11:02AM +0200, John Paul Adrian Glaubitz wrote:
> On Fri, 2026-06-12 at 18:00 +0200, Johan Hovold wrote:
> > On Fri, May 08, 2026 at 02:05:59PM +0200, Johan Hovold wrote:
> > > The kfr2r09 platform setup code fails to drop the references it acquires
> > > to the I2C adapter.
> > 
> > > Johan Hovold (2):
> > >   sh: kfr2r09: fix i2c adapter leak on USB gdaget setup
> > >   sh: kfr2r09: fix i2c adapter leak on serial console setup
> > 
> > Can these be picked up now?
> 
> I will try to review some patches this weekend.

Any chance to get these into 7.3?

Johan
