Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E272DD60E;
	Fri, 24 Apr 2026 21:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777065006; cv=none; b=auqkfEPttpvZPgEMv3hRwc2lMWiQ6K3Ga/sBspdpJIpgG4xu0aFknKy4QDfDUTE2cUVVHCw/uu8PczdMD61oJe1gqyp3ui2FXMDgFs2s9CyZgKMJTYbZw01zHtuLYoIF36yZa7CRJlOCM+Yq/ExCDXacAVafFSkwfnoNaLMwecU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777065006; c=relaxed/simple;
	bh=BK6VAgnfLmb7D6P4QXxUNpkyx0adFQfzIOqNQR3pUiY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=L5Qza7G8xOYyo4efDGHw0HAC3WcaQvu2cXJCrFzA5YIfCLRMmKRSFyOyD87JBsSywxZNzrGMrJZa9qXgU7spOixE0SH/8YFm3648GPct4O8OnJpk1O6EwUTIxHfvN3Wx9xjXs5nI8KR/b2VT+d4Ne8aYB2HEehRu/lfVRhj9RCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu; spf=pass smtp.mailfrom=artur-rojek.eu; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artur-rojek.eu
Received: by mail.gandi.net (Postfix) with ESMTPSA id 10E0B3ED84;
	Fri, 24 Apr 2026 21:09:54 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 24 Apr 2026 23:09:54 +0200
From: Artur Rojek <contact@artur-rojek.eu>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Johan Hovold <johan@kernel.org>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] maple: switch to dynamic root device
In-Reply-To: <39b8846254ceebd7f4bee44c6348ef1f9802910d.camel@physik.fu-berlin.de>
References: <20260424104142.2617115-1-johan@kernel.org>
 <c67bd8df5fbfc357dc20ad7973eb5adb@artur-rojek.eu>
 <39b8846254ceebd7f4bee44c6348ef1f9802910d.camel@physik.fu-berlin.de>
Message-ID: <858b0863309f308fb49a27911b22b17e@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Score: -100
X-GND-Cause: dmFkZTEQfa1Oc5JItPlPNz3wzGKSXFbRpuzT8AWDgq7eAKN7KRKbiWP8F3wSe6hPYhlr7Bb7FWq3rJTv2Mh8V0GCQpfGHFUdylNfYhxS1Kw0rKtGJ4i0rMPVmUZsdfwQ+z4/hA1VP9la4x7oducWXoIK2+OpinsFIJSZpNmhbGLFWrlsSqZxvRDWYUERv0/+EmBmaRcpTQefxkHZWfCGcVv/XVH8sGXGAkMAySF7Xt/4AYXozQ1Pz/Bhh5cjg5BBUj7788sHtzRPYe5fiAVXWX/2Pu3by1X5BEPGQgBQo5xE+szOSA6SorwHDTB4NZR0/9RVwA6zpXAkH/C+3GXh/Q4HFRbtEkoQO1ypnWNqoIcJEYsyb8PzNPnLcPuVCcwal702cABVXM9CvmXtFLsLhO8eA9Ls1PulxuOo2QIK9BIJlS6M+s969io+B2OQ5VOXjH1A84bMxA4b/AJCvylGD3VUk0Qxvy3E8gtJH0QzW7/1lCp+3EbcWEM6nfG8gy6mTfPXu+PpO2Gs9G/PawEe9TUjosvacn9VKg6yaZ9agegoT3CuZJSTwroSjA7rgYsRnnEWEqIS+D0WNx5zR/r8rQeP/pa+KlxVL8kNBipktLfsRqnCXpV6R05jlZhOS1zqB2MgNR916l1FaTb+bFEh8LVyIhWtuiLGAd0Kr64+LYFDLcRUgg
X-GND-State: clean

On 2026-04-24 21:59, John Paul Adrian Glaubitz wrote:
> Hi Artur,
> 
> On Fri, 2026-04-24 at 21:08 +0200, Artur Rojek wrote:
>> On 2026-04-24 12:41, Johan Hovold wrote:
>> > Driver core expects devices to be dynamically allocated and will, for
>> > example, complain loudly when no release function has been provided.
>> >
>> > Use root_device_register() to allocate and register the root device
>> > instead of open coding using a static device.
>> >
>> > Note that this also fixes a reference leak in case device_register()
>> > fails which may be flagged by static checkers.
>> >
>> > Signed-off-by: Johan Hovold <johan@kernel.org>
>> 
>> Hi Johan,
>> 
>> thanks for the patch. Verified on real hardware. LGTM:
>> 
>> Acked-by: Artur Rojek <contact@artur-rojek.eu>
> 
> Maybe add a Tested-by as well.

Tested-by: Artur Rojek <contact@artur-rojek.eu>

> 
> Adrian
