Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA3A14D420
	for <linux-sh@vger.kernel.org>; Fri, 30 Aug 2024 06:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724999461; cv=none; b=uv3mmybnQfUQZBMmh/bK3bwcyQQfELB0Iff5A6bNXdZn/sGT8VXda4wwGNxzmmnBtScD3ktps3TdOJKrBxMNVIcSM7FLNCenlHpI7ttCNHIRtA0n2i7t5HjUfRpluqGa1pt7DYSsfKLs7m/yxNSML+44axwAJo8urt6w2bU88mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724999461; c=relaxed/simple;
	bh=rOfnV1h6ePy1h6vtm1Oq8aYzjVxASebDiR+MQrFTMaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJpUg1/oPLIdNXj1BRI9KLUVK3ejX+u9xDg40PZhDYi7iUThg5knn3V+kI5FY7gc/cd0jhZ4CBCeJhDwqUS1ZuH3+njDaFP4N/KQSurgVf4i5yV5GEA6kf10WEbMPdcnq0J+OtqZdDCpFP7BAdjLfsDgIJ5Io3cNUvKZX6/K/Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bpN9Li1t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bpN9Li1t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724999458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5rxQOV0U9jos/ewQUlBldN7ZSJbrE3k5eVCijlLXnUk=;
	b=bpN9Li1t7xMvRTpMqP0BBSRWa7VgakCU1hfgKDVxKX0pieF6T9H3Nu94NJYvvFRPI0CZq4
	O8tHQXfFIwpmLUDcVAz5MCWnMB7rJUHFLtTNq0wAQUbRVtNFeRv51tr6bz0ZS73eM3MPGE
	ERr2YW4NiWvjRLCg2arRkJJRJgPPr3U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-u30SmAoyMdqFmu6gfgZuwQ-1; Fri,
 30 Aug 2024 02:30:53 -0400
X-MC-Unique: u30SmAoyMdqFmu6gfgZuwQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3AC2E19560B1;
	Fri, 30 Aug 2024 06:30:51 +0000 (UTC)
Received: from localhost (unknown [10.72.112.42])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3990E1955F35;
	Fri, 30 Aug 2024 06:30:48 +0000 (UTC)
Date: Fri, 30 Aug 2024 14:30:45 +0800
From: Baoquan He <bhe@redhat.com>
To: Dave Vasilevsky <dave@vasilevsky.ca>
Cc: glaubitz@physik.fu-berlin.de, linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org, mpe@ellerman.id.au,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Reimar =?iso-8859-1?Q?D=F6ffinger?= <Reimar.Doeffinger@gmx.de>
Subject: Re: [PATCH] crash: Default to CRASH_DUMP=n when support for it is
 unlikely
Message-ID: <ZtFnFaHfh09wOw6o@MiWiFi-R3L-srv>
References: <20240823125156.104775-1-dave@vasilevsky.ca>
 <ZtE5Z/gDR1WixG9S@MiWiFi-R3L-srv>
 <1568b378-5592-4d23-a572-4e09f3996331@vasilevsky.ca>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568b378-5592-4d23-a572-4e09f3996331@vasilevsky.ca>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 08/29/24 at 11:37pm, Dave Vasilevsky wrote:
> On 2024-08-29 23:15, Baoquan He wrote:
> >> +config ARCH_DEFAULT_CRASH_DUMP
> >> +	def_bool n
> > 
> > If we don't add ARCH_DEFAULT_CRASH_DUMP at all in sh arch, the
> > CRASH_DUMP will be off by default according to the below new definition
> > of CRASH_DUMP?
> 
> Yes, that's true. But if we don't add it at all in sh arch, it looks confusing
> in the search feature of menuconfig:
> 
> > Symbol: ARCH_DEFAULT_CRASH_DUMP [=ARCH_DEFAULT_CRASH_DUMP]
> > Type  : unknown
> 
> So I thought it was better to explicitly set it to 'n'. What do you think?

If so, better adding it. Thanks.

