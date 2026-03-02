Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9098B3358A6
	for <linux-sh@vger.kernel.org>; Mon,  2 Mar 2026 10:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772445635; cv=none; b=aTGP6ssbXaaxYflDLlN8aOg4weL04et2OCu7KBvE35ls/e302AM9TMAqEZB8XAp+VHE1cply3ju6KTnva45rU5vNWx4kqTftfQWEJYUYIdDODIHoRZSwH+1Ld6lqgYN8eXWl7Cx0cRhSlQzINVfJYHKbLk2O6EVLMaSpmNiKEHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772445635; c=relaxed/simple;
	bh=4y2TOHi9TFOVkbjGDV689T/Smv9dTsRouELeh2CzMQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IBPgPdSYvUANgoquION4i0n/KN3bOCzWWxZAU5uWt2M83aAuh3oercenT/TTZUoKegz+EGsqgW7r3RvYS5gkLMqKSKG9v1Mp7jcqSNFnk8ZS28WdiQoyBMkYzH8entI3UlISuY2kbwk/56KlR2y6CI9fFax+EIPxrUrhX6p1YKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-94aaa5d3bfcso2621598241.3
        for <linux-sh@vger.kernel.org>; Mon, 02 Mar 2026 02:00:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772445633; x=1773050433;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8HkRe6vR1zoQp8bGRDh2bo/ApHTR7KmRx9+/JW4v6E=;
        b=R7p1fvUUm+OWMeE4WnHIdQjky0gNrBOyiLg/1tX42tN3wnYcf8DA8wJg+6NPZa//xL
         5Xe8bQ9WRKUCIvvrH/Fpsd2O0UgVuBeUixjf5LlgjsayJ7P4/m9s3aC5G1pXMb6WAW9N
         ZwOlraTvLg/ODYkrcSW4RXB/1qOIfvA+wy3OhZCdHGpos+eb8RS2R95dS+uU4UK8J4f8
         n2ruNI+OjgozUb9o3poDly5pLX8Rlm3KYwy+YtiQgGmd7e+itIzJ4x+cXNAwUq79EUE8
         qzSFmMIwWCLnuZGw+BPuV+ZIVUsKQtv4ZHhU25W7Jm17uJfRW3wzoSKyPwImg2vjFkOS
         ABkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmcZx22wH2w+lW/DZExzH8niF3Ff+90A1Oz/nl+M4iCvpABOA7QLmAKj2hTTsrh04LHo+KiLCkOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJiB9nAuOyaD2mKDNSxGQfIDP30S1duwtRrfWI8so9XS8fTMEY
	FULJa0Ag3N7enaMaw666RbJ1PPjs0U1VWmk0YRogE8mSQrJewEcYX/uzhb9Q0ZL0
X-Gm-Gg: ATEYQzz4XQxT4b20WGYZBZb0+Ye/somDbAMRRu+vBIdLMohxTt5Tc6k9cAoJN0B7C8j
	e39sBGuqGO+YveRNncWtQ5+rBfRbGOsanEUxPpxHG3l5I2YXzqzEiQKtdCe9EVc3b9Tju8kHeYQ
	8D27OlIOoZw+/DKEKf58PxyFJMyxiWhX5XEcGhSf5dsXsbFvGz4Kvt3JxjqN2L6zeZGYbaP+RCh
	9NVbumInqnF6L6WGslsB/28aWoFd35kh319jQ2HLWQMvZMbL+x6xf5zigAkxihwF4Uq0tSHYXJZ
	0+DM8HgAekDjOu2jK3ef9mV74p3eaki7t6ZQi3nOP7y9OXw2PgYn60vkx6PcxdbTSLEx5m103hj
	ph074nYsFUi0R1Q91xrpeTPSmloQHzPay9JewLCxXSlXIarBKukalGza56AE+njnDjo9uJVT9h6
	O8csogJa6CbmvpCA3h1ntxajEkjiuWNEn9DPsaK4BuMK3NrrYD0Ks4OMcoBccbhrfY
X-Received: by 2002:a05:6102:e09:b0:5ee:a0e6:a9f4 with SMTP id ada2fe7eead31-5ff32313879mr6068900137.12.1772445632681;
        Mon, 02 Mar 2026 02:00:32 -0800 (PST)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ff1e7af30asm12632579137.3.2026.03.02.02.00.31
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 02:00:31 -0800 (PST)
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-56a87d7c5d7so3473601e0c.3
        for <linux-sh@vger.kernel.org>; Mon, 02 Mar 2026 02:00:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1/YSdy+Y1pRw8L/Kb33LLjvC+ArV3lBgsK4CjY/7hfyPZhVt5CcOYRBh/taI8ymVbbW7CvnaUyg==@vger.kernel.org
X-Received: by 2002:a05:6122:1c0f:b0:566:22e6:35df with SMTP id
 71dfb90a1353d-56aa09f82acmr5754346e0c.5.1772445631307; Mon, 02 Mar 2026
 02:00:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302002729.19438-1-dakr@kernel.org> <20260302002729.19438-2-dakr@kernel.org>
In-Reply-To: <20260302002729.19438-2-dakr@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 2 Mar 2026 11:00:20 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUi3uNoDJ67WkNSKn=BD1F7D1Ot=gz4TwFPvaaYmKaNcg@mail.gmail.com>
X-Gm-Features: AaiRm52H_j84TKaKZyu39pwrVpDQPCGWPfmBnPTyHzO3FAF2JqSLhA9oDdBhutg
Message-ID: <CAMuHMdUi3uNoDJ67WkNSKn=BD1F7D1Ot=gz4TwFPvaaYmKaNcg@mail.gmail.com>
Subject: Re: [PATCH 1/3] driver core: generalize driver_override in struct device
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, hanguidong02@gmail.com, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	abelvesa@kernel.org, srini@kernel.org, s.nawrocki@samsung.com, 
	nuno.sa@analog.com, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-hwmon@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Danilo,

On Mon, 2 Mar 2026 at 01:28, Danilo Krummrich <dakr@kernel.org> wrote:
> Currently, there are 12 busses (including platform and PCI) that
> duplicate the driver_override logic for their individual devices.
>
> All of them seem to be prone to the bug described in [1].
>
> While this could be solved for every bus individually using a separate
> lock, solving this in the driver-core generically results in less (and
> cleaner) changes overall.
>
> Thus, move driver_override to struct device, provide corresponding
> accessors for busses and handle locking with a separate lock internally.
>
> In particular, add device_set_driver_override(),
> device_has_driver_override(), device_match_driver_override() and a
> helper, DEVICE_ATTR_DRIVER_OVERRIDE(), to declare the corresponding
> sysfs store() and show() callbacks.
>
> Until all busses have migrated, keep driver_set_override() in place.
>
> Note that we can't use the device lock for the reasons described in [2].
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=220789 [1]
> Link: https://lore.kernel.org/driver-core/DGRGTIRHA62X.3RY09D9SOK77P@kernel.org/ [2]
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Thanks for your patch!

> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -381,6 +381,66 @@ static void __exit deferred_probe_exit(void)
>  }
>  __exitcall(deferred_probe_exit);
>
> +int __device_set_driver_override(struct device *dev, const char *s, size_t len)
> +{
> +       const char *new, *old;
> +       char *cp;
> +
> +       if (!s)
> +               return -EINVAL;
> +
> +       /*
> +        * The stored value will be used in sysfs show callback (sysfs_emit()),
> +        * which has a length limit of PAGE_SIZE and adds a trailing newline.
> +        * Thus we can store one character less to avoid truncation during sysfs
> +        * show.
> +        */
> +       if (len >= (PAGE_SIZE - 1))
> +               return -EINVAL;
> +
> +       /*
> +        * Compute the real length of the string in case userspace sends us a
> +        * bunch of \0 characters like python likes to do.
> +        */
> +       len = strlen(s);
> +

The newline case below is is basically the same case as the empty
string.  Hence if you would move the newline check here:

    if (len) {
            cp = strnchr(s, len, '\n');
            if (cp)
                    len = cp - s;
    }

then the "cp != s" check below is no longer needed.

> +       if (!len) {
> +               /* Empty string passed - clear override */
> +               spin_lock(&dev->driver_override.lock);
> +               old = dev->driver_override.name;
> +               dev->driver_override.name = NULL;
> +               spin_unlock(&dev->driver_override.lock);
> +               kfree(old);
> +
> +               return 0;
> +       }

Also, this block can be eliminated completely...

> +
> +       cp = strnchr(s, len, '\n');
> +       if (cp)
> +               len = cp - s;
> +
> +       new = kstrndup(s, len, GFP_KERNEL);
> +       if (!new)
> +               return -ENOMEM;

... by pre-initializing new to NULL, and making the allocation of new
conditional on len being non-zero.

> +
> +       spin_lock(&dev->driver_override.lock);
> +       old = dev->driver_override.name;
> +       if (cp != s) {
> +               dev->driver_override.name = new;
> +               spin_unlock(&dev->driver_override.lock);
> +       } else {
> +               /* "\n" passed - clear override */
> +               dev->driver_override.name = NULL;
> +               spin_unlock(&dev->driver_override.lock);
> +
> +               kfree(new);
> +       }
> +       kfree(old);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(__device_set_driver_override);
> +
>  /**
>   * device_is_bound() - Check if device is bound to a driver
>   * @dev: device to check

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
