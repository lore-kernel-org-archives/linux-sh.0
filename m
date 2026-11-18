Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.133.4.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794986346;
	b=BFm7YK0X2hsaiYtbbl9uC9rVd5rC6l74TuIBV+lE9WwrN6GRsRIhpACn6321ZrhhgVqn
	 U6KBcRaRGnJSVU22JCN1XGrAShLMzSQqThx9yflhw7BFEYobc+KLsCj6EXMxHgwsjEw01
	 HjsEnxmlcIOvmnz3ADy0gdSXb6qDMakVYRNE2nHe0NuR4J6lILnYjepn5q9PXgZm+ogLi
	 Oii6VDeEI1CzexbGGNpUB7AxQdDz32AuQX6in5fGbvF93X+OvgMJ0QoqZjoYUdjcJOYJX
	 FvL8UStNe72BHbMqoEAWSliL4heTJ2sLqz884wnxsEMAfnklZqFeWeKC44nQnUmPVzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794986346;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-Original-Sender:
	 X-Originating-IP:X-ZEDAT-Hint;
	bh=pv++et0mwHq/V6N2fgl7wO1m0BW27uqfUGY7bt9Z3Fo=;
	b=EHcBFH5dgovvWqxMRyH1KFKgru13AyrvJfq/xXdo5MuAAv1qcwWXTb5nb+2hMI8Q9b0P
	 Guilr8b2Vd/y4y7BXJFyI96kMhtncH1LbCrjq6zqc5tloy+Z+NnbYUM8+BBK+ofCFvWgw
	 KQfrE9YXSMGySwcuPkZSXXIKRRDDr+o6ObjuhKiP9j3ZISlawbOH1uUY+Ru8FLM6x9ww5
	 tZLhmAKf2frvvpoEcVmtiVTkP9ZUjOug3HmIX7Y4u/mmM+mQA8x1Iz0lXqZ46GofvoQ3u
	 Uw7SSOd6mm10xJ8fbWkGVW2WxPNe1DdTYfysUcPXzsers1Fwm8HTtyYicDr6U18n7Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=physik.fu-berlin.de;
	spf=pass smtp.mailfrom=zedat.fu-berlin.de;
	dkim=pass header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=LAeCj9Ka;
	arc=none smtp.remote-ip=130.133.4.66
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1330606A31C;
	Wed, 18 Nov 2026 07:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1330606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=LAeCj9Ka
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=pv++et0mwHq/V6N2fgl7wO1m0BW27uqfUGY7bt9Z3Fo=; t=1794986345;
	x=1795591145; b=LAeCj9KaEIvm1mI2Wk2F944wK+bHIJivTbMQrDfAXKlWq6VaN36NaD23u+T1V
	odDFh8j1vHv4lWoN1KHO0t+WDA220r7mR3eltvCXcECdLxl2H77dnIFpOjWToDJHORKNf7da3xI+M
	0Fet0/tqDQhtrrLraeEyuwBdE0stfTjlnMY/jkAoc9Scu2ULF7cgfCnPZmrRaFhl5Pq116uXPnhg0
	tNx3YwlnrAGITtc6nT2r9H9Dy78nQqp2JZBb+W44NVlYfuxs+lZ83IjMddWnpo4fdh4pPcmL3z5y/
	4nJ8Cn9SK9qrfRv+I/zvYVgpwLYN40tgWa55GDGgMGiKxCRoKA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xTZwU-00000000Ie4-3CYh; Wed, 18 Nov 2026 08:18:54 +0100
Received: from p57bd95b5.dip0.t-ipconnect.de ([87.189.149.181] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xTZwU-00000000GJ1-2A33; Wed, 18 Nov 2026 08:18:54 +0100
Message-ID: <43a18a77ed58835878ecf8c4ec88a0a323dfcd74.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v3 3/9] sh: sq: Add missing kobject release callback to
 ktype_percpu_entry
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Ian Rogers <irogers@google.com>, Rich Felker <dalias@libc.org>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>, linux-sh@vger.kernel.org, 
	driver-core@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Date: Wed, 18 Nov 2026 08:18:53 +0100
In-Reply-To: <CAP-5=fUUatDonEFfc4bFAPKgOokjn8vEOPUNEKV185-g16U-8g@mail.gmail.com>
References: <20261108223913.3624571-1-irogers@google.com>
	 <20261108223913.3624571-4-irogers@google.com>
	 <CAP-5=fUUatDonEFfc4bFAPKgOokjn8vEOPUNEKV185-g16U-8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Ian,

On Tue, 2026-11-17 at 12:28 -0800, Ian Rogers wrote:
> On Sun, Nov 8, 2026 at 2:39=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >=20
> > In sq_dev_add(), sq_kobject[cpu] is dynamically allocated with
> > kzalloc_obj() and initialized with ktype_percpu_entry. When
> > sq_dev_remove() calls kobject_put(kobj), the kobject is never freed
> > because ktype_percpu_entry lacks a .release callback.
> >=20
> > Provide a sq_kobj_release() callback that calls kfree(kobj).
> >=20
> > Fixes: d7c30c682a27 ("sh: Store Queue API rework.")
> > Signed-off-by: Ian Rogers <irogers@google.com>
>=20
> Gentle ping on this patch (moving SuperH maintainers to To: in case
> this got buried in Cc:).
>=20
> Danilo offered to take the full 9-patch kobj_type::release __must_init
> series through the driver-core tree with subsystem ACKs, and this is
> one of the last two patches awaiting an Acked-by. Does this look okay
> to go via driver-core?

Sorry, this got buried somehow. The patch looks fine to me. Let me ack it.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
