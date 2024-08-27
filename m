Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9819C16BE14
	for <linux-sh@vger.kernel.org>; Tue, 27 Aug 2024 09:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724749335; cv=none; b=MN+OBM6vYwfP/PnPc5W7Huipxl3urApPNsZfMOOqGPA7c+oUE4hmGuLclLSYsUrjkbXnhCrsYBnLhbdGbciw1I7J1QARlCksbjOmTcNtt+cUbcNGuUY6DuRUd03yxQOqC2w50DMzoEK/uV2/AlmXoCvOSKyPfbvk9mfjTCrx/8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724749335; c=relaxed/simple;
	bh=CNgje/G2UMnIInNFSzspq8/Z5XpdG66fBhV4nVsqiOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7mhgHE6Nc+Iemi1Asv2IsmjqFHFHPYOpCx4vz5K74yWGWDI86W+jRmX8CTSQRBkYn+rcNNnP8X9drvfq7UBiLQcmEoMHe1/oHH+jRqoFsBBqAvODzjit4gAewuD/SbnqkCEZRjWoZ/PI6asIbzQQoxBpdytYQl31GlffV4s4P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dgp6agpq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dgp6agpq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724749332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=outpxqXc6KM2Oo4/0nqD4smTGWGwDj3DOJrNewpgErA=;
	b=dgp6agpqlSJc07JJsv+eXN33QWCP0zMDcbSFyO+/dICmjEsR74TYOPbkVfyBdhV22122XS
	bgcpMAc2PyVNaeLN3HYs2NVdmdR45Xbt3uU6B+5dYan6RTd5UeWqJ9cYBj9h0QqzsBHH7J
	0Hk9GcWbTVPSB1b+hsuCyB8A9Mf/f0M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-rv4ABExJM5egEclpNPuyLA-1; Tue,
 27 Aug 2024 05:02:08 -0400
X-MC-Unique: rv4ABExJM5egEclpNPuyLA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B6471955BFE;
	Tue, 27 Aug 2024 09:02:05 +0000 (UTC)
Received: from localhost (unknown [10.72.112.42])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 416C019560AA;
	Tue, 27 Aug 2024 09:02:02 +0000 (UTC)
Date: Tue, 27 Aug 2024 17:01:58 +0800
From: Baoquan He <bhe@redhat.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Dave Vasilevsky <dave@vasilevsky.ca>, linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org, mpe@ellerman.id.au,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Reimar =?iso-8859-1?Q?D=F6ffinger?= <Reimar.Doeffinger@gmx.de>
Subject: Re: [PATCH] crash: Default to CRASH_DUMP=n when support for it is
 unlikely
Message-ID: <Zs2WBgtADYxzVMyt@MiWiFi-R3L-srv>
References: <20240823125156.104775-1-dave@vasilevsky.ca>
 <CAMuHMdVYNhFJ+qBDP3_fi9oeHsgOL0vqPe1YqE18+M8n1onssw@mail.gmail.com>
 <09c29a3c4879d4ce5d8b97fd60d8ba5e38bed979.camel@physik.fu-berlin.de>
 <Zs1wpHxfTcwKr517@MiWiFi-R3L-srv>
 <f355e26eead641f5f281372aadf9dee7de19a4c7.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f355e26eead641f5f281372aadf9dee7de19a4c7.camel@physik.fu-berlin.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 08/27/24 at 08:37am, John Paul Adrian Glaubitz wrote:
> On Tue, 2024-08-27 at 14:22 +0800, Baoquan He wrote:
> > About why it's enabled by default, as Michael has explained in another
> > thread, distros usualy needs to enable it by default because vmcore
> > dumping is a very important feature on servers, even guest instances. 
> > Even though kdump codes are enabled to built in, not providing
> > crashkernel= value won't make vmcore dumping take effect, it won't cost
> > system resources in that case.
> 
> OK, thanks for the explanation. But as we have found out in the mean time,
> the assumption was wrong to enable it by default for all architectures as
> some architectures cannot boot a crash dump kernel with their default bootloader
> but only through kexec.
> 
> Can we have a follow-up patch to disable crash dump kernels where they're
> not needed? I mean, not every platform supported by Linux is obviously a
> x86-based or POWER-based server.

Yes, while isn't Dave's patch a good one to fix it? In Dave's patch, the
default enabling of CRASH_DUMP has been taken off, change to rely on
ARCH_DEFAULT_CRASH_DUMP provided by each arch.

 config CRASH_DUMP
        bool "kernel crash dumps"
-       default y
+       default ARCH_DEFAULT_CRASH_DUMP

