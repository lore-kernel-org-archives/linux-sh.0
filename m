Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0F9224C2
	for <linux-sh@vger.kernel.org>; Thu,  4 Jan 2024 13:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LaVyEDVX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87BF9C433C8;
	Thu,  4 Jan 2024 13:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704376648;
	bh=KCCPdJ29mSquqDQQY2fDEqBcWm/j3g3nQGuAxByIaWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LaVyEDVXxAxv6YWWhxVfzOu1rEZZVOvnrxqm1xCv0oM1hx/+tjdOrKyaODh5YHNeP
	 RuRx1i3jdL/GTbrIF9tXDUA7cCDIsoCaj4Cf8yEv8p+2LLbNc8/Q2DSnWOOJmsGtoU
	 Q3/qz34ZpDLqCi/kp1Azj62M2BZ2es6+Ql236GCY=
Date: Thu, 4 Jan 2024 14:57:26 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: dalias@libc.org, linux-sh@vger.kernel.org, ysato@users.sourceforge.jp
Subject: Re: patch "maple: make maple_bus_type static and const" added to
 char-misc-testing
Message-ID: <2024010406-country-entire-262d@gregkh>
References: <2024010439-cauterize-trash-b603@gregkh>
 <7bdec121c0ce916f4589dd4247f9482704373aee.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bdec121c0ce916f4589dd4247f9482704373aee.camel@physik.fu-berlin.de>

On Thu, Jan 04, 2024 at 02:48:18PM +0100, John Paul Adrian Glaubitz wrote:
> Hi Greg!
> 
> On Thu, 2024-01-04 at 14:37 +0100, gregkh@linuxfoundation.org wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     maple: make maple_bus_type static and const
> > 
> > to my char-misc git tree which can be found at
> >     git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
> > in the char-misc-testing branch.
> > 
> > The patch will show up in the next release of the linux-next tree
> > (usually sometime within the next 24 hours during the week.)
> > 
> > The patch will be merged to the char-misc-next branch sometime soon,
> > after it passes testing, and the merge window is open.
> > 
> > If you have any questions about this process, please let me know.
> > 
> > 
> > From e76933a9bfa9b7f28a387f2e13cb3e689adc200d Mon Sep 17 00:00:00 2001
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Date: Tue, 19 Dec 2023 15:06:19 +0100
> > Subject: maple: make maple_bus_type static and const
> > 
> > There is no need to export maple_bus_type as no one uses it outside of
> > maple.c, so make it static, AND make it const as it can be read-only as
> > no one modifies it.
> 
> I was planning to start reviewing patches for arch/sh the upcoming weekend,
> so you don't have to take the patch through your own tree.

No worries, this way it gets into 6.8-rc1.

thanks,

greg k-h
