Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32715363C73;
	Mon, 28 Sep 2026 05:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790575053; cv=none; b=kLzLWIsiqLje+KN+nJ3I+tyob294zkQI7Jokxlk4HyrCnJvg9TBJCj3bt95OpjrJVf3X456wWDAXlbvJvFKSrYwKC4UjWOdFBgQ3ciu0BI3X8izBpcR5K6Skn32En0wQFdBQAOjuER7Qj36FnnzbFdrGgqN9Q9F0TApoRNxojiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790575053; c=relaxed/simple;
	bh=U2GROJJTUnj7Hm7DAM8RbMohqr9lonHcwiRKkk22vE0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JiM+dJ3Yk1OpfvXXEtaVBXYSpRcD62yRCo2/OXnGDIaCcqhvuRFAl6E+7fiGehj7HawKWIKfQFn43Ih13zVqzfoDra8xNJxxg+aDy4lkOxEDzrp2pWfYENajtw05YKiNXW3IH77IxINvGmApBnWmB1BaX4iZZIx12mPDFfXLwXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=oZaOeUQl; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="oZaOeUQl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=serHbvY0qU3fAdcG56bcrNqBZELdIJ9RhLiJ7Pbgx+o=; t=1790575051;
	x=1791179851; b=oZaOeUQlULMQF/grkSffCGw9X8Vfg/yoQ7F0111VeiyYjx6x1BdJ+SkpN7Yry
	vohFe+TCIQQGdEe8NdEhHNI/XJ/iY0ovpdsFk+Nbg+xAxHB0MsBXjxpYog7a6/I0SC+5TFnT/rvOq
	6IC0eck02HTvw26N1zB68P3Ray1ecdvR8T8gtNaCRdro032xp3LJsX3F9Slwln4GItAMF5YHPhbfu
	AIyfh4VQHX/zbH6d7P7FvAq5BTEzZ8hzcWU3if+gVwSuSeZ8Qtf14FsYIHQhI3fF+KW1caYxwxAU9
	KVjdZvRehzP2KDtoLd6na+BfEqfwopCa+pLmDoFK05flElqTYg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xB4Mi-00000001crB-2kob; Mon, 28 Sep 2026 07:57:28 +0200
Received: from dynamic-077-191-243-001.77.191.pool.telefonica.de ([77.191.243.1] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xB4Mi-0000000004u-1puw; Mon, 28 Sep 2026 07:57:28 +0200
Message-ID: <92e110eef6dac0c6ddceb6ddda1658aeeaf1f0ec.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] irqchip/jcore-aic: Fix lost IPIs on SMP
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Karl Mehltretter <kmehltretter@gmail.com>, Thomas Gleixner
 <tglx@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Radu Rendec <radu@rendec.net>, Artur
 Rojek	 <contact@artur-rojek.eu>, Rich Felker <dalias@libc.org>, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 28 Sep 2026 07:57:27 +0200
In-Reply-To: <20260928035408.25871-1-kmehltretter@gmail.com>
References: <20260928035408.25871-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Karl,

On Mon, 2026-09-28 at 05:54 +0200, Karl Mehltretter wrote:
> Since commit bdf4e2ac295fe ("genirq: Allow per-cpu interrupt sharing for
> non-overlapping affinities"), handle_percpu_devid_irq() only runs an
> action whose affinity mask contains the current CPU. Only actions set up
> through the percpu_devid request functions have such a mask.
>=20
> handle_jcore_irq() passes every per-CPU interrupt to
> handle_percpu_devid_irq(). The J2 IPI is not a percpu_devid interrupt.
> j2_prepare_cpus() requests it with request_irq() and IRQF_PERCPU, so its
> action has no affinity mask and cpumask_test_cpu() reads through a NULL
> pointer. J2 has no MMU to catch this. The read returns whatever is at
> address 0, the action is not found, and IPIs are dropped as spurious
> ("Spurious percpu IRQ20 on CPU1", printed once).
>=20
> Pass only percpu_devid interrupts (the PIT) to handle_percpu_devid_irq()
> and the other per-CPU interrupts to handle_percpu_irq() again, as before
> commit d7e3fd658248f ("irqchip/jcore-aic, clocksource/drivers/jcore: Fix
> jcore-pit interrupt request").
>=20
> Found with a two-CPU J2 model simulated from the J-Core RTL. Without
> this change the boot stalls with both CPUs idle shortly after
> "smp: Brought up 1 node, 2 CPUs". With it, the boot reaches userspace.
>=20
> Fixes: bdf4e2ac295fe ("genirq: Allow per-cpu interrupt sharing for non-ov=
erlapping affinities")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>=20
> Notes:
>     Tested on a two-CPU J2 model simulated from the J-Core RTL with
>     Verilator (J2 CPUs, caches, bus mux and AIC1 from jcore-cpu/jcore-soc=
),
>     kernel v7.3-rc4 j2_defconfig with SMP=3Dy:
>    =20
>     - unpatched: "Spurious percpu IRQ20 on CPU1", pending IPI messages ar=
e
>       never cleared (the message word of CPU1 grows to 0x6), boot stalls
>       with both CPUs idle after SMP bring-up
>     - patched: IPIs are handled, boot reaches userspace on both CPUs
>    =20
>     Not tested on J-Core hardware. Testing on real hardware is welcome.
>=20
>  drivers/irqchip/irq-jcore-aic.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/irqchip/irq-jcore-aic.c b/drivers/irqchip/irq-jcore-=
aic.c
> index 94c05cf974be8..b4fee02997eee 100644
> --- a/drivers/irqchip/irq-jcore-aic.c
> +++ b/drivers/irqchip/irq-jcore-aic.c
> @@ -37,8 +37,10 @@ static struct irq_chip jcore_aic;
> =20
>  static void handle_jcore_irq(struct irq_desc *desc)
>  {
> -	if (irqd_is_per_cpu(irq_desc_get_irq_data(desc)))
> +	if (irq_is_percpu_devid(irq_desc_get_irq(desc)))
>  		handle_percpu_devid_irq(desc);
> +	else if (irqd_is_per_cpu(irq_desc_get_irq_data(desc)))
> +		handle_percpu_irq(desc);
>  	else
>  		handle_simple_irq(desc);
>  }

Can you tell me what toolchain you used to build the kernel for J2?

Last time I tried to use the one provided by Rob Landley, the build
failed due to an internal compiler error so I couldn't actually build
a kernel to test it on my J2 Turtleboard.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
