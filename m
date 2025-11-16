Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F247C225A29;
	Sun, 16 Nov 2025 18:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763317566; cv=none; b=DLjqLs504rW3KCeI9V0nNAYeIvgGnEhqStcyzPq31jQccW7NnmNUyntGWG5IFUUWwMQrc2N+qKrV/TCtm/aB1cUjvzYtSD17hMDkPK7T+9H3k5+lvzTCu87fLkelTt04b7Q8SUFpNgSepHCOQmHSpGFT3ybw1+nSFx38TQFyphQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763317566; c=relaxed/simple;
	bh=K2p9JT2sNsf5pHL7MmFiy4cd078JElk/07WgIPbLxq0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=uoGQbCHTjISQvxt3f9ML6PPCpZX6ND2WZ/hdEMP7NTSDEWE4Ot5FsItO3Eq0rfmEALUC+5XAmcjLb2IGFbgfiMvZMtKuQ2ZWQNhKeOTf/dX3ndFtkH9qzJzOM/9pCoXZ/sN10vPJt63jje4OtLyMIqfmudtx1sOP+/gMNt6mFuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu; spf=pass smtp.mailfrom=artur-rojek.eu; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artur-rojek.eu
Received: by mail.gandi.net (Postfix) with ESMTPSA id CCA4343B9F;
	Sun, 16 Nov 2025 18:25:53 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 16 Nov 2025 19:25:53 +0100
From: Artur Rojek <contact@artur-rojek.eu>
To: Florian Fuchs <fuchsfl@gmail.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil
 <paul@crapouillou.net>
Subject: Re: [PATCH] sh: maple: fix empty port handling
In-Reply-To: <aRoPeNu7UZog0srr@lithos>
References: <20251112190444.3631533-1-fuchsfl@gmail.com>
 <4f70a38490b12d13858f45f3e7a531bf5dc2162d.camel@physik.fu-berlin.de>
 <999e3970e1580def5ddbf1921a9ef4a4@artur-rojek.eu> <aRUOTfCJtqnNBjU3@lithos>
 <d25d9c581f5b4f22c9b94761972aa0fe@artur-rojek.eu> <aRoPeNu7UZog0srr@lithos>
Message-ID: <5aa7d2005114e7fc476ecdeeac8bea13@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudeivdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvfevufgjfhfkgigtgfesthejjhdttddtvdenucfhrhhomheptehrthhurhcutfhojhgvkhcuoegtohhnthgrtghtsegrrhhtuhhrqdhrohhjvghkrdgvuheqnecuggftrfgrthhtvghrnheptdejuedtgefgtdfhgfdugefgffffteetteffuddtgfefheekgedvtdekvddvtdeknecukfhppedutddrvddttddrvddtuddrudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddtrddvtddtrddvtddurdduledphhgvlhhopeifvggsmhgrihhlrdhgrghnughirdhnvghtpdhmrghilhhfrhhomheptghonhhtrggtthesrghrthhurhdqrhhojhgvkhdrvghupdhnsggprhgtphhtthhopeejpdhrtghpthhtohepfhhutghhshhflhesghhmrghilhdrtghomhdprhgtphhtthhopehglhgruhgsihhtiiesphhhhihsihhkrdhfuhdqsggvrhhlihhnrdguvgdprhgtphhtthhopeihshgrthhosehushgvrhhsrdhsohhurhgtvghfohhrghgvrdhjphdprhgtphhtthhopegurghlihgrsheslhhisggtrdhorhhgpdhrtghpthhtoheplhhinhhugidqshhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgp
 dhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgruhhlsegtrhgrphhouhhilhhlohhurdhnvght
X-GND-Sasl: contact@artur-rojek.eu

On 2025-11-16 18:52, Florian Fuchs wrote:
> On 16 Nov 13:34, Artur Rojek wrote:
>> On 2025-11-12 23:46, Florian Fuchs wrote:
>> > Hi Artur,
>> > thank you so much for fixing the DC boot on linux again!
>> > Adrian, thank you for looking at it!
>> >
>> > On 12 Nov 22:46, Artur Rojek wrote:
>> > > thanks for the patch! Can this be tested with just regular
>> > > controllers?
>> >
>> > Yes, indeed you can test it with the controller, when you compile with
>> > joystick support, like:
>> >
>> > 	CONFIG_MAPLE=y
>> > 	CONFIG_INPUT=y
>> > 	CONFIG_INPUT_JOYDEV=y
>> > 	CONFIG_INPUT_EVDEV=y
>> > 	CONFIG_INPUT_JOYSTICK=y
>> > 	CONFIG_JOYSTICK_MAPLE=y
>> >
>> > You should not put a VMU in though, as thats currently broken (I have a
>> > patch ready).
>> >
>> > Then you can directly read from the evdev and listen for the button
>> > presses:
>> > 	bash-5.3# cat /dev/input/event2 | xxd
>> >
>> > You need to press a button for 20-30 times, as it seems to buffer the
>> > events and outputs it in batches.
>> >
>> > Then, you should see the following outputs for the buttons:
>> >
>> > Button A:
>> > 	00000000: 7800 0000 94c3 0d00 0100 3001 0000 0000  x.........0.....
>> > Button B:
>> > 	000001e0: 7800 0000 94c3 0d00 0100 3101 0100 0000  x.........1....
>> > Button X:
>> > 	000003b0: 7800 0000 94c3 0d00 0100 3301 0100 0000  x.........3.....
>> > Button Y:
>> > 	00000900: 7800 0000 94c3 0d00 0100 3401 0100 0000  x.........4.....
>> >
>> > The Joystick should be detected like this:
>> > 	/ # dmesg|grep maple
>> > 	maple: bus core now registered
>> > 	maple (null): detected Dreamcast Controller: function 0x1: at (2, 0)
>> > 	maple (null): no driver found
>> > 	input: Dreamcast Controller as /devices/maple/2:00.1/input/input2
>> >
>> > Another indicator is the dmesg log for empty ports:
>> > 	maple (null): no devices to port 3
>> >
>> > These messages were previously not there, as the empty ports were never
>> > detected.
>> 
>> Hey Florian,
>> 
>> Before applying this patch, no input on a maple port is being 
>> registered
>> until all 4 maple ports are populated (in my case by four 
>> controllers).
>> Once all 4 are plugged in, I can register input on either of them by
>> cat-ing their respective char devs.
>> 
>> After applying the patch, I confirm that input can be read immediately
>> for the present devices, even if the other ports are unpopulated.
>> 
>> However, this patch also breaks hotplug on maple ports - I can no 
>> longer
>> plug in additional controllers at runtime and have them show up.
>> 
>> I think we need to hold off on this patch until the hotplug issue is
>> addressed.
>> 
> 
> Thank you for taking the time to test it! And sorry for the obvious 
> issue,
> I think my testing was wrong as I just removed and plugged in an 
> already
> registered device, and missed it with a new one.

No worries. Thanks for looking into this - appreciated!

On a side note, with your patch, after the initial disabling of unused
ports, new maple codes (in maple_dma_handler) arrive only for the first
and second port (and even despite MAPLE_RESPONSE_DEVINFO, no new devices
are detected). The remaining two ports don't generate any codes at all
on hotplug attempts.

I don't know Maple bus to tell if this is normal or not, but make sure
you test hotplug on all four ports.

Cheers,
Artur

> 
> Regards,
> Florian
