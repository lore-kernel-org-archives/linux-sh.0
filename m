Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556872F1FFC
	for <linux-sh@vger.kernel.org>; Sun,  5 Apr 2026 13:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775395492; cv=pass; b=Yog+2vZ2bFE8Evo0Ex718EA10aJonHpZTfAzqOt+wbkzIIfp0arrzi7X84Gjb0xfl2hVSF8VzQhWJRpyLY3+ehBW25fPSXM9RNbvEWxxTGEjwVzqnlWzw+lYDzbUCKSBYLNa+xiwl1POqZIqE4ygrXYqF+M0dbomsX1u2/ymTL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775395492; c=relaxed/simple;
	bh=GQ28NUfUdY0jv+w4vVK47r3Q2Dzx0TPLZxugBsDVtFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ogmcnKz7rRXyCZ1AJSExZjAehfvm17dDOoP15cFBknh7SWi60bYKvRBE+8otr2NFQQDyTc3pILeOFk7zHUEEZzr6LW9pmLoI4ZZhwx4Q4kmfeJx3j4ihch+Nj0TbTV/cT9M74XIcmrF6WMXxIMJp4WeHs1IHXohlfejPMrRCBBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lq5KE5AM; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lq5KE5AM"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-66bb6eb28acso5795573a12.0
        for <linux-sh@vger.kernel.org>; Sun, 05 Apr 2026 06:24:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775395490; cv=none;
        d=google.com; s=arc-20240605;
        b=ap8OLZPPzhXJ35Avr3vzdhYa4sq5/7qYQn5W9nQf0YmiyKDKHUJ7Tmd6YlQEDWsQdo
         4AYVek+gSqEw/1k6GVIrfR0Q1NwSNMPjvff7Oyli4co4RHaKuRkxC9Fd2k8f6Ki6U9Fd
         8aAVOhvt7QG8P6gJ3HhFJG994pXNg2pHe6vd5J6CTSXD/l3/DbGaix7g6fArbdcz3H5B
         aIFmbe9qv8RKtDwBjRaNHa2p2gk7YfGlldA93FeUSJa2lvD6qGP6UZQ+VxDoJ5cbj76s
         5SLhb2TBFkj5ug56npS4Xwwg8tJu+RTFHruzBmsLPaeBbZMMCh3TTcziZGg9qpmispxE
         UPuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IFdEl1snxGd722jLaP5MhSrSuC8HlnBjFSw+fdQTY04=;
        fh=T7yRQISD0yERY0gXvmjYvSbtZGnWtgsippBK2HCeEXc=;
        b=QfqYi+1mnsE0YHX0sH6o53+S8yv9ag0z9vLW3TgR4JKCjqhIEcieNTH72WY1oNwisB
         23dcRolZzhZqmaSW1sqrK3dPgCqGBdShjaGem+yFIAAI8krC2RtcJvISBEJAB7223jhV
         l/fXieFCsbhKSStAqsRjcQj4cEO8oj13ElfvkGoGWC8I5mJ9GK0lhSLItodL25+c5Nfu
         IsimXHfEJh/pmRuKTL5Wp/ZcWidCUIYd5Z74YASmHqx+ubuvwKcsQs3iaW24hCvc8lCJ
         FR1zrLcNF68IqizQEez1wO7ik7yf1oo3qj0m7vNDD4qik/wftQEuZRZ7uPnAJ4ze+JO8
         WLhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775395490; x=1776000290; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IFdEl1snxGd722jLaP5MhSrSuC8HlnBjFSw+fdQTY04=;
        b=Lq5KE5AMUnIl9XmsB9j3ZpyHnGvKWNUbToja84InvIir6MEZvyRalPKFk6x/D9LwDv
         qnhLeVSH+/c2DxyYQgaPgfAo94/p3Zq/CMEFJpyfjJjtHnhWsIJJqcDNz4UOFFcFwkAa
         rGf7PteCKg8JMK8O0mMHA/Pp8eDuAu0mPLmGvwdIZqzRGAT52GkCZB8PEzxLYoeGlmhH
         YduoR991fESlNCgGndZqkj5dV7TjwnbLb/0I4sk+hVWhRpnKaa+lL7yZ0KuOI4ALksQH
         N/MBNpNOoVnQWnMbK+EwdBdzAAOEmeXFFgJ01JXlcx2og4WV7FTsGyzPy0faXEFRwEAu
         QWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775395490; x=1776000290;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFdEl1snxGd722jLaP5MhSrSuC8HlnBjFSw+fdQTY04=;
        b=KDrNaWYS8yLZDIPn5+dji5Ae9/nGDNL/n/QdRchzuE74WUQhtGbsnLjHCzr9LTx3qv
         dcCpLPnTRQnX6iGNnUVYF8TwsWBDm3N6h0tF1QCAu23YfgAxUX8Yfqa+ehS19UL3ENhw
         QCfwFM7hEWVBZTFbSrg72obZFERl8gNVfGAFbG4N2paPrkakdTBwsbdclVPNm7KP8cMU
         0x/zwLRG6Jw5s8TY9zMeJzEylZP3Q7/p1bU4dxk4aSEiHRZ7r1XvUgKijxQSNyYjzIOn
         w0zgyBwVGn6UsG3qdpH5srT2IRbuOh7swRUUNCu//k9jBHfLBcSsb+vVMn6GhnQyTPZB
         5rvg==
X-Gm-Message-State: AOJu0YzbkFokB6ciyIsTt8ibsl7THKoz/OU0adQffDnvxUXtBF9QlCAs
	SM1JgMyi5BxWjhcvYBzXUL5cXnjTmZ0XB6moIp0Y+pewXgKNx672gNUR+eTqYWmj72wQIxZDLMZ
	p4lF7tP/uL4jpvXlQLKFF+mDk4vEjlqg=
X-Gm-Gg: AeBDietUGI6/NpFc3mpK7GVu6D8JjUM9ILaemZkcDsXyfPNndXSDYH2mq814UQHPM4/
	hzfd2ujBuFksp0s3owX5ZY8WqDZI4Da2K/uQzllvZWHVCDf9ndTDht9UEJra5JlGrjOSMiTcdYF
	SqqZOKcKDJsVnD1+ATVD4PAyF6nd7P6QGiBJaJR0PqZWbxDLjFRukMp0sluVdEHuDlKrOoWOVui
	kaqPp3swxW12gCB6b0oTkbKNDdzVn63rS5hLnxaKqf1JQQv1XpOYdRIDdfphHugDUcvD0MB5o4s
	CJHh8aMBuMseHCUT++PZfOLgYXrr4IOfSFh5gtL8p/9pbT9ItNyo7cuD2uymb6uMFI85RmIIq3e
	CNbK9k4kqgQ==
X-Received: by 2002:a05:6402:46d3:b0:66e:abe5:ab22 with SMTP id
 4fb4d7f45d1cf-66eabe5ac9amr985686a12.5.1775395489551; Sun, 05 Apr 2026
 06:24:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260405082330.4104672-1-fuchsfl@gmail.com> <20260405082330.4104672-3-fuchsfl@gmail.com>
In-Reply-To: <20260405082330.4104672-3-fuchsfl@gmail.com>
From: Adrian McMenamin <adrianmcmenamin@gmail.com>
Date: Sun, 5 Apr 2026 14:24:38 +0100
X-Gm-Features: AQROBzB5_8DgoNmUALCH7wvmerr0Yw3kKkRU6Ddd7hkMMX9PSvqaglQj9kExsEM
Message-ID: <CACwZE5Rmy3A0k3tvc32gv0V3T1LL2PaP_+S7N87mwNppLTh=PA@mail.gmail.com>
Subject: Re: [PATCH 2/2] cdrom: gdrom: update gendisk capacity on open
To: Florian Fuchs <fuchsfl@gmail.com>
Cc: linux-sh@vger.kernel.org, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Artur Rojek <contact@artur-rojek.eu>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 5 Apr 2026 at 09:23, Florian Fuchs <fuchsfl@gmail.com> wrote:
>
> Update the gendisk capacity of the media. Without the capacity, the block
> reads fail before reaching the request queue, which prevented ISO9660
> mounts. Refresh the capacity from the TOC leadout in gdrom_bdops_open()
> so it checks the inserted media.
>
...
> +
>  static int gdrom_bdops_open(struct gendisk *disk, blk_mode_t mode)
>  {
>         int ret;
> @@ -492,6 +511,8 @@ static int gdrom_bdops_open(struct gendisk *disk, blk_mode_t mode)
>
>         mutex_lock(&gdrom_mutex);
>         ret = cdrom_open(gd.cd_info, mode);
> +       if (!ret)
> +               ret = gdrom_update_capacity();
>         mutex_unlock(&gdrom_mutex);
>         return ret;
>  }


Will this not reintrocue the potential race condition bug that was
eliminated here -
https://github.com/mcmenaminadrian/linux/commit/2bbea6e117357d17842114c65e9a9cf2d13ae8a3
(not by me, I add)?
