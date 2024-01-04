Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76CC224E4
	for <linux-sh@vger.kernel.org>; Thu,  4 Jan 2024 14:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BZMH/I1G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00838C433C7;
	Thu,  4 Jan 2024 14:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704378056;
	bh=qdbi75ogSoOyKGmG/rTrCIHodZrQ+tAZ4VnJQgqcmtg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BZMH/I1G0k1gncjuQLxiXgeobX8teGFBZCVNIuAY0NInGcmmSlavN7noonFm8X/Yu
	 ZrRTsmKKAP5UEw6H2Zkbb0qh5y85xaONayHWuMWUOAnVhuu/X5wyu2Hmg9r8RS3O/y
	 gNIsYB9oIJx6Z2cttVLe1e3LyX2hskLtiqUCFeb0=
Date: Thu, 4 Jan 2024 15:20:53 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: dalias@libc.org, linux-sh@vger.kernel.org, ysato@users.sourceforge.jp
Subject: Re: patch "maple: make maple_bus_type static and const" added to
 char-misc-testing
Message-ID: <2024010428-crank-snap-8ff8@gregkh>
References: <2024010439-cauterize-trash-b603@gregkh>
 <7bdec121c0ce916f4589dd4247f9482704373aee.camel@physik.fu-berlin.de>
 <2024010406-country-entire-262d@gregkh>
 <810666aa13f5309d52d47109d20c4cf511a628e7.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <810666aa13f5309d52d47109d20c4cf511a628e7.camel@physik.fu-berlin.de>

On Thu, Jan 04, 2024 at 03:02:36PM +0100, John Paul Adrian Glaubitz wrote:
> On Thu, 2024-01-04 at 14:57 +0100, Greg KH wrote:
> > > I was planning to start reviewing patches for arch/sh the upcoming weekend,
> > > so you don't have to take the patch through your own tree.
> > 
> > No worries, this way it gets into 6.8-rc1.
> 
> But the merge window for 6.8-rc1 isn't open yet, is it?

It has to be in linux-next _BEFORE_ the merge window opens.

thanks,

greg k-h
