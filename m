Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C8A4915B5
	for <linux-sh@vger.kernel.org>; Sun, 18 Oct 2026 14:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792334901; cv=none; b=VXYAKffir4VUSvnbU0uDvlW40xCITI3HfJmT8dFO8UhJdOJHc53XWVhb3QylbMbow3ae2oXOeDovuC8cMNqasQiypA+K2eMFmTPuIyX4vS5pg5BhRDcmpaWuOcR292NTIaZao451GUmDZnl2OIH69vghr6v+7q+hUSCmUI6/8rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792334901; c=relaxed/simple;
	bh=Hj5hLisB54S1y/tYqExYUjuqnvH778SRo1sotusOCHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GDcxg9Vg10hPat1OkCUoj1QuZpFAgoY164vGJGQZZONLrxzeHZCzLhAt9+TYHu6cwQoxci2TqlMTZcmP/g8OOpjrkpIfkEwLgm/RrHjkS4uE7gF7s5ycGupnSs+Rs8S3VN/Z6ncg8966dg3o7+RDLRnMg9jI3vjlHnifH2NpS5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5c9e7731b34so1050692e0c.2
        for <linux-sh@vger.kernel.org>; Sun, 18 Oct 2026 07:48:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792334899; x=1792939699;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=i/+KfkD3prUE3gpbH6xDwZzQ4znjfDPPu+7aaw/E4IY=;
        b=REGcZgttLoAE27nZWp+MN80cuBTO0rx/PgP+RgE7Mt2N9oFNPVg/aDaOSFbh7KAXWa
         qLqtexTdssQGsRMlHa9ppR5P8frkVESjQes7i9nW4zCICACDXeCa/lqX4DE2VQ2VpPRU
         phOe3rUfKeR17Vw5B7bSpfybhJr58/nIp7LGqoHyhmu3A0oXQmFJ/KCO7jfsvi6ES5K8
         4exTE8VtMgGlup1sdslE4Wa8r4NxO+yE+YWUbsP3q7cj7YVH26wKuZJPuIdk0Sj3bi7c
         wrWS/PJy7+kttfLz8AC7fhWqQh5Ig3x1KsUisjxCzSfqJx/z6tuDjv0R3yWdTGQIyuGe
         2SGg==
X-Forwarded-Encrypted: i=1; AKwUvBxqarSGbDBkSM0csb8eIU6sTWh9U7r4L1S8nncK08Yktu8OBlfFxMP8JRY//i9JKNHFq2d7KMJIiQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLutbp7QelFectJ+wqO2roKRvRJGXV5BpNzIu8+xJ0mK48IHZZb
	I3WLoURQkVLwIR5IbNZLmOUpZHgfeU1F4a5vduWkw8JC5Mhm0qiIJG4nFERgSxBy
X-Gm-Gg: AYBFou16jqi5ftx83vfaw348iMmcxQIKxp5+pMz6PwyR2ublCGB6rd6IRwuC/s9sbGV
	hmuWrdGBc8V5SWT3piBMMH/7o/OACYW3vrCmWFzB0jVyqJ7TMZ09tgnlHe+9z9ka8EDonbpWlbM
	a6cQqB/daPKpdqyepvDsdQl0Pnha7BhjCBk4MzyFo1Dy1CFvNRRn4EC4SFT6X1Kwqwg7wxpGgtT
	0RS1QBOaDIPXq8wzyZCJorm0AbjngkiTR0e4OnNUhe8GvYQjHI3rq6fSxqsIJjamZNaaI2Getj/
	eLo1tLEbdrodKSMvvz9n/sXO8CcMC5l2BbxMuMY1qdUFDbSw/8phFUSfyW4gqhXnyxHQy3a3D/S
	U7BCAyBZF65zjHfDaf/zFp9jwui6QEDIMHEo6ZtVd153KJFKFD3HjeDajHIdR4ziWmZNJZWYFZW
	92gS8JFZqjE+hEs5PtOO37FSQypq0sqllQBswZsTUs/8OwWFAGSIrKQFmAroBpfQzAlnVQ6bQxk
	beA1+mWE+ZTJQAsDq+OFbja2fPaAtSVWAS5
X-Received: by 2002:a05:6122:f06:b0:5ea:99a6:2670 with SMTP id 71dfb90a1353d-5eaaa8f4e5bmr2086656e0c.23.1792334898853;
        Sun, 18 Oct 2026 07:48:18 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ea9b128725sm7574485e0c.0.2026.10.18.07.48.18
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 07:48:18 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7cb3388613fso880929137.3
        for <linux-sh@vger.kernel.org>; Sun, 18 Oct 2026 07:48:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx3cz97z4rltn8iDz8zcBfDjuiAV1MqGGYy6FK8UagvSeMY0LZpQAA+WB9kxwj6Mg8SAhjm81o0JQ==@vger.kernel.org
X-Received: by 2002:a05:6102:2c0d:b0:7c3:2f13:d905 with SMTP id
 ada2fe7eead31-7cc3670d3c9mr1798032137.3.1792334897916; Sun, 18 Oct 2026
 07:48:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261017041419.311921-1-daniel@0x0f.com> <4cdb2939264e0b7d767f44289fddffd40fddf504.camel@physik.fu-berlin.de>
In-Reply-To: <4cdb2939264e0b7d767f44289fddffd40fddf504.camel@physik.fu-berlin.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 18 Oct 2026 16:48:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXmZash+8PmfSVrT=Wwob-mkq0x4umyRgX2-yikV9kaVA@mail.gmail.com>
X-Gm-Features: AclHuK8RBwZK_z43GrchRos_lydjyPBWt8zUJgcfKwlnh5NSKD4CTmW99AiE-yI
Message-ID: <CAMuHMdXmZash+8PmfSVrT=Wwob-mkq0x4umyRgX2-yikV9kaVA@mail.gmail.com>
Subject: Re: [PATCH 0/2] sh: Fix IDE on landisk
To: Daniel Palmer <daniel@0x0f.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, dalias@libc.org, dlemoal@kernel.org, 
	cassel@kernel.org, linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yoshinori Sato <yoshinori.sato@nifty.com>
Content-Type: text/plain; charset="UTF-8"

Hi Daniel,

On Sat, 17 Oct 2026 at 09:48, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Sat, 2026-10-17 at 13:14 +0900, Daniel Palmer wrote:
> > I dug out my landisk to look at kexec for Geert. Since I'm lazy and
> > LLMs are good at fixing bitrot I let my LLM work out how to get
> > it to boot again.
> >
> > There are some other issues (perf is apparently borken, there are
> > some issues with the decompresor and big kernels..) but this
> > seems to be the only thing stopping it booting with the defconfig.
> >
> > Disclaimer since we don't need to give LLM tags anymore:
> > - LLM debugged the issue.
> > - It has been checked on real hardware.
> > - I have checked the IDE driver patch, cleaned it up and
> >   cleaned out massive walls of text that LLMs seem to like
> >   to add but I have left its summary of the issue in the commit
> >   message.
> >
> > Daniel Palmer (2):
> >   ata: pata_artop: read the ATP865 mode register through pci_iomap
> >   sh: landisk_defconfig: enable PATA_ARTOP for the ATP865
> >
> >  arch/sh/configs/landisk_defconfig |  2 +-
> >  drivers/ata/pata_artop.c          | 12 ++++++++++--
> >  2 files changed, 11 insertions(+), 3 deletions(-)
>
> Great, thanks for fixing this. While I have LANDISK hardware myself,
> I cannot probably set it up fast enough now to test your patches as
> I don't know where I put it after moving places.
>
> I hope Geert can test and review your patches and I'll pick them up
> with his Reviewed-by and Tested-by signatures.

Sorry, I must have different hardware, as mine doesn't have an
ATP865 PCI device:

    # lspci
    00:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 20)
    00:02.0 USB Controller: NEC Corporation USB (rev 43)
    00:02.1 USB Controller: NEC Corporation USB (rev 43)
    00:02.2 USB Controller: NEC Corporation USB 2.0 (rev 04)

My CF rootfs uses pata_platform, which is enabled in my working .config.
landisk_defconfig lacks CONFIG_PATA_PLATFORM=y, so it hangs during
boot. After enabling that, the boot gets further, but it still hangs:

    INIT: Id "1" respawning too fast: disabled for 5 minutes
    INIT: Id "2" respawning too fast: disabled for 5 minutes
    INIT: no more processes left in this runlevel

Adding

    CONFIG_DEVTMPFS=y
    CONFIG_DEVTMPFS_MOUNT=y

to landisk_defconfig fixes that.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
