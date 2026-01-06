Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A73E32E154
	for <linux-sh@vger.kernel.org>; Tue,  6 Jan 2026 12:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767704186; cv=none; b=oCxc4S07f9Xw2IZeLb2mBZ55GOpnyfDhy/jLOeCLeCYz+IFMVf+h2IwuBf93UQCKPI4/JcU2xLbl+EPGXLzVSHpfI1jw+iCToIgeeTGoWpwXAM/su2UURwpjHMTPN7m2ec6f4Vn0LYaXszcEsZUUfqi8wTM8Jk6jIeLyiYI6GyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767704186; c=relaxed/simple;
	bh=a6QY7v3K7LjddIGzyyZ7ya0cKsRU0fqtaAJcXUSvpLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JtdJat6WfD/2hS/yY3tDfjHmw4qNtE5E7nPieN7eofStxw4xR85uKj7rnlF7ezQbQsdHOHZ1bPdLImxOFa0NSG47XxAczgVP3VKc6LFBJtwEZUoNWCLz5j8cRs9V/ZKsBzCNXTHAQFUJG8Nfp3FcCLm0Ikq/G1jqiywNll9WTq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=COPvcOnV; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="COPvcOnV"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-bf5ac50827dso576504a12.2
        for <linux-sh@vger.kernel.org>; Tue, 06 Jan 2026 04:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1767704184; x=1768308984; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a6QY7v3K7LjddIGzyyZ7ya0cKsRU0fqtaAJcXUSvpLo=;
        b=COPvcOnVePvaNxl6O/hNRyX2xGpDmK9EjSC3WkJfnNhsTWD+vTeCZCD/eaEYfE8dOD
         6dJVcJqM8Y/Fhkl+jjBQuYw5Z5AqgWTaWqyvcieysYkG8YUZY/DzZnGpKtblypfAWozv
         s6C4yp/EF6R/Ba0S27cSWZE+6S8RJsTiIEvLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767704184; x=1768308984;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6QY7v3K7LjddIGzyyZ7ya0cKsRU0fqtaAJcXUSvpLo=;
        b=VSoNoqwpkS4oSGs+P+CEWbiis1oUCiJ5Bx3/zVO35ISMvo1r9/+XDDyxzj1iwFmRUU
         xYoNccx+wGHWyceyHbyB3kTZC+LZXoyHtUeJ9/JAia9lLRweS+bQb6VfUrp/mbVdF8go
         fHu2pmg67dSjVZq6XBwTTJOVmXqMCfoGivnvtN/DwCTMjviWofJDQtwda4cg8xj7xnXS
         DU52Oe+945qwRCFUGKeSPCjJD8IbN8JFE+yxih+0SQUE7N/3bzFp1wf65x7eXlzDyeN/
         tVhTj8aP9xAmdG7lx+FNp0lcM5v40k3PwIyjRDYJffmTGMMfh2GuCJ/+5IEs+vb1QBEV
         kaXA==
X-Forwarded-Encrypted: i=1; AJvYcCVF7weRlaT3dDVj83jBtsPa7yjsSv7ixPdo2dqQnJsCPIi24pCUGvWqv/zKYEgZN/JrZUu7wSxi6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZTyV9L1ptw2Rl8xJOxB/Sxgw8V7RcJo6RPwUAvr+yOXSjY2nf
	rzPAWMb3EJqvqfWg/O5aMV5Y68ZkxJo7FW9nELJiVsdG/OwiW8V7+huHEUvLV8qkAwrURymX0bn
	vYbeiCcW/ZexWBDsoROXK3Mq0sS+KvypR+qZbv74qVA==
X-Gm-Gg: AY/fxX4C/Na+RA7KkMLZw05wiVc6xEyN5RONWZGCON/u44wvwTpMFK28RQIXeEr3RI4
	vIbWwj188fo7x6q/dWCybY7xUbBxPPQsmc/0Od7I1DP/q0cAEDtG8hbPyMSKbNeGbPyBN95Y75k
	hUC3chYFmMcXiH4WjVjCeXnO2HhnojjqGu+zsH9NSEE0ZWG+GsxWXwupspa+FCmtz+Yfl6NdfsV
	HmVSfB6AWNQWRhJ9VAjNIRe6b+70RlwLZqa85AGzxA2v2Thz+ivnSwYBeKHHxId940cyi0joVPI
	Ax7mqPM=
X-Google-Smtp-Source: AGHT+IHnONGJjk+cAuGQ/Uc3C9K5oE87B+HOi6y2Nb+5V2EGCNfaEvbJpioISHK4gDmLBHgSsc6t8cW7NhLgahAIJWI=
X-Received: by 2002:a17:90b:3e83:b0:341:315:f4ed with SMTP id
 98e67ed59e1d1-34f5f280f61mr2131814a91.10.1767704183640; Tue, 06 Jan 2026
 04:56:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260101-custom-logo-v2-0-8eec06dfbf85@kernel.org>
 <20260101-custom-logo-v2-6-8eec06dfbf85@kernel.org> <CAMuHMdVy48F5HAfqfJgbY83KDAztb9YWTqm8mT1ntTfj0311oA@mail.gmail.com>
In-Reply-To: <CAMuHMdVy48F5HAfqfJgbY83KDAztb9YWTqm8mT1ntTfj0311oA@mail.gmail.com>
From: Daniel Palmer <daniel@0x0f.com>
Date: Tue, 6 Jan 2026 21:56:11 +0900
X-Gm-Features: AQt7F2oqCzC4ATldD0uEPXW8K0e3G46S_P8BzIk8JoOxtgGMBUB2Uvx42XKGtbU
Message-ID: <CAFr9PX=hc31at7uHrZ3qcqtTd=B+726WZyxMz+7j1bAJ1vokhQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] video/logo: move logo selection logic to Kconfig
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Vincent Mailhol <mailhol@kernel.org>, Helge Deller <deller@gmx.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Jan 2026 at 20:54, Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> E.g. an m68k multi-platform kernel including Mac support will scare
> non-Mac users into thinking their machine was assimilated by the
> Apple Empire...
>

This is actually how I tell if my Amiga or Mac is currently connected
to my monitor... Amiga has the normal tux, Mac has the tux inside of a
monitor.
