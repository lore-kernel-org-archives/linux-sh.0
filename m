Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDDA1DF261;
	Fri, 24 Apr 2026 19:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777059952; cv=none; b=abkjdUyM9FHr36BSYTDHVpnK0/ss8Qanw8pFyh4ItiSX40+2rNALJToDsXL8S4II38SPQORuFc1udLHzs3Hm5okSEI8jpn6um/GVx3jiZ1V401tK7DtuJmoFUiO85DCpOa1c9jX+wvYYWdY+aKJzgAu6zhvhnBKlDlf+z4dzMOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777059952; c=relaxed/simple;
	bh=OzZRCHfU7XUp1cT9rAAmxP4KirMpHIuA97bcwWW/t/Y=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=kI2datmFu/Nuf/OHjI0scAPAiMh+WhCG7n5X9waxoKmiLwLkc8BLCIPRStkS/7Z07fyA1bWag5XLA+MzWdBaI4irZJB9bf03YkD1pMUNVhpMOGtuyPK39Ycabx1CGrUftDBDPPerQ/L7qJT3+inlajDNhZmWJ+ZNxfGb6esDQ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu; spf=pass smtp.mailfrom=artur-rojek.eu; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artur-rojek.eu
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id E3906580332;
	Fri, 24 Apr 2026 18:57:57 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1332A3ED27;
	Fri, 24 Apr 2026 18:57:49 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 24 Apr 2026 20:57:49 +0200
From: Artur Rojek <contact@artur-rojek.eu>
To: Florian Fuchs <fuchsfl@gmail.com>
Cc: linux-sh@vger.kernel.org, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Adrian McMenamin
 <adrianmcmenamin@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] cdrom: gdrom: update gendisk capacity on open
In-Reply-To: <20260423194132.693271-3-fuchsfl@gmail.com>
References: <20260423194132.693271-1-fuchsfl@gmail.com>
 <20260423194132.693271-3-fuchsfl@gmail.com>
Message-ID: <50ddbb7442b01eefdbdb7bd1f01327f1@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: contact@artur-rojek.eu
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGTNHf/OU5iiaJ3Z8lbtBcSWiGaSwn2L4M5H269TaTujulHbn91BvBmJx0bUJ4BIJSa/JWZfDu97jHh41AJ8+ZpnrFOuVae0n+pVHzQE73/TfZ93y2DFSdiuR/STiK8KZH/gAS0BZNHm+C5XhnIEwS+5m0IK+Ai6DBA6z5y5vDeDQruG1dskfdHxaaCHFo5XviNQUmO5gn4wf05d+KhKWix6YfvkahM0IzMwKPvvRzD92KRUJ0HlzLmzGqWjy20LTFvKwuRsgXEPyoiGLymAcRJqtXIsTYL0zaG22Xd/OFdWG7mlkXveA2gUl/eKB1kJSaUwUPoh1RYLXpLko9Qo0ItIYpjTGLJE9nP5d6OZGUIgtAXq/VqmV7FGebPm0iGwNbRBKu7Y8VrNW4IdHE3PLA7ibHmvkKekOXwhRBOmBcfi6whSmabBIjtidojrrUxMQyspdfQe97QoCVSBJMOQfRM409UQlLVYac/Lr/KxcHovrAg7XpLk7g4k0btfyY/4CPY0femMT4tnRELmXhGWqef/G/iwMzJzOrflRaTjEoGwTEyKi+rIdpaHHwAYybHN4WoTy9uUCQ+ycczCTfnRHVZRvsf5W6o0hAYPV82avf2+0kcd9yltkboAvJJ+T99Mrv0vi0L2tW+WiJf2DoL+VNKC+BX5mQDkLH0YJCpyQkO7A

On 2026-04-23 21:41, Florian Fuchs wrote:
> Update the gendisk capacity of the media. Without the capacity, the 
> block
> reads fail before reaching the request queue, which prevented ISO9660
> mounts. Refresh the capacity from the TOC leadout in gdrom_bdops_open()
> so it checks the inserted media.
> 
> Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>

Hey Florian,
thanks for v3. Verified on real hardware.

> ---
> v2->v3: Also add quirk to handle proprietary GDROMs, using the same
>         mechanic like in gdrom_get_last_session() try session 1 first
> 	for GDROM, then session 0 for CDROMs. Dropped Acked-By due to
> 	code change.
> v1->v2: no change for gdrom_update_capacity(), but for
>         gdrom_bdops_open(): handle the failure case when
>         gdrom_update_capacity() fails but previous cdrom_open() 
> succeeded,
>         to cleanup the successful cdrom_open() with cdrom_release()
> 
> v2: 
> https://lore.kernel.org/linux-sh/20260419162823.2829286-3-fuchsfl@gmail.com/
> v1: 
> https://lore.kernel.org/linux-sh/20260405082330.4104672-3-fuchsfl@gmail.com/
> 
>  drivers/cdrom/gdrom.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
> index 094d55b2d004..1e73617b39ac 100644
> --- a/drivers/cdrom/gdrom.c
> +++ b/drivers/cdrom/gdrom.c
> @@ -474,6 +474,27 @@ static const struct cdrom_device_ops gdrom_ops = {
>  				  CDC_RESET | CDC_DRIVE_STATUS | CDC_CD_R,
>  };
> 
> +static int gdrom_update_capacity(void)
> +{
> +	sector_t cap;
> +	int ret;
> +
> +	if (gdrom_drivestatus(gd.cd_info, CDSL_CURRENT) != CDS_DISC_OK) {
> +		set_capacity(gd.disk, 0);
> +		return -ENOMEDIUM;
> +	}
> +	ret = gdrom_readtoc_cmd(gd.toc, 1);
> +	if (ret)
> +		ret = gdrom_readtoc_cmd(gd.toc, 0);
> +	if (ret) {
> +		set_capacity(gd.disk, 0);
> +		return ret;
> +	}

Since you already clobber the return value of
gdrom_readtoc_cmd(gd.toc, 1), then how about make it even simpler:

>        if (gdrom_readtoc_cmd(gd.toc, 1) && gdrom_readtoc_cmd(gd.toc, 
> 0)) {
>                set_capacity(gd.disk, 0);
>                return -EINVAL;
>        }

With or without the above change:

Acked-by: Artur Rojek <contact@artur-rojek.eu>

Cheers,
Artur

> +	cap = (sector_t)get_entry_lba(gd.toc->leadout) * GD_TO_BLK;
> +	set_capacity(gd.disk, cap);
> +	return 0;
> +}
> +
>  static int gdrom_bdops_open(struct gendisk *disk, blk_mode_t mode)
>  {
>  	int ret;
> @@ -482,6 +503,12 @@ static int gdrom_bdops_open(struct gendisk *disk, 
> blk_mode_t mode)
> 
>  	mutex_lock(&gdrom_mutex);
>  	ret = cdrom_open(gd.cd_info, mode);
> +	if (ret)
> +		goto out;
> +	ret = gdrom_update_capacity();
> +	if (ret)
> +		cdrom_release(gd.cd_info);
> +out:
>  	mutex_unlock(&gdrom_mutex);
>  	return ret;
>  }
