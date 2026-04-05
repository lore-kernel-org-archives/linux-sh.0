Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1AE168BD
	for <linux-sh@vger.kernel.org>; Sun,  5 Apr 2026 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775394992; cv=pass; b=NZHQgV3028E38RpPt2vSUt24A9ex4wUn9IKwgli/uOSvpFFkorhO+wYw/7LfaIX0GrC3ObjWhUxByPQiwnlNkS9YFKXRQe1skOJxfxzXF356qZ6lozGPZLgMXSvjagntPnF1EoCrgEFpjaBB0Z/vgGJHcTw5cKSnOEchzwWS36Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775394992; c=relaxed/simple;
	bh=Ly4ReE5ZY6QMSHcoPlSOVHi/ePTv7bG2hci37RTMBJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fz3vzlMcXLJejJxt7oXBTDYqSLPdThpmTU4EbG8Mvaiz9KiZBeMZ2Su6Hob/eulnpOiuOUgz+JSGcD+FHet+MyFuTn2xmS8qxfwX5o3XgpzAOMhpIIvunEnAced/a0dMP91ghTLV1KKueWR/8TwcuKSrHs1XHyx1nPrvWp/S3zA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXlir58r; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXlir58r"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-66ec3b7b1deso589194a12.2
        for <linux-sh@vger.kernel.org>; Sun, 05 Apr 2026 06:16:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775394988; cv=none;
        d=google.com; s=arc-20240605;
        b=ECllZtUmWSEVszzNRbFsohVsL0RI4/vtR+Nx+m5IwSOqSlilG/7c0FFjpVkGJjjPgW
         jyf/9UONKv4/kK5rgUF2ip21PMDYyiW2RfYUqDhCKxa9wKAUMGmsK536jdL68QXrE2Ph
         Wb1ITLFABywoMCIz5Y4CUS2cxHZTxkTrNxdqZ4BTJOt+grIrabQxk22xpE7fYnS5jSn0
         DBlJ2aqUuT2QwDj9ZwPHR89gYQaThRu59TSSpWQkXSuDXejxFSIszMSdgbFwA6zwYkMn
         NHXFeavSxUAZgCIpVW/dB2jS1XAVIYRBQKkCsm1I8YgMUSF8S+5ppj2sKoMDQvuFRPq6
         ROMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xvpYyCRLWgdo1VGzh2pTS+EMDwube+KJdI+DsTN88c8=;
        fh=T7yRQISD0yERY0gXvmjYvSbtZGnWtgsippBK2HCeEXc=;
        b=KsS4ulWBWLgDepgy36PESqejapl7+wc0z/wJAyExdT3JZqbGU2kSRgQ/pKHKcfl3Fd
         Av4b7zhhM4J+n/JP1hm5fmIHehBXg/Zrbw3ENa/5mcll9NyiIsCtMLlgCGV1TAVHdk9L
         kMxax5qkmPdcPAbrKza9ea+tIb3HVtjTXM8n7hR5NETmw8LDpA/5NRb2MA15jf9aCkwp
         XgJjhBoNX0HSglX8J2Vw8ADRn7YknrejHrTAy8L9ty2tI8V7FK7V3ft7MLqCNgqkYtVr
         KLpOS6ATd9AbW3V+sDY9r4vML8WniB9rPt471Q5fCyAaMjiNIfraOYx6qtNKSHSH0V1u
         TgVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775394988; x=1775999788; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xvpYyCRLWgdo1VGzh2pTS+EMDwube+KJdI+DsTN88c8=;
        b=MXlir58rZaiF1fL0ou4L8NR4ozdupNw5J3tO/jbBLCSUa/zAMRlzS6Ojd8FnFy8w6/
         zAkzvc6l2G83Zxbd/iZP2+mKWZJvgXFAg/8+hoTaDQJJOBQrR5cjkroU2gM7+3mmzRpU
         E0LZ37LArDl46yuDyISMZEUV5TJMTxmkGztTyCIAHaGVIz88dRaLhwgsf84Q0KI/NFQ5
         uHfDIt4htKnATLT47ZSyeG7rxCP9CyluSNsju1watqUaN95UBiQMBdIcArjUd68BYwj1
         TOLKEFekH4nZX5CgzDz++MDzHuQA5zM8Re0Ul7Htpm43Tj4wvI4nE4j+ihpJhB5eZjMa
         0uVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775394988; x=1775999788;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvpYyCRLWgdo1VGzh2pTS+EMDwube+KJdI+DsTN88c8=;
        b=lAY90wEA2ljsUp5k1uxgkAw2kA+04MVRfz0oRh73olLfujfueD0kNJjRCfIi14lpeS
         0gs14zDqktfV1/7SWoADuYKMzLlo0i1j9jwqD2YkXKoMLzoSk6LH1Ch8/flpFjtzgDh1
         mokkLT7VwEsZNHQlrxHHxGIAmWWaoFCbswan7UxhzJYspEtGpkDJQ+YfTgNtM+i+01sz
         PV2pwmP6V2JSAcE4LeC0eK1mAwPBeQU0zcyK+JR93FITqzrokCfAYb/6WkNC/ww919LQ
         z+ik//yXGQ53WmcrDWImQVrRPDdpfOtx9vzfZTXy9Qr6EaKsQ1oa0LODjYhMmEyfcjwu
         rLgg==
X-Gm-Message-State: AOJu0Yzl7Ygwko//eBgivNIOFTZyXwgWM6YR4H1F8hOs6t4IjPNSwUov
	mJ6HC3scWZRSIAPcQ8DCtyGytWxwLE9Dvrp71ZsOPLBbL4LYvQnmzL3cmw09id5pRJHHWNVZYgZ
	e9gZ6cLQCNd1n3W6thiRTfj4Vhew69IuRYVrD
X-Gm-Gg: AeBDievIfH2nAwiwWpWdcBhLJ6YRK8G0C+LKCnlkUW7k+WePe0uv60WEzULoO868THN
	nznHUry8vPzCOthjDrcs+yyRk9a3R/38uBufktAvwkrjNqefbMVTbEmQ6hMUCH+6gM2l1xrjzfA
	Xud0fa4cMwy8btas3onGiBjNUWRoLpUB+/X128+1/YVIvo3PE7Mj/UXMauG2M5Y/4sx59emTmPB
	ccePO5CHSSdp/Yx31ckHvy+De8TQt5QnHTSCAmDAx2AlBpIPQC9x1RNjWNK/5muahunPlnA2Ecb
	iceXMvQC0agjn3kHTxXn6viFeeF+c3ZcnA/6PTInXZmRiLdWEBo0iEQ9DtIlvnuaZUUJLEqvuS8
	pbgbNiz5NM1e8rR/+BjFq
X-Received: by 2002:a05:6402:46ce:b0:66e:7071:5ce with SMTP id
 4fb4d7f45d1cf-66e70711494mr1989535a12.26.1775394988022; Sun, 05 Apr 2026
 06:16:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260405082330.4104672-1-fuchsfl@gmail.com> <20260405082330.4104672-2-fuchsfl@gmail.com>
In-Reply-To: <20260405082330.4104672-2-fuchsfl@gmail.com>
From: Adrian McMenamin <adrianmcmenamin@gmail.com>
Date: Sun, 5 Apr 2026 14:16:16 +0100
X-Gm-Features: AQROBzDcgD0a_IZndD0FdHm8XCslACnezKR1fTlZt0C7HNPV41mNpNkZBBgHe8E
Message-ID: <CACwZE5QeuDnEOGar6-0tfkhO2s8UuvdcjMMf7ubFhVUeh=7JcA@mail.gmail.com>
Subject: Re: [PATCH 1/2] cdrom: gdrom: replace port I/O with MMIO accessors
To: Florian Fuchs <fuchsfl@gmail.com>
Cc: linux-sh@vger.kernel.org, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Artur Rojek <contact@artur-rojek.eu>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 5 Apr 2026 at 09:23, Florian Fuchs <fuchsfl@gmail.com> wrote:
>
> GDROM_DATA_REG is a memory-mapped data register, but the driver uses
> outsw() and insw() only for this register. Replace this with local
> helpers using MMIO accessors ioread16_rep() / iowrite16_rep().
>
> Before, it oopsed accessing the data register, as the io_port_base
> P2SEG gets added to the argument in outsw() / insw(), which leads to an
> unusable drive:
>
>         BUG: unable to handle kernel paging request at 405f7080
>         PC: [<8c28d5b4>] gdrom_spicommand+0x6c/0xb0
>
> Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
> ---
> The original Oops can be reproduced just by mounting a disc, like:
> mount -t iso9660 -o ro /dev/gdrom /mnt
> ---
>  drivers/cdrom/gdrom.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
> index 4ba4dd06cbf4..dccf41fa5d0a 100644
> --- a/drivers/cdrom/gdrom.c
> +++ b/drivers/cdrom/gdrom.c
> @@ -171,6 +171,16 @@ static void gdrom_identifydevice(void *buf)
>                 data[c] = __raw_readw(GDROM_DATA_REG);
>  }
>
> +static void gdrom_fifo_readw(void *buf, unsigned int words)
> +{
> +       ioread16_rep((void __iomem *)GDROM_DATA_REG, buf, words);
> +}
> +
> +static void gdrom_fifo_writew(const void *buf, unsigned int words)
> +{
> +       iowrite16_rep((void __iomem *)GDROM_DATA_REG, buf, words);
> +}
> +
>  static void gdrom_spicommand(void *spi_string, int buflen)
>  {
>         short *cmd = spi_string;
> @@ -198,7 +208,7 @@ static void gdrom_spicommand(void *spi_string, int buflen)
>                 gdrom_getsense(NULL);
>                 return;
>         }
> -       outsw(GDROM_DATA_REG, cmd, 6);
> +       gdrom_fifo_writew(cmd, 6);
>  }
>


This is one of those "how did this ever work to begin with" bugs when
examined today - bur rather than introduce new local functions can we
not just use either readsw(p, d, l)/writesw(p, d, l) or
__raw_writew(p,d,l) and __raw_read(p,d,l) directly?

Adrian
