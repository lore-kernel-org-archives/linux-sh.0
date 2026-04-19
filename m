Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF792DAFD7;
	Sun, 19 Apr 2026 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776617409; cv=none; b=pWJ7n8mAOIaKHAO0NMiaK35ZL8Sl/giHMYYw6vypfqF5VWigpwUIUMycmv2DcxnODwrC3pmqtXvETjt75HPOA1RRVeKkxE2ZyQ6BQUA3rW+UOTh3oj3Fwdc1LhMwBjMiGfZzjuzOM4Vb8wrfLcNC1+0EhFYefET0nfrMumz4SPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776617409; c=relaxed/simple;
	bh=IjftfJZDIbaBY64oojVxcRkvZNBR0WngPDC8JXt4m5k=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=UEALXOzo1bOBF3lGUkeqmN2TuqZ8I8McblURQGQqwWDTRsEB4x9bzlxHtuPm7Bo6TRUR7FkOD2xBYKR7Av5XUC5ntSJ41qTDqcQLsr1Nvq0VQZbpojZf2G8FW7P03m8M3ehBYYgud4BgWoI7c8uRYwj97L/XODw80z2q2UiYhng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu; spf=pass smtp.mailfrom=artur-rojek.eu; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artur-rojek.eu
Received: by mail.gandi.net (Postfix) with ESMTPSA id C43E13ED36;
	Sun, 19 Apr 2026 16:50:03 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 19 Apr 2026 18:50:03 +0200
From: Artur Rojek <contact@artur-rojek.eu>
To: Florian Fuchs <fuchsfl@gmail.com>
Cc: linux-sh@vger.kernel.org, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Adrian McMenamin
 <adrianmcmenamin@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] cdrom: gdrom: replace port I/O with MMIO accessors
In-Reply-To: <20260419162823.2829286-2-fuchsfl@gmail.com>
References: <20260419162823.2829286-1-fuchsfl@gmail.com>
 <20260419162823.2829286-2-fuchsfl@gmail.com>
Message-ID: <b4aba43a43084ea2a5696c7eeed04b9f@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Cause: dmFkZTF2KnxUzHQFoXNlDYbcqkoI6/6ke3wPi5j6XxvwUlvvg5tA5LFoXXqBKJ5ZbR4VfUVO5crthAIl5sNriAHe6Zdj12Jj+gkrQm+zutvMZGLj9CCRU4R4L6KGMjAgTRrOISH9X13OGSHTTAJIPcgVb15N8HDIjjyRtlp94/wqkI3oeog3JZ3NZlSaoJHQojbhex9nKEPi4VQHkQrLPRllawt4bg+gfzbq2chmgaVM4JRU8WCJxmgVaGD1eLOFsB1LkFuWbuqAicWZGUgYk0lUDFVZs2rmbNnpSdAumicWpGPn3s8gvsyiiWWvHj+OCGMW8RgBC0du4I5nWsgkB3Y1UO2AW35p4JHTumblodshTOf5KneqBMyavV5bWfvv24z/Tuv0EG0l/mhBOJJzzPyYUDv0QR/WkHXiJ4W6s2dj+8gljLkQ4ajSUlm9O8z8dIEg2tJDKVxmzjX1/qy5KgQG9HNMXlmOaT9bP4/95fWi1DcT3LG2ov0sZJJ2bkg5pzWTJplCdoOPLUn15qydVJTZmSGXAix3wQDabpUtHenTlpMw9LIXHmUrN6tf+QG5cNtjf2kw/FmSEvdLF8d8SqDb9sUAiLlyAogo6PWJz0pMndtJgNz3fk5/s2akDst8+br8uPvtuAVaEpDA0gg9es36a6V/hrlQGRoDwyWpWTdr2/1q8g
X-GND-State: clean
X-GND-Score: -100

On 2026-04-19 18:28, Florian Fuchs wrote:
> GDROM_DATA_REG is a memory-mapped data register, but the driver uses
> outsw() and insw() only for this register. Replace this with MMIO
> accessors readsw() / writesw().
> 
> Before, it oopsed accessing the data register, as the io_port_base
> P2SEG gets added to the argument in outsw() / insw(), which leads to an
> unusable drive:
> 
>         BUG: unable to handle kernel paging request at 405f7080
>         PC: [<8c28d5b4>] gdrom_spicommand+0x6c/0xb0
> 
> Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>

Acked-by: Artur Rojek <contact@artur-rojek.eu>

> ---
> v1->v2: Don't use helper functions with io.*_rep(), but writesw() and
>         readsw() local in the respective functions
> 
> v1: 
> https://lore.kernel.org/linux-sh/20260405082330.4104672-2-fuchsfl@gmail.com/
> ---
>  drivers/cdrom/gdrom.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
> index 4ba4dd06cbf4..89938d9b2825 100644
> --- a/drivers/cdrom/gdrom.c
> +++ b/drivers/cdrom/gdrom.c
> @@ -198,7 +198,7 @@ static void gdrom_spicommand(void *spi_string, int 
> buflen)
>  		gdrom_getsense(NULL);
>  		return;
>  	}
> -	outsw(GDROM_DATA_REG, cmd, 6);
> +	writesw((void __iomem *)GDROM_DATA_REG, cmd, 6);
>  }
> 
> 
> @@ -282,7 +282,7 @@ static int gdrom_readtoc_cmd(struct gdromtoc *toc, 
> int session)
>  		err = -EINVAL;
>  		goto cleanup_readtoc;
>  	}
> -	insw(GDROM_DATA_REG, toc, tocsize/2);
> +	readsw((void __iomem *)GDROM_DATA_REG, toc, tocsize / 2);
>  	if (gd.status & 0x01)
>  		err = -EINVAL;
> 
> @@ -433,7 +433,7 @@ static int gdrom_getsense(short *bufstring)
>  		GDROM_DEFAULT_TIMEOUT);
>  	if (gd.pending)
>  		goto cleanup_sense;
> -	insw(GDROM_DATA_REG, &sense, sense_command->buflen/2);
> +	readsw((void __iomem *)GDROM_DATA_REG, &sense, sense_command->buflen 
> / 2);
>  	if (sense[1] & 40) {
>  		pr_info("Drive not ready - command aborted\n");
>  		goto cleanup_sense;
> @@ -612,7 +612,7 @@ static blk_status_t gdrom_readdisk_dma(struct 
> request *req)
>  		cpu_relax();
>  	gd.pending = 1;
>  	gd.transfer = 1;
> -	outsw(GDROM_DATA_REG, &read_command->cmd, 6);
> +	writesw((void __iomem *)GDROM_DATA_REG, read_command->cmd, 6);
>  	timeout = jiffies + HZ / 2;
>  	/* Wait for any pending DMA to finish */
>  	while (__raw_readb(GDROM_DMA_STATUS_REG) &&
