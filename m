Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A6247255E;
	Wed,  7 Oct 2026 09:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791364426; cv=none; b=N3S2rzTLhlPANvQSPRIP58HVrFatYTHTxro2r5GoTHUR+el/RC8uwX/XV2XIXkwUXaXleAFpPkVVmUMhpqXDDkpI1gTmIVCDF8pITuI54qFxGaYggY41rbSzUy640GCqmM5mt3701prZ5TuVYtlhgNWEVwF18AcTK0XITfQjoZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791364426; c=relaxed/simple;
	bh=7sAbJvsLuyHmk5yDXP6O77myg7KkYaLkTd7mstcqVe0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W8z0idgx7jS+8n+ZOKgOtlgQOAtiwu1eV+psWrmb51gbT1xLTLlyV+BvWLAakjh4vRypnLe3v3NiJEKv5rOgGcwlq5ix5DYMygc6Z6+qXZJkqkxM7ZFv5rvQTWJS33Y47cgdzM8nTOYMzOLPRGFNaOv1uhKt/XFyC0uiC2sYR9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=KKxeomNg; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="KKxeomNg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=mqisTjwH67781oBTs466IKVYCcBQB6inr38VPw9lLfI=; t=1791364380;
	x=1791969180; b=KKxeomNgyfsd3R9f0UNQrsFS/AYeQG9nDkswzS9k/PTjqxgVgqaiF4lRvcRP7
	TthHFtPWWkXIVHgpvBt74ZkTx8krD1ewpRqvPF63wZTItKVd0x4EN7Tp2HfIiCP3pz9w7wJlOQkXc
	YZZRw0JECi1Vx+KM6JmE2Fu5FKvZxEwwfhYJa1BzbXhZgme5wOhCtjSandpDWIrk39hOnHkiS/xin
	jBf7OyikE5NF3OslYItlvcnkaeLcWfLQQoHIgG8CyUz117ZAaGSqPZs4c8MxbQdIaJjGUS7QSKgF8
	5Gdr7xZyP9vgZaZt8xzPZTU5wHbKzCbrk4JOg403kzByA5LgJw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xENhf-00000000BtO-1tlx; Wed, 07 Oct 2026 11:12:47 +0200
Received: from p5b13a90a.dip0.t-ipconnect.de ([91.19.169.10] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xENhf-00000000jHB-0wOo; Wed, 07 Oct 2026 11:12:47 +0200
Message-ID: <2b0a2d9afa8e2dbd1d6e8ea8f88a4627816ae2d6.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2] usb: r8a66597-hcd: fix buffer overflow on odd-length
 FIFO reads
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Karl Mehltretter <kmehltretter@gmail.com>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-usb@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 07 Oct 2026 11:12:46 +0200
In-Reply-To: <20261005212823.55737-1-kmehltretter@gmail.com>
References: <20261005212823.55737-1-kmehltretter@gmail.com>
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

On Mon, 2026-10-05 at 23:28 +0200, Karl Mehltretter wrote:
> An external R8A66597 (pdata->on_chip is not set) is read through a 16-bit
> FIFO port. r8a66597_read_fifo() rounds the byte count up to whole words
> and passes that word count to ioread16_rep(), which stores two bytes for
> every word. For an odd byte count the last word puts one byte more into
> the buffer than packet_read() asked for. When the data ends at the end of
> the URB's transfer buffer, that byte is written behind the buffer.
>=20
> Enumerating a device is enough to trigger it. The USB core reads the
> configuration descriptor header into a 9-byte kmalloc() buffer and the
> driver stores 10 bytes. An SH7785LCR board booted with slub_debug=3DFZPU
> reports:
>=20
>   [kmalloc Redzone overwritten] 0x820c4229-0x820c4229 @offset=3D553. Firs=
t byte 0x9 instead of 0xcc
>   BUG kmalloc-32 (Not tainted): Object corrupt
>   Allocated in usb_get_configuration+0x12c/0x11d8 age=3D51 cpu=3D0 pid=3D=
10
>   Object   820c4220: 09 02 20 00 01 01 00 80 fa 09 cc cc cc cc cc cc
>=20
> Odd-sized HID report descriptors are overrun in the same way. Without
> slab debugging the byte ends up in the unused tail of a kmalloc() object.
> A transfer buffer that is embedded in a larger object has the byte after
> it overwritten.
>=20
> Section 2.8.5 of the R8A66597 datasheet tells software to discard the
> excess byte of the last 16-bit FIFO read when DTLN is odd. Read only the
> whole words into the buffer. Read the last word into a temporary and
> store only its first byte. Use ioread16_rep() for that word as well, so
> that the byte is taken in the same byte order as the words before it.
>=20
> Fixes: 5d3043586db4 ("USB: r8a66597-hcd: host controller driver for R8A66=
597")
> Cc: stable@vger.kernel.org
> Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Closes: https://lore.kernel.org/linux-sh/3bd32eaf159db61ed1d423e1d52a869b=
3689c682.camel@physik.fu-berlin.de/
> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Assisted-by: LLM

I was wondering: Would it maybe be better if you disclosed what LLM you use=
d?
I have seen that many others have done so and I'm not sure if it's actually
prepared to have the model disclosed.

Adrian

> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>=20
> v2:
> - Simplify the handling of the last byte as suggested by Geert: no count
>   variable, len & 1, and a plain byte store instead of a 1-byte memcpy().
> - Reword the commit message and add the SLUB report from Adrian's board.
> - Add Adrian's Tested-by. It was given for v1. The FIFO accesses are the
>   same in v2, only the copy of the last byte changed.
>=20
> v1: https://lore.kernel.org/r/20261002213225.27834-1-kmehltretter@gmail.c=
om/
>=20
> Adrian tested v1 on an SH7785LCR board. I tested v2 on a custom QEMU
> model of the board with 32-bit and 29-bit kernels and slub_debug=3DFZPU.
> Both report the overflow without the patch and not with it.
>=20
>  drivers/usb/host/r8a66597.h | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/host/r8a66597.h b/drivers/usb/host/r8a66597.h
> --- a/drivers/usb/host/r8a66597.h
> +++ b/drivers/usb/host/r8a66597.h
> @@ -179,8 +179,15 @@ static inline void r8a66597_read_fifo(struct r8a6659=
7 *r8a66597,
>  			       len & 0x03);
>  		}
>  	} else {
> -		len =3D (len + 1) / 2;
> -		ioread16_rep(fifoaddr, buf, len);
> +		ioread16_rep(fifoaddr, buf, len / 2);
> +
> +		if (len & 1) {
> +			u16 tmp;
> +
> +			/* Keep the byte order of the string read above. */
> +			ioread16_rep(fifoaddr, &tmp, 1);
> +			((u8 *)buf)[len - 1] =3D *(u8 *)&tmp;
> +		}
>  	}
>  }
> =20

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
