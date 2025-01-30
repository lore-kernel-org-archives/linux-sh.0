Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A12145B27;
	Thu, 30 Jan 2025 08:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738225712; cv=none; b=LKSy+JU8y0HjAT5PLg1vMXv9It8wRc2A9c6V0Z0Fs8/kC4I5TKJFAPmgl35pzEIKDv5gqtd8Ig0MrRiuohifhAM5Zwst5GZorrrStwq+KJPJ2/A++xr6rHW3rPKTE6l3eJnf/p4864gi7j0qIGYiYBQeAqE3av2gzXEE/o+U8XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738225712; c=relaxed/simple;
	bh=bbBgEkFsletXi8yE0h2piyiQJMcoIugxE8tLFE+KzbI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C+YD6LkyAVQHp2GKEHp1+k9VIP7gBpsllV2zBalq1y5XD9Sz4s6e1u6RcUOl6PCMrHK5QKPRjhIETh1V/2H4IpB3O3OvUksdqwB171z0ifU5jzOSWloQa4gttVJjBqOUV6NerP5OVWRHrm6mRnud5GEXpgkXA9qdXuA0yBJfXd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=VA1ZCumS; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="VA1ZCumS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WtOOCJkEduRa01QsR9Cft5tnAPFPRfNF932iIKtL0G4=; t=1738225709; x=1738830509; 
	b=VA1ZCumSHSMacdq8BsD2EACMh7y+hIYl20OK21tyZl2i/VshwqrCrvVxzxuri/9I5bYTygKI9j0
	ZVgZSow3leNdezvMnQhUBU3KUGa7DUm34abkvzzv1JsXBtMwkYd7rxW9cVC8OATpl0MSak4EwhGN7
	nNLF27S4FOoPqAg/KFRpAAr5VjyWNL/CK5jf4LBH6pZCuGXscdj1yMsi924pZDkDvB/7H3X33N9sk
	ZxSpdQV9tZ9obMNyF1L5S/ILG9/IxGy9EnQqmq4ZQENTscsHkFUqIBF0Pf4etrGXuyS2xfnC/r1QI
	jL7UYDh7GRw9TxVYpkjUUbkW0klygqz6hESg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1tdPuU-00000000ARd-2sqZ; Thu, 30 Jan 2025 09:28:26 +0100
Received: from p5dc55198.dip0.t-ipconnect.de ([93.197.81.152] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1tdPuU-00000001j8H-1sco; Thu, 30 Jan 2025 09:28:26 +0100
Message-ID: <8754dbeecb9ee16f84a82548f5e4121ec422ae3a.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2] sh/irq: use seq_put_decimal_ull_width() for decimal
 values
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: David Wang <00107082@163.com>
Cc: dalias@libc.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Date: Thu, 30 Jan 2025 09:28:25 +0100
In-Reply-To: <20241130134909.171183-1-00107082@163.com>
References: 
	<a9fe22747f20cae9fcc9b9d20109e7afbf8e6b93.camel@physik.fu-berlin.de>
	 <20241130134909.171183-1-00107082@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi David,

On Sat, 2024-11-30 at 21:49 +0800, David Wang wrote:
> On a system with n CPUs and m interrupts, there will be n*m decimal
> values yielded via seq_printf(.."%10u "..) which has significant costs
> parsing format string and is less efficient than
> seq_put_decimal_ull_width(). Stress reading /proc/interrupts
> indicates ~30% performance improvement with this patch.
>=20
> Signed-off-by: David Wang <00107082@163.com>
> ---
>  arch/sh/kernel/irq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/sh/kernel/irq.c b/arch/sh/kernel/irq.c
> index 4e6835de54cf..9022d8af9d68 100644
> --- a/arch/sh/kernel/irq.c
> +++ b/arch/sh/kernel/irq.c
> @@ -43,9 +43,9 @@ int arch_show_interrupts(struct seq_file *p, int prec)
>  {
>  	int j;
> =20
> -	seq_printf(p, "%*s: ", prec, "NMI");
> +	seq_printf(p, "%*s:", prec, "NMI");
>  	for_each_online_cpu(j)
> -		seq_printf(p, "%10u ", per_cpu(irq_stat.__nmi_count, j));
> +		seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat.__nmi_count, j), 10=
);
>  	seq_printf(p, "  Non-maskable interrupts\n");
> =20
>  	seq_printf(p, "%*s: %10u\n", prec, "ERR", atomic_read(&irq_err_count));

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
