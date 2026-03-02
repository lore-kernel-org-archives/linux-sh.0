Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6243F331A78
	for <linux-sh@vger.kernel.org>; Mon,  2 Mar 2026 10:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772447930; cv=none; b=L1DDcabrSByCf+G+COXoWnZGqe9WWFy3EUFgKDzDz1IoDuwwYXnzs0nS77plNFUh700vlQp8Kp+LoyEtTgtLoysbIythY4vSIgY0DvMMGM2uiN6+j4CvZspqFgk4o3viBTEyDBVJ0sCg37aPwtN5GlQcuSXdswO4nog+IgkvyEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772447930; c=relaxed/simple;
	bh=PO0TbLRbiVrKvdhPwH7RKWikT/wKrrUI+0ibUOovsCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scPOte+MsJw/Rm5iQSdc40TiQqBkbOzxQOdvB3a8jmBISd4gJdwQdl7cv8FBNmnYb/qwgJp3x9BpdKT0AaTDYfiVtvia20g/+tC775ZhGK29NrqkSaoMH+zUgfwnz5J/0GjX+pJuDOWNIyyx6h+a6imngbRg5Ixf/DZyHgSWnLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-94ddffda372so3707761241.1
        for <linux-sh@vger.kernel.org>; Mon, 02 Mar 2026 02:38:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772447928; x=1773052728;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bl7RAWu6mKzowPFnldQghONe5pbsD04RWaX4BUYhOlo=;
        b=kKQKvoBj5F1sxO50OF42v3P+yKXZtnxHlEBtsHakY9Z1/HiJDuNHfARFYhw+EshlXX
         AEq7JoPJ7uOC6jJNWhShnH1PXMiwtwpzPtdZ9JqyWZHvZ7IrcHwzXJLEs4qSBTYXFSSQ
         1uk9aHZfEEGoqVHO+b/ST39vJEviAQN9FZ2bPTarBDNBjQfuz68gfNQu+ISOs5hhlIY/
         LkfO51yBZDd3w5xhM0Ae8prnnvB8ETSrtRWRGoKCi8E+72oU7Y78MUdplu8cPSBRL/iO
         0lKaCCLZfBweSzJFiruNLipkXJp7XV/Avf3GMBSYIPV8CrKvpx3LrWXBx0WHs4jNmfof
         MRpA==
X-Forwarded-Encrypted: i=1; AJvYcCUKcIOOneFdm75/+kL1xR4h4wn2JssrRiIy5xZ6qb7pYF80O3uKBC99KCQ/dKjucz5pcWVrYvL7Xw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyK/ZtzP32qiZZHO7wN8d1z6xhgUykLlKHKXfYSf5wp7BamjDxy
	NrlRawDf7W7iptjXvL9pdIPjCFc1HouJjGZDKcCSXcbHd5IYdOp2ntbBEmYk3rke
X-Gm-Gg: ATEYQzx1yqhERAWcAK6ai9CqEsU63NmXzjJ/0X3UVnmoUAAkdcL15UjxLDg3Zx3amNJ
	MKOAW33hmdZtBUfRdrcwLrbaYA9msq8SB9RThDYwxd263fNKHr/cVr/uNxnM6faDr/CTdb4Ez/c
	Z+vHQVR4fPS3EDHam5q7M9936Vi3JOSZkLUGkg/PjuVD14yOyGpNNJsgbffdiWDJ0cM9hdqmDdW
	ovN4y/3+rl8voadIKt55TCK6Wf4iFc4ZXnSShvUzxWbsI8HvXpg+A3KJfBfEUOu9H+sdX0w8hSI
	AYobTGLuKav+y1dgulE7xMTxaQTbQrF6P5Ktw63u2/MK6b35138r+NUh6h23EK349eIkpy420Ef
	3789i0TMlPtvdijFnqQQAxHBH6ZD/2EIBzbAQuWU9uXGqor6z6B0gE3a/vyEhSMGT4RiJHhWFM8
	dD6siPe7IOl+ZEXMb/ArnLBlrrjmO6vR7QX4BXYBe7AZ7uqhJBQ7iaytewqKIndhGJ
X-Received: by 2002:a05:6102:c53:b0:5ff:1c7b:3d5c with SMTP id ada2fe7eead31-5ff3378c823mr5242015137.18.1772447928288;
        Mon, 02 Mar 2026 02:38:48 -0800 (PST)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ff1e808164sm12850459137.4.2026.03.02.02.38.47
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 02:38:47 -0800 (PST)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5674cd243d9so4149653e0c.0
        for <linux-sh@vger.kernel.org>; Mon, 02 Mar 2026 02:38:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVATGzxPzfbO3ELASK4vbJINdzfT/rhQDrnuvHj7Ph99qoEy96hCPXEUNrkEMqFB0F7xfp2wx0IdQ==@vger.kernel.org
X-Received: by 2002:a05:6102:440e:b0:5ef:b32c:dff8 with SMTP id
 ada2fe7eead31-5ff1cda8e40mr7754538137.5.1772447927548; Mon, 02 Mar 2026
 02:38:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302002729.19438-1-dakr@kernel.org> <20260302002729.19438-2-dakr@kernel.org>
 <CAMuHMdUi3uNoDJ67WkNSKn=BD1F7D1Ot=gz4TwFPvaaYmKaNcg@mail.gmail.com> <DGS82WWLXPJ0.2EH4VJSF30UR5@kernel.org>
In-Reply-To: <DGS82WWLXPJ0.2EH4VJSF30UR5@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 2 Mar 2026 11:38:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVe7Z3k1sz2dEYqfpp7uqdYjrqL-gRbUE7CPBpOA+-RfA@mail.gmail.com>
X-Gm-Features: AaiRm52rSumTG3nFZ9P6FzWdxvQ0hMzWVlbis5lyqzx4MgKVwMUrLmFH3gE-zLg
Message-ID: <CAMuHMdVe7Z3k1sz2dEYqfpp7uqdYjrqL-gRbUE7CPBpOA+-RfA@mail.gmail.com>
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

On Mon, 2 Mar 2026 at 11:26, Danilo Krummrich <dakr@kernel.org> wrote:
> On Mon Mar 2, 2026 at 11:00 AM CET, Geert Uytterhoeven wrote:
> >> --- a/drivers/base/dd.c
> >> +++ b/drivers/base/dd.c
> >> @@ -381,6 +381,66 @@ static void __exit deferred_probe_exit(void)
> >>  }
> >>  __exitcall(deferred_probe_exit);
> >>
> >> +int __device_set_driver_override(struct device *dev, const char *s, size_t len)
> >> +{
> >> +       const char *new, *old;
> >> +       char *cp;
> >> +
> >> +       if (!s)
> >> +               return -EINVAL;
> >> +
> >> +       /*
> >> +        * The stored value will be used in sysfs show callback (sysfs_emit()),
> >> +        * which has a length limit of PAGE_SIZE and adds a trailing newline.
> >> +        * Thus we can store one character less to avoid truncation during sysfs
> >> +        * show.
> >> +        */
> >> +       if (len >= (PAGE_SIZE - 1))
> >> +               return -EINVAL;
> >> +
> >> +       /*
> >> +        * Compute the real length of the string in case userspace sends us a
> >> +        * bunch of \0 characters like python likes to do.
> >> +        */
> >> +       len = strlen(s);
> >> +
> >
> > The newline case below is is basically the same case as the empty
> > string.  Hence if you would move the newline check here:
> >
> >     if (len) {
> >             cp = strnchr(s, len, '\n');
> >             if (cp)
> >                     len = cp - s;
> >     }
> >
> > then the "cp != s" check below is no longer needed.
> >
> >> +       if (!len) {
> >> +               /* Empty string passed - clear override */
> >> +               spin_lock(&dev->driver_override.lock);
> >> +               old = dev->driver_override.name;
> >> +               dev->driver_override.name = NULL;
> >> +               spin_unlock(&dev->driver_override.lock);
> >> +               kfree(old);
> >> +
> >> +               return 0;
> >> +       }
> >
> > Also, this block can be eliminated completely...
> >
> >> +
> >> +       cp = strnchr(s, len, '\n');
> >> +       if (cp)
> >> +               len = cp - s;
> >> +
> >> +       new = kstrndup(s, len, GFP_KERNEL);
> >> +       if (!new)
> >> +               return -ENOMEM;
> >
> > ... by pre-initializing new to NULL, and making the allocation of new
> > conditional on len being non-zero.
> >
> >> +
> >> +       spin_lock(&dev->driver_override.lock);
> >> +       old = dev->driver_override.name;
> >> +       if (cp != s) {
> >> +               dev->driver_override.name = new;
> >> +               spin_unlock(&dev->driver_override.lock);
> >> +       } else {
> >> +               /* "\n" passed - clear override */
> >> +               dev->driver_override.name = NULL;
> >> +               spin_unlock(&dev->driver_override.lock);
> >> +
> >> +               kfree(new);
> >> +       }
> >> +       kfree(old);
> >> +
> >> +       return 0;
> >> +}
> >> +EXPORT_SYMBOL_GPL(__device_set_driver_override);
>
> This is essentially a copy of driver_set_override(). Except for the required
> minor changes I intentionally kept it "as is" as it will go through -fixes and
> we know it works properly.

So I will have two to fix? ;-)

> Do you mind sending a follow-up patch with your suggested improvements?

Adding it to my TODO list, if this patch makes it as-is.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
