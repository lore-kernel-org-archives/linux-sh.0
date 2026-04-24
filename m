Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F495368975;
	Fri, 24 Apr 2026 19:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777058652; cv=none; b=GzANvNDuP7ezM5AWb87tVB0o8yO9hh5YhQmPpqpt/HyN3ZzYe3Q0h+SK8kznF7OA+2AGBI2NDS9cW7Q7NYWUGSjpOLwSJI8l/jkrSI5x3w7oYMcim0l5EskM7lpIj5hwrnA00l+slIvdnMxecP/CjXajUN7vNQy+NRhS9g7PgaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777058652; c=relaxed/simple;
	bh=BSoxNxCdF4QrhDPoa3IcCjqFuLg+MhIAkka/6OpmYFc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=htbZZSDIFsxZGT3boyJ0sACpP4pea7eKOjG43KWV1+B2DdqzsSgpcixiaIbI6j2ZueX5xT0mt+8oQ8W0sU1jkWWJPbgspY57new7vMhAY04H+gWfKrpIYyvRA8nSfsod1X/3chzj9so5PPVTJh9Cep3dh7V5WllnoYYq8AUrmcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu; spf=pass smtp.mailfrom=artur-rojek.eu; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artur-rojek.eu
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 7882E582773;
	Fri, 24 Apr 2026 19:08:39 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3C8383ED47;
	Fri, 24 Apr 2026 19:08:31 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 24 Apr 2026 21:08:31 +0200
From: Artur Rojek <contact@artur-rojek.eu>
To: Johan Hovold <johan@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] maple: switch to dynamic root device
In-Reply-To: <20260424104142.2617115-1-johan@kernel.org>
References: <20260424104142.2617115-1-johan@kernel.org>
Message-ID: <c67bd8df5fbfc357dc20ad7973eb5adb@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: contact@artur-rojek.eu
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTEaSb7d3RczHOpdSdjof+d81wLqKZkLMAqtG+p/j3vzwgK1acGO+gXahbKLzk7liD41jifOnE+kgxqdNdd9/2tIiObRepL1aDF1nPmjueFPh63+34GgAwnH8sItrXsPDQ13d00sDgQ1upcFRLPIikbpIbdE/+SQbZEA23SO02moV+os8pU4L7vy8QTT/A5BBqj64C8nFsren5NJHealziKHQ5VOB9qkx6ku5sqvrCOwmSf3CmAlsZZONfBzaP/7raXnbIgKD8c63KvUfxtVkAutQUNc0hyCAotlDIHjMifeR9Kgh7b616ZvUrh21FdiDB49jJXnCJ+bZg+s3ymMxImrmX9ewF794BVsU4BQ9Pf65wNDKfI4c8//cjvjwEk4ZZsl8TZj9NFSsFoDof8pEj9Y1t35gPEcJNsBhXIeUjMIuyYnzjEUikgwDL7ypl2GO198Bo2o6LZOxjpbU6bvjex8KGAfxjw3fy+DwJvGc/KD4pE8qJYN9pKhdwShUQJ2iF5q1ibjNpvEoC6s4iKztpnP/0xfpJLvzZRnzF0iyC3XdJ4vMtrKaFNS1zqk6X/Atceg2WrQnSStgYI4NvwPd2yA+jxC2UY3DGtfEyNFBn6wM5djP6Vr00tRCW2cITiLOjInfQBDdDtmsa9uNf7WwzVg+f9qIftnAA51NOGEOypPFQ

On 2026-04-24 12:41, Johan Hovold wrote:
> Driver core expects devices to be dynamically allocated and will, for
> example, complain loudly when no release function has been provided.
> 
> Use root_device_register() to allocate and register the root device
> instead of open coding using a static device.
> 
> Note that this also fixes a reference leak in case device_register()
> fails which may be flagged by static checkers.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Hi Johan,

thanks for the patch. Verified on real hardware. LGTM:

Acked-by: Artur Rojek <contact@artur-rojek.eu>
