Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF6271742
	for <linux-sh@vger.kernel.org>; Fri, 30 Aug 2024 03:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724987769; cv=none; b=Q5SmIAxY6wpiynJazP0OhJnNLXYEln4OhRGhJrDIlIGflJmI+7HpUMBJ09de2ncIqA28iiaCjHzzTndKRB4vxMA80hr7dR4kBWQdY4Z5y/A3EuZWwYVwaCK6OcX37ApSiT1XXWhAW4mI3F9Ioef4mPQ2oXaGgZyWTCtqYgxuBiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724987769; c=relaxed/simple;
	bh=NaHwV1FmZk3Fpu1NKCZliEKzQe8Q0O8LMhXv7yyOkjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzTOxMF2sfga7zpizghsVLE909WmUo5Mi3NCGMB18FERPli+pTzzc3De81tmDdXO9otikY5LzZnb/uoYKQVZTWZMvEWThCHSfKSU8++hKot3ChLxYXeTNZbmBq25NPtetMGgq1IPLOYJLu7zCQGRkt2xYKvRGxMf9w08LvBG7w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bkm+kCp1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bkm+kCp1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724987765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Y16gZ5ll9x+ZZRQurc1f4Q2jGpW469PmPcdJZo7k8I=;
	b=Bkm+kCp1nF/aynI+HfPIbF2tL5QkvM4rpWGtm+MfdPiSarZKfvR/9HBufxLPrCf5tjGqhm
	rcH2xzHbh0gJhA4/PmCMh7V9vHkWtgqmHoGLgqF+z2ARk3MNvdE+MPZxq3yTVn3+Akn/bL
	iXywMoh8yuWcd1udvxo9zBHRY7mNn+c=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-E_cgXM_TMY2lLDSNHnmYZA-1; Thu,
 29 Aug 2024 23:16:01 -0400
X-MC-Unique: E_cgXM_TMY2lLDSNHnmYZA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E21241955D55;
	Fri, 30 Aug 2024 03:15:57 +0000 (UTC)
Received: from localhost (unknown [10.72.112.42])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3149E1955F1B;
	Fri, 30 Aug 2024 03:15:55 +0000 (UTC)
Date: Fri, 30 Aug 2024 11:15:51 +0800
From: Baoquan He <bhe@redhat.com>
To: Dave Vasilevsky <dave@vasilevsky.ca>
Cc: glaubitz@physik.fu-berlin.de, linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org, mpe@ellerman.id.au,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Reimar =?iso-8859-1?Q?D=F6ffinger?= <Reimar.Doeffinger@gmx.de>
Subject: Re: [PATCH] crash: Default to CRASH_DUMP=n when support for it is
 unlikely
Message-ID: <ZtE5Z/gDR1WixG9S@MiWiFi-R3L-srv>
References: <20240823125156.104775-1-dave@vasilevsky.ca>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823125156.104775-1-dave@vasilevsky.ca>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hi Dave,

On 08/23/24 at 08:51am, Dave Vasilevsky wrote:
......snip..
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index 1aa3c4a0c5b2..b04cfa23378c 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -549,6 +549,9 @@ config ARCH_SUPPORTS_KEXEC
>  config ARCH_SUPPORTS_CRASH_DUMP
>  	def_bool BROKEN_ON_SMP
>  
> +config ARCH_DEFAULT_CRASH_DUMP
> +	def_bool n

If we don't add ARCH_DEFAULT_CRASH_DUMP at all in sh arch, the
CRASH_DUMP will be off by default according to the below new definition
of CRASH_DUMP?

Thanks
Baoquan

> +
>  config ARCH_SUPPORTS_KEXEC_JUMP
>  	def_bool y
>  
......  
> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> index 6c34e63c88ff..4d111f871951 100644
> --- a/kernel/Kconfig.kexec
> +++ b/kernel/Kconfig.kexec
> @@ -97,7 +97,7 @@ config KEXEC_JUMP
>  
>  config CRASH_DUMP
>  	bool "kernel crash dumps"
> -	default y
> +	default ARCH_DEFAULT_CRASH_DUMP
>  	depends on ARCH_SUPPORTS_CRASH_DUMP
>  	depends on KEXEC_CORE
>  	select VMCORE_INFO
> -- 
> 2.34.1
> 

