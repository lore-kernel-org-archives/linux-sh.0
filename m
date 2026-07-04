Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBDF21770B
	for <linux-sh@vger.kernel.org>; Sat,  4 Jul 2026 15:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783180105; cv=none; b=YXZp605KQqNLtxYFZilhWQTKFOs+Gv6OQ6lmktTGJSUJKwXjBaZ87EoUVw4Q4co7wEas7QiYNnEkF/DELZmpWBAe73UlX4Zjay77Pb1Fme3Y2kwjn9Afgmkn7NPep6NqHWO59+jSO28oXH5AykIVHC32BcDX783W/P7P4VTUZGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783180105; c=relaxed/simple;
	bh=Vo0/uthTCA9t/S1uhiavK6qelh2NJYHHNcX+iaTVo1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpLOAG1fed0vtkAJn2aDdg83cV23HY968g2+oCaWf9yXIb+D/nkiPDacDV2QJBdpkpRwK/GYwlutmjde9ESEZrKoloyC2pGZfd5fgBowA6auPflCGPgWcRl+0Zy2X8B/worX8D+nLt3/81l4cFzEoIfyYNg9h7FFfvQjtRL21ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/++k5es; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/++k5es"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4758b2a9e2aso915652f8f.2
        for <linux-sh@vger.kernel.org>; Sat, 04 Jul 2026 08:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783180102; x=1783784902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VYulFp3SO5/MbqdqSCJYzK/afw2ecrlo9KeAU+Q8Zjg=;
        b=k/++k5eshOcbx+SUqawdsrMdhiduEMBZbcWBd6iYkQ9ptN3lHZ3nn6OfvgpZ3Y3Ibr
         eBTc9Wb48dGIFmyT9ipaqgDMmclvuU9nM5LFJgxnRxENUeKzpXcFlNH21orXTloEmGC0
         3MGiA8HWhhkVD7cyVBP/KJo6Z+BldeFSHdP+Ltccz7rj5mn0QLLrwsJ7uS6SPzyG/G2l
         v7j2utBE1x9yOZYwqZswVPwa0hSUyJTlsGhvpQ1P9qBJbH/dG/7QJ9iyWcMQawC0BL7a
         r3lCxubu03uW5YRFSz3CiUzJ1nJANaMcwjRayNeoJ5/ITD/dMngImHuuGiN1Rvis3R14
         5AfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783180102; x=1783784902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYulFp3SO5/MbqdqSCJYzK/afw2ecrlo9KeAU+Q8Zjg=;
        b=IwBuYZ1X+b6EwEmb5BuxxWGViLjYhVYrFB7vGOAakcCPe4+9HumWhCLK98FgEoUYpS
         BmIwJTkF8GSMr6ADbxpmRrr0G3bLeTi1dmjNHPNmA8js4NozV87kmyW7l/cSr9qggsu2
         XPH5i0U0KPnG8zgZpXcGgjy8wFgVtTYxM3ivNnZs4xi6CxmEfE3+t7FNDwqbO1IgDFfn
         tSS8tx0lO2Y1KUS1frROKSzKXe0ZdHsdAAYk0utb64mP/Y68l4/BZzxWVDkTLjfXXzoI
         dw+4ARw9wHFJmlOghFWoQJtEfXUFC5EqH7VJG1Wt6OJjWVE2Ayl4xwbYeZDyd5Ac4eLu
         SRmA==
X-Forwarded-Encrypted: i=1; AFNElJ833vMi5e3GccPTbYUuR5qce0wiWiUmWA4gWMEN5q6wcezoQE2kI+vDwVGkqA8QYPmv831rus/R5A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/JmZULPYQyi4jBvF2AONmeLTD1NtZpiFo0xz9pNHkbNcQ8asQ
	YrXxMouBE0PNCs1qkGoeoLjkw63B4ry2CGepMgyRkVZ8QEpjnquk1iY=
X-Gm-Gg: AfdE7cmnhJ+lRx7ksKR9fvO9QGn/vCqOR+agMPvGNMcpNzrY+myRQPjpnOfqHTuRQ5O
	DEezkrXy674vnel8sE2CSe7Cxra14mBmH+VfhIQOGkuvZw2tQPp9E4eTz2NqcsCqSP2E5n49pDZ
	N1385yOQ2O2fJ93CCBb1Awt3nN44ZzFKUByqmudbAoe0KQ+KxGEcnpWo8IMD6m2TGE739dFZTRj
	7HxWW0WveBFTjRBYwB2K6OrTlFbjOhVUYWgsddeSJTu0IXYa11bintSBkk2onYVlm2SBGB09uZO
	1mQm8izmK/m7FymL8BhLdEqFRMb1Spe58XzH2roppI+TjCCMW23v3/tKFcksJroLSk423wTzs94
	EG+Sm9aPDb7+lUS4p4sWrA4OrVS61vMIaCxGOg4xB9sHuU6PrW/8eSnr0DWjnnraJbHDmfV/X4V
	pdEG9UpMUNhrAjGvd1aghxWjw3xR9OZwx/7W+/9YM+8lltJMm+h5ZLjBuPsiUCf6yaSA==
X-Received: by 2002:a05:600c:4e8a:b0:493:a960:a0bf with SMTP id 5b1f17b1804b1-493d11f3296mr44682275e9.21.1783180101792;
        Sat, 04 Jul 2026 08:48:21 -0700 (PDT)
Received: from lithos ([2a02:810d:4a94:b300:ccc7:6431:13a2:5d53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63172fesm381717435e9.0.2026.07.04.08.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 08:48:21 -0700 (PDT)
Date: Sat, 4 Jul 2026 17:48:16 +0200
From: Florian Fuchs <fuchsfl@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Adrian McMenamin <adrianmcmenamin@gmail.com>,
	linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>,
	linux-input@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-sh@vger.kernel.org
Subject: Re: [PATCH 18/26] sh: maple: introduce callback_mutex in maple_device
Message-ID: <akkrQJfxSCvUptC4@lithos>
References: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
 <20260703-b4-maple-cleanup-v1-18-41e424964da5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703-b4-maple-cleanup-v1-18-41e424964da5@gmail.com>

Hi Dmitry,

On 03 Jul 22:57, Dmitry Torokhov wrote:
> The Maple bus core invokes client callbacks asynchronously from a
> workqueue (maple_dma_handler). If a device is removed (or closed) while
> a callback is in flight, it can lead to UAF bugs if the driver's private
> data is freed.
> 
> Introduce callback_mutex in struct maple_device to synchronize
> callback registration/modification and callback invocation.
> 
> Assisted-by: Antigravity:gemini-3.5-flash
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/sh/maple/maple.c | 9 +++++++--
>  include/linux/maple.h    | 2 ++
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
> index c0715e3ace6f..7c82b7a8a280 100644
> --- a/drivers/sh/maple/maple.c
> +++ b/drivers/sh/maple/maple.c
> @@ -121,6 +121,7 @@ void maple_getcond_callback(struct maple_device *dev,
>  			void (*callback) (struct mapleq *mq),
>  			unsigned long interval, unsigned long function)
>  {
> +	guard(mutex)(&dev->callback_mutex);
>  	dev->callback = callback;
>  	dev->interval = interval;
>  	dev->function = cpu_to_be32(function);
> @@ -230,11 +231,13 @@ static struct maple_device *maple_alloc_dev(int port, int unit)
>  	mdev->dev.bus = &maple_bus_type;
>  	mdev->dev.parent = &maple_bus;
>  	init_waitqueue_head(&mdev->maple_wait);
> +	mutex_init(&mdev->callback_mutex);
>  	return mdev;
>  }
>  
>  static void maple_free_dev(struct maple_device *mdev)
>  {
> +	mutex_destroy(&mdev->callback_mutex);
>  	kmem_cache_free(maple_queue_cache, mdev->mq->recvbuf);
>  	kfree(mdev->mq);
>  	kfree(mdev);
> @@ -655,8 +658,10 @@ static void maple_dma_handler(struct work_struct *work)
>  				break;
>  
>  			case MAPLE_RESPONSE_DATATRF:
> -				if (mdev->callback)
> -					mdev->callback(mq);
> +				scoped_guard(mutex, &mdev->callback_mutex) {
> +					if (mdev->callback)
> +						mdev->callback(mq);
> +				}
>  				atomic_set(&mdev->busy, 0);
>  				wake_up(&mdev->maple_wait);
>  				break;
> diff --git a/include/linux/maple.h b/include/linux/maple.h
> index 641cf3330409..48ed7558b8ab 100644
> --- a/include/linux/maple.h
> +++ b/include/linux/maple.h
> @@ -3,6 +3,7 @@
>  #define __LINUX_MAPLE_H
>  
>  #include <linux/device.h>
> +#include <linux/mutex.h>
>  #include <mach/maple.h>
>  
>  /* Maple Bus command and response codes */
> @@ -75,6 +76,7 @@ struct maple_device {
>  	char product_licence[64];
>  	atomic_t busy;
>  	wait_queue_head_t maple_wait;
> +	struct mutex callback_mutex;
>  	struct device dev;
>  };
>  
> 
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog
> 

Thank you so much for your efforts. I can confirm sashikos finding in my
test (that I saw later), that this patch hangs the bus if a VMU memcard
is inserted. So that the peripherals don't work anymore after insertion
of the memcard. With a last log like:
Dreamcast_visual_memory 3:01.E: VMU at (3, 1) is busy

Regards
Florian
