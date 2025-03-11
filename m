Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D9B7B3E1;
	Tue, 11 Mar 2025 23:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741736447; cv=none; b=V07suV6qlfUnyK8awJ0SbhDE2CnPTF/vqP07a70wS+Pvkn10F+FZDLEYfvtdHqDVPnNp/1ierfqfbZvgNLJMWOEXNW2HCSBBrEjbGWaN3JIqpXMBR8HT1Mb10jTi4PYaLTK9nhHs0CNrekK20OIybzj39OYZp4f/1OTTfAyWnbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741736447; c=relaxed/simple;
	bh=cEAkLUL/KTEhx1CxNQ9t/SS2CT0SmbpUmlzNz9Bumns=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=T3hbsvJuQfsFn/X2bNLEvA+GwwrVI2zScCAXIzG1iWgCH7x+Yc/abc+yjfBGtSR57JIcXgSNB6M1XeLyXbFvh8hGgUyNVjrFDzmJewncOt8SAAj+sbUdtFPViyt2K63b7PP/I/Nymc+UAIav7cogZoXi+CPTSZq2zpu7syP5BEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu; spf=pass smtp.mailfrom=artur-rojek.eu; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artur-rojek.eu
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2FD35433EB;
	Tue, 11 Mar 2025 23:40:40 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 12 Mar 2025 00:40:40 +0100
From: Artur Rojek <contact@artur-rojek.eu>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas
 Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>, Geert
 Uytterhoeven <geert+renesas@glider.be>, "D . Jeff Dionne"
 <jeff@coresemi.io>, Rob Landley <rob@landley.net>, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sh: align .bss section padding to 8-byte boundary
In-Reply-To: <5365422a9715376c76a89e255c978fc39064e243.camel@physik.fu-berlin.de>
References: <20250216175545.35079-1-contact@artur-rojek.eu>
 <20250216175545.35079-2-contact@artur-rojek.eu>
 <5365422a9715376c76a89e255c978fc39064e243.camel@physik.fu-berlin.de>
Message-ID: <433bc8a0732bf8a63c64c4bf0e6ad4a7@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdefheegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvfevufgjfhfkgigtgfesthejjhdttddtvdenucfhrhhomheptehrthhurhcutfhojhgvkhcuoegtohhnthgrtghtsegrrhhtuhhrqdhrohhjvghkrdgvuheqnecuggftrfgrthhtvghrnhepvdfffeevuddvudethfeugfektdektdduuedvgfetfeefudetgfdvveeiieeiheeknecuffhomhgrihhnpehlughsrdhssgenucfkphepuddtrddvtddtrddvtddurdduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedutddrvddttddrvddtuddrudelpdhhvghlohepfigvsghmrghilhdrghgrnhguihdrnhgvthdpmhgrihhlfhhrohhmpegtohhnthgrtghtsegrrhhtuhhrqdhrohhjvghkrdgvuhdpnhgspghrtghpthhtohepuddupdhrtghpthhtohepghhlrghusghithiisehphhihshhikhdrfhhuqdgsvghrlhhinhdruggvpdhrtghpthhtohephihsrghtohesuhhsvghrshdrshhouhhrtggvfhhorhhgvgdrjhhppdhrtghpthhtohepuggrlhhirghssehlihgstgdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtohept
 hhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepuhgsihiijhgrkhesghhmrghilhdrtghomhdprhgtphhtthhopehgvggvrhhtodhrvghnvghsrghssehglhhiuggvrhdrsggvpdhrtghpthhtohepjhgvfhhfsegtohhrvghsvghmihdrihho
X-GND-Sasl: contact@artur-rojek.eu

On 2025-03-11 18:28, John Paul Adrian Glaubitz wrote:
> Hi Artur,

Hey Adrian,
thanks for looking into this patch.

> 
> I'm currently trying to review this patch, but I'm not 100% sure how it
> this change helps grows the .bss section, see below. Maybe you can help
> me understand what's happening.
> 
> On Sun, 2025-02-16 at 18:55 +0100, Artur Rojek wrote:
>> J2 based devices expect to find a devicetree blob at the end of the 
>> bss
>> section. As of a77725a9a3c5, libfdt enforces 8-byte alignment for the
>> dtb, causing J2 devices to fail early in sh_fdt_init.
>> 
>> As J2 loader firmware calculates the dtb location based on the kernel
>> image .bss section size, rather than the __bss_stop symbol offset, the
>> required alignment can't be enforced with BSS_SECTION(0, PAGE_SIZE, 
>> 8).
>> Instead, inline modified version of the above macro, which grows .bss
>> by the required size.
>> 
>> While this change affects all existing SH boards, it should be benign 
>> on
>> platforms which don't need this alignment.
>> 
>> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
>> ---
>>  arch/sh/kernel/vmlinux.lds.S | 15 ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/sh/kernel/vmlinux.lds.S 
>> b/arch/sh/kernel/vmlinux.lds.S
>> index 9644fe187a3f..008c30289eaa 100644
>> --- a/arch/sh/kernel/vmlinux.lds.S
>> +++ b/arch/sh/kernel/vmlinux.lds.S
>> @@ -71,7 +71,20 @@ SECTIONS
>> 
>>  	. = ALIGN(PAGE_SIZE);
>>  	__init_end = .;
>> -	BSS_SECTION(0, PAGE_SIZE, 4)
>> +	__bss_start = .;
>> +	SBSS(0)
>> +	. = ALIGN(PAGE_SIZE);
> 
> What this effectively does is removing ". = ALIGN(sbss_align);" first 
> from BSS_SECTION().
> 
> Then it inserts ". = ALIGN(PAGE_SIZE);" after the "SBSS(0)".
> 
> If I understand this correctly, SBSS() inserts a zero-padding and if 
> I'm not mistaken,
> inserting ". = ALIGN(PAGE_SIZE);" will cause this padding to grow to at 
> least PAGE_SIZE
> due the alignment.
> 
> Is this correct?
> 
>> +	.bss : AT(ADDR(.bss) - LOAD_OFFSET) {
>> +		BSS_FIRST_SECTIONS
>> +		. = ALIGN(PAGE_SIZE);
>> +		*(.bss..page_aligned)
>> +		. = ALIGN(PAGE_SIZE);
>> +		*(.dynbss)
>> +		*(BSS_MAIN)
>> +		*(COMMON)
>> +		. = ALIGN(8);
> 
> If my understanding above is correct, why do we will need an additional 
> ". = ALIGN(8)"
> here?

I'll tackle both of the above questions at once.
I'm by no means an expert at GNU Linker syntax, but the intention of
this patch is to put . = ALIGN(8) inside the .bss : { ... } section
definition, so that the section itself grows by the requested padding.

In the original BSS_SECTION(0, PAGE_SIZE, 4), the last argument inserts
a 4 byte padding after the closing brace of .bss section definition,
causing the __bss_stop symbol offset to grow, but not the .bss section
itself:

#define BSS_SECTION(sbss_align, bss_align, stop_align)			\
	. = ALIGN(sbss_align);						\
	__bss_start = .;						\
	SBSS(sbss_align)						\
	BSS(bss_align)							\
	. = ALIGN(stop_align);						\
	__bss_stop = .;

TurtleBoard loader is only concerned with the .bss section size - it
doesn't care about any symbol offsets - and hence this seemingly cryptic
change (you can display the section size information with
readelf -t kernel_image).
The rest of the changes are simply to "inline" the BSS() macro (as I
needed to access that closing brace), and the former sbss_align,
bss_align (that's your PAGE_SIZE) and stop_align arguments are passed
accordingly, the same way they used to be passed before. The only
visible effect should be the move of ALIGN(stop_align) inside of .bss
section definition, and the change of stop_align value from 4 to 8.

Arguably the TurtleBoard loader should read the __bss_stop symbol offset
instead, but in this patch I'm trying to solve the issue from kernel's
point of view.

Cheers,
Artur

> 
>> +	}
>> +	__bss_stop = .;
>>  	_end = . ;
>> 
>>  	STABS_DEBUG
> 
> Thanks,
> Adrian
