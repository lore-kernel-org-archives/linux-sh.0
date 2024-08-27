Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA9D33999
	for <linux-sh@vger.kernel.org>; Tue, 27 Aug 2024 06:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724739765; cv=none; b=CZqwAxaUynApzqMTyQgxePcj7CkdxpIVEf0xxGj4jXRkdzbQYc5dtIxRyqlLM8WEfJiSwG2RVNF2XsCCw0LFJwGWfHvehkV+SCQosAQAIbJZ0Vp3Cha2Hxux+iOH7EwMC8w7Y1GQQqdBkXpv9DIZhgVf4sf9YOELaGfUzRfy5oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724739765; c=relaxed/simple;
	bh=JlI+TELUdd7s6FPujobr2Ezax9MfoTnBaxSFowSiAa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcvaqTmXI0RFfmk3twc3Zc5VOlFzaKcYeBIUqxpZnD6xMLhmcJlkIB26dn2Pj5SSlYUs3Ra4zFpVooHl7qQDgErz7RgJGo3Hp5NMrmqUHADxiT8g4myBewh7OXD51JoZLUNmz/91vvSyvB5RUuW5n5EvDw8JM1u7W8W+6UNcnn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WYVPf+E6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WYVPf+E6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724739762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EnUXRhsOmY1WUumG5iPOdpGy9YuwRoJOmvxNn5A0R3s=;
	b=WYVPf+E6PRFssKzR/UKFpzxOTzWqiQwy7puxSa4NWU/Tkz4Y3nnomxscMnZ/VXnNQquvsq
	J4pjIyVeOLGRizlGBKcbgm964oeJcHnJ6l0i52v+ae0GsKzvNMmvNw6kkEjCMalkXDG8Fl
	I8AfD3nl/UpXhsPod2vewi7p99KoGTg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-t7YesfeCNKOOuuMJdnOrxQ-1; Tue,
 27 Aug 2024 02:22:39 -0400
X-MC-Unique: t7YesfeCNKOOuuMJdnOrxQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C07E19560B1;
	Tue, 27 Aug 2024 06:22:36 +0000 (UTC)
Received: from localhost (unknown [10.72.112.42])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C25D219560A3;
	Tue, 27 Aug 2024 06:22:33 +0000 (UTC)
Date: Tue, 27 Aug 2024 14:22:28 +0800
From: Baoquan He <bhe@redhat.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Dave Vasilevsky <dave@vasilevsky.ca>, linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org, mpe@ellerman.id.au,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Reimar =?iso-8859-1?Q?D=F6ffinger?= <Reimar.Doeffinger@gmx.de>
Subject: Re: [PATCH] crash: Default to CRASH_DUMP=n when support for it is
 unlikely
Message-ID: <Zs1wpHxfTcwKr517@MiWiFi-R3L-srv>
References: <20240823125156.104775-1-dave@vasilevsky.ca>
 <CAMuHMdVYNhFJ+qBDP3_fi9oeHsgOL0vqPe1YqE18+M8n1onssw@mail.gmail.com>
 <09c29a3c4879d4ce5d8b97fd60d8ba5e38bed979.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09c29a3c4879d4ce5d8b97fd60d8ba5e38bed979.camel@physik.fu-berlin.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 08/23/24 at 08:16pm, John Paul Adrian Glaubitz wrote:
> Hi Geert,
> 
> On Fri, 2024-08-23 at 15:13 +0200, Geert Uytterhoeven wrote:
> > IMHO CRASH_DUMP should just default to n, like most kernel options, as
> > it enables non-trivial extra functionality: the kernel source tree has
> > more than 100 locations that check if CONFIG_CRASH_DUMP is enabled.
> 
> I guess we should then revert that part of Baoquan's original patch.
> 
> > What is so special about CRASH_DUMP, that it should be enabled by
> > default?
> 
> Let's ask Baoquan who made the original change to enable CRASH_DUMP by default.

Sorry for late reply.

It's me who enabled it by default when I clean up the messy Kconfig items
related to kexec/kdump. Before the clean up, CONFIG_CRASH_DUMP only
controlled a very small file including sevearl functions and macro
definitions. But kernel codes took CRASH_DUMP as switch of kdump.

About why it's enabled by default, as Michael has explained in another
thread, distros usualy needs to enable it by default because vmcore
dumping is a very important feature on servers, even guest instances. 
Even though kdump codes are enabled to built in, not providing
crashkernel= value won't make vmcore dumping take effect, it won't cost
system resources in that case.

Thanks
Baoquan

