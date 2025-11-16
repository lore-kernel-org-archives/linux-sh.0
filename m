Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA92E28E5;
	Mon, 17 Nov 2025 00:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763340286; cv=none; b=AFGB5ylcYeJ6+NwMpY4fu7XSN/P8fGyaF2rmqDYeAVdIEl4+x8688PAT9fuObw0MqwVJT2RBiZzaJZHw+kIYId77rIpemtFh/OQmvJJMyK1QGUEMswLCtD5xcNwnhXcQ01TweOJWuvAD5U+4e71z9RPcRjgunOfy2dzT62lo1bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763340286; c=relaxed/simple;
	bh=6eNRoSNpp5jhrvsXL8YroEIrhcobH2ELzWRx5T9FO1w=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=UQkjsb25HMRpDtfyKtBRp8kMRL8dPf1qzJ9SmEJ0Hn0SF7ZEQ/CWNC6oI42zZg7EOkvx0x1gNmKTEtbAUfU9huN3CMz27Adki1obddsjtamdWg98sD/NySuY4Z2+CDUYQ31nPgb0sziIk8Pxvoj/qSlnJiRhIleJXmtDecxz5vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu; spf=pass smtp.mailfrom=artur-rojek.eu; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artur-rojek.eu
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 22BAF58C80B;
	Sun, 16 Nov 2025 12:34:55 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3E85343EDD;
	Sun, 16 Nov 2025 12:34:47 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 16 Nov 2025 13:34:46 +0100
From: Artur Rojek <contact@artur-rojek.eu>
To: Florian Fuchs <fuchsfl@gmail.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil
 <paul@crapouillou.net>
Subject: Re: [PATCH] sh: maple: fix empty port handling
In-Reply-To: <aRUOTfCJtqnNBjU3@lithos>
References: <20251112190444.3631533-1-fuchsfl@gmail.com>
 <4f70a38490b12d13858f45f3e7a531bf5dc2162d.camel@physik.fu-berlin.de>
 <999e3970e1580def5ddbf1921a9ef4a4@artur-rojek.eu> <aRUOTfCJtqnNBjU3@lithos>
Message-ID: <d25d9c581f5b4f22c9b94761972aa0fe@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudehheelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvfevufgjfhfkgigtgfesthejjhdttddtvdenucfhrhhomheptehrthhurhcutfhojhgvkhcuoegtohhnthgrtghtsegrrhhtuhhrqdhrohhjvghkrdgvuheqnecuggftrfgrthhtvghrnhepheejgfefiedtjeeiieevleeugfeghfelheekteehvdegieeihfetvdegieeihfeinecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepuddtrddvtddtrddvtddurdduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedutddrvddttddrvddtuddrudelpdhhvghlohepfigvsghmrghilhdrghgrnhguihdrnhgvthdpmhgrihhlfhhrohhmpegtohhnthgrtghtsegrrhhtuhhrqdhrohhjvghkrdgvuhdpnhgspghrtghpthhtohepjedprhgtphhtthhopehfuhgthhhsfhhlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhlrghusghithiisehphhihshhikhdrfhhuqdgsvghrlhhinhdruggvpdhrtghpthhtohephihsrghtohesuhhsvghrshdrshhouhhrtggvfhhorhhgvgdrjhhppdhrtghpthhtohepuggrlhhirghssehlihgstgdrohhrghdprhgtphhtthhopehlihhnuhigq
 dhshhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehprghulhestghrrghpohhuihhllhhouhdrnhgvth
X-GND-Sasl: contact@artur-rojek.eu

On 2025-11-12 23:46, Florian Fuchs wrote:
> Hi Artur,
> thank you so much for fixing the DC boot on linux again!
> Adrian, thank you for looking at it!
> 
> On 12 Nov 22:46, Artur Rojek wrote:
>> thanks for the patch! Can this be tested with just regular 
>> controllers?
> 
> Yes, indeed you can test it with the controller, when you compile with
> joystick support, like:
> 
> 	CONFIG_MAPLE=y
> 	CONFIG_INPUT=y
> 	CONFIG_INPUT_JOYDEV=y
> 	CONFIG_INPUT_EVDEV=y
> 	CONFIG_INPUT_JOYSTICK=y
> 	CONFIG_JOYSTICK_MAPLE=y
> 
> You should not put a VMU in though, as thats currently broken (I have a
> patch ready).
> 
> Then you can directly read from the evdev and listen for the button
> presses:
> 	bash-5.3# cat /dev/input/event2 | xxd
> 
> You need to press a button for 20-30 times, as it seems to buffer the
> events and outputs it in batches.
> 
> Then, you should see the following outputs for the buttons:
> 
> Button A:
> 	00000000: 7800 0000 94c3 0d00 0100 3001 0000 0000  x.........0.....
> Button B:
> 	000001e0: 7800 0000 94c3 0d00 0100 3101 0100 0000  x.........1....
> Button X:
> 	000003b0: 7800 0000 94c3 0d00 0100 3301 0100 0000  x.........3.....
> Button Y:
> 	00000900: 7800 0000 94c3 0d00 0100 3401 0100 0000  x.........4.....
> 
> The Joystick should be detected like this:
> 	/ # dmesg|grep maple
> 	maple: bus core now registered
> 	maple (null): detected Dreamcast Controller: function 0x1: at (2, 0)
> 	maple (null): no driver found
> 	input: Dreamcast Controller as /devices/maple/2:00.1/input/input2
> 
> Another indicator is the dmesg log for empty ports:
> 	maple (null): no devices to port 3
> 
> These messages were previously not there, as the empty ports were never
> detected.

Hey Florian,

Before applying this patch, no input on a maple port is being registered
until all 4 maple ports are populated (in my case by four controllers).
Once all 4 are plugged in, I can register input on either of them by
cat-ing their respective char devs.

After applying the patch, I confirm that input can be read immediately
for the present devices, even if the other ports are unpopulated.

However, this patch also breaks hotplug on maple ports - I can no longer
plug in additional controllers at runtime and have them show up.

I think we need to hold off on this patch until the hotplug issue is
addressed.

> 
> btw, I have also a cdi file, that boots for me, although I heard there
> were issues on the NTSC-U devices, if helpful:
> https://github.com/foxdrodd/dreamcast-linux/releases/download/6.17.7/linux6177-joystick.cdi

Thanks for the cdi. I have no means to burn CDs anymore, so instead
I quickly built a small buildroot based rootfs, and booted it as
initramfs over serial line :-)

Cheers,
Artur

> 
> Thank you for your efforts,
> Florian
