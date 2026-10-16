Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F57F30D3FD
	for <linux-sh@vger.kernel.org>; Fri, 16 Oct 2026 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143998; cv=none; b=Db8tEi3+5YF4THhf5oumyEmo7OZGHLyHTlmeDsQgjmlnmCi7Oz+4/pOTNVGkMyD8AfuTIIfrvMq/b+P5He9b91KSL6Q+X5nOhx8E+zNfwMCi9khGeZlvGCf6JX3agsfA7Dx0aBdryJ0IdOvJ9BWFR0TZXS8nH8Ua80nOgLDETsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143998; c=relaxed/simple;
	bh=dtGwiNVLvRzJgPmc3AMsrUs63tP/ZD6tl6IPZXPINBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mh+qQtTmHH7n5IEgD4daVZN/fS2622wWTOAhBq648k4o5IH154jhK+wnVw0wVALUhcBODXe+Z8VVzWtJqwF//wydgKEErAZAZ5M63CeNVbgZJMsoRv2AXDWNheQ31W8nTDWy449PofvTzpxoBSF7Y2lFV/s0rV2shR2e51H++GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVVtc+qf; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVVtc+qf"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso1395451f8f.1
        for <linux-sh@vger.kernel.org>; Fri, 16 Oct 2026 02:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792143995; x=1792748795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M2cqWmRNyjNWhj0WFk106jjuzLQTTpAhM+Ovdp3/AVQ=;
        b=jVVtc+qfJcEjzOGFoHnKzjikA3Tsv2nC6ZfqRVo+I40yrZ0GIK+3af/Rkbp1qBC0na
         siEzdLWK2bcpFXSWA58utEjhDzxceaGVXHykNMSkiGGMz9ifeIhrbc/h8F3uxr7oJjfR
         n4k6kOIstcTV6geVluj8/CDoYiVt84bkOy00ZKkQ9FJgtlxqpGaupeiZNTWEN1zFWYLi
         RhcKXSgqk5BE7tek3UAXtgJQeJy5K9xxqCY0UCXtFC8u6M3qXlovG3HgAX97r2MOzJqq
         2Hs7HGglWfVUaLIYTFLnvP4u9wUSH+pXcyA1snBcgSBuX8w1gZR8Dx90AY96hPQ2/4s2
         Na+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792143995; x=1792748795;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M2cqWmRNyjNWhj0WFk106jjuzLQTTpAhM+Ovdp3/AVQ=;
        b=oMsPLlmZvDuwEGqIsggTXWYQ5ljW+LX1SfGpiOSZTTrub+8xwmCFVDCAStRd3Y2eBb
         BxkSor0uTaiHuk8rvZrnYJwsfiHvyYGgYfhbZuwWJf4nSzMXxOV/BdBwAGDTjaShRDdL
         8bpb0sODy0uL9Cqrz/g7X3doI1SSJjMIp7aDs/s90ItfDlOJywaG5nkN7Bt233DrE7e7
         0C+38fwjo0jsSPj59tul1rnnwXLNb66tFd0TzDIXY0M1EwMSKrVBC0oXfyg74jADjOyh
         IhkO9jMYNfK7xCmGwDmD/2f1LX3MHtZTrglRTrZx5WvkQNt5/sLs20I1gxsX2hLZF+V9
         uXkg==
X-Forwarded-Encrypted: i=1; AKwUvBz1vbHXEIJ/D+q9XUwTLtf5sNB96ECJVUz/utkib4UZL42O0RkeFICzavmtKBQDauOApKT1rPkv5A==@vger.kernel.org
X-Gm-Message-State: AFq9FYIKVzoUpnzSXXk3VsGw5tQa+HASJousIkEQtT+1nTgorITE+Wzw
	Bokbkb0eZIApCtrBYuy8jM5cG70SOSzgGFi0Wg4Ge1GfOakPM0E+6243
X-Gm-Gg: AYBFou0j1Crv0sShREOt0hDhHmirPJhvsjQwsnWPzSgt4yyUggcZpSw2Lo6nIvCeKO4
	s4TzmxOgS9PYdX4zsqVA1zNw1WHQeF4jvkhaqL3bZjFFWqgw8OQv4QdSR/LlxMtEVK/qXTDKpjm
	LF1g1pssRs299N5mUR5xLOSa+yv1n/17JoBOooKEF5fEzcda0XKUstZ78OHptyqJvS63sSGC8Fl
	+OdzmkSKVpQ5+YH7bkcTt9GzDH52tP1Da4kXkjNcEzuCe/eat4Q1nN52uDyPY3PwQfpMbsp79ro
	9wf9m/llnc80mWONf8xO49PCIPCNr4zsClo9TLtiFp/cI6ZhOxIxHroi3sj2HyH0GsW99DQcpoI
	Ve9C33/9qd7TFD3NJEngWpAnIaiRKXiLi0MwY1pOZoM8uieKC+TrneBPDK8iO7qSgtHGp0PK4ms
	CIvfreCXL0ahfUO8FfnySP6L79k9rRnuaQ0aRta070x/3Hv0qb17huus7bRCH0tCWacT8im3wKb
	DQGyuqzXtUsTSPYsxnIa7h+clNKNdHoScfegiA1fA3d65dnu5WbWgYx/AgLDeZjJiyCc41nr9aa
	5XJ6ZqcGuM7Tl5X4rOKzTdIiOzEZP2BTQ0NZgIn9Bx6mVHXIyIQ1nWHPrUie4JaFOsKjaaXIGKA
	=
X-Received: by 2002:a05:6000:613:b0:48d:f3fd:7311 with SMTP id ffacd0b85a97d-48df3fd7408mr10814698f8f.49.1792143995005;
        Fri, 16 Oct 2026 02:46:35 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a951-9501-1471-d90c-a21f-9dd7.310.pool.telefonica.de. [2a02:3100:a951:9501:1471:d90c:a21f:9dd7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd5038b8sm4012108f8f.48.2026.10.16.02.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:46:34 -0700 (PDT)
Date: Fri, 16 Oct 2026 11:46:32 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Yoshinori Sato <yoshinori.sato@nifty.com>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Peter Xu <peterx@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: mm: fix double mmap_lock release on SIGBUS and
 SIGSEGV faults
Message-ID: <atHwnaEUDihOsGUQ@gmail.com>
References: <20260928001937.12793-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928001937.12793-1-kmehltretter@gmail.com>

On Mon, Sep 28, 2026 at 02:19:37AM +0100, Karl Mehltretter wrote:
> A process that survives the signal keeps an mm with a corrupted
> mmap_lock. With CONFIG_DEBUG_RWSEMS and lockdep, stress-ng --msync
> (which catches SIGBUS) reports within a minute:
> 
>   WARNING: bad unlock balance detected!
>   stress-ng-msync/54 is trying to release lock (&mm->mmap_lock) at:
>   mm_fault_error+0xd0/0x16c
>   ...
>   DEBUG_RWSEMS_WARN_ON(tmp < 0): count = 0xffffff00, ...
> 
> and without them, find_vma() warns that mmap_lock is not held right
> after it was taken. Seen on a custom QEMU model of the SH7785LCR, in
> both 29-bit and 32-bit mode.
> 
> Drop the release from do_sigbus(), whose only caller is
> mm_fault_error(), and use bad_area_nosemaphore() for VM_FAULT_SIGSEGV.
> bad_area() has no users left and goes away.
> 
> Fixes: fb027ada051a ("sh/mm: use helper fault_signal_pending()")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
> 
> Notes:
>     Tested in QEMU on a custom SH7785LCR model, not on hardware.
>     Reproducer: Debian sh4 stress-ng 0.22.01 --msync
> 

A friendly ping on this fix.

I have now also reproduced it with stock QEMU 11.0.2 on the upstream
r2d machine (SH7751R): the unpatched kernel warns after a caught SIGBUS,
while the patched kernel does not.

Also, the stress-ng command in the review notes is incorrect. Use:

  stress-ng --msync 1 --timeout 60s

Thanks,
Karl
