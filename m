Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AE11DDD9
	for <linux-sh@vger.kernel.org>; Fri,  5 Jan 2024 07:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jU9+Nxeb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B57C433CA;
	Fri,  5 Jan 2024 07:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704440092;
	bh=7C4iu4t7vRsxsOwshHbLEeZzMhVNx5nZHs5GaUriptk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jU9+NxeblWWKIEcHpZT/LAkcYYeOnRlqqHQyGmuQd/mm7H0Q8q/1Ajgj9en60PhLK
	 IHJR7j1UFrO949FYnJBHVFJHfb2vtYlMaFm3ttUfWmDlv+fdBPP9r89iw20kEOhFZ7
	 HeiukD30mYAbIvwSjFeNkehzPr3OWDutWQG3JJgo=
Date: Fri, 5 Jan 2024 08:34:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, dalias@libc.org,
	linux-sh@vger.kernel.org, ysato@users.sourceforge.jp
Subject: Re: patch "maple: make maple_bus_type static and const" added to
 char-misc-testing
Message-ID: <2024010536-snowboard-curtain-8e0d@gregkh>
References: <2024010439-cauterize-trash-b603@gregkh>
 <7bdec121c0ce916f4589dd4247f9482704373aee.camel@physik.fu-berlin.de>
 <2024010406-country-entire-262d@gregkh>
 <810666aa13f5309d52d47109d20c4cf511a628e7.camel@physik.fu-berlin.de>
 <2024010428-crank-snap-8ff8@gregkh>
 <8652ad54d8d15dbb52f8feec69bde939409ae18c.camel@physik.fu-berlin.de>
 <CAMuHMdW6rhSBD2JQrS6nE=3xEQk7nCJW-TEH8Nw64BPtjzoqEQ@mail.gmail.com>
 <33944cd25cbeb4f9d88ebf81f3b0cb8d368f742b.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33944cd25cbeb4f9d88ebf81f3b0cb8d368f742b.camel@physik.fu-berlin.de>

On Thu, Jan 04, 2024 at 07:44:30PM +0100, John Paul Adrian Glaubitz wrote:
> On Thu, 2024-01-04 at 17:01 +0100, Geert Uytterhoeven wrote:
> > > I don't understand the hurry.
> > 
> > You really should aim to have your for-next branch ready by rc7, so
> > testers can find and report most issues, and you can get them fixed,
> > before the merge window opens.
> 
> Do testers not go on holiday vacations? I was just on vacation for two
> weeks and I find it irritating that my work is now overridden because
> of that.

What is being overridden here?

confused,

greg k-h
