Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED32A3BFE37;
	Tue,  3 Mar 2026 16:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772555113; cv=none; b=qPEcdnLtjd0oZ/+pkufzfXLby36isxxQlY2l8CFEqmODJGd6omXrSDZmL+QqdYuaHDJQFJlNEVMgi6o18Zy/gptPdfRClFgOzK8eLGgknUYy9RD+KQyvFLl4hpTH/Qd7MZLridjb096/QJFM9PW7oHoSsTfX5rmceHv8jAoFgVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772555113; c=relaxed/simple;
	bh=Lzei46mZsFfkX8o4DbwriZnJFbQPag4hXLTsoTS7WBM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=ufewpV3NyqF995Onq03JwLll3VEOZFhcgY7ALLG0S816+1Gcb0IIN45pH73tpjLNjB7usAjuK/2F+txe7JPZck5r9R5TWizXTtG68KoTSQVhUTwLqeN8DMKABc7qn/UvbwZsiLWBjZIFhB6aJDqWSBfgKwKrHltHRhrEmqcynJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1gDciMK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1gDciMK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D8FC116C6;
	Tue,  3 Mar 2026 16:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772555112;
	bh=Lzei46mZsFfkX8o4DbwriZnJFbQPag4hXLTsoTS7WBM=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=b1gDciMKmxqJFhLhN4FetRczLqf+CttHovYs2ls9wewYfiUZA2KA+DpSzV/pA6tfO
	 LvyRXRWxbMDL2lShxxrawxA3nBnbO+6eU1/9cZ8aPq0SaUEcnA+xMwRnz1mRl2n9aa
	 IxrtMYO6W3tFizgT4R6uzfnfWCUHnQmIpUt4uPoEhbVgi3SXIgMAmQarA2Psq+QIkD
	 7CRMsin1l+1ITxQeb50Q2mjNjDHF7lByhF8gMaxYucxv4AidELFS01HWE3PzOqIW3D
	 gnR+QTlNwIaS0A053PS4zkXfM2G9e2EVDoG0bGxmvmgh6Xd4dNP0qJpRYeDbQjFeC+
	 39Qy5OO1udjBg==
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Mar 2026 17:25:07 +0100
Message-Id: <DGTACERFTTCV.29XON9ZLYAEQL@kernel.org>
Subject: Re: [PATCH v2 3/4] hwmon: axi-fan: don't use driver_override as IRQ
 name
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <hanguidong02@gmail.com>, <ysato@users.sourceforge.jp>, <dalias@libc.org>,
 <glaubitz@physik.fu-berlin.de>, <abelvesa@kernel.org>, <srini@kernel.org>,
 <s.nawrocki@samsung.com>, <nuno.sa@analog.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <imx@lists.linux.dev>, <linux-hwmon@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-sound@vger.kernel.org>,
 <linux-sh@vger.kernel.org>, "Guenter Roeck" <groeck7@gmail.com>
To: "Guenter Roeck" <linux@roeck-us.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260303115720.48783-1-dakr@kernel.org>
 <20260303115720.48783-4-dakr@kernel.org>
 <b46c5757-b67d-4949-b8d8-54b799464b5d@roeck-us.net>
In-Reply-To: <b46c5757-b67d-4949-b8d8-54b799464b5d@roeck-us.net>

On Tue Mar 3, 2026 at 5:23 PM CET, Guenter Roeck wrote:
> On Tue, Mar 03, 2026 at 12:53:20PM +0100, Danilo Krummrich wrote:
>> Do not use driver_override as IRQ name, as it is not guaranteed to point
>> to a valid string; use NULL instead (which makes the devm IRQ helpers
>> use dev_name()).
>>=20
>> Fixes: 8412b410fa5e ("hwmon: Support ADI Fan Control IP")
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>
> Applied.

I need this patch in the driver-core tree, otherwise I can't land patch 4 o=
f
this series [1]. :(

Any chance you can drop it from your tree?

[1] https://lore.kernel.org/driver-core/20260303115720.48783-5-dakr@kernel.=
org/
