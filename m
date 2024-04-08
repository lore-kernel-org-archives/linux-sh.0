Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A03140396
	for <linux-sh@vger.kernel.org>; Mon,  8 Apr 2024 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712589977; cv=none; b=Ors3vOAujhmmLmD1yMSTzwS/gK7vIj9Naw+gyYz4QgGhmhoUT/QbgX65uxI11TQhhrYy0E+inXOOe5XF3oQDO4BA9szxvvVuqIvsm3WGLt8Cn5tFTwCA7R2MwniWB1lmjPmCA38ZSJ5aUEQEAzJ2uBqJ7otDZ0dFgyBxdc/k+2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712589977; c=relaxed/simple;
	bh=DP+q2sSRQ6+dIlhJlzCwYJnhovhCmCKYWo+aC/dH+tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pi89gSrNCc/8BsVVFqDC7qbdUEWkOx0GhXD/sKA/VtUX2+mJSTXxafV8hLViee+Mu3Gu87bFHJZD1dTCl7Zq4kKqDCSHhPWIVYo5EDUV7HZnpmK6evATUjITjzjmb+Mbbg52+7i+6sa4iRLvu/Wceux5xw2QvhWkmMHk9ve7+Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iL0qNbB9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iL0qNbB9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5B3C433F1;
	Mon,  8 Apr 2024 15:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712589976;
	bh=DP+q2sSRQ6+dIlhJlzCwYJnhovhCmCKYWo+aC/dH+tI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iL0qNbB9zwHIqcK4lvYS7mETCF55Yor8+Cg6pxFuQ7JSrbWoI0PQf4hb6aL6pn1L5
	 0VuyjItc6/yE+439vp75N+NeKmzUGaRDvy/rxf+b7wwOfoz25Iw0n0CCQj2fE/99DE
	 OJ7kd8DoYFyVVhWnRbLjs26oizvzoW9FQ/UjfOFg=
Date: Mon, 8 Apr 2024 11:26:13 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Rob Landley <rob@landley.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>
Subject: Re: [RESEND v7 00/37] Device Tree support for SH7751 based board
Message-ID: <20240408-colossal-rugged-ferret-fba6f6@lemur>
References: <cover.1712205900.git.ysato@users.sourceforge.jp>
 <e5f6a857-1296-e110-a3b2-c05d08522371@landley.net>
 <CAMuHMdWL0aHmZS7NuZO5AUhn=zmNDG+fPZzmG--DyZr-LFwZ-Q@mail.gmail.com>
 <aebc1db5-5c3e-dafe-0c35-7d0a4ed4d885@landley.net>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aebc1db5-5c3e-dafe-0c35-7d0a4ed4d885@landley.net>

On Fri, Apr 05, 2024 at 01:57:32PM -0500, Rob Landley wrote:
> Let's see, google says it's a random python3 tool, probably wants a newer
> python3 version than I've got because everything that uses python3 does, it says
> "you can run it directly from the git repository"...
> 
> $ ./b4.sh
> Traceback (most recent call last):
>   File "/home/landley/b4/src/b4/command.py", line 10, in <module>
>     import b4
>   File "/home/landley/b4/src/b4/__init__.py", line 37, in <module>
>     from typing import Optional, Tuple, Set, List, BinaryIO, Union, Sequence,
> Literal, Iterator, Dict
> ImportError: cannot import name 'Literal' from 'typing'
> (/usr/lib/python3.7/typing.py)

Python 3.7 is EOL as of last June, which is why you're seeing this error
trying to run the latest master branch.

To be able to use a EOL version of Python, you will need to run a contemporary
release of b4, which is 0.11. To do so, you may check out the stable-0.11.y
branch and repeat this operation.

-K
