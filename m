Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAF0145FE0;
	Thu, 12 Mar 2026 20:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346539; cv=none; b=YL/l7/SpRgSv4y7R7hQYf+TKR5RYiGjNXDRbByPTMoBSzobNgCwHZaM+Ksel0lvSi3Xdx0qU3VrXHe/4EdZWdx87heDq9QaCaC2DdnY2ijsCkhrhdVm9Ek2QJSLjfk+mKFVXHhfZHeScQkEy8HxA77iUlsOEQ3X6HG2ObeLhDEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346539; c=relaxed/simple;
	bh=HrOFyT1mkelJqN8jGvgQvPsCgvOzSZJphOurWCaFA2o=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=vEVei2s0Id46mpEhYuoS4gIyF+m/VWu07Oj24r1+miVuLRjj7lD1rc6qN7TmSphx66d0ay4SSuA+/m944eU7oEJHIhRuP5b1JnjLerKGVWFWclON3RQpwwCaSUe3y953rkLH6ksTFw+ghCi3eGyBT323tbVlUuIopveFBf4vq5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkjDkjoo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkjDkjoo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1AAAC19425;
	Thu, 12 Mar 2026 20:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773346538;
	bh=HrOFyT1mkelJqN8jGvgQvPsCgvOzSZJphOurWCaFA2o=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=IkjDkjooZTZgrCrA+Rda8txmysbqsyTTsb22w0OBa6A4vLjJGA1eGLV+5TuznbMzl
	 gv9LET4Xnz71scBmubiUF/NtK68fae706v+4vHRWHTnMHqhu6va/0PyrfakKphirB1
	 dgvf/ZN+9t+D7/mTRUgJVlxTAcMB2B/tzoa0Y1+IdmId2ylYs2p1/TGwA8XZ+msYMs
	 lpp06P/OEbe8n/Kr1KiMFxG3/Eu7cLlIIL+GoM8u2A15PXJsCJRdDD6uurY2RUWAqy
	 OoLRdJPZC+o7846fqXlmR0LxAr0/GV5xditIuaAWYwkRakrk+mnL0+xzCCbbDiIhXr
	 7vZYz66R8vozQ==
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Mar 2026 21:15:33 +0100
Message-Id: <DH12VR46PG5L.HJHWKJL8TXBO@kernel.org>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <hanguidong02@gmail.com>, <ysato@users.sourceforge.jp>, <dalias@libc.org>,
 <glaubitz@physik.fu-berlin.de>, <abelvesa@kernel.org>, <srini@kernel.org>,
 <s.nawrocki@samsung.com>, <nuno.sa@analog.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 4/4] driver core: platform: use generic
 driver_override infrastructure
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <imx@lists.linux.dev>, <linux-hwmon@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-sound@vger.kernel.org>,
 <linux-sh@vger.kernel.org>
References: <20260303115720.48783-1-dakr@kernel.org>
 <20260303115720.48783-5-dakr@kernel.org>
 <DGUUVEFWIFCF.RX8CSJ96ZHMC@kernel.org>
In-Reply-To: <DGUUVEFWIFCF.RX8CSJ96ZHMC@kernel.org>

On Thu Mar 5, 2026 at 1:42 PM CET, Danilo Krummrich wrote:
> On Tue Mar 3, 2026 at 12:53 PM CET, Danilo Krummrich wrote:
>>  arch/sh/drivers/platform_early.c |  6 ++++--
>>  drivers/clk/imx/clk-scu.c        |  3 +--
>>  drivers/slimbus/qcom-ngd-ctrl.c  |  6 ++----
>>  sound/soc/samsung/i2s.c          |  6 +++---
>
> Some ACKs would be appreciated. :)

Looking forward to pick this up soon, please let me know if there are any
concerns.

Thanks,
Danilo
