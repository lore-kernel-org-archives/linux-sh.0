Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A1313C3F2;
	Sat, 30 Nov 2024 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732970519; cv=none; b=Grq6RUo7ww0tH2QPmGw5opA6ezb9G3CeXiMSWhBipTlxGJNEqERql4fY/WK/Px7mB1S3GKDrcyFTZYludjWQIBhREYlbXmzwje7XUQHjCplWp0qBjbwJvjYPOCAsXIIj1j64AKag8nrv8qZBSWG4f5dJCAdbnghfVJPFEsk+i5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732970519; c=relaxed/simple;
	bh=AmES6UYZnvyg79CV8OFghNDc2d2kSl1UyHfR5h7R6eU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ubx+ifFaw80m917cdIaKhKQ2VJcvjQYK8Z6JsCV5/NX3UOQOFJKj+NbJqK3S+BihFUkcbMLuQ2S+GouZ9vXJCJR9A2KjqXd3SqHhutztZZHpfMkndwnthQowgSwrZnE4znqZbKFVfrCs60T5ak0yd/7RK2SxtTY6yHFe2GuQKBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=foaSAP5M; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="foaSAP5M"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OaswsWBcu5Qc090/c6OA49kGrpKmWX/g0YV7f4mrWpw=; t=1732970517; x=1733575317; 
	b=foaSAP5M8rEqOVooBjxTwP7ztwcz+OjfnsuNKXnUopBRXax2hTmMPZRkNjC+hMvvvBrKIrNDj5e
	qYeLEStmPNCrJQP6IAX/pIrSi0/KiVpSBSTc9aAYguMfj6PTTU8Vk/6yEjNeSVZEKCpjKMkVUng3a
	BbdLmv/kgsetXGY2ief4hB6+oKt+qhgBEYlgcP4ucwRxm3RT9xNKcRqAC1LTtAPFoQJ1lalNpwsj7
	hvDW7JtUqHARBqpBgo1Jn0Qm78wT5SJaQ9z+vozxLTU5lJ8NMMKTocQMZpdIvt7zalUnobfMEoLYh
	IuYxzcYq+CQxQpDlKnOyw8ngUxuBvz/YbgDg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1tHMnL-0000000437a-1Ndl; Sat, 30 Nov 2024 13:41:55 +0100
Received: from dynamic-078-054-081-111.78.54.pool.telefonica.de ([78.54.81.111] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1tHMnL-00000001SaI-0YMm; Sat, 30 Nov 2024 13:41:55 +0100
Message-ID: <bc772ca68b843e89ec201db46e3dc94d55faebaf.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 13/13] sh/irq: use seq_put_decimal_ull_width() for
 decimal values
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: David Wang <00107082@163.com>, ysato@users.sourceforge.jp,
 dalias@libc.org
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Date: Sat, 30 Nov 2024 13:41:54 +0100
In-Reply-To: <20241108162634.9945-1-00107082@163.com>
References: <20241108162634.9945-1-00107082@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi David,

On Sat, 2024-11-09 at 00:26 +0800, David Wang wrote:
> Performance improvement for reading /proc/interrupts on arch sh
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

Sorry for the very late reply!

I don't quite understand why seq_put_decimal_ull_width() should be faster t=
han seq_printf().

Can you elaborate on this a bit more?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
