Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7A8CA0FE6
	for <linux-sh@archiver.kernel.org>; Fri,  1 Sep 2023 13:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbjIANKA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 1 Sep 2023 09:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjIANJ6 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 1 Sep 2023 09:09:58 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34DAE0
        for <linux-sh@vger.kernel.org>; Fri,  1 Sep 2023 06:09:55 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-58fb73e26a6so20727447b3.1
        for <linux-sh@vger.kernel.org>; Fri, 01 Sep 2023 06:09:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693573795; x=1694178595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPz4NOvTWZ50fporlP0A/RbF5RHNoQ2Jkt4A9Cdsu8I=;
        b=bRaPtqM1CBlVxgRfhD+y8PNF66RMPjJkW8+qRsYJZoyK+czMY4Ibj2J4Dr7UWYWEsJ
         Ar5kzDzYeNCROlky5fW8ke0nyBzyOKTBp8FkoA3gZG9VzY5OSgNVNFK+2L/Ww9/uzpiw
         b9tp5L8TOnOvJaYHpg400gKyzUkcnkxDb52FMr3AjwWQxsXwNNPopA+WDCOCv36/7trd
         Va+4HvchxaqeQb4814ym74REwPoT7wIz+krdP2AQKB42AeP11gx+UZY0tt53tvl3K26C
         dzVhBV4gRkFkbcf1aGYz6iCOGFLCvrb9hSBqu+8+5R6u5ctb0q3c8gz1oaQGSuMWViRh
         GpFQ==
X-Gm-Message-State: AOJu0YyNOtD1fkv7B8xALMBGvC4/hfvSMmQWSr7A2fqc1EQWWbdRbn5i
        7f/vemKcKkVAqh1/enp/8rjqMRufrosvVA==
X-Google-Smtp-Source: AGHT+IGRxF0ejAEG90ij/zlygQ5yjDTZQPh8xxSEG9rtyPutOVueyoSI50zeLxCvOOO9PmOn9X0k4A==
X-Received: by 2002:a81:8741:0:b0:569:e7cb:cd4e with SMTP id x62-20020a818741000000b00569e7cbcd4emr2557404ywf.48.1693573794874;
        Fri, 01 Sep 2023 06:09:54 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id v66-20020a814845000000b0058cd7816bcbsm1047038ywa.17.2023.09.01.06.09.54
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 06:09:54 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-d77c5414433so1545820276.0
        for <linux-sh@vger.kernel.org>; Fri, 01 Sep 2023 06:09:54 -0700 (PDT)
X-Received: by 2002:a25:d204:0:b0:d7a:c572:fa3 with SMTP id
 j4-20020a25d204000000b00d7ac5720fa3mr3024226ybg.25.1693573794441; Fri, 01 Sep
 2023 06:09:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693444193.git.ysato@users.sourceforge.jp> <f622670c0af1bf01bf7c2f16241db0c36233a7d9.1693444193.git.ysato@users.sourceforge.jp>
In-Reply-To: <f622670c0af1bf01bf7c2f16241db0c36233a7d9.1693444193.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 1 Sep 2023 15:09:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXtJ4tn27n64avxDMpnO-kxF-pbcf=W1_1wuYAH0WSiow@mail.gmail.com>
Message-ID: <CAMuHMdXtJ4tn27n64avxDMpnO-kxF-pbcf=W1_1wuYAH0WSiow@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH 08/12] mfd/sm501: Add OF properties.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

On Fri, Sep 1, 2023 at 12:23 AM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Some parameters only platform_device.
> Added same parameters in OF property.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> --- a/drivers/mfd/sm501.c
> +++ b/drivers/mfd/sm501.c
> @@ -80,6 +80,9 @@ struct sm501_devdata {
>         unsigned int                     irq;
>         void __iomem                    *regs;
>         unsigned int                     rev;
> +#if defined(CONFIG_OF)
> +       struct device_node              *np;
> +#endif

"np" is only used during probing, so you can just pass it as a parameter
instead.

>  };
>
>
> @@ -1370,6 +1373,106 @@ static int sm501_init_dev(struct sm501_devdata *sm)
>         return 0;
>  }
>
> +static unsigned int sm501_parse_devices_str(const char *str)

This function is unused when COFNIG_OF=n, so please move inside the
#idef below.

> +{
> +       char *sep;
> +       unsigned int device = 0;
> +       int i;

unsigned int

> +       int len;
> +       static const struct {
> +               char *devname;
> +               unsigned int devid;
> +       } devlist[] = {
> +               { "usb-host", SM501_USE_USB_HOST },
> +               { "usb-gadget", SM501_USE_USB_SLAVE },
> +               { "ssp0", SM501_USE_SSP0 },
> +               { "ssp1", SM501_USE_SSP1 },
> +               { "uart0", SM501_USE_UART0 },
> +               { "uart1", SM501_USE_UART1 },
> +               { "accel", SM501_USE_FBACCEL },
> +               { "ac97", SM501_USE_AC97 },
> +               { "i2s", SM501_USE_I2S },
> +               { "gpio", SM501_USE_GPIO },
> +               { "all", SM501_USE_ALL },
> +       };
> +
> +       do {
> +               sep = strchr(str, ',');
> +               len = sep ? sep - str : strlen(str);
> +               for (i = 0; i < ARRAY_SIZE(devlist); i++) {
> +                       if (strncasecmp(str, devlist[i].devname, len) == 0) {
> +                               device |= devlist[i].devid;
> +                               break;
> +                       }
> +               }
> +               str = sep + 1;
> +       } while (sep);
> +       return device;
> +}
> +
> +#if defined(CONFIG_OF)
> +static void sm501_of_read_reg_init(struct sm501_devdata *sm,
> +                                  const char *propname, struct sm501_reg_init *val)
> +{
> +       u32 u32_val;
> +
> +       if (!of_property_read_u32_index(sm->np, propname, 0, &u32_val))
> +               val->set = u32_val;
> +       if (!of_property_read_u32_index(sm->np, propname, 1, &u32_val))
> +               val->mask = u32_val;

Error handling?

> +}
> +
> +static int sm501_parse_dt(struct sm501_devdata *sm)
> +{
> +       struct sm501_platdata *plat;
> +       const char *devstr;
> +       u32 u32_val;
> +
> +       if (sm->np == NULL)
> +               return 0;

This cannot happen.

> +       plat = kzalloc(sizeof(struct sm501_platdata), GFP_KERNEL);

devm_kzalloc(), to simplify error handling

> +       if (plat == NULL)
> +               return -ENOMEM;
> +       plat->init = kzalloc(sizeof(struct sm501_initdata), GFP_KERNEL);

devm_kzalloc()

> +       if (plat->init == NULL)
> +               goto err;
> +
> +       if (!of_property_read_string(sm->np, "sm501,devices", &devstr))
> +               plat->init->devices = sm501_parse_devices_str(devstr);
> +       if (!of_property_read_u32_index(sm->np, "sm501,mclk", 0, &u32_val))
> +               plat->init->mclk = u32_val;
> +       if (!of_property_read_u32_index(sm->np, "sm501,m1xclk", 0, &u32_val))
> +               plat->init->m1xclk = u32_val;

Do you need any error handling?

>  static int sm501_plat_probe(struct platform_device *dev)
>  {
>         struct sm501_devdata *sm;
> @@ -1384,7 +1487,6 @@ static int sm501_plat_probe(struct platform_device *dev)
>         sm->dev = &dev->dev;
>         sm->pdev_id = dev->id;
>         sm->platdata = dev_get_platdata(&dev->dev);
> -

Please keep this blank line.

>         ret = platform_get_irq(dev, 0);
>         if (ret < 0)
>                 goto err_res;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
