Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEABDC77B7A
	for <linux-sh@archiver.kernel.org>; Wed,  7 Jun 2023 07:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238596AbjFGHjd (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 7 Jun 2023 03:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238386AbjFGHjK (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 7 Jun 2023 03:39:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5AC273A
        for <linux-sh@vger.kernel.org>; Wed,  7 Jun 2023 00:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686123401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VCpM3n9uxiNBqWYphesbEdJfBdCBdNVjlNpr9KooViE=;
        b=IXtZa3k9G+j2InWFcIipN6/AtSQoZyrLaSy9r0BLgAmFyrJ+HDripo8AV/zugNQ0+zoyGm
        fgRT3oWOrLtNrt1rqHwbxn6TH1O9/8gm9zJC2sMiFCE25OM0Z6VX2zi+6iCbd69PBQpxzB
        ctOc10/YsT5b72Gqbbq+SPsulkWtINc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-u2iv5xrFNh2sIUFOAIrWVw-1; Wed, 07 Jun 2023 03:36:40 -0400
X-MC-Unique: u2iv5xrFNh2sIUFOAIrWVw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f70f9995aeso33800475e9.0
        for <linux-sh@vger.kernel.org>; Wed, 07 Jun 2023 00:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686123399; x=1688715399;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VCpM3n9uxiNBqWYphesbEdJfBdCBdNVjlNpr9KooViE=;
        b=J/yYpBseE//C3/+eZ/ohG/X6NHgapgNIvt9IByNzYjZTSOdJ0Ioz9vjTQygZJoQ2ho
         KhnMKMH+xTdkLad0Eis5kY/pf5dh358KyojAFyQ2a9vU4KQFsr9pu1sq8HRCDjY57cvs
         A9UGV1QZy5uhMNFyoRmmU01UO9Itn3/B/0T00UzObljnVnc/8RwOkxTKopr/nXoCatGk
         XhivaAlRQKogrR1Amyyls+JjZuy72LOJ4erZtVp7BLchxU3Sje+Di/Ip1U8GXyZ6w7lq
         xdOZVZry8+cNGUOIBWS5APz0EnQtIo306ecLCfwHRLb5V+Hjd0F7f+36EMurHEU2z8wC
         qEgQ==
X-Gm-Message-State: AC+VfDzu7tci3vf919nmijuOMFWisB6Jp2eLpGsJlOsfgK1kHBy1JP2g
        +msiiihzg6IFcrHRDObaNiQLo3ou7SH5O5DtpOZkyM71VVUBBAIyINvwxBD3AczPNGMDQyudxUH
        lqaN1LqzycoepY3Sb5fo=
X-Received: by 2002:adf:fc48:0:b0:30a:f0fd:dca4 with SMTP id e8-20020adffc48000000b0030af0fddca4mr3438818wrs.3.1686123399229;
        Wed, 07 Jun 2023 00:36:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4QHTJetA/ydYNcZpnkz18WI9SIVhHJpnswtj0+WuXSdy2RjUolx7XRR0vsMR7cmSEWXP1qKQ==
X-Received: by 2002:adf:fc48:0:b0:30a:f0fd:dca4 with SMTP id e8-20020adffc48000000b0030af0fddca4mr3438803wrs.3.1686123398984;
        Wed, 07 Jun 2023 00:36:38 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t7-20020a1c7707000000b003f6cf9afc25sm1125337wmi.40.2023.06.07.00.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 00:36:38 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 04/30] fbdev/atyfb: Reorder backlight and framebuffer
 init/cleanup
In-Reply-To: <20230605144812.15241-5-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-5-tzimmermann@suse.de>
Date:   Wed, 07 Jun 2023 09:36:37 +0200
Message-ID: <873533hgfu.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The driver's backlight code requires the framebuffer to be
> registered. Therefore reorder the init and cleanup calls for
> both data structures.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

