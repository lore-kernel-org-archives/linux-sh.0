Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F9533E355
	for <linux-sh@vger.kernel.org>; Fri, 24 Apr 2026 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050662; cv=none; b=Djk84s1Er0TeNWuMmr9NHnQKwICWy+ZUxExGPs+yQuwiIb7naKXC7TuuvQfjYVmvqXd+4LDFsAQa8z8tyw+Y3tsb7Xg9QzbjP8n9lSgTE1Jj2FbHv80MQtaJ0IvvF0NyHhD2dU0X3qbxCuNos/u9VLqi3COclKZ8dOEMNrB7UMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050662; c=relaxed/simple;
	bh=PqY0DlOc5QVxOpdkHP6Ci9tpZLb7pdcsY9EgYIDAcX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7rq7PpWNDEn2DigDEwNdYlQLJ2BD/k9Zhm/rsc4KJYZ8ZCM43GYBNsIVv8SAS0C02Dv0SxwaAFmcZPRw9p5R5rr7pzseEDWJDe5MV20JbQU7ZBw6HkK5DPdJd2yRtVpF432+1nqZDVxCXlVCifEHRlONa5dxAecmYo7Rbd7Lrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j/K5AJsa; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j/K5AJsa"
Date: Fri, 24 Apr 2026 19:10:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777050659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HXLgGbrRDSqViLm3/46KWass2TEKy/mGXvR1+Wp8kWc=;
	b=j/K5AJsa7v0oJXvIUy02/bj+vjwOEueV2gzu+u3PJAzInTCnpBj/Z6EzjwCeDgdkBPadjn
	Rnera4h2B4iD6AdGql7Ni3BNpaYeHmJVEZTFz7Vwxb5YbHdl5GUNJVIbcCBPP76Q9t2+Aw
	XzHV27gV8FGUHQQEw2rmOX8je777808=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: use sizeof() in memchunk_cmdline_override
Message-ID: <aeukFnPUqcm64-2_@linux.dev>
References: <20260423120441.212278-3-thorsten.blum@linux.dev>
 <CAMuHMdUzktvZ2x4yVvq6CDXCe8XJ49MAea2krQHGYPEVQ-sqPQ@mail.gmail.com>
 <aetQv3emr_o8kK-h@linux.dev>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aetQv3emr_o8kK-h@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 24, 2026 at 01:15:20PM +0200, Thorsten Blum wrote:
> On Fri, Apr 24, 2026 at 01:05:48PM +0200, Geert Uytterhoeven wrote:
> > Hi Thorsten,
> > 
> > On Thu, 23 Apr 2026 at 14:10, Thorsten Blum <thorsten.blum@linux.dev> wrote:
> > > Replace the hard-coded string length with 'sizeof("memchunk.") - 1' and
> > > remove the comment.
> > >
> > > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > 
> > Thanks for your patch!
> > 
> > > --- a/arch/sh/mm/consistent.c
> > > +++ b/arch/sh/mm/consistent.c
> > > @@ -23,7 +23,7 @@ static void __init memchunk_cmdline_override(char *name, unsigned long *sizep)
> > >         int k = strlen(name);
> > >
> > >         while ((p = strstr(p, "memchunk."))) {
> > > -               p += 9; /* strlen("memchunk.") */
> > > +               p += sizeof("memchunk.") - 1;
> > 
> > Can't you just use strlen() instead, i.e. won't the compiler optimize
> > that into a constant?
> 
> That only works if ARCH_HAS_FORTIFY_SOURCE is selected, which is not the
> case for arch/sh. Otherwise I would have used strlen().

More concretely, because __HAVE_ARCH_STRLEN is set in
arch/sh/include/asm/string_32.h, strlen() resolves to the arch-specific
assembly implementation in arch/sh/lib/strlen.S.

However, constant folding is only guaranteed when calls go through
__builtin_strlen(), e.g. via the wrapper in linux/fortify-string.h,
which SH does not use with dreamcast_defconfig.

I also checked the disassembly, and sh4-linux-gnu-gcc (Debian 14.2.0-19)
did not optimize it into a constant.
