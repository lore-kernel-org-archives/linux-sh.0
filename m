Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D29C7EE23
	for <linux-sh@archiver.kernel.org>; Wed,  7 Jun 2023 08:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237815AbjFGIsf (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 7 Jun 2023 04:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239353AbjFGIse (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 7 Jun 2023 04:48:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE5A18F
        for <linux-sh@vger.kernel.org>; Wed,  7 Jun 2023 01:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686127674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zDz69+oFYWXX1BmnVAcHgBw7nzJBGz38VxVt62J1FoQ=;
        b=Ymtix0B2RpLygBtwDyCB8LQnhRaxsDOQkUheYT8SJjaNGQNIJVsl1MN+vuTeTkzKCwaG8H
        XwYakLRHCCdDu2uQJmbnF+u0WHUWIahhjTdimR/QonoVdzqpFIpYIEUYH2rwdJg/6TMGfU
        BLfCu0j6KNYleT4SKLU+BaHrCiwg3Yo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-h__ep7qyPSC45GwrPkHGAA-1; Wed, 07 Jun 2023 04:47:49 -0400
X-MC-Unique: h__ep7qyPSC45GwrPkHGAA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30c2e9541b9so3874916f8f.0
        for <linux-sh@vger.kernel.org>; Wed, 07 Jun 2023 01:47:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686127668; x=1688719668;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zDz69+oFYWXX1BmnVAcHgBw7nzJBGz38VxVt62J1FoQ=;
        b=M9iLQg7ccHu1OAxYLFOaOsJvNAOsOfd9tI8kUBnx/CrA+0Z3gpAfZaFT8a6Y6H1vLM
         y43XGwd3G1+BqFH5OjaKdUwSbYmZLSnXuOvWFcVuCW430RtfeW5+qQYzgDm5pWdaP4Mi
         VoEtOXGNM6+dMkhBSjxW/EETLOHA34jcLnfH/sK1OiseKvJUswoiwVmQG5rxN0sbIi+Q
         E0YZVRMvhL3DU0FsZxNMLRHFSJlGWxfUT0gWe9FjfZxyq+j93LNzNSac5q0VOTr5StM/
         Yo799QDhmh0/KKRw2meu323Tn3Pq2/vH8YFM1rsniSU1X0ulyIamvbHiKKNRhwdc8WKD
         SDHA==
X-Gm-Message-State: AC+VfDwkuVMrXjI7ze/ROcbDodyx3Nj+ef1/gR1AD7dTH0kEn2MoSIy3
        pHJwPVNCwiIE93+D84xbgGf5VepTs2wzjS+zRa/34cOriDNdLZOofdksNudI8OHLeINjjJt32Hn
        wwd2F4nDyBS2H+IFvK0c=
X-Received: by 2002:a5d:45c6:0:b0:30a:e495:2544 with SMTP id b6-20020a5d45c6000000b0030ae4952544mr3492874wrs.23.1686127668650;
        Wed, 07 Jun 2023 01:47:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4HyIAuVGnzEFE0Y0RegoBmQPKta0aQoYnV+QnWWgwUwsjGZISbQLbaBPCUULIqP84aItfwIg==
X-Received: by 2002:a5d:45c6:0:b0:30a:e495:2544 with SMTP id b6-20020a5d45c6000000b0030ae4952544mr3492862wrs.23.1686127668360;
        Wed, 07 Jun 2023 01:47:48 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d6601000000b0030e5b1fffc3sm1029071wru.9.2023.06.07.01.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 01:47:48 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 09/30] fbdev/ep93xx-fb: Alloc DMA memory from hardware
 device
In-Reply-To: <20230605144812.15241-10-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-10-tzimmermann@suse.de>
Date:   Wed, 07 Jun 2023 10:47:47 +0200
Message-ID: <87o7lrfyks.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Pass the hardware device to the DMA helpers dma_alloc_wc(), dma_mmap_wc()
> and dma_free_coherent(). The fbdev device that is currently being used is
> a software device and does not provide DMA memory.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

