Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6754A37AA78
	for <linux-sh@vger.kernel.org>; Fri, 24 Apr 2026 11:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777029323; cv=none; b=lMFddRPAj99JJumv8PAOsc0eaIaLGksg87JVMUK1RTd4qGg7xTT0asrZjYucoIInf9OoJ5LIyQxNA7pnCtt6tDxljk/LtcxxM6Flev7p6/lYXn7rVOnZ6nqUZd7qWQkkD1rU54eo75ghXg0OBIcS30T6q/qsC8WQnpirhRE2gVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777029323; c=relaxed/simple;
	bh=PpTalOa37C/pSYzCXSoBpp4erqS4ygsY4dOdi9hlZR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTlo8xKm3Z+XmewBqUtaLDICf789cl1qD//EJsKcFfGXxyuiwGrPH137AG9GLuZeR3c9oOr8UqNZs74SdoxWq1P4NAhRxvEvutlNuifWmirg9K7ewR6VUwuUQFkJTlkugPPynWttELvoR3DpnXHguqSxGe94VHtWKFJAE/WhezY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nv+sDtVF; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nv+sDtVF"
Date: Fri, 24 Apr 2026 13:15:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777029320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ik00J3bJbxJJcmBW6bQaJ+xHAKlREgOypDjt/JpbhNQ=;
	b=nv+sDtVF9FuIahodMpHjBNVX5rhAxWyDoFXAqDoxg0guW3uIEMa2S0WyyH4frsixWfjbrN
	s7mDlpzrAoyNluWPpqa/XeDLVLAmrO5HTlJvVtlLV0IJVaavHbPvq1wF50GICf7cDKM0Sj
	ImGqN17QHJUdq6R0gFkb7VJ+9gUxGIc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: use sizeof() in memchunk_cmdline_override
Message-ID: <aetQv3emr_o8kK-h@linux.dev>
References: <20260423120441.212278-3-thorsten.blum@linux.dev>
 <CAMuHMdUzktvZ2x4yVvq6CDXCe8XJ49MAea2krQHGYPEVQ-sqPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUzktvZ2x4yVvq6CDXCe8XJ49MAea2krQHGYPEVQ-sqPQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 24, 2026 at 01:05:48PM +0200, Geert Uytterhoeven wrote:
> Hi Thorsten,
> 
> On Thu, 23 Apr 2026 at 14:10, Thorsten Blum <thorsten.blum@linux.dev> wrote:
> > Replace the hard-coded string length with 'sizeof("memchunk.") - 1' and
> > remove the comment.
> >
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> 
> Thanks for your patch!
> 
> > --- a/arch/sh/mm/consistent.c
> > +++ b/arch/sh/mm/consistent.c
> > @@ -23,7 +23,7 @@ static void __init memchunk_cmdline_override(char *name, unsigned long *sizep)
> >         int k = strlen(name);
> >
> >         while ((p = strstr(p, "memchunk."))) {
> > -               p += 9; /* strlen("memchunk.") */
> > +               p += sizeof("memchunk.") - 1;
> 
> Can't you just use strlen() instead, i.e. won't the compiler optimize
> that into a constant?

That only works if ARCH_HAS_FORTIFY_SOURCE is selected, which is not the
case for arch/sh. Otherwise I would have used strlen().
