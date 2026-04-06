Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D3730C608
	for <linux-sh@vger.kernel.org>; Mon,  6 Apr 2026 09:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775466341; cv=none; b=lN6+gSGjQt8vLf1XiVLWjbIuUI9xL0KNkDF3CNBgaZg4XnLC72JvJa1UbGqBsbigoaHjg2cbxOvi8rLvBmnrbuC1qd2laT2FzbcSwT5S3mKY9PIhoO+oZaMWzE84LQdQJpVxi9OrFq197Y/6FmlN5Z/L6JyTWUNX/2RGFQyBIkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775466341; c=relaxed/simple;
	bh=w7jenhJ0dKykCMlkImSdWUnPpkxAQcuWZqLp2XZtfxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXrJDhIMAtjzHFpulZqQJKvz9JeEFgrVR7wnkJdvqQHs3ZmKbjtDqDrCsCsRavp30x3rl/bJUMNbUcm5TAi8RoSBi7h7YIoLckgVAGC5DKKvrxhB8J+2GJIuPevwUz0FizLTHwa0VphXNQoZJiEcU0JRoSxrj+BOHbK8DEyClgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pMtG6tau; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMtG6tau"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43b95e5b3afso2069074f8f.3
        for <linux-sh@vger.kernel.org>; Mon, 06 Apr 2026 02:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775466338; x=1776071138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lTshqiZu7FR413ezZFMwutWDBwrOJEWMON4NJbyE60A=;
        b=pMtG6taudFSS8Hzs07GDx4bVopQH9xpv2BDnWJ6b073T8FzII5rY7StI2O5gk1P0lB
         r+FL1WHFMuLFL0/8DZzAPKZi4MUkfnFM+/MrhDyaKW2ai8acyw6Q6n8x0tF8AtABeRVt
         1ABri77ooczFn/VtWFWXn5kbse19hVFJLkfklT9Wt6gjrYNXR3FoT6B6GcVGMoHtu6Yh
         vpPXBLcgQ06xMKhAYjznMou57I0e9nyM9osnkTsYUTb3bakoPh1kSdhsh+b3NGz6r3YW
         RXwcXuTLZG2zYyiSZBRXHVb07I1g5bFiMXcSonUWhMI53dEqCw9wo0ffU//PaH9zPT94
         B4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775466338; x=1776071138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lTshqiZu7FR413ezZFMwutWDBwrOJEWMON4NJbyE60A=;
        b=VvgLMA3TERBcKPX9hCO+h0cQKYsTy3jl3pSNonfpiLf5oEl5MvWxxoEm/8m8Z0Ba/4
         dmz3iIZWgt5lUp2uMGCTqL/ODNOm6XI0y0r3ct1FFAu0cMXFCTKCu4COf1Cz+WaDGgO0
         TScRmeUtmPLCxMflXrY5O2sM/xQxhTaQuVQieLcsAY1ZNFWPyyvq4vurNtpR6SpAZ0YA
         Kv5CMqICzb9VZWOHf/Zaw+WlQk+BPNBvbRmRWM0foY64aU2Ex72Z04ECpdbc0iswZOMk
         dKe3pn+So//Oum5X3tkLHpXJBeZ/bf1GN/IvQ0DlvTDBzdkckv22tmwgQHjdfNYEhWZB
         UeZw==
X-Gm-Message-State: AOJu0Yy+VwvF/kzYNk+yRUsClHCdkZiAYeMIxXaL9qo9pyU4fq3SIrMQ
	q+LuKR7BkaKl/rMDBJTkR0lKMMxa6JxvbizHm36COJVjbzhJLh/oaIk=
X-Gm-Gg: AeBDieuTBobtTueNixhWpOrN+yV5LCzI0TiKa+y/EmeX3OKlsXiD9PLKJliAlDXTpYg
	+Tj5ymiYmZfEP8MGYGHUcyDAm6upDZ4Uh01uaNKio2JFJkG28DHWbAmEsmTQW8UKIs3PihtXWY3
	odvzex4GqrZJL0GZCqUcdg5V/YO3in4XQx5022Y/H3HFBE6Xj6nP1kb9JAVCr5OggmHXh5he8vz
	HTqdgGsfkn1EbIdw5uvheyF5EPEK8k1QJQbvKLET5YTf6JTqcD5afwa6STkjgIhWab0J+9XyUYQ
	t5qJHRdUArtz/FyF18gWW4c8Kkoal0W+9tF8py/pk089aRbUx78EUw3xqY9G0Yy0UExfpOSHXLq
	kvcisolhmvHE7SKefX/Gm9TsBn0ZV5Y45Uh5OM8PEO23MPi2KBu+V7SAlpEfdD+gzbXDSO34a8m
	n0I3Ss3PMKqd6gsMoZlt44P9bvuBmx45ClOcsgZkfyZAs1KCSFPskJf+Y7Z+9KC1KBkg5qOZlyD
	7NW
X-Received: by 2002:a05:6000:24c4:b0:43c:fe0e:5bc5 with SMTP id ffacd0b85a97d-43d2926a073mr16585727f8f.4.1775466338029;
        Mon, 06 Apr 2026 02:05:38 -0700 (PDT)
Received: from lithos ([2a02:810d:4a94:b300:aeeb:3bab:9e78:12a6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d2738sm39982904f8f.24.2026.04.06.02.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 02:05:37 -0700 (PDT)
Date: Mon, 6 Apr 2026 11:05:31 +0200
From: Florian Fuchs <fuchsfl@gmail.com>
To: Adrian McMenamin <adrianmcmenamin@gmail.com>
Cc: linux-sh@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Artur Rojek <contact@artur-rojek.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cdrom: gdrom: replace port I/O with MMIO accessors
Message-ID: <adN3W5qr-XhusNmq@lithos>
References: <20260405082330.4104672-1-fuchsfl@gmail.com>
 <20260405082330.4104672-2-fuchsfl@gmail.com>
 <CACwZE5QeuDnEOGar6-0tfkhO2s8UuvdcjMMf7ubFhVUeh=7JcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACwZE5QeuDnEOGar6-0tfkhO2s8UuvdcjMMf7ubFhVUeh=7JcA@mail.gmail.com>

On 05 Apr 14:16, Adrian McMenamin wrote:
> On Sun, 5 Apr 2026 at 09:23, Florian Fuchs <fuchsfl@gmail.com> wrote:
> >
> > GDROM_DATA_REG is a memory-mapped data register, but the driver uses
> > outsw() and insw() only for this register. Replace this with local
> > helpers using MMIO accessors ioread16_rep() / iowrite16_rep().
> >
> > Before, it oopsed accessing the data register, as the io_port_base
> > P2SEG gets added to the argument in outsw() / insw(), which leads to an
> > unusable drive:
> >
> >         BUG: unable to handle kernel paging request at 405f7080
> >         PC: [<8c28d5b4>] gdrom_spicommand+0x6c/0xb0
> >
> > Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
> > ---
> > The original Oops can be reproduced just by mounting a disc, like:
> > mount -t iso9660 -o ro /dev/gdrom /mnt
> > ---
> >  drivers/cdrom/gdrom.c | 18 ++++++++++++++----
> >  1 file changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
> > index 4ba4dd06cbf4..dccf41fa5d0a 100644
> > --- a/drivers/cdrom/gdrom.c
> > +++ b/drivers/cdrom/gdrom.c
> > @@ -171,6 +171,16 @@ static void gdrom_identifydevice(void *buf)
> >                 data[c] = __raw_readw(GDROM_DATA_REG);
> >  }
> >
> > +static void gdrom_fifo_readw(void *buf, unsigned int words)
> > +{
> > +       ioread16_rep((void __iomem *)GDROM_DATA_REG, buf, words);
> > +}
> > +
> > +static void gdrom_fifo_writew(const void *buf, unsigned int words)
> > +{
> > +       iowrite16_rep((void __iomem *)GDROM_DATA_REG, buf, words);
> > +}
> > +
> >  static void gdrom_spicommand(void *spi_string, int buflen)
> >  {
> >         short *cmd = spi_string;
> > @@ -198,7 +208,7 @@ static void gdrom_spicommand(void *spi_string, int buflen)
> >                 gdrom_getsense(NULL);
> >                 return;
> >         }
> > -       outsw(GDROM_DATA_REG, cmd, 6);
> > +       gdrom_fifo_writew(cmd, 6);
> >  }
> >
> 
> 
> This is one of those "how did this ever work to begin with" bugs when
> examined today - bur rather than introduce new local functions can we
> not just use either readsw(p, d, l)/writesw(p, d, l) or
> __raw_writew(p,d,l) and __raw_read(p,d,l) directly?
> 
> Adrian

Yeah, totally, I put them inline. I first had a loop with the __raw.*
functions, that made more sense to extract.

Will send it, Thanks!
Florian
