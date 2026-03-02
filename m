Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341CE32AAA0;
	Mon,  2 Mar 2026 16:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468944; cv=none; b=H7QfsaOIZBSPPzGt8uhCrwG2MzJT2qnvJspNtecAUNVRHY9avCD4PPV5oDfoxRStAIuCJXYAiu3c9tdhrgB5XsFyy3BpxyTuEb3wWNQwqY/iaLmZ0F/XTTraBjoLJ1Zy4pWbW/KyZRHcLswK3BvD3YV8GOrqrOlt5nJjZYzyBPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468944; c=relaxed/simple;
	bh=Q5EJz0ks9pfcEKpulvqPiKiB3QcWP4MPjhaSyuLWtKA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=oYjpaLHj7p56aK7O2Ptf4kvKNKsIq+wjGXSGKzWpRN7MFvRoF3uALoW1POfw8vB5gcCH9mlEq6CTWF8MAaVBMO6RLB5ETMOIrtdJznRRO3kmTR+IwSxR+j8iyZINsJk0XOg+47RpUzCK7Rr//ku3BQ1nVNwKHcZFKWHR7xqSeww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lxn3G3Qg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lxn3G3Qg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551A2C19423;
	Mon,  2 Mar 2026 16:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772468943;
	bh=Q5EJz0ks9pfcEKpulvqPiKiB3QcWP4MPjhaSyuLWtKA=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Lxn3G3QgbEq3Mw2dsJKkaDqk5SKvaOp5Gs4pFlnODhb9INkygZgiGZdaRoF6Nuv0P
	 BR5iV8/i60Q1y6PJKV4iGJjZnWcac/kTJlLw83K/8Ffwb5VyMP5SqyfxAIUCptdFsL
	 rhofpvbYeC6LMiGyD8zKmrP5KlGcbLEB1f/lpHB2r+Sa6zKXHSgU5GQHec+qJe4oav
	 ehMfC5OXRAer9/XETfOexepaoaQhDQ+4BXSp0PDwcxVfKbDAqIw2/NYv69viXzd0Yh
	 93ws0C0XQw6/8aCxDkUW6RJ8V1Rr165zj6wx/1abbm6pySatXQLzfBn2dEnQZ20QIg
	 x5E0dXBq/qbGg==
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Mar 2026 17:28:58 +0100
Message-Id: <DGSFSTFQ4Z1K.31HQCRTB3ZHF7@kernel.org>
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
To: "Armin Wolf" <W_Armin@gmx.de>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260302002729.19438-1-dakr@kernel.org>
 <20260302002729.19438-2-dakr@kernel.org>
 <bc06539d-84b3-4500-86e7-3f01f1ea3183@gmx.de>
In-Reply-To: <bc06539d-84b3-4500-86e7-3f01f1ea3183@gmx.de>

On Mon Mar 2, 2026 at 11:23 AM CET, Armin Wolf wrote:
> Nice patch series, centralizing the handling of driver_override in the
> device core removes a lot of duplicated code.
>
> I wonder if we can also move DEVICE_ATTR_DRIVER_OVERRIDE() into the devic=
e
> core by registering the associated sysfs attribute inside bus_add_device(=
).
>
> Bus types that honor driver_override could for example set a boolean flag
> inside struct bus_type to tell the device core that driver_override is
> supported.
>
> However this is just a suggestion, the current patch series seems fine to=
 me.

That's a very good suggestion, thanks for pointing it out. In fact, I alrea=
dy
thought of this at some point, but then forgot to implement it. :)
