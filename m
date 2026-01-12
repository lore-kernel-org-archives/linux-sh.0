Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAA9346FD1;
	Mon, 12 Jan 2026 11:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768219131; cv=none; b=Yi+LeL0JlcWmDfVAdwIUlx4iDMyNDnJX/KHvveKOFFINFH1fqdOpX0jZaVvJzBOjhwHemWU2y6/tOk1YpGLCzEi+ZlXnpx68T4z+1eqUbj4mg79b32+Y+O6pqLJ1F4CtzDDwX9hHCjpUQh0X/7+oWEeqd/l79VJ1ggReVHos3Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768219131; c=relaxed/simple;
	bh=R9L4zeA6mtRu+9ZzXm8n4iexyZvYCJ3f/LvVe56n9W8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YsdxPWRGyRQIWq5+rznY7W6FxJy28hDZJ63forpM8guruVdgGf1fDEL/+QmVqThgoPNBngDB+cfqqMg6q/H/Zu4RkW9fCP6o+1EBpzDy6/7DVprimpED8NGq8BIvXs6y6ZtfX0pPtyiv8SDRcn34Y3y/DAMCv29wXKeeQJGEgp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=18Ky7KCj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vabyckit; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="18Ky7KCj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vabyckit"
Date: Mon, 12 Jan 2026 12:58:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768219128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKE6h/gn7vnW4wnmNCi2FV5u+b8KMMipSlKOJiYjjq8=;
	b=18Ky7KCjl/hz1MF3Pwa+oV1DNRz92AoX6EUwtKcslpos8Q/G0VupAzhufznkd67s/Zg4WB
	OVq3hjTFWnON2RJPDwIb+XBr29wvKwWd0CwxBzW2mmBREEywCfUPBTlUDVCU9arGMXG0On
	76zZoUVuAmqeR8+9Sv80Q7dUaqDQfgEK4quHOQbFP5RhcJvlTXw/6fCwYi+01emT6+lej1
	4myAHv2p3Qh0NCDtc6yQ4Ug5NBNCHOTm67zml51wIvne8DEpoUqZAHLkzKRR5JUXrU/ckS
	0wYHJvUvwVqkRr3ilVmzvCzWSQGtW5UiMz1QWfJzOgz1Ad9tDApYc+278jZdVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768219128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKE6h/gn7vnW4wnmNCi2FV5u+b8KMMipSlKOJiYjjq8=;
	b=vabyckitE3UcCKycdQP6xZLhhPsmgYEdjjMsFGxqjPNFYm/upOGk48sP7e7F3kxFQLLguw
	5ypPoh6iYAQd8tDQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: remove CONFIG_VSYSCALL reference from UAPI
Message-ID: <20260112125659-d522ea0c-80a5-4b09-9ab8-76182f94893e@linutronix.de>
References: <20260112-uapi-sh-at-sysinfo-ehdr-v1-1-b01dfe98a66a@linutronix.de>
 <aacdc1083c37bddfb721b732bdd7019f30b3915c.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aacdc1083c37bddfb721b732bdd7019f30b3915c.camel@physik.fu-berlin.de>

On Mon, Jan 12, 2026 at 12:14:26PM +0100, John Paul Adrian Glaubitz wrote:
> Hi Thomas,
> 
> On Mon, 2026-01-12 at 12:02 +0100, Thomas Weiﬂschuh wrote:
> > The definition of AT_SYSINFO_EHDR was gated between CONFIG_VSYSCALL to
> > avoid a default gate VMA to be created. However that default gate VMA
> > was removed entirely in commit a6c19dfe3994
> > ("arm64,ia64,ppc,s390,sh,tile,um,x86,mm: remove default gate area").
> > 
> > Remove the now unnecessary conditional.
> > 
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> >  arch/sh/include/uapi/asm/auxvec.h | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> > 
> > diff --git a/arch/sh/include/uapi/asm/auxvec.h b/arch/sh/include/uapi/asm/auxvec.h
> > index 8eb47ede7193..63fcc39e2c6a 100644
> > --- a/arch/sh/include/uapi/asm/auxvec.h
> > +++ b/arch/sh/include/uapi/asm/auxvec.h
> > @@ -13,14 +13,10 @@
> >   */
> >  #define AT_FPUCW		18	/* Used FPU control word.  */
> >  
> > -#if defined(CONFIG_VSYSCALL) || !defined(__KERNEL__)
> >  /*
> > - * Only define this in the vsyscall case, the entry point to
> > - * the vsyscall page gets placed here. The kernel will attempt
> > - * to build a gate VMA we don't care about otherwise..
> > + * The entry point to the vsyscall page gets placed here.
> >   */
> >  #define AT_SYSINFO_EHDR		33
> > -#endif
> >  
> >  /*
> >   * More complete cache descriptions than AT_[DIU]CACHEBSIZE.  If the
> 
> Thanks for your patch!
> 
> I don't really know what AT_SYSINFO_EHDR is about. Could you explain the background
> a little so that I have a better understanding of what I am reviewing?

It is the entrypoint to the vDSO. From getauxval(3):

 AT_SYSINFO_EHDR
        The address of a page containing the virtual Dynamic Shared Object (vDSO) that the kernel creates
        in order to provide fast implementations of certain system calls.


That UAPI constant needs to be exposed to userspace even if the specific
kernel does not have a vDSO. This is the current behavior which is preserved.
Userspace will detect the presence or absence of the vDSO based in the
auxiliary vector.


Thomas
