Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72BC375ACF;
	Sat,  9 May 2026 21:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778362789; cv=none; b=HbaEzYBu70o6S4dx8r+E/imEA/Ap332YWe75wmt6PCvcSnd3dgRgfODbckp00YB9XfAUOpii3RJa7y5uRVCnlLOyAVjJ4wLZg7eKjKH1MoomgfH/m8J/aYHcNl2IHR2fWj27afbhb2iRXd7A2wpFYDS8ltoAevULHoktQiILy3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778362789; c=relaxed/simple;
	bh=xjH7Q0WEFczZoKyX5W0MDBQyB4VJZh2aGjDwpUT3BTk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=KIb2oS8z1t6IgV0vRQ9g65Pin4RQLL6LZvQ4HqWaXeGzx+GQ5k1kBbfHEvFA7AlXuEIS/jLskgt5lG4zcC0dEk/Kc3a2vvVK+UzCWLFesJxTEO0uBc4hWDH2fdrI6YHsEFx2q6u/f0ULg30qAHJM88p/gVMakguPc8A0m5EOi4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu; spf=pass smtp.mailfrom=artur-rojek.eu; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artur-rojek.eu
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 6EF355806D3;
	Sat,  9 May 2026 21:12:33 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DD28A2019D;
	Sat,  9 May 2026 21:12:23 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 09 May 2026 23:12:23 +0200
From: Artur Rojek <contact@artur-rojek.eu>
To: Florian Fuchs <fuchsfl@gmail.com>
Cc: linux-sh@vger.kernel.org, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Rich Felker <dalias@libc.org>, Adrian
 McMenamin <adrianmcmenamin@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sh: maple: fix empty port handling
In-Reply-To: <20260426212714.2286437-1-fuchsfl@gmail.com>
References: <20260426212714.2286437-1-fuchsfl@gmail.com>
Message-ID: <765772b0c683faf8260a7f09833a1752@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: contact@artur-rojek.eu
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTEp2qp/zDg1kdnYOFSI2gXopKxBWx+Kgg44dqoHckMXXo7WFETR+I3qDCSy5kUxhCJHZF9+6puRXMUFKCyfrjNxKmSIV4n7kdSQQESGqmpw7VLvT9/nqdShwf+/UXaID8io7ywDgAaTKhysXjTtREDZR4fiFRbqHpMhLxpkj+k0CoTdJcZLtnQys8cz4+iRg0gyv4PpAAoyFWA8KxfYk4q1rb+kBbcpSnZhOoFrJM1vy8urrwwnO4w8VhC+En5OSDN6NN6iqx3zO6ZY94FCvGeEQxi+H9Gd+jpjp8HxCF/OkMLWhszWGWF7h1/XTXNBrhATSukQrtVxezq/MyzhZx8VTIcS5xLRL8mz3kzsysvtZaNlpV4p2tzcGoIpGx5NwLeaysIDpq5bG2mhssvVVSKuQzJcQZoXmrrDNRF723Na/k+YKZAZsRzTC7IrqoisPhjWHzZXIvug9/1X6Y7du9WDQ384J6agemYNSSnzd98xQE1aoC10y2z7dxNg2wCN7c8cR8NvHloCSRuGwnYamDcRjTrMjTwiBu7rqmucRqStNfAeLgHbzINw3NrU/J7Leyf+QhgoAxHKpeq+/HhB1axoFalRmaDbFNtHAYunqSyiLuN3SlaJpvirS/gppbXrc2RbrT/vxY3//u/gLR1GB3MVZGYLZ75VWTh/VDjygWPNSg

On 2026-04-26 23:27, Florian Fuchs wrote:
> Fix the handling of empty ports, to restore the ability to use the 
> device
> with less than 4 populated ports and also be able to hot-plug new 
> devices
> in empty ports at runtime.
> 
> Explicitly cast the response code in maple_response_devinfo() to s8 so
> that 0xFF from the device gets interpreted as signed and flows like the
> NONE response, previously it was considered unknown response code, 
> which
> blocked the maple bus.
> 
> Remove the locking variable from maple_vblank_handler() as there is no
> locking information returned from maple_add_packet() and it lead to 
> only
> ever check exactly one empty port.
> 
> Update maple_response_devinfo() to explicitly check for empty ports on
> unit 0, to be able to hot-plug devices in empty ports.
> 
> Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>

Hey Florian,

Commit message could be "massaged" a bit, but otherwise everything works
fine. Thanks for fixing this!

Verified on real hardware.

Tested-by: Artur Rojek <contact@artur-rojek.eu>
Acked-by: Artur Rojek <contact@artur-rojek.eu>
