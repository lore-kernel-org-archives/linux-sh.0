Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B43525C6E2;
	Wed, 12 Nov 2025 21:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762983970; cv=none; b=kB55daKidrKACjYoUHy3mWXo+HJxZ9c+Ida44OvU1D+r4FC3Wt1WSptAUFtoAGtqdQccgWMy09bsldZaUOuPaFwLaL9mcNO+H81560WiFlT2tdgvOJ6ve7cKUiIRET3ZIvcI0/dP3mh4UY9d7EsE3qiu/C3s/IwqSwaSgHYPgLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762983970; c=relaxed/simple;
	bh=YGWkWkBylWJ+ZGiXchMT3sAa3UTBljwjaA+VMpVAmFk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=awS5AN3eSJRR0msJZpx86PbOMNoGVfBwQo7y1VgMORNSZo7gH3gB1+cMXSpwTiRUP1tsoM2y1Q9SOq/WgFUi/QIQrHApavUuzRC+8mpIr/voMQJ2+ETSgP8QFWccHbnm3ybFbowS2hLGSwK/S05bEQB0pxl84A9FpC9Sve3LtbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu; spf=pass smtp.mailfrom=artur-rojek.eu; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artur-rojek.eu
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4C1FB4447A;
	Wed, 12 Nov 2025 21:46:01 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 12 Nov 2025 22:46:01 +0100
From: Artur Rojek <contact@artur-rojek.eu>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Florian Fuchs <fuchsfl@gmail.com>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: maple: fix empty port handling
In-Reply-To: <4f70a38490b12d13858f45f3e7a531bf5dc2162d.camel@physik.fu-berlin.de>
References: <20251112190444.3631533-1-fuchsfl@gmail.com>
 <4f70a38490b12d13858f45f3e7a531bf5dc2162d.camel@physik.fu-berlin.de>
Message-ID: <999e3970e1580def5ddbf1921a9ef4a4@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdehudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvfevufgjfhfkgigtgfesthejjhdttddtvdenucfhrhhomheptehrthhurhcutfhojhgvkhcuoegtohhnthgrtghtsegrrhhtuhhrqdhrohhjvghkrdgvuheqnecuggftrfgrthhtvghrnhepteffudektdfggedvtdelveeiuedvffdtudefudeiheeltdfhudeigfffkeeigfdtnecuffhomhgrihhnpehpphdrshgvnecukfhppedutddrvddttddrvddtuddrudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddtrddvtddtrddvtddurdduledphhgvlhhopeifvggsmhgrihhlrdhgrghnughirdhnvghtpdhmrghilhhfrhhomheptghonhhtrggtthesrghrthhurhdqrhhojhgvkhdrvghupdhnsggprhgtphhtthhopeeipdhrtghpthhtohepghhlrghusghithiisehphhihshhikhdrfhhuqdgsvghrlhhinhdruggvpdhrtghpthhtohepfhhutghhshhflhesghhmrghilhdrtghomhdprhgtphhtthhopeihshgrthhosehushgvrhhsrdhsohhurhgtvghfohhrghgvrdhjphdprhgtphhtthhopegurghlihgrsheslhhisggtrdhorhhgpdhrtghpthhtoheplhhinhhugidqshhhsehvg
 hgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: contact@artur-rojek.eu

On 2025-11-12 22:31, John Paul Adrian Glaubitz wrote:
> Hi Florian.
> 
> On Wed, 2025-11-12 at 20:04 +0100, Florian Fuchs wrote:
>> Handle timeout response from empty ports of the maple bus to prevent a
>> stuck maple_sentq and a blocked maple bus.
>> 
>> When only some ports are used, e.g. if only keyboard is connected and 
>> the
>> other ports are empty, the device tends to timeout and return 0xff for
>> the empty port. This needs to be handled, just like the
>> MAPLE_RESPONSE_NONE response, to detect empty ports and to have usable
>> peripherals, if not all of the ports are utilized. Previously, an 
>> empty
>> port resulted in a never cleared maple_sentq which totally blocked the
>> maple bus to be used.
>> 
>> Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
>> ---
>> Note: This patch was tested on real Sega Dreamcast hardware and 
>> resulted
>> in a usable keyboard, even when only 1 or 2 ports where populated. The
>> hot-plugging of the keyboard does also work fine.
>> 
>> The description of the timeout response can be obtained on the bottom 
>> of
>> of the page: https://mc.pp.se/dc/maplebus.html: "If no response is
>> received before the timeout, a word with all bits set (FFFFFFFF) is
>> written at the Result address."
>> 
>>  drivers/sh/maple/maple.c | 1 +
>>  include/linux/maple.h    | 3 ++-
>>  2 files changed, 3 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
>> index 6dc0549f7900..3d6c716cfc98 100644
>> --- a/drivers/sh/maple/maple.c
>> +++ b/drivers/sh/maple/maple.c
>> @@ -649,6 +649,7 @@ static void maple_dma_handler(struct work_struct 
>> *work)
>>  			list_del_init(&mq->list);
>>  			switch (code) {
>>  			case MAPLE_RESPONSE_NONE:
>> +			case MAPLE_RESPONSE_TIMEOUT:
>>  				maple_response_none(mdev);
>>  				break;
>> 
>> diff --git a/include/linux/maple.h b/include/linux/maple.h
>> index 3be4e567473c..4ae3cc6678a8 100644
>> --- a/include/linux/maple.h
>> +++ b/include/linux/maple.h
>> @@ -27,7 +27,8 @@ enum maple_code {
>>  	MAPLE_COMMAND_BWRITE,
>>  	MAPLE_COMMAND_BSYNC,
>>  	MAPLE_COMMAND_SETCOND,
>> -	MAPLE_COMMAND_MICCONTROL
>> +	MAPLE_COMMAND_MICCONTROL,
>> +	MAPLE_RESPONSE_TIMEOUT = 255
>>  };
>> 
>>  enum maple_file_errors {
>> 
>> base-commit: 24172e0d79900908cf5ebf366600616d29c9b417
> 
> Thanks for your patch! I'll try to get it reviewed in the weekend.
> 
> In the meantime, I'll like to add Artur Rojek who did some work for 
> Linux on the
> Dreamcast as well if I remember correctly. Maybe he could test your 
> patch as I
> currently don't have my Dreamcast set up for testing.

Hi Adrian,
I indeed did some minor work to restore Dreamcast support in Linux. Will
give this patch a try once I find some free time.

Florian,
thanks for the patch! Can this be tested with just regular controllers?
I don't own a Dreamcast keyboard.

Cheers,
Artur


> 
> Adrian
