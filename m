Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799CA3845B9;
	Thu, 12 Mar 2026 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773328884; cv=none; b=ZpYMbL3kK4XhAPOZ/kX1rKyji8/eSHJAGOXUq5QkaqwUSI1eQLcH3CHedOHn1FPCDwgtgw8xdnOv1O4oLLWKP31TsCm9/PTOy4/ZI+Rz+41eAkIM0xh2bLvt7YdHKLNd9B7DDtFiIk3y/a4IAOCyMkHxkpmCiXBFec6Wliokx6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773328884; c=relaxed/simple;
	bh=YTAxrKfaWlpyf0/MK7MHIXvdGyAf3SGdE+RVhDUnn4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cctAT8BaCIYDl84OjHPi4uoxMxHrGOW48u7ToIYVMH52rrl+q8AbbaJ3xjkPVxYmRrTHyvZYCAoOeNuOZJ6bhJqQpMcYueE4l2WeLs6VxBWPrbR9GNxR8pv1LKSiWh4/RH5wvhzUaat1pANAHYjk/NsFIihnwFqt27DfsyHabjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H9Q9X2T3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H9Q9X2T3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A01FC4CEF7;
	Thu, 12 Mar 2026 15:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773328884;
	bh=YTAxrKfaWlpyf0/MK7MHIXvdGyAf3SGdE+RVhDUnn4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H9Q9X2T3SiKNqN8iRSmDM2YLLYjtuMVcUUEgGBorB2p3By5rIVUWBVkHKRrccuaK1
	 AmHkVUXLmmm3QX1mxuG5EGKkoxKrI4B6D46oXzR5d/qXCINt3gjp4P1p21uUJU/xRc
	 7G5wmia3BsnaRZZBII3WDSOtyYry38I/7UO63WB0=
Date: Thu, 12 Mar 2026 16:21:19 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rafael@kernel.org, hanguidong02@gmail.com, ysato@users.sourceforge.jp,
	dalias@libc.org, glaubitz@physik.fu-berlin.de, abelvesa@kernel.org,
	srini@kernel.org, s.nawrocki@samsung.com, nuno.sa@analog.com,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-hwmon@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-sh@vger.kernel.org
Subject: Re: [PATCH v2 0/4] driver core: generalize driver_override
 infrastructure
Message-ID: <2026031211-landside-subtype-5750@gregkh>
References: <20260303115720.48783-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303115720.48783-1-dakr@kernel.org>

On Tue, Mar 03, 2026 at 12:53:17PM +0100, Danilo Krummrich wrote:
> Currently, there are 12 busses (including platform and PCI) that duplicate the
> driver_override logic for their individual devices.
> 
> All of them seem to be prone to the bug described in [1].
> 
> While this could be solved for every bus individually using a separate lock,
> solving this in the driver-core generically results in less (and cleaner)
> changes overall.
> 
> Thus, move driver_override to struct device, provide corresponding accessors for
> busses and handle locking with a separate lock internally.
> 
> In particular, add device_set_driver_override(), device_has_driver_override(),
> device_match_driver_override() and a helper, DEVICE_ATTR_DRIVER_OVERRIDE(), to
> declare the corresponding sysfs store() and show() callbacks.
> 
> Until all busses have migrated, keep driver_set_override() in place.
> 
> Note that we can't use the device lock for the reasons described in [2].
> 
> This patch series includes the migration of the platform bus; patches for all
> other affected busses still need to be extracted as a follow-up of the WIP
> treewide patch in [3].
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=220789
> [2] https://lore.kernel.org/driver-core/DGRGTIRHA62X.3RY09D9SOK77P@kernel.org/
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=driver_override

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
