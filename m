Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B217080E;
	Mon,  2 Mar 2026 10:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772447166; cv=none; b=mLVdiOVanS6c0EAPmtCnrP4+iRP/CFrF8ViObeGZa04a0BVGeqIoCGECgIMIuAUSyiEDO+eNPfnFZtz1leBtpWxpC78irkis8sR/erMicD+eQ3t2ZHGZSDNWEi7YNToSL2bou8F8e7osQABYrHOfto5zf7CPLY3PV3c6vs0S8a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772447166; c=relaxed/simple;
	bh=BV6a99X28x34kTu9fysdlsKntyYEL/oGxGvWite1jvc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=jDxDTQb43L6Hi1wRDtLjPakwctMs+o8Jni27HnYwBmYMjYUPag7vQsiGpEbZSFiykAOt3HqKRkUDP1DNntnJcHcz5zUv0iYZ8TVOd4Xm9LFUNHWvDrbjyHToevvDmtwC1lK4qzUjY9C+3uf5xQKJgWtwGukmiJgrYaAasgWNDLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDDfP1Os; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDDfP1Os"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46B1C19423;
	Mon,  2 Mar 2026 10:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772447166;
	bh=BV6a99X28x34kTu9fysdlsKntyYEL/oGxGvWite1jvc=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=WDDfP1Os+Q2p2z+RS7kZDGEKhwFriK49KhDmRtg3zaU9IpOTzmHFJktc6s2TTgXh9
	 rCMG087zrTfSKPyR6ZxxJV8Dtq723CqOnPxMljezlPxkaLvUfiuA6QGzyJsW2MDC5a
	 xjkBjuX9tRC8g+xC9U2kLkqq3SdO7DWlRjt0z6g05gWMrl5uX0hgkve3WSoDgpzUZy
	 G8j6E6gmL2YDCrdms/GPfoYoXmlIzeLz8zlm9cwPMC799SSKoobzW6GUyuo+KIvQIk
	 WzoSQ2cpO0n7gVa7i2jPPNzUWRjrI4YMEShOprcDrQNdY5lqVic90fUKr58PI3UzwE
	 GSyU7LbaOYDOw==
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Mar 2026 11:26:01 +0100
Message-Id: <DGS82WWLXPJ0.2EH4VJSF30UR5@kernel.org>
Subject: Re: [PATCH 1/3] driver core: generalize driver_override in struct
 device
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <hanguidong02@gmail.com>, <ysato@users.sourceforge.jp>, <dalias@libc.org>,
 <glaubitz@physik.fu-berlin.de>, <abelvesa@kernel.org>, <srini@kernel.org>,
 <s.nawrocki@samsung.com>, <nuno.sa@analog.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <imx@lists.linux.dev>, <linux-hwmon@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-sound@vger.kernel.org>,
 <linux-sh@vger.kernel.org>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260302002729.19438-1-dakr@kernel.org>
 <20260302002729.19438-2-dakr@kernel.org>
 <CAMuHMdUi3uNoDJ67WkNSKn=BD1F7D1Ot=gz4TwFPvaaYmKaNcg@mail.gmail.com>
In-Reply-To: <CAMuHMdUi3uNoDJ67WkNSKn=BD1F7D1Ot=gz4TwFPvaaYmKaNcg@mail.gmail.com>

On Mon Mar 2, 2026 at 11:00 AM CET, Geert Uytterhoeven wrote:
>> --- a/drivers/base/dd.c
>> +++ b/drivers/base/dd.c
>> @@ -381,6 +381,66 @@ static void __exit deferred_probe_exit(void)
>>  }
>>  __exitcall(deferred_probe_exit);
>>
>> +int __device_set_driver_override(struct device *dev, const char *s, siz=
e_t len)
>> +{
>> +       const char *new, *old;
>> +       char *cp;
>> +
>> +       if (!s)
>> +               return -EINVAL;
>> +
>> +       /*
>> +        * The stored value will be used in sysfs show callback (sysfs_e=
mit()),
>> +        * which has a length limit of PAGE_SIZE and adds a trailing new=
line.
>> +        * Thus we can store one character less to avoid truncation duri=
ng sysfs
>> +        * show.
>> +        */
>> +       if (len >=3D (PAGE_SIZE - 1))
>> +               return -EINVAL;
>> +
>> +       /*
>> +        * Compute the real length of the string in case userspace sends=
 us a
>> +        * bunch of \0 characters like python likes to do.
>> +        */
>> +       len =3D strlen(s);
>> +
>
> The newline case below is is basically the same case as the empty
> string.  Hence if you would move the newline check here:
>
>     if (len) {
>             cp =3D strnchr(s, len, '\n');
>             if (cp)
>                     len =3D cp - s;
>     }
>
> then the "cp !=3D s" check below is no longer needed.
>
>> +       if (!len) {
>> +               /* Empty string passed - clear override */
>> +               spin_lock(&dev->driver_override.lock);
>> +               old =3D dev->driver_override.name;
>> +               dev->driver_override.name =3D NULL;
>> +               spin_unlock(&dev->driver_override.lock);
>> +               kfree(old);
>> +
>> +               return 0;
>> +       }
>
> Also, this block can be eliminated completely...
>
>> +
>> +       cp =3D strnchr(s, len, '\n');
>> +       if (cp)
>> +               len =3D cp - s;
>> +
>> +       new =3D kstrndup(s, len, GFP_KERNEL);
>> +       if (!new)
>> +               return -ENOMEM;
>
> ... by pre-initializing new to NULL, and making the allocation of new
> conditional on len being non-zero.
>
>> +
>> +       spin_lock(&dev->driver_override.lock);
>> +       old =3D dev->driver_override.name;
>> +       if (cp !=3D s) {
>> +               dev->driver_override.name =3D new;
>> +               spin_unlock(&dev->driver_override.lock);
>> +       } else {
>> +               /* "\n" passed - clear override */
>> +               dev->driver_override.name =3D NULL;
>> +               spin_unlock(&dev->driver_override.lock);
>> +
>> +               kfree(new);
>> +       }
>> +       kfree(old);
>> +
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(__device_set_driver_override);

This is essentially a copy of driver_set_override(). Except for the require=
d
minor changes I intentionally kept it "as is" as it will go through -fixes =
and
we know it works properly.

Do you mind sending a follow-up patch with your suggested improvements?
