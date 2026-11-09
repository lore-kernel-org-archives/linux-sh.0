Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794208329;
	b=xjpeKxlqjllf3j5qsAk6MWWXVt53yvKYc2ApZakRDLEdQZO3qKarsT4XChLTt5ZogZ4+
	 a0ViPS7rq4ew59pVqC1njt8YlUynPUUhmeIMGgRld2BgZBR6sdP9yXK4dTa2SJ5UD4azn
	 clPu+ocyT6jDsxCAmCieg1Nuht0GwUdmbiXetdXYyR2u4ib5i+4s94H8ooAVjWrcQAvlT
	 866bl/l/XP7Y4PuVTRSwUnAGOE5rp8RhcKSYqmNKwGx+jXm3gOAmYjfh01BTnztg3IEky
	 c05Equq1MX0wVgS056HX5ROqzaSkwWoDPUQxzJaL8Fh08j3j0HGlrFPYXsuy6oYNDFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208329;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=OupCEGaIrNwuKpf7Jfdnd1ZAhIgrnuD9zgt3Qr7q5bI=;
	b=Qz+xTA3nIJjA+52zpjaC7sLbIDVR6pJf85ehOztCRqggeHydnMut85yNEu7eQQukbq92
	 YvjEgujUIXyjdF8M+NZxIoLzhbJV+qZtoGsGLkVZGYsoyNfd/FwXQHYg9TgVs+SO41QGz
	 9LcY9akyy3kyKEsKRcmuU6i3ERA5uyb+xSr8S1XPJvNpx+hBbelvqO22nCHspA1C/eZOx
	 EZOZ3Hf2uhVDKnEwfrGllWu23KxgS42hu5VY1bQdWIF/dOl0EwaslDPexknhXtDpWrSUG
	 TGWId6tnipXXz//HFVd9yDJ6LqNsjQOYAiOtwXGh6Na4con/LtKXJg1gMN2Zi2t4yww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S3VYJ1Ch;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20424606A31C
	for <linux-sh@vger.kernel.org>; Mon,  9 Nov 2026 07:12:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20424606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S3VYJ1Ch
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91ea3f6a506so5272746d6.0
        for <linux-sh@vger.kernel.org>; Sun, 08 Nov 2026 23:12:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794208328; cv=none;
        d=google.com; s=arc-20260327;
        b=Cp6QN+iu9d4Fku5dRGcUkBvrc0BQQleCB0S1eO4SL6Ot6J/I1ZA1UZMCW961TYJGYm
         jyJnt6LKDGz33htli0yLNqVksKjq5z6EyzQm7N4/DNsZb3seZvIk02U9TPziVhDfqXqp
         c3kXZGKJebTnDWw/jPuztlPZDaaux5m2pYfrHqh6+mXFyJAzkJ4nPs41dBUvn15pj9g+
         mPNQglIJ23E/DykYiAMkTGsU9z3eENYRYCcdJozXqwvhdm/idoJlGqrDINhkRk7K9+N/
         7VQvbe54G1DDNKFNmHmjU2Uv2HGIVeKRjouEgymNzTDOK7Vjm+eLuJ0TaZBQ/qOOFIia
         epLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OupCEGaIrNwuKpf7Jfdnd1ZAhIgrnuD9zgt3Qr7q5bI=;
        fh=nI0Els2nYq3KAno0DivxJESryiLlH/ymIieODASnOz4=;
        b=sRW6CuojGmEP+MDl7EfReRJqPgRsUBEJ84B0ue7KgGFRrtjhS7AXpGb76vMt5uBZz2
         jW7IC7E8FC1Y/q3v9Zet31K8OxYGTS461rqU8O1X3xiWFCzSIhFCUNiXeq7llVCPIkYw
         oFxW1D1Znrcuxe6H3fD4GAE6qIa/AHk5MZXzUtpG9dnmILWF2bs0VqxvWp6/LpfS43jI
         XQ6+s797YrKU4md2NP2vpBz/Fme/RiCgRpQQL4MUl2iyON3ITOnhKQFT5ODLghp0I2cc
         6BKPjXO2eStePs4vEJkV5nuHsV2meiXgq8DE2NXB104m+eN6TRg/cIdY0MngEXuhDyer
         XhUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794208328; x=1794813128; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OupCEGaIrNwuKpf7Jfdnd1ZAhIgrnuD9zgt3Qr7q5bI=;
        b=S3VYJ1ChTDVlnZj+ORlw3KQTe4wFrKpaIAerq2bLU+VqDtH0D62D+PF3ST71FgSKI+
         k1KBQoX5cgBknJwIVa4+v74qnq7guJen+5Mi3pSWXAvG/6KxzRROdUD9ZCBVIIC47Aev
         NdntDwYgJwQRuTbSHQOU1HTk4ydzNikWETFE1v6pzuJnbsxJ/xRxx+sThdeF2sllZkDl
         ntVA+YCCpQEIpTyFDPU1J7q9JZCEI6uDFFeOdAZvOc3nPmQ7moYUlxwzyFBDVrb1XK6D
         gpVA68mlf54X1gjcI/xPPjua/XDCwpeogYnFwPZoQYTVk8QR7hyfQZLaSbQohcJZNHXr
         sjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794208328; x=1794813128;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OupCEGaIrNwuKpf7Jfdnd1ZAhIgrnuD9zgt3Qr7q5bI=;
        b=FWx6zQVTNT8xhH9yRMLz//aTwGS0iOpckF2A5wU57JwwqPthCdhk8VZjzawgKeEBnP
         D81gog+g89Cp6XkcHp8F2Ubz87PWMdm8R9QD86AwuE8FT4dWwu/gMkmKvB+O+g8Cp62b
         r2ACh3U+PSsuqm60iR4i898YCgIjAwEQttzuqLWNCQNrFoWqDIe/UZGWAd/WR3YNDkxr
         NvFgT+y+RMv6HjSe70+boTvv4QHRGp07by9Z5Vq9FjuT3C98/EghTKK0DaObDmNkANcM
         G43oRlCVB7KZksS0O8iNzJVckbD0dydmlQow36eP7c7An5IjKumZ66IV1ZDhGh6gOT6n
         yQVw==
X-Gm-Message-State: APuU4Z8G6ZB1B07I0bEC0hZdNbAZDyFR05Sm3l6udoP8o0JFUaf3L0zi
	iB/fq19nstZTL3mR29PI1p4MEgTivM6JMAAGP9xTOiK6yDd+Yq+FwmjbTGyQCAevKbOIYImoYd0
	t0LXet7XQjrhJTCBwERk9uPT/vq9HTQfm8QgOBdk=
X-Gm-Gg: AYBFou35IMt2QMPx6J8zNhwVAEfj0upwzmym3z7QVbAyWE6xQwJ63FXmxekwgSSJIQL
	fqmQp0XRhPPtP+DTIH4nkKt+nRqSfj10NdWOoVcqE5LK/LKgnJBeTcEmV9vV4bnOGgArCfUOcfP
	dgbn04C/riNEMhChQmw7LZCQ8y9onn6pmkP10B0CDVE5EVoT0TJcYlr41VjulW5BVhD0kXSNNyT
	rq5fdsU2nzovgNkIj9RSrMSfXxaDiQwXL8sKeQP7WsnZ3f+S9TYePCJzhfC/7Og/nuuMRDQb+9d
	k55fnYdXxGOxccimkUtRnPg6KuaII7Xi01BSc/P1TmOi4Oo/eGf2NSdVDIEtnROPtz06VKmrfh3
	sJ7vGW13wot/CvpHhVBUi1tumfg8FhybtfRQF
X-Received: by 2002:ad4:5c46:0:b0:91e:9d18:6a61 with SMTP id
 6a1803df08f44-91ed21f31e0mr43992646d6.5.1794208328122; Sun, 08 Nov 2026
 23:12:08 -0800 (PST)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261002041220.133911-1-artem122novak@gmail.com>
 <CAPufuhaE=pg9yzqZYaDcfkxooZeQPzSNsKQw-kX7PHN99yZyQQ@mail.gmail.com> <469a405f0a447cf433e9449016551cb408fd11dc.camel@physik.fu-berlin.de>
In-Reply-To: <469a405f0a447cf433e9449016551cb408fd11dc.camel@physik.fu-berlin.de>
From: Artem Novak <artem122novak@gmail.com>
Date: Mon, 9 Nov 2026 01:11:57 -0600
X-Gm-Features: AclHuK9M0NU4pJUOxjwJxtUPXJmeVW_GjcaKtkSrXnuPLAjKurNTbXo_mGqnfSw
Message-ID: <CAPufuhbXzbgBR=L+5o3eBRXXnHh2FPqThdUnnPsSOuSyjgOsfw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] sh: add initial SH7305 CPU support
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Adrian,

No problem, thanks for the update

Best regards,
Artem

On Mon, Nov 9, 2026 at 1:04=E2=80=AFAM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> Hi Artem,
>
> On Mon, 2026-11-09 at 00:43 -0600, Artem Novak wrote:
> > I wanted to follow up on this patch series,
> > as it's been a little over five weeks since the v2 submission.
>
> I'm sorry, but there has been too much else on my plate in the
> past weeks. And before I can get to your patches, there are a
> few others still lingering on Patchwork for SH that I need to
> review and pick up.
>
> See: https://patchwork.kernel.org/project/linux-sh/list/
>
> > I'm happy to revise and resubmit if necessary.
>
> Not necessary. I will let you know.
>
> Adrian
>
> --
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer
> `. `'   Physicist
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
