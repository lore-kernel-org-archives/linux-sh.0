Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175B5EB64D9
	for <linux-sh@archiver.kernel.org>; Mon, 10 Jul 2023 13:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjGJNJD (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 10 Jul 2023 09:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbjGJNIC (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 10 Jul 2023 09:08:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE09110C7
        for <linux-sh@vger.kernel.org>; Mon, 10 Jul 2023 06:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688994333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cSSXjKtHNo2g+s4fKQO8ycwZ9VSR9y5qDmg/kPz0J+8=;
        b=NDekGdoVFuvPxqBPm/p8URYHUEwrlee7pnACszE4CztEXS8QClMi+uhA/7W5iKi6rNAU7A
        ImwAW4o9H6riexZj7hlloOSE6AgNJcBLna4YcmqgtWhnM3Q8sxoa2otZsO/plrPDDIJjjv
        S03AAqBX54a0A6gBqFiIzhASVHqu3NQ=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-6VD0TKAEPLGbCXeOBTr8tA-1; Mon, 10 Jul 2023 09:05:32 -0400
X-MC-Unique: 6VD0TKAEPLGbCXeOBTr8tA-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-bacfa4ef059so5434323276.2
        for <linux-sh@vger.kernel.org>; Mon, 10 Jul 2023 06:05:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688994331; x=1691586331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cSSXjKtHNo2g+s4fKQO8ycwZ9VSR9y5qDmg/kPz0J+8=;
        b=a2o5WR3OybfQ4dOSvA3Zn5CpFFiXqcX+PRAqnIu6YTAtz0+uHmsjZSgiRa3UOa9r5Q
         vyOFlzEvL1QO1AgFdm2gsMLl8B3wxxcO3x9Jh52jy+Y9P9Vdgzguc3b61gAdG5LIfwhC
         fJaUo8FM+FQQZxadV5K8N7l7RYeMT6JxvaQitBzOdBpHM/QFD7DlxbRcePPR10OaTwRE
         9z+X60VqvRXkJhGhxCs7bMZFmc6JiIyVlzcs2bzO8af+ioEmo81gLNq0ijQjxJOqbJUl
         YT3DCHOj1QjY8mdjeOZup9jt69BzpnL7LEEroqz4ArTgCbEKVFtTjL4b9JGaUMM58lfs
         TY3w==
X-Gm-Message-State: ABy/qLa8GZGzwC3wHZZJVebh9iGJVDbfCnzh0h0S2CYZ/1FGcAsUw9Zr
        uNY8Lyu8oBBjvRfuZ48FL6nzPvmZi6iCRaGzDuDpfEZOdZXQcRSJuqc9DNKt7OFQ81+RO0OlEDN
        hzHzfEU30ldHXcC8knScMIQpd8m1ph0zSWwc=
X-Received: by 2002:a25:1f02:0:b0:c67:8903:532b with SMTP id f2-20020a251f02000000b00c678903532bmr9557474ybf.44.1688994331565;
        Mon, 10 Jul 2023 06:05:31 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFYCDVRqXESu2lKlw5OOq57+bm9EWCrFUc3sqkdq7rbGFO3X2AFRnXejnh8LqRK8eFbanSG74Fa5+uKsOptTgw=
X-Received: by 2002:a25:1f02:0:b0:c67:8903:532b with SMTP id
 f2-20020a251f02000000b00c678903532bmr9557452ybf.44.1688994331376; Mon, 10 Jul
 2023 06:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230710130113.14563-1-tzimmermann@suse.de> <20230710130113.14563-11-tzimmermann@suse.de>
In-Reply-To: <20230710130113.14563-11-tzimmermann@suse.de>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 10 Jul 2023 15:05:19 +0200
Message-ID: <CAO-hwJLvBpNu1z4qM9+331-oUroh4g5HORL=EZS0nb+HHe+fdw@mail.gmail.com>
Subject: Re: [PATCH 10/17] hid/picolcd: Remove flag FBINFO_FLAG_DEFAULT from
 fbdev driver
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     deller@gmx.de, javierm@redhat.com, linux-sh@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, linux-input@vger.kernel.org,
        linux-media@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-geode@lists.infradead.org, linux-nvidia@lists.surfsouth.com,
        linux-hyperv@vger.kernel.org, linux-omap@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>,
        Jiri Kosina <jikos@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Mon, Jul 10, 2023 at 3:01=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> The flag FBINFO_FLAG_DEFAULT is 0 and has no effect, as struct
> fbinfo.flags has been allocated to zero by framebuffer_alloc(). So do
> not set it.
>
> Flags should signal differences from the default values. After cleaning
> up all occurences of FBINFO_FLAG_DEFAULT, the token can be removed.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: "Bruno Pr=C3=A9mont" <bonbons@linux-vserver.org>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Feel free to take this through the DRI tree (or any other that handles
FB) with the rest of the series if you want.

Cheers,
Benjamin

> ---
>  drivers/hid/hid-picolcd_fb.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/hid/hid-picolcd_fb.c b/drivers/hid/hid-picolcd_fb.c
> index dabcd054dad9..d726aaafb146 100644
> --- a/drivers/hid/hid-picolcd_fb.c
> +++ b/drivers/hid/hid-picolcd_fb.c
> @@ -527,7 +527,6 @@ int picolcd_init_framebuffer(struct picolcd_data *dat=
a)
>         info->var =3D picolcdfb_var;
>         info->fix =3D picolcdfb_fix;
>         info->fix.smem_len   =3D PICOLCDFB_SIZE*8;
> -       info->flags =3D FBINFO_FLAG_DEFAULT;
>
>         fbdata =3D info->par;
>         spin_lock_init(&fbdata->lock);
> --
> 2.41.0
>

