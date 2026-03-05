Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50F4366DAE;
	Thu,  5 Mar 2026 12:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772714582; cv=none; b=OKepzO2UQhdY12SzxgoEVWGhZ7n9gvQFs9oRGKf86EWuSWg2M88OcDqd3LZl/NByCm0DfRmphtAEFjGlyHzxvON9N+NJ7VPHfidrrpTJEawiyEcYZY6jqT9rsrGzsr3x9kRYlAM2BffLS+o9VK+n/ijgf27zY515ICMLoeL5q1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772714582; c=relaxed/simple;
	bh=3GlZ8dbSH/9p2g0p8El8ep4WXI+MyDdKLj11spmChUk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=fY7iXFiJRv/mRD1x10s83PYU1G6F22YANaVfODSYZLmLFiOSfCcYM8QO1Gmmga6itSTXS4bN6OCFGbK+qAXUU92OFvvmH8uJTaAvbezl4DF454emLugTM2HD46yVrpuawfOCTPssvrND+UeIKe9vtGGQd/p4xxI2sWVrA+t43pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgFzGNx1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgFzGNx1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DC4C116C6;
	Thu,  5 Mar 2026 12:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772714582;
	bh=3GlZ8dbSH/9p2g0p8El8ep4WXI+MyDdKLj11spmChUk=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=GgFzGNx12a4sekSUlult5vhaiCEQPa/aodzXN8+UHcXB3h8noGgqo4GbdB34J33Bh
	 k0vB3oEX+wHYIMvcx8tVEPu3MyqbFT6qW757DZY8vcFyfVz/noQd5yqrt4neD9+rfs
	 t8vSpAssKPubdnCiqh8XKnSsuO8PffrFbbM1UftRybtTvJAhq+QNNDt9TqI+y270BQ
	 Y1v0vI/P0ullu4h1G5odV1MexgfXfvq8nNVqWq0Z04Q+Ojbx9KJtpwy82SzX4XoAWT
	 jxfHiANb/IJiVmSEOqOPlvSOZZ7IUyw1qnrYoMLDAxgLJPzKcwWrAK3K6kSUFekuYC
	 qEpw/odNELIwg==
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Mar 2026 13:42:57 +0100
Message-Id: <DGUUVEFWIFCF.RX8CSJ96ZHMC@kernel.org>
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
In-Reply-To: <20260303115720.48783-5-dakr@kernel.org>

On Tue Mar 3, 2026 at 12:53 PM CET, Danilo Krummrich wrote:
>  arch/sh/drivers/platform_early.c |  6 ++++--
>  drivers/clk/imx/clk-scu.c        |  3 +--
>  drivers/slimbus/qcom-ngd-ctrl.c  |  6 ++----
>  sound/soc/samsung/i2s.c          |  6 +++---

Some ACKs would be appreciated. :)
