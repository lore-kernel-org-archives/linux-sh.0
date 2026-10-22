Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792660652;
	b=F+G8zEDlvl3qMX2H7Mbw14Km58S0tOEX+bWEgioFTu2RMU/MjxQSUXrj/kqQd4y4811Z
	 FIi2S3d18FTR8lVXKpm41FBEX2rNH3jC36kelGu/ciWK5h1PeKxeuDtaoWrjucGTzRUvp
	 yGzjoJl/MQndNeqOMfnqxdV/gITRaoCok3/gsVmc1ubD1eu2h7zxg/D3vTnMFHLQX/6No
	 J0BjMw8URZCJKrsc1LX8T4gC3RAlvJcE6a5Ulvrhwqr4eTa9tWTPpqcqwGxYjM8XvPTvO
	 1z1iUYKhC21QF/C3/8w5z5HM2+kbwWC24mZRQ6Nr5D20/El0vlC+XjYdv0HLeymBjKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660652;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=T75Ev+zmY9+TyBZeNfZa9ivEcQCv7sC4JnP+VJ1K3fY=;
	b=NPpOMdRKfyYPf+nEBJQs41mYZ89P9MC5nHm6oJm1PN3HdZGdWeQFISIr+pegV2cAN9kl
	 8Jljr5fs4YSd4tWw0ssP3rYZhVhkIIvsiNliRBqa4yLObJ9woRNr6/FhEcIFAuA65z82H
	 UXdoJy1Qx7dSPCi9s7lB1OoQmvCcnXBjPiSWH4iXliiSHhxs4per7oNi9hPneYY/ZS5Ay
	 Gr8dh80ld19fiAI0m5bND0kRVva68981RxvMkSblJisnDfi5ni64r6rmT9fabNxIHsymK
	 Aaxl+FSoqWnlBhKYHCAldzm72aoG7LHh3eKn0TMROCqFL7XoVSWa8/DTJi/vsA95qRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=0x0f.com;
	spf=pass smtp.mailfrom=0x0f.com;
	dkim=pass header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b="QS/VIZ4d";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BA0606A324
	for <linux-sh@vger.kernel.org>; Thu, 22 Oct 2026 09:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02BA0606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b=QS/VIZ4d
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8ab38a051aaso16088617b3.3
        for <linux-sh@vger.kernel.org>; Thu, 22 Oct 2026 02:17:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792660650; cv=none;
        d=google.com; s=arc-20260327;
        b=KEjrkJVUzLJGsvA5/XqenU2JlkDMZZv9yx61Jj30UQkxJrJNTDoz8J7WERRv6fCFy8
         T0QVbSVuAL44aoQj70qXWeUNXc1DrhLkt9OX6KTMqlDpHqoHU+RBtbB4jWB7SA1cNDy8
         H9LQV1DQ25TUqH9NoeGKqkkKRGN/2Fx85dtn4w3h8wZvIw+ndvQid3CEY/HELFSwfMm9
         CQz7Weil8hL3UU28tYzp820tsSMcf1rLtR2/phbUulx5iXS7x8qS7SjBM96GKVmaRsk8
         x/0f7RmT/5XOFZ+osihWhdhK9nppjhvS7/lFT7KcSiWfLVZCOkyjcjPHVKeMjpxpDx39
         1tDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=T75Ev+zmY9+TyBZeNfZa9ivEcQCv7sC4JnP+VJ1K3fY=;
        fh=XreIA/gXBtjHcPVBia/LQPczxdSYIglhNi/lgzPlIiE=;
        b=DxpaoOvJYQ6kfmrJ4376SnQuMFTCOAEq87LdJFe/bw1QiNDKZHmAbKntT0PTygZVvT
         PMDSRgrFMZLACucmH75U+Pe+NRRUnxfiQDyJDeGXRDnO7HoQoGNJVhYivga8cE5h7wo6
         TWvjJPJpM9BJmpJy+iQepdM3DmNi+cnrxsjLG7yS8NS+WeBsG7LLG4zD/dGeV0vQQl3D
         1fiDhzg3wHILd3vPwzn1pHO2IXUgYPmigzHF1s8n4CRj9Cuwu52mliwOE/cK0jiEDYaR
         ca8Xp7LM+KhZ/SOjdpz+KuJfZdCz+d0jADTqCXGM8Xp1NpPnsoFuWlMCqzq48OyDuI8d
         IRsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1792660650; x=1793265450; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T75Ev+zmY9+TyBZeNfZa9ivEcQCv7sC4JnP+VJ1K3fY=;
        b=QS/VIZ4dgQSENDa+6BaYJAzoA5uVw9/TbVenjpW14qvL7kCWLJmEy1T6yUrMG7IJGj
         b3SCPtOwZwfsm80dgzNO2ImjhSOS7GLSif2dCBM0/YMP3shuzQbXoh4j/pcS1jK0Ja6f
         7zAx/FHVVcFAXfvPrdlute4fKZdAjeL2Zc1Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660650; x=1793265450;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=T75Ev+zmY9+TyBZeNfZa9ivEcQCv7sC4JnP+VJ1K3fY=;
        b=qWifjE6JQiYNXW76431crB22qEdYcOcK8v3yFguqrv7yxZMXUOS6oCEeB0AxCCA5+Q
         OePkOKa5kEye36ZdjRfZ0ggKuW683K9sU/1KFp4NnkeBiBGJVae+Ze/DEyXtN0mdHaDY
         EH7UlOicwn6Gjb4Nc1MoI33N8duDAN+sD1kU0BKBqsleA+PxBL0dcMwUEEMheWBdlcC6
         mGRhWZPZjN/PPgs2RXvJWe7EXGDtm0uJAWkMF0eOxbW+e9L6jOQ14ThOrszuXyKtZaB+
         nudqD6ev0rO/3bvW1RDDe+H4gGhLOIgWwLNBYcpXW3qCNhrzDAzGo51n0RsyScgmxIBo
         KYPQ==
X-Forwarded-Encrypted: i=1; AKwUvBxreKk6LfWx44Du+b6qkF/dQ49uaewfN3qexhE/ZHxZWhHpr6c7h7FWiHE/p+j/HUJWwxJkQNo23A==@vger.kernel.org
X-Gm-Message-State: AFq9FYKLLQI8NTFDzTsQCGR+lYCcmV/H/vneInWbKc1YTx4sYzTd2aNE
	Am2amzgAyvKfwJfCYTO2W8DjV6bazkYlyyMu44DI+EQojMCyoDDeiTkEOW8Q1Tr1Ca6ALLV9Th7
	u0SM7vYCSL/jpa/WSJfYt300GEUPnfqznaKfhQz25fFYScvUpmWIZ
X-Gm-Gg: AYBFou1AIGNps1tQROODugnTGMnA9+srzt6cPhWNzPdJD4liunsuTv4Ohfv+R9ZbFX0
	YnFLrZe+zuqppByfQJmFDPkfblvIX78ed9MDknbIE3f1JxEaB4N8CAv/ZI2Bj+90IxlG9uazoug
	/G2HaFosC+cy68LssjhB9V8mgnLiMqA5lNb+ncwCPjpQxhSIoskI0pevJW5eGvHXu0BStNUtCdo
	b+kQVK15ZqwW83SdSFVfq7uyPRcvpe8WGwh0FA7/nDA+nZ7cAV+d++VdLS0l61sOjmWRoe7UZHM
	7BZrVQoKEy8kpt9RKOnbHXm0KFibDvjRuRB+iEKPDjlw6gC7KOI1bVzbh/Udp1FhNxL7s/SBmFe
	exgcbI1I47RvwszS+2TufuPYaDZIzDHmWujNQzF6mmYrL1IP0W2967GHVvnse
X-Received: by 2002:a05:690c:6603:b0:873:5c7b:c102 with SMTP id
 00721157ae682-8b133f865b4mr28955697b3.58.1792660649848; Thu, 22 Oct 2026
 02:17:29 -0700 (PDT)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261017041419.311921-1-daniel@0x0f.com> <20261017041419.311921-2-daniel@0x0f.com>
 <3f657b75-64c9-442b-a609-987cc16f5501@kernel.org>
In-Reply-To: <3f657b75-64c9-442b-a609-987cc16f5501@kernel.org>
From: Daniel Palmer <daniel@0x0f.com>
Date: Thu, 22 Oct 2026 18:17:18 +0900
X-Gm-Features: AclHuK_xkZziVetz0qA3HvsssgwelX2fb-dhEKVmNQmS_hEtJeTxKXJZsKa-iK4
Message-ID: <CAFr9PXnNKfZtXpBe2OVZvu=rf+fsx5NEp7tSGS_FxRKsL3+wQw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ata: pata_artop: read the ATP865 mode register
 through pci_iomap
To: Damien Le Moal <dlemoal@kernel.org>
Cc: ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	cassel@kernel.org, linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, 
	geert@linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Damien,

On Thu, 22 Oct 2026 at 16:01, Damien Le Moal <dlemoal@kernel.org> wrote:
> > +     case 2: {       /* 6280 or 6280 + fast */
> > +             void __iomem *bmdma = pci_iomap(pdev, 4, 1);
> > +             u8 cfg;
> > +
> > +             if (!bmdma)
> > +                     return -ENOMEM;
> > +             cfg = ioread8(bmdma);
> > +             pci_iounmap(pdev, bmdma);
> > +             if (cfg & 0x10)
> >                       ppi[0] = &info_628x_fast;
> >               else
> >                       ppi[0] = &info_628x;
> >               break;
> >       }
> > +     }
>
> This is really ugly... Please move the "case 2" variable declarations to the top
> of the function so that you do not have to do something like this.

That's fair. I'll fix that up.

> Of note also is that this switch does not have a "default" case, which is really
> bad practice, even though in this case, we should never hit unknown values.
> But I would still prefer seeing something like:
>
>         default:
>                 pr_warn("Invalid driver data\n");
>                 pci_disable_device(pdev);
>                 return -ENODEV;
>         }

Can we fix that later or should I roll it into this patch? Being an
old driver I think it probably has a bunch of preexisting style issues
that need to be fixed but that seems like a separate issue from making
it functional again.

Cheers,

Daniel
