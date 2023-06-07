Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C80C7EE43
	for <linux-sh@archiver.kernel.org>; Wed,  7 Jun 2023 07:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbjFGH4L (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 7 Jun 2023 03:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbjFGH4K (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 7 Jun 2023 03:56:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205EB106
        for <linux-sh@vger.kernel.org>; Wed,  7 Jun 2023 00:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686124523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zrMzVIVwuoeUQwH5hpliW2Jq51XgxuMBmmo9TGjEBeo=;
        b=YeUTGY09Uhx6OvQQs+YzJ40ATnG/bPIDumBmDHDLKp5E4TMPkxUXmOCvzLQvSJLnv7EDR4
        fddOecpsQ3JoAYoqc9fz6wnwScB8jK8+1vXZrYwiNvvdt81S5nbhN/53l6NKllvMmHHSR6
        YGrq2OXUM/yO/mtNo7gfgfhg6sG5xnQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-Kwov5eiDN4Gqq5Mcd5qYVw-1; Wed, 07 Jun 2023 03:55:15 -0400
X-MC-Unique: Kwov5eiDN4Gqq5Mcd5qYVw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4f62d8e527bso1829800e87.1
        for <linux-sh@vger.kernel.org>; Wed, 07 Jun 2023 00:55:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686124513; x=1688716513;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zrMzVIVwuoeUQwH5hpliW2Jq51XgxuMBmmo9TGjEBeo=;
        b=lrISeQ0ZumIiuWKKoQe2/zjX/pC70u7Tzl4oY0Z0OBPN8wXFVTcReXldNihbPSPTeP
         cgM2tNC+7qBRYphYj9/DfmxO2tg9goJ3tqZ0w+iYbMWDipyT+XXwEbg2hyMRpdoISlMx
         x+SWsNhykaVBCRHcCvRK2t3PAl2oelz53sMiN82+/+HXBhBNVWb1gsz2O/J6Qgc/RcXG
         enoFZttmyQV71q32r9Hnw76lcR99oD3oP/O7BWIMHLsM8jFKE5SaXPiSsbY722PtDjaq
         Wt8K9KPCxU9OZ2GqnJojPs5xw9aTpfWfmUcpV7KYlUvnC+9GvNaJTbvPrX8nvT2unkcn
         FYTQ==
X-Gm-Message-State: AC+VfDzYQXTCD6cDBSzRh0o8hR6/HZWGhKV0AbiOFDMstEdE9IKxn5OJ
        P0Ohh4NL600S+x6PFeKQkiPGTvHQbwBv6Rkenb2HQHmYu1xreEObJA81Q3Awtf+n+ahbAhDF0UD
        4WhK8rKCsxj3W3F7v64A=
X-Received: by 2002:ac2:5a19:0:b0:4f3:bb14:bd40 with SMTP id q25-20020ac25a19000000b004f3bb14bd40mr1643609lfn.36.1686124513740;
        Wed, 07 Jun 2023 00:55:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5iJQ/YOY5BYJYpCuij2Dk8TuMWnzRrrUQf5oe61hk5gDfo5VjRa0aD7EjgG4gko6svJeBZBA==
X-Received: by 2002:ac2:5a19:0:b0:4f3:bb14:bd40 with SMTP id q25-20020ac25a19000000b004f3bb14bd40mr1643602lfn.36.1686124513442;
        Wed, 07 Jun 2023 00:55:13 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z9-20020a5d4d09000000b0030e5c8d55f2sm480065wrt.6.2023.06.07.00.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 00:55:13 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 07/30] fbdev/aty128fb: Use hardware device as backlight
 parent
In-Reply-To: <20230605144812.15241-8-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-8-tzimmermann@suse.de>
Date:   Wed, 07 Jun 2023 09:55:12 +0200
Message-ID: <87ttvjg10f.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Use the hardware device in struct fb_info.device as parent of the
> backlight device. Aligns the driver with the rest of the codebase
> and prepares fbdev for making struct fb_info.dev optional.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

