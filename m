Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BBA2E03EA;
	Sun, 19 Apr 2026 16:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776617990; cv=none; b=UhZHstoNzt/DP3xMPqOOO+BaQhmO/vFPV5OpMH8yncHiD/CicIdjNwg/+o5Efv7xyIVWVx+ZPZq3Onytr/mJAriudgN2FbN7L0A00SdfORxmTJ8LMmytG08TiAsxPQAYMBICmTZMYackLCx6sGfS11RRhSXmOKGIZYpAloEmj30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776617990; c=relaxed/simple;
	bh=fLxYIkuTCVk6PGDvkKUF7+UG5iIk9VxwzcYDg3Ja3wk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=aH6bjNeuyCz16AfdNrdqGdGOiWF2CdVml9zhUhd668aktRBPeNNweQHTjYviIHLqfelOzVrrQ6mFbpCoOlhwyDbnsFNTCbFYNiJNqEoFGcOSlj7g2s5e1+mvFbjVcZNXpj350MHk85bUdyHssYZ6BSWNMDNbB/zHB7Z/RwFwfmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu; spf=pass smtp.mailfrom=artur-rojek.eu; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artur-rojek.eu
Received: by mail.gandi.net (Postfix) with ESMTPSA id 668DC3EC14;
	Sun, 19 Apr 2026 16:59:35 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 19 Apr 2026 18:59:35 +0200
From: Artur Rojek <contact@artur-rojek.eu>
To: Florian Fuchs <fuchsfl@gmail.com>
Cc: linux-sh@vger.kernel.org, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Adrian McMenamin
 <adrianmcmenamin@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] cdrom: gdrom: update gendisk capacity on open
In-Reply-To: <20260419162823.2829286-3-fuchsfl@gmail.com>
References: <20260419162823.2829286-1-fuchsfl@gmail.com>
 <20260419162823.2829286-3-fuchsfl@gmail.com>
Message-ID: <c69727e55588166886f7988d140ea35a@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Score: -100
X-GND-Cause: dmFkZTF2SXCoUQN8P74J7FX0lHAwoikeUsRaMzGiqmLa5I+F+SbSaGqbjt+5JXROJL/VXV62+KlAMN0DQ+UiX86NhZ+2qZEcCst8FkSG4YI7/jEQF9h86MffGa5sCbp7N+l0EEDMyjj89289a9TZpr8MSjjhTO/Zj1D9IbIvVjcRmW4MTpCjf0ttR5oc1j0/MoZXKQpUipI5Jra23yqegE7zv1QSYpV8EM+HErE3iWvwXT6UL22YiDawhGhGBZZF9Lvn12A3hOJoxcF9C8Aua84aBFqrxjdJ/+Q0xE7nfzk6PsW3rXPe5sy8rMmLUGjYWnTV4Mvj01BGuJSGRx//o1uQzlieHU/c3YWA8cRsPrS5HN+fG/iDvPexF+iPLf+khG5YaXWsuW/8dSOFomxRJ6A0VFI97DlLoTcLpgv9xUnPH4674Eq2n7xuIIvk//RphnKFeMhbu9o7CFX9fPEc1zsTfmOtyj397dp7keaePy6d7P+advhYr/PiTku8+37RUjY4CYVrsCQicQJR4nPYsCbSCLhRt5/wW82p107Rk8QYDNvjLA89S3jQhBrzPp5WjI4XLr6e/q99vCtGAhvxzBrQq6KfTH2u5+WR8U1lIi/aoK5DPZLcssqB4jbUzrtZctIErlI8ogJ1L4nKg0voA8iJuIUNDF4MTaEXGN9xDpYUy7P4Rg
X-GND-State: clean

On 2026-04-19 18:28, Florian Fuchs wrote:
> Update the gendisk capacity of the media. Without the capacity, the 
> block
> reads fail before reaching the request queue, which prevented ISO9660
> mounts. Refresh the capacity from the TOC leadout in gdrom_bdops_open()
> so it checks the inserted media.
> 
> Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
> ---
> v1->v2: no change for gdrom_update_capacity(), but for
>         gdrom_bdops_open(): handle the failure case when
>         gdrom_update_capacity() fails but previous cdrom_open() 
> succeeded,
>         to cleanup the successful cdrom_open() with cdrom_release()
> 
> v1: 
> https://lore.kernel.org/linux-sh/20260405082330.4104672-3-fuchsfl@gmail.com/
> ---
>  drivers/cdrom/gdrom.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
> index 89938d9b2825..fb95288fad72 100644
> --- a/drivers/cdrom/gdrom.c
> +++ b/drivers/cdrom/gdrom.c
> @@ -474,6 +474,25 @@ static const struct cdrom_device_ops gdrom_ops = {
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
> +	ret = gdrom_readtoc_cmd(gd.toc, 0);
> +	if (ret) {
> +		set_capacity(gd.disk, 0);
> +		return ret;
> +	}
> +	cap = (sector_t)get_entry_lba(gd.toc->leadout) * GD_TO_BLK;
> +	set_capacity(gd.disk, cap);
> +	return 0;
> +}
> +
>  static int gdrom_bdops_open(struct gendisk *disk, blk_mode_t mode)
>  {
>  	int ret;
> @@ -482,6 +501,12 @@ static int gdrom_bdops_open(struct gendisk *disk, 
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

Hey Florian,

thanks for v2!

Acked-by: Artur Rojek <contact@artur-rojek.eu>

PS. I found the reason behind mount failing for the first time after
a disc swap - you need to send a dummy 0x0 SPI command to "sink"
the pending UNIT_ATTENTION error, otherwise it will permeate at
the next command executed, which in our case is gdrom_preparedisk_cmd().

I already sent you a WIP patch via IRC. Once you test it, would you
consider including it in this series and sending v3?

Cheers,
Artur
