Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D239128377
	for <linux-sh@vger.kernel.org>; Mon,  9 Sep 2024 02:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725849343; cv=none; b=hFzUq9kof0gEdV30lIQMy232dNVeF4TL0wOjbqadgYvddIgY+6PQDTvnoP2paTZtlvgsGaki1SY613tIAjrcp1L8zgsoT+wfpTCK/FkrE1hAyk1Ay25Hu80XwFCQVa6jLWrwiJnpjKaxoNN10sNz7/oviRi2B9lzZ1KigjTSNiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725849343; c=relaxed/simple;
	bh=ZjtEHt8bSvmRde39BXklX+Lti/JhyV/GdXZeYzGRgUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxRO13woOnqd2wvnWZwpWm+TTlZ84y55oPw0n920a2LfffcNdfZCtltVm0/VG8A8wGNo3ntSZvfkKtbr0DKx4aEhle+5UUIdfEKEgAsizZ61JaOZ4XInvDTzXG5Y8yLn+AjTjGRfbRiwGs3znQBSSa4/Cl7nHUcSzffGvIJojdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WZPRA0GE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZPRA0GE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725849340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjtEHt8bSvmRde39BXklX+Lti/JhyV/GdXZeYzGRgUo=;
	b=WZPRA0GEhAmhH89Vad4rDhnXXXh2sMMtA2ryzw2Jjmn9WaqF99IFXqpLn3abFr6WtOcGhZ
	8lj7fQ5a+B4WyoyHjPzSVUwdJmhJddQn9ZY53P7QdiwWLJa3KqVUZdqwVd1vYq9iH6MSrs
	XIpeVmIE3/kjuL8MU5EnVU9G5sykDdA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-stwFWWh1NuS5XhhFDaflqA-1; Sun,
 08 Sep 2024 22:35:37 -0400
X-MC-Unique: stwFWWh1NuS5XhhFDaflqA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 24C7119560A5;
	Mon,  9 Sep 2024 02:35:35 +0000 (UTC)
Received: from localhost (unknown [10.72.112.58])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0DB3C1956086;
	Mon,  9 Sep 2024 02:35:32 +0000 (UTC)
Date: Mon, 9 Sep 2024 10:35:27 +0800
From: Baoquan He <bhe@redhat.com>
To: Dave Vasilevsky <dave@vasilevsky.ca>
Cc: glaubitz@physik.fu-berlin.de, linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org, mpe@ellerman.id.au,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Reimar =?iso-8859-1?Q?D=F6ffinger?= <Reimar.Doeffinger@gmx.de>
Subject: Re: [PATCH] crash: Default to CRASH_DUMP=n when support for it is
 unlikely
Message-ID: <Zt5e72DEl0K8cQe9@MiWiFi-R3L-srv>
References: <20240823125156.104775-1-dave@vasilevsky.ca>
 <c04fe24a-26e6-44b5-a2dd-00eac589e36b@vasilevsky.ca>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c04fe24a-26e6-44b5-a2dd-00eac589e36b@vasilevsky.ca>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 09/08/24 at 03:57pm, Dave Vasilevsky wrote:
> I received a notification from Patchwork that my patch is now in the state "Handled Elsewhere".[0] Does that mean someone merged it somewhere? Or that I should be using a different mailing list? Or something else?

I guess it's powerpc dev's patchwork which automatically grabs this
patch to do some testing? Becuase ppc list is added in the CC. I don't
think this patch has been picked by people because this is an old v1 and
there's concern about it.

